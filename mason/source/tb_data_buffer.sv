
`timescale 1ns / 10ps

module tb_data_buffer();

   //local parameters
   localparam CLK_PERIOD = 10;

   //DUT signals
   reg tb_clk;
   reg tb_n_rst;
   reg [31:0] tb_rx_data;
   reg 	      tb_get_rx_data;
   reg 	      tb_store_tx_data;
   reg [31:0] tb_tx_data;
   reg [1:0]  tb_data_size;
   reg [7:0]  tb_tx_packet_data;
   reg 	      tb_get_tx_packet_data;
   reg [7:0]  tb_rx_packet_data;
   reg [6:0]  tb_buffer_occupancy;
   reg 	      tb_store_rx_packet_data;
   reg 	      tb_clear;
   reg 	      tb_lock_error;
   reg 	      tb_lock_db;
   
   //test bench signals
   reg 	      tb_test_num;
   string     tb_test_case;
   reg [7:0]  expected_buffer_occupancy;
   int 	      x;
   
   /////////////////////////
   // standard reset task //
   /////////////////////////
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

   /////////////////////////////////////
   // check output for expected value //
   /////////////////////////////////////
   task check_output;
      input logic  test_value;
      input logic  expected_value;
      input string signal_name;
      input string test_case;
      begin
	 if (test_value == expected_value)
	   begin
	      $info("Output %s = %d is correct for test case %d %s", signal_name, test_value, tb_test_num, test_case);
	   end
	 else
	   begin
	      $error("ERROR: %s = %d is incorrect for test case %d %s", signal_name, test_value, tb_test_num, test_case);
	   end
      end
   endtask // ckeck_output

   ////////////////////////////////////
   // check output for metastability //
   ////////////////////////////////////
   task check_output_meta;
      input logic test_value;
      input string signal_name;
      begin
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

   ///////////////////////
   // check data output //
   ///////////////////////
   task check_data_output;
      begin
	 if (tb_tx_packet_data != 'b0)
	   begin
	      $info("TX Packet Data successful output");
	   end
	 else
	   begin
	      $error("ERROR: TX Packet Data not successfully output");
	   end
      end
   endtask // check_data_output

   /////////////////////
   // check RX output //
   /////////////////////
   task check_rx_output;
      begin
	 if (tb_rx_data != 'b0)
	   begin
	      $info("RX Data successful output");
	   end
	 else
	   begin
	      $error("ERROR: RX Data not successfully output");
	   end
      end
   endtask // check_rx_output
         
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
   data_buffer data_buffer(
      .clk(tb_clk),
      .n_rst(tb_n_rst),
      .rx_data(tb_rx_data),
      .get_rx_data(tb_get_rx_data),
      .store_tx_data(tb_store_tx_data),
      .tx_data(tb_tx_data),
      .data_size(tb_data_size),
      .tx_packet_data(tb_tx_packet_data),
      .get_tx_packet_data(tb_get_tx_packet_data),
      .buffer_occupancy(tb_buffer_occupancy),
      .rx_packet_data(tb_rx_packet_data),
      .store_rx_packet_data(tb_store_rx_packet_data),
      .clear(tb_clear),
      .lock_db(tb_lock_db),
      .lock_error(tb_lock_error)
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
	tb_lock_db = 1'b0;
	#0.1;

	/////////////////////////////////
	// Test Case 1: Power on reset //
	/////////////////////////////////

	tb_test_num += 1;
	tb_test_case = "Power on reset";
	#0.1;

	tb_n_rst = 1'b0;
	tb_clear = 1'b1;
	tb_get_rx_data = 1'b0;
	tb_store_tx_data = 1'b0;
	tb_tx_data = 'b0;
	tb_data_size = 'b0;
	tb_get_tx_packet_data = 1'b0;
	tb_rx_packet_data = 'b0;
	tb_store_rx_packet_data = 1'b0;
	tb_lock_db = 1'b0;

	@ (posedge tb_clk);
	tb_clear = 1'b0;
	
	#(CLK_PERIOD/2.0);

	check_output(tb_lock_error, 1'b0, "lock_error", tb_test_case);
	
	#CLK_PERIOD;

	check_output(tb_lock_error, 1'b0, "lock_error", "one clock cycle after reset");

	@ (posedge tb_clk);

	tb_n_rst = 1'b1;
	#0.1;

	check_output(tb_lock_error, 1'b0, "lock_error", "after reset is over");


	@ (posedge tb_clk);
	reset_dut();
	@ (posedge tb_clk);
 
		
	/////////////////////////////////////////
	// Test Case 2: Small Transfer from RX //
	/////////////////////////////////////////
	tb_test_num += 1;
	tb_test_case = "Small transfer from RX";

	tb_store_rx_packet_data = 1'b1;
	tb_rx_packet_data = 8'b11011001;
	@ (posedge tb_clk);
	tb_store_rx_packet_data = 1'b0;

	@ (posedge tb_clk);
	@ (posedge tb_clk);
		
	expected_buffer_occupancy = 7'b0000001;
	for (x=0; x<7; x++)
	  begin
	     check_output(tb_buffer_occupancy[x], expected_buffer_occupancy[x], "buffer_occupancy", tb_test_case);
	  end

	@ (posedge tb_clk);


	///////////////////////////////////////
	// Test Case 3: Small Transfer to TX //
	///////////////////////////////////////
	tb_test_num += 1;
	tb_test_case = "Small transfer to TX";

	tb_get_tx_packet_data = 1'b1;
        @ (posedge tb_clk);
	check_data_output();
	tb_get_tx_packet_data = 1'b0;

	expected_buffer_occupancy = 7'b0000000;
	for (x=0; x<7; x++)
	  begin
	     check_output(tb_buffer_occupancy[x], expected_buffer_occupancy[x], "buffer_occupancy", tb_test_case);
	  end


	@ (posedge tb_clk);
	reset_dut();
	@ (posedge tb_clk);


	/////////////////////////////////////////
	// Test Case 4: Large Transfer from RX //
	/////////////////////////////////////////
	tb_test_num += 1;
	tb_test_case = "Large transfer from RX";

	tb_store_rx_packet_data = 1'b1;
	tb_rx_packet_data = 8'b11110000;
        for (x=0; x<16; x++)
	  begin
	     tb_rx_packet_data = 8'b11001010;
	     @ (posedge tb_clk);
	  end
	tb_store_rx_packet_data = 1'b0;

	expected_buffer_occupancy = 7'b0001101;
	for (x=0; x<7; x++)
	  begin
	     check_output(tb_buffer_occupancy[x], expected_buffer_occupancy[x], "buffer_occupancy", tb_test_case);
	  end

	@ (posedge tb_clk);


	///////////////////////////////////////
	// Test Case 5: Large Transfer to TX //
	///////////////////////////////////////
	tb_test_num += 1;
	tb_test_case = "Large transfer to TX";

	tb_get_tx_packet_data = 1'b1;
        for (x=0; x<16; x++)
	  begin
	     @ (posedge tb_clk);
	     check_data_output();
	  end
	tb_get_tx_packet_data = 1'b0;

	expected_buffer_occupancy = 7'b0000000;
	for (x=0; x<7; x++)
	  begin
	     check_output(tb_buffer_occupancy[x], expected_buffer_occupancy[x], "buffer_occupancy", tb_test_case);
	  end


	@ (posedge tb_clk);
	reset_dut();
	@ (posedge tb_clk);


	////////////////////////////////////////////
	// Test Case 6: Max Size Transfer from RX //
	////////////////////////////////////////////
	tb_test_num += 1;
	tb_test_case = "Large transfer from RX";

	tb_store_rx_packet_data = 1'b1;
	for (x=0; x<64; x++)
	  begin
	     tb_rx_packet_data = 8'b11001010;
	     @ (posedge tb_clk);
	  end
	tb_store_rx_packet_data = 1'b0;

	expected_buffer_occupancy = 7'b1000000;
	for (x=0; x<7; x++)
	  begin
	     check_output(tb_buffer_occupancy[x], expected_buffer_occupancy[x], "buffer_occupancy", tb_test_case);
	  end

	@ (posedge tb_clk);


	//////////////////////////////////////////
	// Test Case 7: Max Size Transfer to TX //
	//////////////////////////////////////////
	tb_test_num += 1;
	tb_test_case = "Large transfer to TX";

	tb_get_tx_packet_data = 1'b1;
        for (x=0; x<64; x++)
	  begin
	     @ (posedge tb_clk);
	     check_data_output();
	  end
	tb_get_tx_packet_data = 1'b0;

	expected_buffer_occupancy = 7'b0000000;
	for (x=0; x<7; x++)
	  begin
	     check_output(tb_buffer_occupancy[x], expected_buffer_occupancy[x], "buffer_occupancy", tb_test_case);
	  end


	@ (posedge tb_clk);
	reset_dut();
	@ (posedge tb_clk);


	//////////////////////////////////////////
	// Test Case 8: Small Transfer from AHB //
	//////////////////////////////////////////
	tb_test_num += 1;
	tb_test_case = "Small Transfer from AHB";

	tb_store_tx_data = 1'b1;
	tb_tx_data = 'b1;
	@ (posedge tb_clk);
	tb_store_tx_data = 1'b0;

	expected_buffer_occupancy = 7'b0000100;
	for (x=0; x<7; x++)
	  begin
	     check_output(tb_buffer_occupancy[x], expected_buffer_occupancy[x], "buffer_occupancy", tb_test_case);
	  end

	@ (posedge tb_clk);


	////////////////////////////////////////
	// Test Case 9: Small Transfer to AHB //
	////////////////////////////////////////
	tb_test_num += 1;
	tb_test_case = "Small Transfer to AHB";

	tb_get_rx_data = 1'b1;
	tb_data_size = 2'b11;
	@ (posedge tb_clk);
	check_rx_output();
	tb_get_rx_data = 1'b0;

	expected_buffer_occupancy = 7'b0000000;
	for (x=0; x<7; x++)
	  begin
	     check_output(tb_buffer_occupancy[x], expected_buffer_occupancy[x], "buffer_occupancy", tb_test_case);
	  end


	@ (posedge tb_clk);
	reset_dut();
	@ (posedge tb_clk);


	///////////////////////////////////////////
	// Test Case 10: Large Transfer from AHB //
	///////////////////////////////////////////
	tb_test_num += 1;
	tb_test_case = "Large Transfer from AHB";

	tb_store_tx_data = 1'b1;
	for (x=0; x<8; x++)
	  begin
	     tb_tx_data = 'b1;
	     @ (posedge tb_clk);
	  end
	tb_store_tx_data = 1'b0;

	expected_buffer_occupancy = 7'b0100000;
	for (x=0; x<7; x++)
	  begin
	     check_output(tb_buffer_occupancy[x], expected_buffer_occupancy[x], "buffer_occupancy", tb_test_case);
	  end

	@ (posedge tb_clk);


	/////////////////////////////////////////
	// Test Case 11: Large Transfer to AHB //
	/////////////////////////////////////////
	tb_test_num += 1;
	tb_test_case = "Small Transfer to AHB";

	tb_get_rx_data = 1'b1;
	tb_data_size = 2'b11;
	for (x=0; x<8; x++)
	  begin
	     @ (posedge tb_clk);
	     check_rx_output();
	  end
	tb_get_rx_data = 1'b0;

	expected_buffer_occupancy = 7'b0000000;
	for (x=0; x<7; x++)
	  begin
	     check_output(tb_buffer_occupancy[x], expected_buffer_occupancy[x], "buffer_occupancy", tb_test_case);
	  end

	@ (posedge tb_clk);
	reset_dut();
	@ (posedge tb_clk);


	//////////////////////////////////////////////
	// Test Case 12: Max Size Transfer from AHB //
	//////////////////////////////////////////////
	tb_test_num += 1;
	tb_test_case = "Large Transfer from AHB";

	tb_store_tx_data = 1'b1;
	for (x=0; x<16; x++)
	  begin
	     tb_tx_data = 'b1;
	     @ (posedge tb_clk);
	  end
	tb_store_tx_data = 1'b0;

	expected_buffer_occupancy = 7'b1000000;
	for (x=0; x<7; x++)
	  begin
	     check_output(tb_buffer_occupancy[x], expected_buffer_occupancy[x], "buffer_occupancy", tb_test_case);
	  end

	@ (posedge tb_clk);


	////////////////////////////////////////////
	// Test Case 13: Max Size Transfer to AHB //
	////////////////////////////////////////////
	tb_test_num += 1;
	tb_test_case = "Small Transfer to AHB";

	tb_get_rx_data = 1'b1;
	tb_data_size = 2'b11;
	for (x=0; x<16; x++)
	  begin
	     @ (posedge tb_clk);
	     check_rx_output();
	  end
	tb_get_rx_data = 1'b0;

	expected_buffer_occupancy = 7'b0000000;
	for (x=0; x<7; x++)
	  begin
	     check_output(tb_buffer_occupancy[x], expected_buffer_occupancy[x], "buffer_occupancy", tb_test_case);
	  end

	@ (posedge tb_clk);
	reset_dut();
	@ (posedge tb_clk);


     end // initial begin
endmodule // tb_data_buffer
