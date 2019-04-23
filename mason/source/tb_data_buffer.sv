
`timescale 1ns / 10ps

module tb_data_buffer();

   //local parameters
   localparam CLK_PERIOD = 10;

   //DUT signals
   reg tb_clk;
   reg tb_n_rst;
   reg [31:0] tb_rx_data;
   reg 	      tb_get_rx_data;
   reg 	      tb_store_data;
   reg [31:0] tb_tx_data;
   reg [1:0]  tb_data_size;
   reg [7:0]  tb_tx_packet_data;
   reg 	      tb_get_tx_packet_data;
   reg [7:0]  tb_rx_packet_data;
   reg 	      tb_store_rx_packet_data;

   //test bench signals
   reg 	      tb_test-num;
   string     tb_test_case;

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
   task ckeck_output;
      begin
	 input string signal_name;
	 input logic  test_value;
	 input logic  expected_value;

	 if (test_value == expected_value)
	   begin
	      $info("Output %s = %d is correct for test case %d", signal_name, test_value, tb_test_num);
	   end
	 else
	   begin
	      $error("ERROR: %s = %d is incorrect for test case %d", signal_name, test_value, tb_test_num);
	   end
      end
   endtask // ckeck_output

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
   // clock generation //
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
   data_buffer data_buffer
     (
      .clk(tb_clk),
      .n_rst(tb_n_rst)
      .rx_data(tb_rx_data),
      .get_rx_data(tb_get_rx_data),
      .store_data(tb_store_data),
      .tx_data(tb_tx_data),
      .data_size(data_size),
      .tx_packet_data(tb_tx_packet_data),
      .get_tx_packet_data(tb_get_tx_packet_data),
      .rx_packet_data(tb_rx_packet_data),
      .store_rx_packet_data(tb_store_rx_packet_data),
      );

   /////////////////////
   // testing process //
   /////////////////////
   initial
     begin
	tb_test_num = 0;
	tb_test_case = "Test bench initialization";
	tb_n_rst = 1'b1;
	tb_get_rx_data = 'b0;
	tb_store_tx_data = 'b0;
	tb_tx_data = 'b0;
	tb_data_size = 'b0;
	tb_get_tx_packet_data = 'b0;
	tb_rx_packet_data = 'b0;
	tb_store_rx_packet_data = 'b0;
	#0.1;

	/////////////////////////////////
	// Test Case 1: Power on reset //
	/////////////////////////////////
	
