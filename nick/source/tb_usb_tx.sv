// $Id: $
// File name:   tb_usb_tx.sv
// Created:     4-18-19
// Author:      Mason Fritzen
// Lab Section: 002
// Version:     1.0  Initial Design Entry
// Description: Test bench for the USB TX module

`timescale 1ns / 10ps

module tb_usb_tx();

   //local parameters
   localparam CLK_PERIOD = 10;         //constant values taken from syncronizer test bench
   localparam FF_SETUP_TIME = 0.190;  //not sure if these will be different for this design
   localparam FF_HOLD_TIME = 0.100;
   localparam CHECK_DELAY = (CLK_PERIOD - FF_SETUP_TIME);
   //tx_packet
   localparam IDLE = 2'b00;
   localparam SEND_DATA = 2'b01;
   localparam SEND_ACK = 2'b10;
   localparam SEND_NACK = 2'b11;
   //outgoing data
   localparam NACK_CODE = 8'b10100101;
   localparam ACK_CODE = 8'b10110100; //8'b00101101;
   localparam DATA_CODE = 8'b00111100;
   
   //DUT portmap signals
   reg tb_clk;
   reg tb_n_rst;
   reg tb_get_tx_packet_data;
   reg [7:0] tb_tx_packet_data;
   reg [6:0] tb_tx_packet_data_size;
   reg [1:0] tb_tx_packet;
   reg tb_tx_status;
   reg tb_d_plus_out;
   reg tb_d_minus_out;
   
   //test bench signals
   int tb_test_num;
   string tb_test_case;
   reg [7:0][63:0] data_to_send;
   reg [7:0][63:0] expected_data_to_send;
   reg [7:0] 	   sync_byte = 8'b00000001;//8'b00000001;
   reg [7:0] 	   expected_tb_d_plus_out;
   reg [7:0] 	   expected_tb_d_minus_out;
   reg [15:0] 	   crc;
   int 		   count1;
   int 		   count2;
   logic [7:0] 	   data_for_crc;
               
   /////////////////////
   // reset procedure //
   /////////////////////
   task reset_dut;
      begin
	 tb_n_rst = 1'b0;

	 @ (posedge tb_clk);
	 @ (posedge tb_clk);

	 @ (negedge tb_clk);
	 tb_n_rst = 1'b1;

	 @ (negedge tb_clk);
	 @ (negedge tb_clk);

      end
   endtask // reset_dut

   ////////////////////////////////////////////
   // checks outputs against expected values //
   ////////////////////////////////////////////
   task check_output;
      input logic expected_value;
      input logic test_value;
      input string signal_name;
      input string extra_info;
      
      begin
	 if (test_value == expected_value)
	   begin
	      $info("Output %s correct for test case %d %s", signal_name, tb_test_num, extra_info);
	   end
	 else
	   begin
	      $error("ERROR: Output %s incorrect for test case %d %s", signal_name, tb_test_num, extra_info);
	   end
      end
   endtask // check_output

   //////////////////////////////////////
   // checks outputs for metastability //
   //////////////////////////////////////
   task check_output_meta;
      input logic test_value;
      input string signal_name;
      
      begin
	 if ((test_value == 1'b1) || (test_value == 1'b0))
	   begin
	      $info("Valid %s during metastability check for test case %d", signal_name, tb_test_num);
	   end
	 else
	   begin
	      $error("ERROR: Output %s METASTABLE for test case %d", signal_name, tb_test_num);
	   end
      end
   endtask // check_output_meta

   //////////////////
   // sends signal //
   //////////////////
   task send_signal;
      input logic [1:0]       tx_packet_input;
      input logic [7:0][63:0] packet_data_input;
      input logic [6:0]       data_size_input;
      input logic [7:0][63:0] expected_data;

      int 		      x;
      int 		      i;
            
      begin
	 tb_tx_packet = tx_packet_input;
	 tb_tx_packet_data_size = data_size_input;

	 //sync byte transmission
	 $info("Encoding sync");
	 encode_output(sync_byte);
	 delay(16);
	 $info(expected_tb_d_plus_out);
	 for (x=0; x<8; x++)
	   begin
	      check_output(expected_tb_d_plus_out[7-x], tb_d_plus_out, "d_plus_out", "for sync byte transmission");
	      check_output(expected_tb_d_minus_out[7-x], tb_d_minus_out, "d_minus_out", "for sync byte transmission");
	      delay(8);
	   end

	 //regular transmission (includes ACK and NACK)
	 for (x=0; x<data_size_input; x++)
	   begin
	      tb_tx_packet_data = packet_data_input[x];
	      $info("Encoding ack");
	      encode_output(tb_tx_packet_data);
	      for(i=0; i<8; i++)
		begin
		   //check_output(expected_tb_d_plus_out[7-i], tb_d_plus_out, "d_plus_out", tb_test_case);
		   //check_output(expected_tb_d_minus_out[7-i], tb_d_minus_out, "d_minus_out", tb_test_case);
		   check_output(expected_data[x][i], tb_d_plus_out, "d_plus_out", "for sync byte transmission");
	           check_output(~expected_data[x][i], tb_d_minus_out, "d_minus_out", "for sync byte transmission");
		   delay(8);
		end
	   end
	 	
	 if(tb_tx_packet == 2'b01) begin
	 //CRC stuff
	 for (x=0; x<2; x++)
	   begin
	      encode_output(crc[x]);
	      for (i=0; i<8; i++)
		begin
		   delay(8);
		   check_output(expected_tb_d_plus_out, tb_d_plus_out, "d_plus_out", "for CRC bits");
		   check_output(expected_tb_d_minus_out, tb_d_minus_out, "d_minus_out", "for CRC bits");
		end
	   end
	  end
	 
	 //delay(8);
	 //check_output(1'b1, tb_tx_status, "tx_status", "for EOP signal");
	 check_output(1'b0, tb_d_plus_out, "d_plus_out", "for EOP signal");
	 check_output(1'b0, tb_d_minus_out, "d_minus_out", "for EOP signal");
	 tb_tx_packet = 2'b00;
	 delay(16);
      end
   endtask // send_signal

   ///////////////////
   // encode output //
   ///////////////////
   task encode_output;
      input logic [7:0] serial_in;

      logic [8:0] 	encoded_out;
      int 		x;
            
      begin
	 //expected_tb_d_plus_out[0] = !tb_d_plus_out;
	 //expected_tb_d_minus_out[0] = tb_d_plus_out;
	 encoded_out[8] = tb_d_plus_out;//1'b1;

	 for (x = 7; x >= 0; x--)
	   begin
	      //delay(8);
	      if (serial_in[x] == 1'b0)
		begin
		   encoded_out[x] = !encoded_out[x+1];
		end
	      else
		begin
		   encoded_out[x] = encoded_out[x+1];
		end
	   end // for (x=1, x<8; x++)
	 expected_tb_d_plus_out = encoded_out[7:0];
	 expected_tb_d_minus_out = ~encoded_out[7:0];
      end
   endtask // encode_output

   ////////////////////
   // CRC generation //
   ////////////////////
   task generate_crc;
      input logic d_in;
      
      int i;
      logic xor1;
      logic xor2;
      logic xor3;
            
      begin
	 xor3 = d_in ^ crc[15];
	 xor2 = crc[14] ^ xor3;
	 xor1 = crc[1] ^ xor3;
	 
	 crc[15] = xor2;
	 crc[14] = crc[13];
	 crc[13] = crc[12];
	 crc[12] = crc[11];
	 crc[11] = crc[10];
	 crc[10] = crc[9];
	 crc[9] = crc[8];
	 crc[8] = crc[7];
	 crc[7] = crc[6];
	 crc[6] = crc[5];
	 crc[5] = crc[4];
	 crc[4] = crc[3];
	 crc[3] = crc[2];
	 crc[2] = xor1;
	 crc[1] = crc[0];
	 crc[1] = xor3;
      end
   endtask // generate_crc
   
   //////////////////////
   // delays operation //
   //////////////////////
   task delay;
      input int delay_num;
      int 	x;
      
      begin
	 for (x=0; x<delay_num; x++)
	   begin
	      @ (posedge tb_clk);
	   end
      end
   endtask // delay
           
   //////////////////////
   // Clock Generation //
   //////////////////////
   always
     begin
	tb_clk = 1'b0;
	#(CLK_PERIOD / 2.0);
	tb_clk = 1'b1;
	#(CLK_PERIOD / 2.0);
     end
   
   //DUT portmap
   usb_tx DUT (.clk(tb_clk),
	       .n_rst(tb_n_rst),
	       .get_tx_packet_data(tb_get_tx_packet_data),
	       .tx_packet_data(tb_tx_packet_data),
	       .tx_packet_data_size(tb_tx_packet_data_size),
	       .tx_packet(tb_tx_packet),
	       .tx_status(tb_tx_status),
	       .dplus_out(tb_d_plus_out),
	       .dminus_out(tb_d_minus_out));

   /////////////////////                                       /////////////////////////////////////////////
   // testing process //                                       // test case guide //////////////////////////
   /////////////////////                                       /////////////////////////////////////////////
   initial                                                     // test case 1 : power on reset /////////////
     begin                                                     // test case 2 : NACK transmission //////////
	tb_test_num = 0;                                       // test case 3 : ACK transmission ///////////
	tb_n_rst = 1'b1;                                       // test case 4 : 1 byte data transmission ///
	tb_tx_packet = 2'b00;                                  // test case 5 : 2 byte data transmission ///
	tb_tx_packet_data = 'b0;                               // test case 6 : 3 byte data transmission ///
	tb_tx_packet_data_size = 'b0;                          // test case 7 : 4 byte data transmission ///
	tb_test_case = "Test Bench Initialization";            // test case 8 : 5 byte data transmission ///
                                                               // test case 9 : 6 byte data transmission ///
	#0.1;                                                  // test case 10: 7 byte data transmission ///
                                                               // test case 11: 8 byte data transmission ///
	///////////////////////////////                        // test case 12: 16 byte data transmission //
	//Test Case 1: Power on reset//                        // test case 13: 24 byte data transmission //
	///////////////////////////////                        // test case 14: 32 byte data transmission //
                                                               // test case 15: 40 byte data transmission //
	tb_test_num += 1;                                      // test case 16: 48 byte data transmission //
	tb_test_case = "Power on reset";                       // test case 17: 56 byte data transmission //
	#0.1;                                                  // test case 18: 64 byte data transmission //
                                                               /////////////////////////////////////////////
	tb_n_rst = 1'b0;
	tb_tx_packet = 'b0;
	tb_tx_packet_data = 'b0;
	tb_tx_packet_data_size = 'b0;
	#(CLK_PERIOD / 2.0);
	
	check_output(1'b0, tb_d_minus_out, "d_minus_out", "");
	check_output(1'b1, tb_d_plus_out, "d_plus_out", "");
	check_output(1'b0, tb_get_tx_packet_data, "tx_packet_data", "");
	check_output(1'b0, tb_tx_status, "tx_status", "");
	
	#CLK_PERIOD;

	check_output(1'b0, tb_d_minus_out, "d_minus_out", "one clock cycle after reset");
	check_output(1'b1, tb_d_plus_out, "d_plus_out", "one clock cycle after reset");
	check_output(1'b0, tb_get_tx_packet_data, "get_tx_packet_data", "one clock cycle after reset");
	check_output(1'b0, tb_tx_status, "tx_status", "one clock cycle after reset");

	@ (posedge tb_clk);
	#(FF_HOLD_TIME * 2);
	tb_n_rst = 1'b1;
	#0.1;
		
	check_output(1'b0, tb_d_minus_out, "d_minus_out", "after reset was deactivated");
	check_output(1'b1, tb_d_plus_out, "d_plus_out", "after reset was deactivated");
	check_output(1'b0, tb_get_tx_packet_data, "tx_packet_data", "after reset was deactivated");
	check_output(1'b0, tb_tx_status, "tx_status", "after reset was deactivated");

	////////////////////////////////////
	// Test Case 2: NACK Transmission //
	////////////////////////////////////
	@ (negedge tb_clk);
	tb_test_num += 1;
	tb_test_case = "NACK transmission";

	tb_tx_packet = 'b0;
	tb_tx_packet_data = 'b0;
	tb_tx_packet_data_size = 7'b0000001;
	data_to_send = 0;
	crc = 0;
			
	reset_dut();

	@ (posedge tb_clk);
	@ (posedge tb_clk);
	data_to_send[0] = NACK_CODE;
	expected_data_to_send[0] = 8'b00110110;
	@ (posedge tb_clk);

	for (count1=0; count1<tb_tx_packet_data_size; count1++)
	  begin
	     data_for_crc = data_to_send[count1];
	     for (count2=0; count2<8; count2++)
	       begin
		  @ (posedge tb_clk);
		  generate_crc(data_for_crc[count2]);
	       end
	  end
	
	send_signal(SEND_NACK, data_to_send, 7'b0000001, expected_data_to_send);//8'b01101100);

	@ (posedge tb_clk);
	
	///////////////////////////
	// Test Case 3: Send ACK //
	///////////////////////////
	@ (negedge tb_clk);
	tb_test_num += 1;
	tb_test_case = "ACK Transmission";

	tb_tx_packet = 'b0;
	tb_tx_packet_data = 'b0;
	tb_tx_packet_data_size = 7'b0000001;
	data_to_send = 0;
	crc = 0;
		
	reset_dut();

	@ (posedge tb_clk);
	@ (posedge tb_clk);
	data_to_send[0] = ACK_CODE;
	expected_data_to_send[0] = 8'b00111001;
	@ (posedge tb_clk);

	for (count1=0; count1<tb_tx_packet_data_size; count1++)
	  begin
	     data_for_crc = data_to_send[count1];
	     for (count2=0; count2<8; count2++)
	       begin
		  @ (posedge tb_clk);
		  generate_crc(data_for_crc[count2]);
	       end
	  end
	
	send_signal(SEND_ACK, data_to_send, 7'b0000001, expected_data_to_send);//8'b10011100);

	@ (posedge tb_clk);
	
	
	///////////////////////////////////////////
	// Test Case 4: 1-Byte Data Transmission //
	///////////////////////////////////////////
	@ (negedge tb_clk);
	tb_test_num +=1;
	tb_test_case = "1-Byte Data Transmission";

	tb_tx_packet = 'b0;
	tb_tx_packet_data = 'b0;
	tb_tx_packet_data_size = 7'd2;
	data_to_send = 0;
	crc = 0;
	
	reset_dut();
	
	@ (posedge tb_clk);
	@ (posedge tb_clk);
	data_to_send[0] = DATA_CODE;
	data_to_send[1] = 8'b01100111;
	expected_data_to_send[0] = 8'b10000010;
	expected_data_to_send[1] = 8'b11101111;
	@ (posedge tb_clk);

	for (count1=0; count1<tb_tx_packet_data_size; count1++)
	  begin
	     data_for_crc = data_to_send[count1];
	     for (count2=0; count2<8; count2++)
	       begin
		  @ (posedge tb_clk);
		  generate_crc(data_for_crc[count2]);
	       end
	  end
	
	send_signal(SEND_DATA, data_to_send, 7'b0000001, expected_data_to_send);

	@ (posedge tb_clk);
	/*
	///////////////////////////////////////////
	// Test Case 5: 2-Byte Data Transmission //
	///////////////////////////////////////////
	@ (negedge tb_clk);
	tb_test_num += 1;
	tb_test_case = "2-Byte Data Transmission";

	tb_tx_packet = 'b0;
	tb_tx_packet_data = 'b0;
	tb_tx_packet_data_size = 7'b0000010;
	data_to_send = 0;
	crc = 0;
	
	reset_dut();

	@ (posedge tb_clk);
	@ (posedge tb_clk);
	data_to_send[0] = 8'b01011001;
	data_to_send[1] = 8'b11100110;
	@ (posedge tb_clk);

	for (count1=0; count1<tb_tx_packet_data_size; count1++)
	  begin
	     data_for_crc = data_to_send[count1];
	     for (count2=0; count2<8; count2++)
	       begin
		  @ (posedge tb_clk);
		  generate_crc(data_for_crc[count2]);
	       end
	  end
	
	send_signal(SEND_DATA, data_to_send, 7'b0000010);

	@ (posedge tb_clk);

	///////////////////////////////////////////
	// Test Case 6: 3-Byte Data Transmission //
	///////////////////////////////////////////
	@ (negedge tb_clk);
	tb_test_num += 1;
	tb_test_case = "3-Byte Data Transmission";

	tb_tx_packet = 'b0;
	tb_tx_packet_data = 'b0;
	tb_tx_packet_data_size = 7'b0000011;
	data_to_send = 0;
	crc = 0;
	
	reset_dut();

	@ (posedge tb_clk);
	@ (posedge tb_clk);
	data_to_send[0] = 8'b00011001;
	data_to_send[1] = 8'b00110011;
	data_to_send[2] = 8'b11110000;
	@ (posedge tb_clk);

	for (count1=0; count1<tb_tx_packet_data_size; count1++)
	  begin
	     data_for_crc = data_to_send[count1];
	     for (count2=0; count2<8; count2++)
	       begin
		  @ (posedge tb_clk);
		  generate_crc(data_for_crc[count2]);
	       end
	  end
	
	send_signal(SEND_DATA, data_to_send, 7'b0000011);

	@ (posedge tb_clk);

	///////////////////////////////////////////
	// Test Case 7: 4-Byte Data Transmission //
	///////////////////////////////////////////
	@ (negedge tb_clk);
	tb_test_num += 1;
	tb_test_case = "4-Byte Data Transmission";

	tb_tx_packet = 'b0;
	tb_tx_packet_data = 'b0;
	tb_tx_packet_data_size = 7'b0000100;
	data_to_send = 0;
	crc = 0;
	
	reset_dut();

	@ (posedge tb_clk);
	@ (posedge tb_clk);
	data_to_send[0] = 8'b00001111;
	data_to_send[1] = 8'b00110011;
	data_to_send[2] = 8'b01101100;
	data_to_send[3] = 8'b11011100;
	@ (posedge tb_clk);

	for (count1=0; count1<tb_tx_packet_data_size; count1++)
	  begin
	     data_for_crc = data_to_send[count1];
	     for (count2=0; count2<8; count2++)
	       begin
		  @ (posedge tb_clk);
		  generate_crc(data_for_crc[count2]);
	       end
	  end
	
	send_signal(SEND_DATA, data_to_send, 7'b0000100);

	@ (posedge tb_clk);

	///////////////////////////////////////////
	// Test Case 8: 5-Byte Data Transmission //
	///////////////////////////////////////////
	@ (negedge tb_clk);
	tb_test_num += 1;
	tb_test_case = "5-Byte Data Transmission";


	tb_tx_packet = 'b0;
	tb_tx_packet_data = 'b0;
	tb_tx_packet_data_size = 7'b0000101;
	data_to_send = 0;
	crc = 0;
	
	reset_dut();

	@ (posedge tb_clk);
	@ (posedge tb_clk);
	data_to_send[0] = 8'b00111001;
	data_to_send[1] = 8'b01010101;
	data_to_send[2] = 8'b10101010;
	data_to_send[3] = 8'b11101110;
	data_to_send[4] = 8'b00100100;
	@ (posedge tb_clk);

	for (count1=0; count1<tb_tx_packet_data_size; count1++)
	  begin
	     data_for_crc = data_to_send[count1];
	     for (count2=0; count2<8; count2++)
	       begin
		  @ (posedge tb_clk);
		  generate_crc(data_for_crc[count2]);
	       end
	  end
	
	send_signal(SEND_DATA, data_to_send, 7'b0000101);

	@ (posedge tb_clk);

	///////////////////////////////////////////
	// Test Case 9: 6-Byte Data Transmission //
	///////////////////////////////////////////
	@ (negedge tb_clk);
	tb_test_num += 1;
	tb_test_case = "6-Byte Data Transmission";

	tb_tx_packet = 'b0;
	tb_tx_packet_data = 'b0;
	tb_tx_packet_data_size = 7'b0000110;
	data_to_send = 0;
	crc = 0;
	
	reset_dut();

	@ (posedge tb_clk);
	@ (posedge tb_clk);
	data_to_send[0] = 8'b00110101;
	data_to_send[1] = 8'b01110010;
	data_to_send[2] = 8'b11000101;
	data_to_send[3] = 8'b00111101;
	data_to_send[4] = 8'b11001111;
	data_to_send[5] = 8'b10000110;
	@ (posedge tb_clk);

	for (count1=0; count1<tb_tx_packet_data_size; count1++)
	  begin
	     data_for_crc = data_to_send[count1];
	     for (count2=0; count2<8; count2++)
	       begin
		  @ (posedge tb_clk);
		  generate_crc(data_for_crc[count2]);
	       end
	  end
	
	send_signal(SEND_DATA, data_to_send, 7'b0000110);

	@ (posedge tb_clk);

	////////////////////////////////////////////
	// Test Case 10: 7-Byte Data Transmission //
	////////////////////////////////////////////
	@ (negedge tb_clk);
	tb_test_num += 1;
	tb_test_case = "7-Byte Data Transmission";

	tb_tx_packet = 'b0;
	tb_tx_packet_data = 'b0;
	tb_tx_packet_data_size = 7'b0000111;
	data_to_send = 0;
	crc = 0;
	
	reset_dut();

	@ (posedge tb_clk);
	@ (posedge tb_clk);
	data_to_send[0] = 8'b11010110;
	data_to_send[1] = 8'b00011010;
	data_to_send[2] = 8'b11110101;
	data_to_send[3] = 8'b01010001;
	data_to_send[4] = 8'b11111001;
	data_to_send[5] = 8'b00111011;
	data_to_send[6] = 8'b10000110;
	@ (posedge tb_clk);

	for (count1=0; count1<tb_tx_packet_data_size; count1++)
	  begin
	     data_for_crc = data_to_send[count1];
	     for (count2=0; count2<8; count2++)
	       begin
		  @ (posedge tb_clk);
		  generate_crc(data_for_crc[count2]);
	       end
	  end
	
	send_signal(SEND_DATA, data_to_send, 7'b0000111);

	@ (posedge tb_clk);

	////////////////////////////////////////////
	// Test Case 11: 8-Byte Data Transmission //
	////////////////////////////////////////////
	@ (negedge tb_clk);
	tb_test_num += 1;
	tb_test_case = "8-Byte Data Transmission";

	tb_tx_packet = 'b0;
	tb_tx_packet_data = 'b0;
	tb_tx_packet_data_size = 7'b0001000;
	data_to_send = 0;
	crc = 0;
	
	reset_dut();

	@ (posedge tb_clk);
	@ (posedge tb_clk);
	data_to_send[0] = 8'b00011010;
	data_to_send[1] = 8'b10101011;
	data_to_send[2] = 8'b00101101;
	data_to_send[3] = 8'b11111000;
	data_to_send[4] = 8'b01110100;
	data_to_send[5] = 8'b00101110;
	data_to_send[6] = 8'b00110001;
	data_to_send[7] = 8'b11011010;
	@ (posedge tb_clk);

	for (count1=0; count1<tb_tx_packet_data_size; count1++)
	  begin
	     data_for_crc = data_to_send[count1];
	     for (count2=0; count2<8; count2++)
	       begin
		  @ (posedge tb_clk);
		  generate_crc(data_for_crc[count2]);
	       end
	  end
	
	send_signal(SEND_DATA, data_to_send, 7'b0001000);

	@ (posedge tb_clk);

	/////////////////////////////////////////////
	// Test Case 12: 16-Byte Data Transmission //
	/////////////////////////////////////////////
	@ (negedge tb_clk);
	tb_test_num += 1;
	tb_test_case = "16-Byte Data Transmission";

	tb_tx_packet = 'b0;
	tb_tx_packet_data = 'b0;
	tb_tx_packet_data_size = 7'b0010000;
	data_to_send = 0;
	crc = 0;
	
	reset_dut();

	@ (posedge tb_clk);
	@ (posedge tb_clk);
	data_to_send[0] = 8'b00011010;
	data_to_send[1] = 8'b10101011;
	data_to_send[2] = 8'b00101101;
	data_to_send[3] = 8'b11111000;
	data_to_send[4] = 8'b01110100;
	data_to_send[5] = 8'b00101110;
	data_to_send[6] = 8'b00110001;
	data_to_send[7] = 8'b11011010;
	data_to_send[8] = 8'b00011010;
	data_to_send[9] = 8'b10101011;
	data_to_send[10] = 8'b00101101;
	data_to_send[11] = 8'b11111000;
	data_to_send[12] = 8'b01110100;
	data_to_send[13] = 8'b00101110;
	data_to_send[14] = 8'b00110001;
	data_to_send[15] = 8'b11011010;
	@ (posedge tb_clk);

	for (count1=0; count1<tb_tx_packet_data_size; count1++)
	  begin
	     data_for_crc = data_to_send[count1];
	     for (count2=0; count2<8; count2++)
	       begin
		  @ (posedge tb_clk);
		  generate_crc(data_for_crc[count2]);
	       end
	  end
	
	send_signal(SEND_DATA, data_to_send, 7'b0010000);

	@ (posedge tb_clk);

	/////////////////////////////////////////////
	// Test Case 13: 24-Byte Data Transmission //
	/////////////////////////////////////////////
	@ (negedge tb_clk);
	tb_test_num += 1;
	tb_test_case = "24-Byte Data Transmission";

	tb_tx_packet = 'b0;
	tb_tx_packet_data = 'b0;
	tb_tx_packet_data_size = 7'b0011000;
	data_to_send = 0;
	crc = 0;
	
	reset_dut();

	@ (posedge tb_clk);
	@ (posedge tb_clk);
	data_to_send[0] = 8'b00011010;
	data_to_send[1] = 8'b10101011;
	data_to_send[2] = 8'b00101101;
	data_to_send[3] = 8'b11111000;
	data_to_send[4] = 8'b01110100;
	data_to_send[5] = 8'b00101110;
	data_to_send[6] = 8'b00110001;
	data_to_send[7] = 8'b11011010;
	data_to_send[8] = 8'b00011010;
	data_to_send[9] = 8'b10101011;
	data_to_send[10] = 8'b00101101;
	data_to_send[11] = 8'b11111000;
	data_to_send[12] = 8'b01110100;
	data_to_send[13] = 8'b00101110;
	data_to_send[14] = 8'b00110001;
	data_to_send[15] = 8'b11011010;
	data_to_send[16] = 8'b00011010;
	data_to_send[17] = 8'b10101011;
	data_to_send[18] = 8'b00101101;
	data_to_send[19] = 8'b11111000;
	data_to_send[20] = 8'b01110100;
	data_to_send[21] = 8'b00101110;
	data_to_send[22] = 8'b00110001;
	data_to_send[23] = 8'b11011010;
	@ (posedge tb_clk);

	for (count1=0; count1<tb_tx_packet_data_size; count1++)
	  begin
	     data_for_crc = data_to_send[count1];
	     for (count2=0; count2<8; count2++)
	       begin
		  @ (posedge tb_clk);
		  generate_crc(data_for_crc[count2]);
	       end
	  end
	
	send_signal(SEND_DATA, data_to_send, 7'b0011000);

	@ (posedge tb_clk);

	/////////////////////////////////////////////
	// Test Case 14: 32-Byte Data Transmission //
	/////////////////////////////////////////////
	@ (negedge tb_clk);
	tb_test_num += 1;
	tb_test_case = "32-Byte Data Transmission";

	tb_tx_packet = 'b0;
	tb_tx_packet_data = 'b0;
	tb_tx_packet_data_size = 7'b0100000;
	data_to_send = 0;
	crc = 0;
	
	reset_dut();

	@ (posedge tb_clk);
	@ (posedge tb_clk);
	data_to_send[0] = 8'b00011010;
	data_to_send[1] = 8'b10101011;
	data_to_send[2] = 8'b00101101;
	data_to_send[3] = 8'b11111000;
	data_to_send[4] = 8'b01110100;
	data_to_send[5] = 8'b00101110;
	data_to_send[6] = 8'b00110001;
	data_to_send[7] = 8'b11011010;
	data_to_send[8] = 8'b00011010;
	data_to_send[9] = 8'b10101011;
	data_to_send[10] = 8'b00101101;
	data_to_send[11] = 8'b11111000;
	data_to_send[12] = 8'b01110100;
	data_to_send[13] = 8'b00101110;
	data_to_send[14] = 8'b00110001;
	data_to_send[15] = 8'b11011010;
	data_to_send[16] = 8'b00011010;
	data_to_send[17] = 8'b10101011;
	data_to_send[18] = 8'b00101101;
	data_to_send[19] = 8'b11111000;
	data_to_send[20] = 8'b01110100;
	data_to_send[21] = 8'b00101110;
	data_to_send[22] = 8'b00110001;
	data_to_send[23] = 8'b11011010;
	data_to_send[24] = 8'b00011010;
	data_to_send[25] = 8'b10101011;
	data_to_send[26] = 8'b00101101;
	data_to_send[27] = 8'b11111000;
	data_to_send[28] = 8'b01110100;
	data_to_send[29] = 8'b00101110;
	data_to_send[30] = 8'b00110001;
	data_to_send[31] = 8'b11011010;
	@ (posedge tb_clk);

	for (count1=0; count1<tb_tx_packet_data_size; count1++)
	  begin
	     data_for_crc = data_to_send[count1];
	     for (count2=0; count2<8; count2++)
	       begin
		  @ (posedge tb_clk);
		  generate_crc(data_for_crc[count2]);
	       end
	  end
	
	send_signal(SEND_DATA, data_to_send, 7'b0100000);

	@ (posedge tb_clk);

	/////////////////////////////////////////////
	// Test Case 15: 40-Byte Data Transmission //
	/////////////////////////////////////////////
	@ (negedge tb_clk);
	tb_test_num += 1;
	tb_test_case = "40-Byte Data Transmission";

	tb_tx_packet = 'b0;
	tb_tx_packet_data = 'b0;
	tb_tx_packet_data_size = 7'b0101000;
	data_to_send = 0;
	crc = 0;
	
	reset_dut();

	@ (posedge tb_clk);
	@ (posedge tb_clk);
	data_to_send[0] = 8'b00011010;
	data_to_send[1] = 8'b10101011;
	data_to_send[2] = 8'b00101101;
	data_to_send[3] = 8'b11111000;
	data_to_send[4] = 8'b01110100;
	data_to_send[5] = 8'b00101110;
	data_to_send[6] = 8'b00110001;
	data_to_send[7] = 8'b11011010;
	data_to_send[8] = 8'b00011010;
	data_to_send[9] = 8'b10101011;
	data_to_send[10] = 8'b00101101;
	data_to_send[11] = 8'b11111000;
	data_to_send[12] = 8'b01110100;
	data_to_send[13] = 8'b00101110;
	data_to_send[14] = 8'b00110001;
	data_to_send[15] = 8'b11011010;
	data_to_send[16] = 8'b00011010;
	data_to_send[17] = 8'b10101011;
	data_to_send[18] = 8'b00101101;
	data_to_send[19] = 8'b11111000;
	data_to_send[20] = 8'b01110100;
	data_to_send[21] = 8'b00101110;
	data_to_send[22] = 8'b00110001;
	data_to_send[23] = 8'b11011010;
	data_to_send[24] = 8'b00011010;
	data_to_send[25] = 8'b10101011;
	data_to_send[26] = 8'b00101101;
	data_to_send[27] = 8'b11111000;
	data_to_send[28] = 8'b01110100;
	data_to_send[29] = 8'b00101110;
	data_to_send[30] = 8'b00110001;
	data_to_send[31] = 8'b11011010;
	data_to_send[32] = 8'b00011010;
	data_to_send[33] = 8'b10101011;
	data_to_send[34] = 8'b00101101;
	data_to_send[35] = 8'b11111000;
	data_to_send[36] = 8'b01110100;
	data_to_send[37] = 8'b00101110;
	data_to_send[38] = 8'b00110001;
	data_to_send[39] = 8'b11011010;
	@ (posedge tb_clk);

	for (count1=0; count1<tb_tx_packet_data_size; count1++)
	  begin
	     data_for_crc = data_to_send[count1];
	     for (count2=0; count2<8; count2++)
	       begin
		  @ (posedge tb_clk);
		  generate_crc(data_for_crc[count2]);
	       end
	  end
	
	send_signal(SEND_DATA, data_to_send, 7'b0101000);

	@ (posedge tb_clk);

	/////////////////////////////////////////////
	// Test Case 16: 48-Byte Data Transmission //
	/////////////////////////////////////////////
	@ (negedge tb_clk);
	tb_test_num += 1;
	tb_test_case = "48-Byte Data Transmission";

	tb_tx_packet = 'b0;
	tb_tx_packet_data = 'b0;
	tb_tx_packet_data_size = 7'b0110000;
	data_to_send = 0;
	crc = 0;
	
	reset_dut();

	@ (posedge tb_clk);
	@ (posedge tb_clk);
	data_to_send[0] = 8'b00011010;
	data_to_send[1] = 8'b10101011;
	data_to_send[2] = 8'b00101101;
	data_to_send[3] = 8'b11111000;
	data_to_send[4] = 8'b01110100;
	data_to_send[5] = 8'b00101110;
	data_to_send[6] = 8'b00110001;
	data_to_send[7] = 8'b11011010;
	data_to_send[8] = 8'b00011010;
	data_to_send[9] = 8'b10101011;
	data_to_send[10] = 8'b00101101;
	data_to_send[11] = 8'b11111000;
	data_to_send[12] = 8'b01110100;
	data_to_send[13] = 8'b00101110;
	data_to_send[14] = 8'b00110001;
	data_to_send[15] = 8'b11011010;
	data_to_send[16] = 8'b00011010;
	data_to_send[17] = 8'b10101011;
	data_to_send[18] = 8'b00101101;
	data_to_send[19] = 8'b11111000;
	data_to_send[20] = 8'b01110100;
	data_to_send[21] = 8'b00101110;
	data_to_send[22] = 8'b00110001;
	data_to_send[23] = 8'b11011010;
	data_to_send[24] = 8'b00011010;
	data_to_send[25] = 8'b10101011;
	data_to_send[26] = 8'b00101101;
	data_to_send[27] = 8'b11111000;
	data_to_send[28] = 8'b01110100;
	data_to_send[29] = 8'b00101110;
	data_to_send[30] = 8'b00110001;
	data_to_send[31] = 8'b11011010;
	data_to_send[32] = 8'b00011010;
	data_to_send[33] = 8'b10101011;
	data_to_send[34] = 8'b00101101;
	data_to_send[35] = 8'b11111000;
	data_to_send[36] = 8'b01110100;
	data_to_send[37] = 8'b00101110;
	data_to_send[38] = 8'b00110001;
	data_to_send[39] = 8'b11011010;
	data_to_send[40] = 8'b00011010;
	data_to_send[41] = 8'b10101011;
	data_to_send[42] = 8'b00101101;
	data_to_send[43] = 8'b11111000;
	data_to_send[44] = 8'b01110100;
	data_to_send[45] = 8'b00101110;
	data_to_send[46] = 8'b00110001;
	data_to_send[47] = 8'b11011010;
	@ (posedge tb_clk);

	for (count1=0; count1<tb_tx_packet_data_size; count1++)
	  begin
	     data_for_crc = data_to_send[count1];
	     for (count2=0; count2<8; count2++)
	       begin
		  @ (posedge tb_clk);
		  generate_crc(data_for_crc[count2]);
	       end
	  end
	
	send_signal(SEND_DATA, data_to_send, 7'b0110000);

	@ (posedge tb_clk);

	/////////////////////////////////////////////
	// Test Case 17: 56-Byte Data Transmission //
	/////////////////////////////////////////////
	@ (negedge tb_clk);
	tb_test_num += 1;
	tb_test_case = "56-Byte Data Transmission";

	tb_tx_packet = 'b0;
	tb_tx_packet_data = 'b0;
	tb_tx_packet_data_size = 7'b0111000;
	data_to_send = 0;
	crc = 0;
	
	reset_dut();

	@ (posedge tb_clk);
	@ (posedge tb_clk);
	data_to_send[0] = 8'b00011010;
	data_to_send[1] = 8'b10101011;
	data_to_send[2] = 8'b00101101;
	data_to_send[3] = 8'b11111000;
	data_to_send[4] = 8'b01110100;
	data_to_send[5] = 8'b00101110;
	data_to_send[6] = 8'b00110001;
	data_to_send[7] = 8'b11011010;
	data_to_send[8] = 8'b00011010;
	data_to_send[9] = 8'b10101011;
	data_to_send[10] = 8'b00101101;
	data_to_send[11] = 8'b11111000;
	data_to_send[12] = 8'b01110100;
	data_to_send[13] = 8'b00101110;
	data_to_send[14] = 8'b00110001;
	data_to_send[15] = 8'b11011010;
	data_to_send[16] = 8'b00011010;
	data_to_send[17] = 8'b10101011;
	data_to_send[18] = 8'b00101101;
	data_to_send[19] = 8'b11111000;
	data_to_send[20] = 8'b01110100;
	data_to_send[21] = 8'b00101110;
	data_to_send[22] = 8'b00110001;
	data_to_send[23] = 8'b11011010;
	data_to_send[24] = 8'b00011010;
	data_to_send[25] = 8'b10101011;
	data_to_send[26] = 8'b00101101;
	data_to_send[27] = 8'b11111000;
	data_to_send[28] = 8'b01110100;
	data_to_send[29] = 8'b00101110;
	data_to_send[30] = 8'b00110001;
	data_to_send[31] = 8'b11011010;
	data_to_send[32] = 8'b00011010;
	data_to_send[33] = 8'b10101011;
	data_to_send[34] = 8'b00101101;
	data_to_send[35] = 8'b11111000;
	data_to_send[36] = 8'b01110100;
	data_to_send[37] = 8'b00101110;
	data_to_send[38] = 8'b00110001;
	data_to_send[39] = 8'b11011010;
	data_to_send[40] = 8'b00011010;
	data_to_send[41] = 8'b10101011;
	data_to_send[42] = 8'b00101101;
	data_to_send[43] = 8'b11111000;
	data_to_send[44] = 8'b01110100;
	data_to_send[45] = 8'b00101110;
	data_to_send[46] = 8'b00110001;
	data_to_send[47] = 8'b11011010;
	data_to_send[48] = 8'b00011010;
	data_to_send[49] = 8'b10101011;
	data_to_send[50] = 8'b00101101;
	data_to_send[51] = 8'b11111000;
	data_to_send[52] = 8'b01110100;
	data_to_send[53] = 8'b00101110;
	data_to_send[54] = 8'b00110001;
	data_to_send[55] = 8'b11011010;
	@ (posedge tb_clk);

	for (count1=0; count1<tb_tx_packet_data_size; count1++)
	  begin
	     data_for_crc = data_to_send[count1];
	     for (count2=0; count2<8; count2++)
	       begin
		  @ (posedge tb_clk);
		  generate_crc(data_for_crc[count2]);
	       end
	  end
	
	send_signal(SEND_DATA, data_to_send, 7'b0111000);

	@ (posedge tb_clk);

	/////////////////////////////////////////////
	// Test Case 18: 64-Byte Data Transmission //
	/////////////////////////////////////////////
	@ (negedge tb_clk);
	tb_test_num += 1;
	tb_test_case = "64-Byte Data Transmission";

	tb_tx_packet = 'b0;
	tb_tx_packet_data = 'b0;
	tb_tx_packet_data_size = 7'b1000000;
	data_to_send = 0;
	crc = 0;
	
	reset_dut();

	@ (posedge tb_clk);
	@ (posedge tb_clk);
	data_to_send[0] = 8'b00011010;
	data_to_send[1] = 8'b10101011;
	data_to_send[2] = 8'b00101101;
	data_to_send[3] = 8'b11111000;
	data_to_send[4] = 8'b01110100;
	data_to_send[5] = 8'b00101110;
	data_to_send[6] = 8'b00110001;
	data_to_send[7] = 8'b11011010;
	data_to_send[8] = 8'b00011010;
	data_to_send[9] = 8'b10101011;
	data_to_send[10] = 8'b00101101;
	data_to_send[11] = 8'b11111000;
	data_to_send[12] = 8'b01110100;
	data_to_send[13] = 8'b00101110;
	data_to_send[14] = 8'b00110001;
	data_to_send[15] = 8'b11011010;
	data_to_send[16] = 8'b00011010;
	data_to_send[17] = 8'b10101011;
	data_to_send[18] = 8'b00101101;
	data_to_send[19] = 8'b11111000;
	data_to_send[20] = 8'b01110100;
	data_to_send[21] = 8'b00101110;
	data_to_send[22] = 8'b00110001;
	data_to_send[23] = 8'b11011010;
	data_to_send[24] = 8'b00011010;
	data_to_send[25] = 8'b10101011;
	data_to_send[26] = 8'b00101101;
	data_to_send[27] = 8'b11111000;
	data_to_send[28] = 8'b01110100;
	data_to_send[29] = 8'b00101110;
	data_to_send[30] = 8'b00110001;
	data_to_send[31] = 8'b11011010;
	data_to_send[32] = 8'b00011010;
	data_to_send[33] = 8'b10101011;
	data_to_send[34] = 8'b00101101;
	data_to_send[35] = 8'b11111000;
	data_to_send[36] = 8'b01110100;
	data_to_send[37] = 8'b00101110;
	data_to_send[38] = 8'b00110001;
	data_to_send[39] = 8'b11011010;
	data_to_send[40] = 8'b00011010;
	data_to_send[41] = 8'b10101011;
	data_to_send[42] = 8'b00101101;
	data_to_send[43] = 8'b11111000;
	data_to_send[44] = 8'b01110100;
	data_to_send[45] = 8'b00101110;
	data_to_send[46] = 8'b00110001;
	data_to_send[47] = 8'b11011010;
	data_to_send[48] = 8'b00011010;
	data_to_send[49] = 8'b10101011;
	data_to_send[50] = 8'b00101101;
	data_to_send[51] = 8'b11111000;
	data_to_send[52] = 8'b01110100;
	data_to_send[53] = 8'b00101110;
	data_to_send[54] = 8'b00110001;
	data_to_send[55] = 8'b11011010;
	data_to_send[56] = 8'b00011010;
	data_to_send[57] = 8'b10101011;
	data_to_send[58] = 8'b00101101;
	data_to_send[59] = 8'b11111000;
	data_to_send[60] = 8'b01110100;
	data_to_send[61] = 8'b00101110;
	data_to_send[62] = 8'b00110001;
	data_to_send[63] = 8'b11011010;
	@ (posedge tb_clk);

	for (count1=0; count1<tb_tx_packet_data_size; count1++)
	  begin
	     data_for_crc = data_to_send[count1];
	     for (count2=0; count2<8; count2++)
	       begin
		  @ (posedge tb_clk);
		  generate_crc(data_for_crc[count2]);
	       end
	  end
	
	send_signal(SEND_DATA, data_to_send, 7'b1000000);

	@ (posedge tb_clk);
	*/
     end // initial begin
endmodule // tb_usb_tx

