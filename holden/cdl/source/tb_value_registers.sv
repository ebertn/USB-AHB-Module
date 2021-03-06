`timescale 1ns / 10ps

module tb_value_registers ();

//**************************************************************
// Constants
//**************************************************************
localparam CLK_PERIOD = 10;


//**************************************************************
// TB Signals
//**************************************************************
logic tb_mismatch;
logic tb_check;
string tb_test_case;
integer tb_test_case_num;

logic [15:0] tb_expected_statusData;
logic [15:0] tb_expected_errorData;
logic [7:0] tb_expected_boData;
logic [7:0] tb_expected_ehtsData;


//**************************************************************
// System Signals
//**************************************************************
logic tb_clk;
logic tb_nRst;


//**************************************************************
// IO Signals
//**************************************************************
logic tb_rxDataReady;
logic tb_rxTransferActive;
logic tb_txTransferActive;
logic tb_txError;
logic tb_rxError;
logic [6:0] tb_bufferOccupancy;
logic [7:0] tb_nextEHTSData;
logic [15:0] tb_statusData;
logic [15:0] tb_errorData;
logic [7:0] tb_boData;
logic [7:0] tb_ehtsData;


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
value_registers DUT (
	.clk(tb_clk),
	.nRst(tb_nRst),
	
	.rxDataReady(tb_rxDataReady),
	.rxTransferActive(tb_rxTransferActive),
	.txTransferActive(tb_txTransferActive),
	.txError(tb_txError),
	.rxError(tb_rxError),
	
	.bufferOccupancy(tb_bufferOccupancy),
	.nextEHTSData(tb_nextEHTSData),
	
	.statusData(tb_statusData),
	.errorData(tb_errorData),
	.boData(tb_boData),
	.ehtsData(tb_ehtsData)
);


//**************************************************************
// DUT Related TB Tasks
//**************************************************************
// Task for reseting DUT
task reset_dut;
begin
	// Activate the rest
	tb_nRst = 1'b0;

  // Maintain the reset for more than one cycle
  @(posedge tb_clk);
  @(posedge tb_clk);

  // Wait until safely away from rising edge of the clock before releasing
  @(negedge tb_clk);
  tb_nRst = 1'b1;

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
  @(negedge tb_clk);
  tb_mismatch = 1'b0;
  tb_check    = 1'b1;
  if (tb_expected_statusData != tb_statusData) begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'statusData' output %s during %s test case", check_tag, tb_test_case);
  end
  if (tb_expected_errorData != tb_errorData) begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'errorData' output %s during %s test case", check_tag, tb_test_case);
  end
  if (tb_expected_boData != tb_boData) begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'boData' output %s during %s test case", check_tag, tb_test_case);
  end
  if (tb_expected_ehtsData != tb_ehtsData) begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'ehtsData' output %s during %s test case", check_tag, tb_test_case);
  end
  // Wait some small amount of time so check pulse timing is visible on waves
  #(0.1);
  tb_check =1'b0;
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
	tb_nRst				= 1'b1;
	tb_rxDataReady		= 1'b0;
	tb_rxTransferActive	= 1'b0;
	tb_txTransferActive = 1'b0;
	tb_txError			= 1'b0;
	tb_rxError			= 1'b0;
	tb_bufferOccupancy 	= 7'h00;
	tb_nextEHTSData 	= 8'h00;
	tb_expected_statusData 	= '1;
	tb_expected_errorData 	= '1;
	tb_expected_boData 		= '1;
	tb_expected_ehtsData 	= '1;

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
	tb_expected_statusData = '0;
	tb_expected_errorData = '0;
	tb_expected_boData = '0;
	tb_expected_ehtsData = '0;
	check_outputs("after reseting DUT");
	
	// Give some visual spacing between check and next test case start
	#(CLK_PERIOD * 2);


	//*****************************************************************************
	// Test Case: Sending in Errors
	//*****************************************************************************
	tb_test_case	 = "Sending in Errors";
	tb_test_case_num = tb_test_case_num + 1;

	// set inputs
	tb_rxError = 1'b1;
	#(CLK_PERIOD * 2);
	tb_txError = 1'b1;
	#(CLK_PERIOD);
	
	// Set and check the expected output
	tb_expected_statusData = tb_statusData;
	tb_expected_errorData = 16'h0101;
	tb_expected_boData = tb_boData;
	tb_expected_ehtsData = tb_ehtsData;
	check_outputs("after sending in error");
	
	// Give some visual spacing between check and next test case start
	#(CLK_PERIOD * 2);


	//*****************************************************************************
	// Test Case: Sending in Status Flags
	//*****************************************************************************
	tb_test_case	 = "Sending in Status Flags";
	tb_test_case_num = tb_test_case_num + 1;

	// set inputs
	tb_rxDataReady = 1'b1;
	tb_txTransferActive = 1'b1;
	#(CLK_PERIOD * 2);
	
	// Set and check the expected output
	tb_expected_statusData = 16'h0201;
	tb_expected_errorData = tb_errorData;
	tb_expected_boData = tb_boData;
	tb_expected_ehtsData = tb_ehtsData;
	check_outputs("after sending in status flags");
	
	// Give some visual spacing between check and next test case start
	#(CLK_PERIOD * 2);


	//*****************************************************************************
	// Test Case: Sending in Buffer Occupancy Stuff
	//*****************************************************************************
	tb_test_case	 = "Sending in Buffer Occupancy Stuff";
	tb_test_case_num = tb_test_case_num + 1;

	// set inputs
	tb_bufferOccupancy = 8'h4F;
	#(CLK_PERIOD);
	
	// Set and check the expected output
	tb_expected_statusData = tb_statusData;
	tb_expected_errorData = tb_errorData;
	tb_expected_boData = 8'h4F;
	tb_expected_ehtsData = tb_ehtsData;
	check_outputs("after sending in buffer occupancy stuff");
	
	// Give some visual spacing between check and next test case start
	#(CLK_PERIOD * 2);


	//*****************************************************************************
	// Test Case: Sending in EHTS Data
	//*****************************************************************************
	tb_test_case	 = "Sending in EHTS Data";
	tb_test_case_num = tb_test_case_num + 1;

	// set inputs
	tb_nextEHTSData = 8'h3A;
	#(CLK_PERIOD);
	
	// Set and check the expected output
	tb_expected_statusData = tb_statusData;
	tb_expected_errorData = tb_errorData;
	tb_expected_boData = tb_boData;
	tb_expected_ehtsData = 8'h3A;
	check_outputs("after sending in EHTS data");
	
	// Give some visual spacing between check and next test case start
	#(CLK_PERIOD * 2);


	//*****************************************************************************
	// Test Case: Sending in Everything
	//*****************************************************************************
	tb_test_case	 = "Sending in Everything";
	tb_test_case_num = tb_test_case_num + 1;

	// reset module
	reset_dut();
	
	// set random inputs
	tb_txError = 1'b1;
	tb_rxTransferActive = 1'b1;
	tb_nextEHTSData = 8'h12;
	#(CLK_PERIOD);
	tb_bufferOccupancy = 8'h12;
	tb_rxError = 1'b1;
	#(CLK_PERIOD);
	tb_txError = 1'b0;
	tb_rxDataReady = 1'b0;
	tb_txTransferActive = 1'b0;
	tb_rxError = 1'b0;
	tb_bufferOccupancy = 8'h01;
	#(CLK_PERIOD);
	tb_txTransferActive = 1'b1;
	#(CLK_PERIOD);
	
	// Set and check the expected output
	tb_expected_statusData = 16'h0300;
	tb_expected_errorData = 16'h0000;
	tb_expected_boData = 8'h01;
	tb_expected_ehtsData = 8'h12;
	check_outputs("after sending in everything");
	
	// Give some visual spacing between check and next test case start
	#(CLK_PERIOD * 2);


end
endmodule
