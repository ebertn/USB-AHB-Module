
`timescale 1ns / 10ps
module tb_usb_rx(); 


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
// RX side signals
//*****************************************************************************

logic tb_dplus_in; 
logic tb_dminus_in; 
logic [2:0] tb_rx_packet; 
logic tb_store_rx_packer; 
logic [7:0] tb_rx_packet_data; 

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
//****************************************************************************
usb_rx DUT (.clk(tb_clk), 
	.n_rst(tb_n_rst), 
	.dplus_in(tb_dplus_in), 
	.dminus_in(tb_dminus_in), 
	.rx_packet(tb_rx_packet), 
	.store_rx_packet(tb_store_rx_packet), 
	.rx_packet_data(tb_rx_packet_data)
); 

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
int i; 
task send_shit; 
input logic [7:0] bytes; 
begin
	for (i = 0; i <= 7; i++) begin
		if (bytes[i] == 1'b0)begin
			tb_dplus_in = tb_dplus_in ^ 1'b1;  
			tb_dminus_in = tb_dminus_in ^ 1'b1;  	
			#(CLK_PERIOD);
		end else begin
			#(CLK_PERIOD); 
		end
	end
end
endtask

task check_shit;
input logic [7:0] expected; 
input logic [7:0] actual; 
begin
	if(expected == actual)begin
		$info("Correct Token"); 
	end else begin
		$error("Incorrect Token"); 
	end
end 
endtask

task sync_byte; 
begin
	
	tb_dplus_in = 1'b0; 
	tb_dminus_in = 1'b1; 	
	#(CLK_PERIOD);
	tb_dplus_in = 1'b1; 
	tb_dminus_in = 1'b0; 	
	#(CLK_PERIOD);
 	tb_dplus_in = 1'b0; 
	tb_dminus_in = 1'b1; 	
	#(CLK_PERIOD);
	tb_dplus_in = 1'b1; 
	tb_dminus_in = 1'b0; 
	#(CLK_PERIOD);
	tb_dplus_in = 1'b0; 
	tb_dminus_in = 1'b1; 	
	#(CLK_PERIOD);
	tb_dplus_in = 1'b1; 
	tb_dminus_in = 1'b0; 	
	#(CLK_PERIOD);
	tb_dplus_in = 1'b0; 
	tb_dminus_in = 1'b1; 	
	#(CLK_PERIOD);
	tb_dplus_in = 1'b0; 
	tb_dminus_in = 1'b1; 	
	#(CLK_PERIOD);
end


endtask

task eop; 
begin
	tb_dplus_in = 1'b0; 
	tb_dminus_in = 1'b0; 	
	#(CLK_PERIOD);
	tb_dplus_in = 1'b0; 
	tb_dminus_in = 1'b0; 
	
end 
endtask	

//*****************************************************************************
//*****************************************************************************
// Main TB Process
//*****************************************************************************
//*****************************************************************************
initial begin
  // Initialize Test Case Navigation Signals
	tb_test_case       = "Initilization";
	tb_test_case_num   = -1;
	//#(0.1);
	
	reset_dut();
/*****************************************************************************
// "In Token"
//*****************************************************************************/
	tb_test_case     = "Test Case 1";
        tb_test_case_num = tb_test_case_num + 1;
	
	sync_byte(); 
	send_shit(8'b10010110); 
	
	
	send_shit(8'b10110011); 
	send_shit(8'b11101110); 
	
	check_shit(8'b00000011, {5'b00000, tb_rx_packet});  
	eop(); 
	reset_dut();
	
	
/*****************************************************************************
// "ACK Token"
//*****************************************************************************/
	tb_test_case     = "Test Case 2";
        tb_test_case_num = tb_test_case_num + 1;
	
	sync_byte(); 
	send_shit(8'b00101101); 
	
	
	send_shit(8'b10110011); 
	send_shit(8'b11101111); 
	reset_dut();
	check_shit(8'b00000000, {5'b00000, tb_rx_packet});  
	

end
endmodule


