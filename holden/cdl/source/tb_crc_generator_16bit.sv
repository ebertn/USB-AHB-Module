`timescale 1ns / 10ps

module tb_crc_generator_16bit ();

//**************************************************************
// Constants
//**************************************************************
localparam CLK_PERIOD = 10;
localparam CRC_SIZE = 16;
localparam MAX_DATA_SIZE = 64;
localparam MAX_DATA_BIT = MAX_DATA_SIZE - 1;
localparam MAX_CRC_BIT = CRC_SIZE - 1;


//**************************************************************
// TB Signals
//**************************************************************
logic tb_mismatch;
logic tb_check;
logic [15:0] tb_expected_crc;
string tb_test_case;
integer tb_test_case_num;
logic [MAX_DATA_BIT:0] tb_test_data;


//**************************************************************
// System Signals
//**************************************************************
logic tb_clk;
logic tb_n_rst;


//**************************************************************
// CRC Checker Signals
//**************************************************************
logic tb_din;
logic tb_clear;
logic tb_shiftEn;
logic [15:0] tb_crc;


//**************************************************************
// Clock Generation Block
//**************************************************************
always begin
	tb_clk = 1'b0;
	#(CLK_PERIOD / 2.0);
	tb_clk = 1'b1;
	#(CLK_PERIOD / 2.0);
end


//**************************************************************
// DUT Instance
//**************************************************************
crc_generator_16bit DUT (
	.clk(tb_clk),
	.nRst(tb_n_rst),
	.din(tb_din),
	.shiftEn(tb_shiftEn),
	.clear(tb_clear),
	.crc(tb_crc)
);


//**************************************************************
// DUT Related TB Tasks
//**************************************************************
// Task for reseting DUT
task reset_dut;
begin
	// Activate the rest
	tb_n_rst = 1'b0;

  // Maintain the reset for more than one cycle
  @(posedge tb_clk);
  @(posedge tb_clk);

  // Wait until safely away from rising edge of the clock before releasing
  @(negedge tb_clk);
  tb_n_rst = 1'b1;

  // Leave out of reset for a couple cycles before allowing other stimulus
  // Wait for negative clock edges, 
  // since inputs to DUT should normally be applied away from rising clock edges
  @(negedge tb_clk);
  @(negedge tb_clk);
  @(posedge tb_clk);  // align everything
end
endtask


// Task to cleanly and consistently check DUT output values
task check_outputs;
  input string check_tag;
begin
  tb_mismatch = 1'b0;
  tb_check    = 1'b1;
  if (tb_expected_crc != tb_crc) begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'crc' output %s during %s test case", check_tag, tb_test_case);
  end
  // Wait some small amount of time so check pulse timing is visible on waves
  #(0.1);
  tb_check =1'b0;
end
endtask


// Task to send stream of data
task send_data;
	input [MAX_DATA_BIT:0] message;
	integer i;
begin
	@(negedge tb_clk);
	tb_shiftEn = 1'b1;
	for (i = 0; i <= MAX_DATA_BIT; i++) begin
		tb_din = message[i];
		#(CLK_PERIOD);
	end
	tb_din = 1'b0;
	tb_shiftEn = 1'b0;
end
endtask


//*****************************************************************************
//*****************************************************************************
// Main TB Process
//*****************************************************************************
//*****************************************************************************
initial begin
	tb_test_case		= "Initialization";
	tb_test_case_num	= -1;
	tb_check			= 1'b0;
	tb_mismatch			= 1'b0;
	tb_n_rst			= 1'b1;
	tb_din				= 1'b0;
	tb_clear			= 1'b0;
	tb_test_data		= '0;
	tb_expected_crc	    = '0;
	tb_shiftEn			= 1'b0;

	// Wait some time before starting first test case
	#(0.1);


	//*****************************************************************************
	// Test Case: Power-On-Reset
	//*****************************************************************************
	tb_test_case	 = "Power-on-Reset";
	tb_test_case_num = tb_test_case_num + 1;

	// Reset the module
	reset_dut();
	
	// Set and check the expected output
	tb_expected_crc = '0;
	check_outputs("after reseting DUT");
	
	// Give some visual spacing between check and next test case start
	#(CLK_PERIOD * 2);


	//*****************************************************************************
	// Test Case: Random Test #1
	//*****************************************************************************
	tb_test_case	 = "Random Test #1";
	tb_test_case_num = tb_test_case_num + 1;

	// Set and send data
	tb_test_data = 64'h1023456789ABCDEF;
	send_data(tb_test_data);
	
	// Set and check the expected output
	tb_expected_crc = 16'h01B9;
	check_outputs("after testing first random number");

	// Clear the crc
	@(negedge tb_clk);
	tb_clear = 1'b1;
	#(CLK_PERIOD);
	tb_clear = 1'b0;
	
	// Set and check the expected output
	tb_expected_crc = '0;
	check_outputs("after clearing random test #2");
	
	// Give some visual spacing between check and next test case start
	#(CLK_PERIOD * 2);

	//*****************************************************************************
	// Test Case: Random Test #2
	//*****************************************************************************
	tb_test_case	 = "Random Test #2";
	tb_test_case_num = tb_test_case_num + 1;

	// Set and send data
	tb_test_data = 64'h9AFFC3E0079CF65E;
	send_data(tb_test_data);

	// Set and check the expected output
	tb_expected_crc = 16'h3D21;
	check_outputs("after random test #2");

	// Clear the crc
	@(negedge tb_clk);
	tb_clear = 1'b1;
	#(CLK_PERIOD);
	tb_clear = 1'b0;
	
	// Set and check the expected output
	tb_expected_crc = '0;
	check_outputs("after clearing random test #2");

	// Give some visual spacing between check and next test case start
	#(CLK_PERIOD * 2);

	//*****************************************************************************
	// Test Case: Random Test #3
	//*****************************************************************************
	tb_test_case	 = "Random Test #3";
	tb_test_case_num = tb_test_case_num + 1;

	// Set and send data
	tb_test_data = 64'h0000FFFF0000FFFF;
	send_data(tb_test_data);

	// Set and check the expected output
	tb_expected_crc = 16'h02F4;
	check_outputs("after testing third random number");

	// Clear the crc
	@(negedge tb_clk);
	tb_clear = 1'b1;
	#(CLK_PERIOD);
	tb_clear = 1'b0;
	
	// Set and check the expected output
	tb_expected_crc = '0;
	check_outputs("after clearing random test #2");
	
	// Give some visual spacing between check and next test case start
	#(CLK_PERIOD * 2);


	//*****************************************************************************
	// Test Case: Reset in Middle of Two
	//*****************************************************************************
	tb_test_case	 = "Reset in Middle of Two";
	tb_test_case_num = tb_test_case_num + 1;

	// Set and send data
	tb_test_data = 64'hCDEF0000FFFF9999;
	send_data(tb_test_data);

	// Set and check the expected output
	tb_expected_crc = 16'hB28D;
	check_outputs("before resetting DUT");

	// Reset the module
	reset_dut();
	
	// Set and send data
	tb_test_data = 64'h5555555555555555;
	send_data(tb_test_data);

	// Set and check the expected output
	tb_expected_crc = 16'h7C3D;
	check_outputs("after reseting DUT");

	// Clear the crc
	@(negedge tb_clk);
	tb_clear = 1'b1;
	#(CLK_PERIOD);
	tb_clear = 1'b0;
	
	// Set and check the expected output
	tb_expected_crc = '0;
	check_outputs("after clearing random test #2");
	
	// Give some visual spacing between check and next test case start
	#(CLK_PERIOD * 2);

	//*****************************************************************************
	// Test Case: Random Test #4
	//*****************************************************************************
	tb_test_case	 = "Random Test #4";
	tb_test_case_num = tb_test_case_num + 1;

	// Set and send data
	tb_test_data = 64'hABCD01234567EF01;
	send_data(tb_test_data);

	// Set and check the expected output
	tb_expected_crc = 16'hAA8D;
	check_outputs("after Random Test #4");
	
	// Clear the checker
	@(negedge tb_clk);
	tb_clear = 1'b1;
	#(CLK_PERIOD);
	tb_clear = 1'b0;

	// Set and check the expected output
	tb_expected_crc = '0;
	check_outputs("after clearing Random Test #4");

	// Give some visual spacing between check and next test case start
	#(CLK_PERIOD * 2);

end
endmodule