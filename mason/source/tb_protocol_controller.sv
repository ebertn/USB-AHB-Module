
`timescale 1ns / 10ps

module tb_protocol_controller();

   //localparameters
   localparam CLK_PERIOD = 10;
      
   //DUT signals
   reg tb_clk;
   reg tb_n_rst;
   reg tb_rx_data_ready;
   reg tb_rx_transfer_active;
   reg tb_rx_error;
   reg tb_tx_transfer_active;
   reg tb_tx_error;
   reg tb_buffer_reserved;
   reg [6:0] tb_buffer_occupancy;
   reg 	     tb_clear;
   reg [1:0] tb_tx_packet;
   reg 	     tb_d_mode;
   reg [2:0] tb_rx_packet;
   reg 	     tb_tx_status;
      
   //test bench signals
   reg 	     tb_test_num;
   string    tb_test_case;

   /////////////////////////
   // standard reset task //
   /////////////////////////
   task reset_dut;
      begin
	 tb_n_rst = 1'b0;
	 
	 @ (posedge clk);
	 @ (posedge clk);
	 @ (negedge clk);

	 tb_n_rst = 1'b1;

	 @ (negedge clk);
	 @ (negedge clk);
      end
   endtask // reset_dut

   /////////////////////////////////////
   // check output for expected value //
   /////////////////////////////////////
   task check_output;
      begin
	 input string signal_name;
	 input logic  test_value;
	 input logic expected_value;

	 if (test_value == expected_value)
	   begin
	      $info("Output %s = %d is correct for test case %d", signal_name, test_value, tb_test_num);
	   end
	 else
	   begin
	      $error("ERROR: %s = %d is incorrect for test case %d", signal_name, test_value, tb_test_num);
	   end
      end
   endtask // check_output
      
   ////////////////////////////////////
   // check output for metastability //
   ////////////////////////////////////
   task check_output_meta;
      begin
	 input logic test_value;
	 input string signal_name;
	 
	 if ((test_value == 1'b1) || (test_value == 1'b0))
	   begin
	      $info("Output %s is stable for test case %d", signal_name, tb_test_num);
	   end
	 else
	   begin
	      $error("ERROR: Output %s is metastable for test case %d", signal_name, tb_test_num);
	   end
      end
   endtask // check_output_meta
      
   //////////////////////
   // clock_generation //
   //////////////////////
   always
     begin
	tb_clk = 1'b1;
	#(CLK_PERIOD/2.0);
	tb_clk = 1'b0;
	#(CLK_PERIOD/2.0);
     end
   
   /////////////
   // portmap //
   /////////////
   protocol_controller protocol_controller
     (
      .clk(tb_clk),
      .n_rst(tb_n_rst),
      .rx_data_ready(tb_rx_data_ready),
      .rx_transfer_active(tb_rx_transfer_active),
      .rx_error(tb_rx_error),
      .tx_transfer_active(tb_tx_transfer_active),
      .tx_error(tb_tx_error),
      .buffer_reserved(tb_buffer_reserved),
      .buffer_occupancy(tb_buffer_occupancy),
      .clear(tb_clear),
      .tx_packet(tb_tx_packet),
      .d_mode(tb_d_mode),
      .rx_packet(tb_rx_packet),
      .tx_status(tb_tx_status)
      );
   
   /////////////////////
   // testing process //
   /////////////////////
   initial
     begin
	tb_test_num = 0;
	tb_test_case = "Test bench initialization";
	tb_n_rst = 1'b1;
	tb_buffer_reserved = 1'b0;
	tb_buffer_occupancy = 'b0;
	tb_rx_packet = 'b0;
	tb_tx_status = 1'b0;
	#0.1;

	/////////////////////////////////
	// Test Case 1: Power on reset //
	/////////////////////////////////
	
