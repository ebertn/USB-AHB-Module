// $Id: $
// File name:   protocol_controller.sv
// Created:     4-13-19
// Author:      Mason Fritzen
// Lab Section: 002
// Version:     1.0  Initial Design Entry
// Description: Protocol Controller for CDL

`timescale 1ns/10ps



//rx_packet
localparam RX_IDLE = 3'b000;
localparam RX_READY = 3'b001;    //OUT Token
localparam RX_RECEIVED = 3'b010;
localparam RX_ERR = 3'b011;
localparam RX_BUSY = 3'b100;
localparam TX_ERR = 3'b101;
localparam TX_START = 3'b110;    //IN Token

localparam TX_IDLE = 2'b00;      //tx_packet
localparam SEND_DATA = 2'b01;
localparam SEND_ACK = 2'b10;
localparam SEND_NACK = 2'b11;

localparam TX_DEFAULT = 1'b0;  //tx_status
localparam FINISHED_SENDING = 1'b1;

module protocol_controller
  (
   input reg 	    clk,
   input reg 	    n_rst,
   input reg [2:0]  rx_packet, //from RX
   input reg 	    buffer_reserved, //from AHB Slave
   input reg [6:0]  buffer_occupancy, //from DB
   input reg 	    tx_status, //from TX
   input reg 	    lock_error,
   output reg 	    rx_data_ready, //to AHB Slave
   output reg 	    rx_transfer_active, //to AHB Slave
   output reg 	    rx_error, //to AHB Slave
   output reg 	    tx_transfer_active, //to AHB Slave
   output reg 	    tx_error, //to AHB Slave
   output reg 	    d_mode, //to external port
   output reg [1:0] tx_packet, //to TX
   output reg 	    clear, //to DB
   output reg 	    lock_db
   );

   typedef enum     {IDLE, RX_ACTIVE, RX_ERROR, PACKET_READY, RX_ACK, RX_NACK, RESERVED, START_TX, TX_ACTIVE, TX_ACK, TX_NACK, TX_ERROR, BUFFER_ERROR, LOCK} statetype;
   statetype state, next_state;
   
   always_comb   //next state logic
     begin
	next_state = IDLE;
	if (buffer_occupancy >= 7'b1000000)
	  begin
	     next_state = BUFFER_ERROR;
	  end
	case (state)
	  IDLE : begin
	     if ((rx_packet == RX_BUSY) || (rx_packet == RX_READY))
	       begin
		  next_state = RX_ACTIVE;
	       end
	     else if (buffer_reserved == 1'b1)
	       begin
		  next_state = RESERVED;
	       end
	     else if (rx_packet == TX_START)
	       begin
		  next_state = START_TX;
	       end
	     else if (rx_packet == TX_ERR)
	       begin
		  next_state = TX_ERROR;
	       end
	     else
	       begin
		  next_state = IDLE;
	       end
	  end // case: IDLE
	  RX_ACTIVE : begin
	     if (rx_packet == RX_BUSY)
	       begin
		  next_state = RX_ACTIVE;
	       end
	     else if ((rx_packet == RX_ERR) || (buffer_reserved == 1'b1))
	       begin
		  next_state = RX_ERROR;
	       end
	     else
	       begin
		  next_state = PACKET_READY;
	       end
	  end // case: RX_ACTIVE
	  RX_ERROR : begin
	     next_state = IDLE;
	  end
	  PACKET_READY : begin
	     if (buffer_reserved == 1'b1)
	       begin
		  next_state = RX_NACK;
	       end
	     else
	       begin
		  next_state = RX_ACK;
	       end
	  end
	  RX_ACK : begin
	     if (tx_status == FINISHED_SENDING)
	       begin
		  next_state = IDLE;
	       end
	     else
	       begin
		  next_state = RX_ACK;
	       end
	  end
	  RX_NACK : begin
	     if (tx_status == FINISHED_SENDING)
	       begin
		  next_state = IDLE;
	       end
	     else
	       begin
		  next_state = RX_NACK;
	       end
	  end
	  RESERVED : begin
	     if ((rx_packet == RX_BUSY) || (rx_packet == RX_READY))
	       begin
		  next_state = LOCK;
	       end
	     else if (buffer_reserved == 1'b0)
	       begin
		  next_state = IDLE;
	       end
	     else
	       begin
		  next_state = RESERVED;
	       end
	  end // case: RESERVED
	  LOCK : begin
	     if ((rx_packet == RX_BUSY) || (rx_packet == RX_READY))
	       begin
		  next_state = LOCK;
	       end
	     else
	       begin
		  next_state = RESERVED;
	       end
	  end
	  START_TX : begin
	     if (buffer_reserved == 1'b1)
	       begin
		  next_state = TX_NACK;
	       end
	     else
	       begin
		  next_state = TX_ACTIVE;
	       end
	  end
	  TX_ACTIVE : begin
	     if (tx_status == FINISHED_SENDING)
	       begin
		  next_state = TX_ACK;
	       end
	     else
	       begin
		  next_state = TX_ACTIVE;
	       end
	  end
	  TX_ACK : begin
	     if (tx_status == FINISHED_SENDING)
	       begin
		  next_state = IDLE;
	       end
	     else
	       begin
		  next_state = TX_ACK;
	       end
	  end
	  TX_NACK : begin
	     if (tx_status == FINISHED_SENDING)
	       begin
		  next_state = IDLE;
	       end
	     else
	       begin
		  next_state = TX_NACK;
	       end
	  end
	  TX_ERROR : begin
	     next_state = IDLE;
	  end
	  BUFFER_ERROR : begin
	     next_state = IDLE;
	  end
	endcase // case (state)
     end // always_comb
   
   always_ff @ (posedge clk, negedge n_rst)
     begin
	if (n_rst == 1'b0)
	  begin
	     state <= IDLE;
	  end
	else
	  begin
	     state <= next_state;
	  end
     end // always_ff @ (posedge clk, negedge n_rst)

   always_comb   //output logic
     begin
 	rx_data_ready = 1'b0;
	rx_transfer_active = 1'b0;
	rx_error = 1'b0;
	tx_transfer_active = 1'b0;
	tx_error = 1'b0;
	d_mode = 1'b0;
	tx_packet = TX_IDLE;
	clear = 1'b0;
	lock_db = 1'b0;
			
	case (state)
	  IDLE : begin
	  end // case: IDLE
	  RX_ACTIVE : begin
	     rx_transfer_active = 1'b1;
	  end // case: RX_ACTIVE
	  
	  RX_ERROR : begin
	     rx_error = 1'b1;
	     clear = 1'b1;
	  end
	  
	  PACKET_READY : begin
	     rx_data_ready = 1'b1;
	  end
	  
	  RX_ACK : begin
	     tx_packet = SEND_ACK;
	  end
	  
	  RX_NACK : begin
	     tx_packet = SEND_NACK;
	  end
	  
	  RESERVED : begin
	     lock_db = 1'b1;
	  end

	  LOCK : begin
	     tx_packet = SEND_NACK;
	  end
	  	  
	  START_TX : begin
	     d_mode = 1'b1;
	  end
	  
	  TX_ACTIVE : begin
	     tx_packet = SEND_DATA;
	     tx_transfer_active = 1'b1;
	  end
	  
	  TX_ACK : begin
	     tx_packet = SEND_ACK;
	  end
	  
	  TX_NACK : begin
	     tx_packet = SEND_NACK;
	  end
	  
	  TX_ERROR : begin
	     tx_error = 1'b1;
	     clear = 1'b1;
	  end
	  BUFFER_ERROR : begin
	     clear = 1'b1;
	  end
	endcase // case (state)
     end // always_comb
   
endmodule // protocol_controller

