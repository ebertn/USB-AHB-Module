
`timescale 1ns / 10ps
//protocal_controller
//data_buffer

module tb_protocol_controller();

// Timing related constants
localparam CLK_PERIOD = 10;
localparam BUS_DELAY  = 800ps; // Based on FF propagation delay


//*****************************************************************************
// Declare TB Signals
//*****************************************************************************

string   tb_test_case;
integer  tb_test_case_num;


//*****************************************************************************
// General System signals
//*****************************************************************************
logic tb_clk;
logic tb_n_rst;

//*****************************************************************************
// Protocal Controller side signals
//*****************************************************************************
//Inputs
logic tb_clear; 
logic tb_get_rx_data; 
logic tb_store_tx_data; 
logic [31:0] tb_tx_data; 
logic [1:0] tb_data_size; 
logic tb_get_tx_packet_data; 
logic [7:0] tb_rx_packet_data; 
logic tb_store_rx_packet_data; 

//Outputs
logic [6:0] tb_buffer_occupancy; 
logic [31:0] tb_rx_data; 
logic [7:0] tb_tx_packet_data; 



//*****************************************************************************
// Clock Generation Block
//*****************************************************************************
// Clock generation block
always begin
  // Start with clock low to avoid false rising edge events at t=0
  tb_clk = 1'b0;
  // Wait half of the clock period before toggling clock value (maintain 50% duty cycle)
  #(CLK_PERIOD/2.0);
  tb_clk = 1'b1;
  // Wait half of the clock period before toggling clock value via rerunning the block (maintain 50% duty cycle)
  #(CLK_PERIOD/2.0);
end


//*****************************************************************************
// DUT Instance
//*****************************************************************************
protocol_controller DUT (.clk(tb_clk), 
	.n_rst(tb_n_rst),
	.clear(tb_clear),  
	.get_rx_data(tb_get_rx_data),  
	.store_tx_data(tb_store_tx_data),
	.tx_data(tb_tx_data),  
	.data_size(tb_data_size), 
	.get_tx_packet_data(tb_get_tx_packet_data), 
	.rx_packet_data(rx_packet_data),  
	.store_rx_packet_data(tb_store_rx_packet_data),
	.buffer_occupancy(tb_buffer_occupancy),
	.rx_data(tb_rx_data), 
	.tx_packet_data(tb_tx_packet_data)
); 
              

//*****************************************************************************
// DUT Related TB Tasks
//*****************************************************************************
// Task for standard DUT reset procedure
task reset_dut;
begin
  // Activate the reset
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
end
endtask


task 
//*****************************************************************************
//*****************************************************************************
// Main TB Process
//*****************************************************************************
//*****************************************************************************
initial begin
  // Initialize Test Case Navigation Signals
	tb_test_case       = "Initilization";
	tb_test_case_num   = -1;
	#(0.1);
	
	reset_dut();


  
  

endtask

endmodule
