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

logic [1:0] tb_expected_state;
logic tb_expected_storeTxData;
logic tb_expected_getRxData;
logic tb_expected_hresp;
logic tb_expected_hready;
logic tb_expected_bufferReserved;


//**************************************************************
// System Signals
//**************************************************************
logic tb_clk;
logic tb_nRst;


//**************************************************************
// IO Signals
//**************************************************************
logic [6:0] tb_haddr;
logic [1:0] tb_htrans;
logic [1:0] tb_hsize;
logic tb_hwrite;
logic tb_hsel;

logic [1:0] tb_state;
logic tb_storeTxData;
logic tb_getRxData;
logic tb_hresp;
logic tb_hready;
logic [1:0] tb_dataSize;
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
state_controller DUT (
	.clk(tb_clk),
	.nRst(tb_nRst),
	
	.haddr(tb_haddr),
	.htrans(tb_htrans),
	.hsize(tb_hsize),
	.hwrite(tb_hwrite),
	.hsel(tb_hsel),

	.state(tb_state),
	.storeTxData(tb_storeTxData),
	.getRxData(tb_getRxData),
	.hresp(tb_hresp),
	.hready(tb_hready),
	.dataSize(tb_dataSize),
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
  if (tb_expected_state != tb_state) begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'state' output %s during %s test case", check_tag, tb_test_case);
  end
  if (tb_expected_storeTxData != tb_storeTxData) begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'storeTxData' output %s during %s test case", check_tag, tb_test_case);
  end
  if (tb_expected_getRxData != tb_getRxData) begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'getRxData' output %s during %s test case", check_tag, tb_test_case);
  end
  if (tb_expected_hresp != tb_hresp) begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'hresp' output %s during %s test case", check_tag, tb_test_case);
  end
  if (tb_expected_hready!= tb_hready) begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'hready' output %s during %s test case", check_tag, tb_test_case);
  end
  if (tb_hsize != tb_dataSize) begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'dataSize' output %s during %s test case", check_tag, tb_test_case);
  end
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


// Task to send data to the slave
task write_data;
	input logic [6:0] address;
	input logic [1:0] size;
begin
	tb_htrans = 2'b01;
	tb_hwrite = 1'b1;
	tb_hsel = 1'b1;
	tb_haddr = address;
	tb_hsize = size;
	#(CLK_PERIOD);
	tb_expected_state = WRITE;
end
endtask

// Task to read data from the registers
task read_data;
	input logic [6:0] address;
	input logic [1:0] size;
begin
	tb_htrans = 2'b01;
	tb_hwrite = 1'b0;
	tb_hsel = 1'b1;
	tb_haddr = address;
	tb_hsize = size;
	#(CLK_PERIOD);
	tb_expected_state = READ;
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
	tb_htrans			= '0;
	tb_hsize			= '0;
	tb_hwrite			= 1'b0;
	tb_hsel				= 1'b0;

	tb_expected_state 			= IDLE;
	tb_expected_storeTxData		= 1'b0;
	tb_expected_getRxData  		= 1'b0;
	tb_expected_hresp			= 1'b0;
	tb_expected_hready			= 1'b1;

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
	check_outputs("after reseting DUT");
	
	// Give some visual spacing between check and next test case start
	#(CLK_PERIOD * 2);


	//*****************************************************************************
	// Test Case: Write Test
	//*****************************************************************************
	tb_test_case	 = "Write Test";
	tb_test_case_num = tb_test_case_num + 1;

	// set inputs
	write_data(7'h00, 2'b10);
	
	// Set and check the expected output
	tb_expected_storeTxData = 1'b1;
	check_outputs("after write test");
	tb_expected_storeTxData = 1'b0;

	// set inputs
	write_data(7'h23, 2'b00);
	
	// Set and check the expected output
	tb_expected_storeTxData = 1'b1;
	check_outputs("after write test");
	tb_expected_storeTxData = 1'b0;

	// set inputs
	write_data(7'h3F, 2'b01);
	
	// Set and check the expected output
	tb_expected_storeTxData = 1'b1;
	check_outputs("after write test");
	tb_expected_storeTxData = 1'b0;

	// set inputs
	write_data(7'h48, 2'b00);
	
	// Set and check the expected output
	check_outputs("after write test");

	// Give some visual spacing between check and next test case start
	#(CLK_PERIOD * 2);


	//*****************************************************************************
	// Test Case: Read Test
	//*****************************************************************************
	tb_test_case	 = "Read Test";
	tb_test_case_num = tb_test_case_num + 1;

	// set inputs
	read_data(7'h00, 2'b10);
	
	// Set and check the expected output
	tb_expected_getRxData = 1'b1;
	check_outputs("after read test");
	tb_expected_getRxData = 1'b0;

	// set inputs
	read_data(7'h23, 2'b00);
	
	// Set and check the expected output
	tb_expected_getRxData = 1'b1;
	check_outputs("after read test");
	tb_expected_getRxData = 1'b0;

	// set inputs
	read_data(7'h3F, 2'b01);
	
	// Set and check the expected output
	tb_expected_getRxData = 1'b1;
	check_outputs("after read test");
	tb_expected_getRxData = 1'b0;

	// set inputs
	read_data(7'h41, 2'b00);
	
	// Set and check the expected output
	check_outputs("after read test");

	// set inputs
	read_data(7'h42, 2'b01);
	
	// Set and check the expected output
	check_outputs("after read test");

	// set inputs
	read_data(7'h44, 2'b00);
	
	// Set and check the expected output
	check_outputs("after read test");

	// set inputs
	read_data(7'h48, 2'b00);
	
	// Set and check the expected output
	check_outputs("after read test");

	// Give some visual spacing between check and next test case start
	#(CLK_PERIOD * 2);


	//*****************************************************************************
	// Test Case: Error Test
	//*****************************************************************************
	tb_test_case	 = "Error Test";
	tb_test_case_num = tb_test_case_num + 1;

	// set inputs
	write_data(7'h15, 2'b11);
	
	// Set and check the expected output
	tb_expected_state = ERROR;
	tb_expected_hresp = 1'b1;
	tb_expected_hready = 1'b0;
	check_outputs("after error test");
	tb_expected_state = IDLE;
	tb_expected_hresp = 1'b0;
	tb_expected_hready = 1'b1;

	// set inputs
	write_data(7'h48, 2'b11);
	
	// Set and check the expected output
	tb_expected_state = ERROR;
	tb_expected_hresp = 1'b1;
	tb_expected_hready = 1'b0;
	check_outputs("after error test");
	tb_expected_state = IDLE;
	tb_expected_hresp = 1'b0;
	tb_expected_hready = 1'b1;

	// set inputs
	write_data(7'h43, 2'b00);
	
	// Set and check the expected output
	tb_expected_state = ERROR;
	tb_expected_hresp = 1'b1;
	tb_expected_hready = 1'b0;
	check_outputs("after error test");
	tb_expected_state = IDLE;
	tb_expected_hresp = 1'b0;
	tb_expected_hready = 1'b1;
	
	// Give some visual spacing between check and next test case start
	#(CLK_PERIOD * 2);


end
endmodule