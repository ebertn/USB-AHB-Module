// $Id: $
// File name:   data_buffer.sv
// Created:     4-13-19
// Author:      Mason Fritzen
// Lab Section: 002
// Version:     1.0  Initial Design Entry
// Description: Data Buffer for CDL

`timescale 1ns/10ps



module data_buffer
  (
   input reg 	     clk,
   input reg 	     n_rst,
   input reg 	     clear, //from PC
   input reg 	     get_rx_data, //from AHB Slave
   input reg 	     store_tx_data, //from AHB Slave
   input reg [31:0]  tx_data, //from AHB Slave
   input reg [1:0]   data_size, //from AHB Slave
   input reg 	     get_tx_packet_data, //from TX
   input reg [7:0]   rx_packet_data, //from RX
   input reg 	     store_rx_packet_data, //from RX
   input reg 	     lock_db,
   output reg [6:0]  buffer_occupancy, //to PC and AHB Slave
   output reg [31:0] rx_data, //to AHB Slave
   output reg [7:0]  tx_packet_data, //to TX
   output reg 	     lock_error
   );

   typedef enum      {IDLE, STORE, RECEIVE, SEND_TX, SEND_RX, CLEAR, LOCK} statetype;
   statetype state, next_state;
   

   //counter variables
   int 		     count1 = 0;           //counts to highest occupied byte
   int 		     count2 = 0;           //counts to lowest occupied byte
   int 		     next_count1;
   int 		     next_count2;
   
   //two dimensional array holding all data
   reg [7:0] [63:0]  data;
   reg [7:0] [3:0]   new_data;
               
   always_comb   //next state logic
     begin                                //all states can be entered from any other state
	if (clear == 1'b1)
	  begin
	     next_state = CLEAR;
	  end
	else if (lock_db == 1'b1)
	  begin
	     next_state = LOCK;
	  end
	else if (store_tx_data == 1'b1)
	  begin
	     next_state = STORE;
	  end
	else if (get_rx_data == 1'b1)
	  begin
	     next_state = RECEIVE;
	  end
	else if (get_tx_packet_data == 1'b1)
	  begin
	     next_state = SEND_TX;
	  end
	else if (store_rx_packet_data == 1'b1)
	  begin
	     next_state = SEND_RX;
	  end
	else
	  begin
	     next_state = IDLE;
	  end
     end // always_comb
   
   always_ff @ (posedge clk, negedge n_rst)  //state registers
     begin
	if (n_rst == 1'b0)    //reset condition
	  begin
	     state <= IDLE;
	  end
	else        //updates state
	  begin
	     state <= next_state;
	  end
     end // always_ff @ (posedge clk, negedge n_rst)
   
   always_comb   //counter
     begin
	next_count1 = 0;
	next_count2 = 0;
	case(state)
	  IDLE : begin
	     next_count1 = count1;
	     next_count2 = count2;
	  end
	  STORE : begin            //increments highest occupied register to store 32 bits at a time
	     next_count1 = count1 + 4;
	  end
	  SEND_RX : begin          //increments highest occupied register to store 1 byte at a time
	     next_count1 = count1 + 1;
	  end
	  SEND_TX : begin          //increments lowest occupied register to send 1 byte at a time
	     next_count2 = count2 + 1;
	     if (next_count1 == next_count2)
	       begin               //resets counters to beginning when
		  next_count1 = 0; //counters reach each other and all
		  next_count2 = 0; //data bytes are empty
	       end
	  end
	  RECEIVE : begin          //increments lowest occupied register
	     if (data_size == 2'b00)
	       begin
		  next_count2 = count2 + 1;
	       end
	     if (data_size == 2'b00)
	       begin
		  next_count2 = count2 + 2;
	       end
	     if (data_size == 2'b00)
	       begin
		  next_count2 = count2 + 3;
	       end
	     if (data_size == 2'b00)
	       begin
		  next_count2 = count2 + 4;
	       end
	     if (next_count1 == next_count2)
	       begin               //resets counters to beginning when
		  next_count1 = 0; //counters reach each other and all
		  next_count2 = 0; //data bytes are empty
	       end
	  end
	  CLEAR : begin
	     next_count1 = 0;
	     next_count2 = 0;
	  end
	endcase // case (state)
	buffer_occupancy = count1 - count2;    //outputs current number of occupied bytes
     end // always_comb

   always_ff @ (posedge clk, negedge n_rst)    //counter storage
     begin
	if (n_rst == 1'b0)
	  begin
	     count1 <= 0;
	     count2 <= 0;
	  end
	else
	  begin
	     count1 <= next_count1;
	     count2 <= next_count2;
	  end
     end // always_ff @ (posedge clk, negedge n_rst)
      
   always_comb //data output and input control
     begin
	rx_data = 'b0;
	tx_packet_data = 'b0;
	new_data = 'b0;
	lock_error = 1'b0;
	
	case (state)
	  STORE : begin
	     new_data[0] = tx_data[7:0];
	     new_data[1] = tx_data[15:8];
	     new_data[2] = tx_data[23:16];
	     new_data[3] = tx_data[31:24];
	  end
	  RECEIVE : begin
	     new_data[0] = rx_packet_data;
	  end
	  SEND_TX : begin
	     tx_packet_data = data[count2];
	  end
	  SEND_RX : begin
	     if (data_size == 2'b00)
	       begin
		  rx_data[7:0] = data[count2];
	       end
	     if (data_size == 2'b01)
	       begin
		  rx_data[7:0] = data[count2];
		  rx_data[15:8] = data[count2 + 1];
	       end
	     if (data_size == 2'b10)
	       begin
		  rx_data[7:0] = data[count2];
		  rx_data[15:8] = data[count2 + 1];
		  rx_data[23:16] = data[count2 + 2];
	       end
	     if (data_size == 2'b11)
	       begin
		  rx_data[7:0] = data[count2];
		  rx_data[15:8] = data[count2 + 1];
		  rx_data[23:16] = data[count2 + 2];
		  rx_data[31:24] = data[count2 + 3];
	       end
	  end
	  CLEAR : begin
	  end
	  LOCK : begin
	     if (get_rx_data == 1'b1)
	       begin
		  lock_error = 1'b1;
	       end
	  end
	  
	endcase // case (state)
     end // always_comb

   always_ff @ (posedge clk, negedge n_rst)  //data storage
     begin
	if (n_rst == 1'b0)
	  begin
	     data <= 0;
	  end
	else
	  begin
	     if (state == RECEIVE)
	       begin
		  data[count1] <= new_data[0];
	       end
	     if (state == STORE)
	       begin
		  data[count1] <= new_data[0];
		  data[count1 + 1] <= new_data[1];
		  data[count1 + 2] <= new_data[2];
		  data[count1 + 3] <= new_data[3];
	       end
	  end // else: !if(n_rst == 1'b0)
     end // always_ff @ (posedge clk, negedge n_rst)
         
endmodule // data_buffer
