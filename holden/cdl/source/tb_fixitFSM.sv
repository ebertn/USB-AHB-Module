`timescale 1ns / 10ps

module tb_fixitFSM ();

//**************************************************************
// Constants
//**************************************************************
localparam CLK_PERIOD = 10;
localparam IDLE = 2'b00;
localparam WRITE = 2'b01;
localparam READ = 2'b10;
localparam ERROR = 2'b11;


//**************************************************************
// TB Signals
//**************************************************************
logic tb_mismatch;
logic tb_check;
string tb_test_case;
integer tb_test_case_num;

logic tb_expected_bufferReserved;


//**************************************************************
// System Signals
//**************************************************************
logic tb_clk;
logic tb_nRst;


//**************************************************************
// IO Signals
//**************************************************************
logic tb_txPacketSizeChanged;
logic tb_rxDataReady;
logic [6:0] tb_bufferOccupancy;
logic [6:0] tb_txPacketDataSize;
logic tb_bufferReserved;


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
fixitFSM DUT (
	.clk(tb_clk),
	.nRst(tb_nRst),
	
	.txPacketSizeChanged(tb_txPacketSizeChanged),
	.rxDataReady(tb_rxDataReady),
	.bufferOccupancy(tb_bufferOccupancy),
	.txPacketDataSize(tb_txPacketDataSize),

	.bufferReserved(tb_bufferReserved)	
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
  if (tb_expected_bufferReserved != tb_bufferReserved) begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'bufferReserved' output %s during %s test case", check_tag, tb_test_case);
  end
  // Wait some small amount of time so check pulse timing is visible on waves
  #(0.1);
  tb_check =1'b0;
  @(posedge tb_clk);
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

	tb_txPacketSizeChanged	= 1'b0;
	tb_rxDataReady		= 1'b0;
	tb_bufferOccupancy	= '0;
	tb_txPacketDataSize = 1'b0;
	tb_expected_bufferReserved = 1'b0;

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
	tb_expected_bufferReserved = 1'b0;
	check_outputs("after reseting DUT");

	
	// Give some visual spacing between check and next test case start
	#(CLK_PERIOD * 2);


	//*****************************************************************************
	// Test Case: Test Cases
	//*****************************************************************************
	tb_test_case	 = "Test Cases";
	tb_test_case_num = tb_test_case_num + 1;

	tb_txPacketSizeChanged = 1'b1;
	tb_txPacketDataSize = 7'h4;
	#(CLK_PERIOD);
	tb_txPacketSizeChanged = 1'b0;

	// Set and check the expected output
	tb_expected_bufferReserved = 1'b1;
	check_outputs("after setting data");

	tb_bufferOccupancy = 7'h4;
	#(CLK_PERIOD);

	// Set and check the expected output
	tb_expected_bufferReserved = 1'b0;
	check_outputs("after setting data");

	tb_txPacketSizeChanged = 1'b1;
	tb_txPacketDataSize = 7'h8;
	tb_bufferOccupancy = 7'h0;
	#(CLK_PERIOD);
	tb_txPacketSizeChanged = 1'b0;

	// Set and check the expected output
	tb_expected_bufferReserved = 1'b1;
	check_outputs("after setting data");

	tb_bufferOccupancy = 7'h4;
	#(CLK_PERIOD);

	// Set and check the expected output
	tb_expected_bufferReserved = 1'b1;
	check_outputs("after setting data");

	tb_bufferOccupancy = 7'h8;
	#(CLK_PERIOD);

	// Set and check the expected output
	tb_expected_bufferReserved = 1'b0;
	check_outputs("after setting data");

	tb_bufferOccupancy = 7'h10;
	tb_rxDataReady = 1'b1;
	#(CLK_PERIOD);
	tb_rxDataReady = 1'b0;

	// Set and check the expected output
	tb_expected_bufferReserved = 1'b1;
	check_outputs("after setting data");

	tb_bufferOccupancy = 7'h8;
	#(CLK_PERIOD);

	// Set and check the expected output
	tb_expected_bufferReserved = 1'b1;
	check_outputs("after setting data");

	tb_bufferOccupancy = 7'h4;
	#(CLK_PERIOD);

	// Set and check the expected output
	tb_expected_bufferReserved = 1'b1;
	check_outputs("after setting data");

	tb_bufferOccupancy = 7'h0;
	#(CLK_PERIOD);

	// Set and check the expected output
	tb_expected_bufferReserved = 1'b0;
	check_outputs("after setting data");

	// Give some visual spacing between check and next test case start
	#(CLK_PERIOD * 2);


end
endmodule
