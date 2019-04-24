`timescale 1ns / 10ps

module tb_address_decoder ();

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

logic [7:0] tb_expected_nextEHTSData;
logic [31:0] tb_expected_hrdata;
logic [31:0] tb_expected_txData;


//**************************************************************
// System Signals
//**************************************************************
logic tb_clk;
logic tb_nRst;


//**************************************************************
// IO Signals
//**************************************************************
logic [6:0] tb_haddr;
logic [1:0] tb_hsize;
logic [31:0] tb_hwdata;
logic [1:0] tb_state;
logic [31:0] tb_rdata;
logic [15:0] tb_statusData;
logic [15:0] tb_errorData;
logic [7:0] tb_boData;
logic [7:0] tb_ehtsData;

logic [7:0] tb_nextEHTSData;
logic [31:0] tb_hrdata;
logic [31:0] tb_txData;


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
address_decoder DUT (
	.clk(tb_clk),
	.nRst(tb_nRst),
	
	.haddr(tb_haddr),
	.hsize(tb_hsize),
	.hwdata(tb_hwdata),
	.state(tb_state),
	.rdata(tb_rdata),
	.statusData(tb_statusData),
	.errorData(tb_errorData),
	.boData(tb_boData),
	.ehtsData(tb_ehtsData),
	
	.nextEHTSData(tb_nextEHTSData),
	.hrdata(tb_hrdata),
	.txData(tb_txData)
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
  if (tb_expected_nextEHTSData != tb_nextEHTSData) begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'nextEHTSData' output %s during %s test case", check_tag, tb_test_case);
  end
  if (tb_expected_hrdata != tb_hrdata) begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'hrdata' output %s during %s test case", check_tag, tb_test_case);
  end
  if (tb_expected_txData != tb_txData) begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'txData' output %s during %s test case", check_tag, tb_test_case);
  end
  // Wait some small amount of time so check pulse timing is visible on waves
  #(0.1);
  tb_check =1'b0;
  @(posedge tb_clk);
end
endtask


// Task to send data to the slave
task write_data;
	input logic [6:0] address;
	input logic [1:0] size;
	input logic [31:0] data;
begin
	tb_haddr = address;
	tb_hsize = size;
	#(CLK_PERIOD);
	tb_state = WRITE;
	tb_hwdata = data;
end
endtask

// Task to read data from the registers
task read_data;
	input logic [6:0] address;
	input logic [1:0] size;
	input logic [31:0] expectedData;
begin
	tb_haddr = address;
	tb_hsize = size;
	#(CLK_PERIOD);
	tb_state = READ;
	tb_expected_hrdata = expectedData;
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

	tb_haddr			= '0;
	tb_hsize			= '0;
	tb_hwdata			= '0;
	tb_state			= '0;
	tb_rdata			= '0;
	tb_statusData		= '0;
	tb_errorData		= '0;
	tb_boData			= '0;
	tb_ehtsData			= '0;

	tb_expected_nextEHTSData = '0;
	tb_expected_hrdata	= '0;
	tb_expected_txData  = '0;


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
	tb_expected_nextEHTSData = '0;
	tb_expected_hrdata	= '0;
	tb_expected_txData  = '0;
	check_outputs("after reseting DUT");
	
	// Give some visual spacing between check and next test case start
	#(CLK_PERIOD * 2);


	//*****************************************************************************
	// Test Case: TX Data
	//*****************************************************************************
	tb_test_case	 = "TX Data";
	tb_test_case_num = tb_test_case_num + 1;

	// set inputs
	write_data(7'h00, 2'b10, 32'hABCDEF5);
	
	// Set and check the expected output
	tb_expected_txData = 32'hABCDEF5;
	check_outputs("after testing tx data");

	// set inputs
	write_data(7'h15, 2'b00, 32'h69696905);
	
	// Set and check the expected output
	tb_expected_txData = 32'h00000005;
	check_outputs("after testing tx data");
	
	// set inputs
	write_data(7'h3F, 2'b01, 32'h6969FFFF);
	
	// Set and check the expected output
	tb_expected_txData = 32'h0000FFFF;
	check_outputs("after testing tx data");
	tb_expected_txData = '0;

	// Give some visual spacing between check and next test case start
	#(CLK_PERIOD * 2);


	//*****************************************************************************
	// Test Case: Next EHTS Data
	//*****************************************************************************
	tb_test_case	 = "Next EHTS Data";
	tb_test_case_num = tb_test_case_num + 1;

	// set inputs
	write_data(7'h48, 2'b00, 32'h8080105A);
	
	// Set and check the expected output
	tb_expected_nextEHTSData = 8'h5A;
	check_outputs("after testing next EHTS data");
	tb_expected_nextEHTSData = '0;	

	// Give some visual spacing between check and next test case start
	#(CLK_PERIOD * 2);


	//*****************************************************************************
	// Test Case: Reading Data
	//*****************************************************************************
	tb_test_case	 = "Reading Data";
	tb_test_case_num = tb_test_case_num + 1;

	// set inputs
	tb_rdata = 32'h00550013;
	read_data(7'h00, 2'b00, 32'h00000013);
	
	// Set and check the expected output
	check_outputs("after reading data");
	
	// set inputs
	tb_rdata = 32'h13131313;
	read_data(7'h3F, 2'b10, 32'h13131313);
	
	// Set and check the expected output
	check_outputs("after reading data");

	// set inputs
	tb_errorData = 16'h0101;
	read_data(7'h42, 2'b01, 32'h00000101);
	
	// Set and check the expected output
	check_outputs("after reading data");

	// set inputs
	tb_boData = 8'h12;
	read_data(7'h44, 2'b00, 32'h00000012);
	
	// Set and check the expected output
	check_outputs("after reading data");

	// set inputs
	tb_boData = 8'h12;
	read_data(7'h44, 2'b00, 32'h00000012);
	
	// Set and check the expected output
	check_outputs("after reading data");

	// set inputs
	tb_statusData = 16'h0301;
	read_data(7'h41, 2'b00, 32'h00000003);
	
	// Set and check the expected output
	check_outputs("after reading data");

	// set inputs
	tb_ehtsData = 8'h05;
	read_data(7'h48, 2'b00, 32'h00000005);
	
	// Set and check the expected output
	tb_expected_nextEHTSData = 8'h05;
	check_outputs("after reading data");

	// Give some visual spacing between check and next test case start
	#(CLK_PERIOD * 2);


end
endmodule
