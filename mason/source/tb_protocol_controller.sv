
`timescale 1ns / 10ps
//protocal_controller
//data_buffer

module tb_protocol_controller();

// Timing related constants
localparam CLK_PERIOD = 10;
localparam BUS_DELAY  = 800ps; // Based on FF propagation delay
//rx_packet
   localparam RX_IDLE = 3'b000;
   localparam RX_READY = 3'b001;    //OUT Token
   localparam RX_RECEIVED = 3'b010;
   localparam RX_ERR = 3'b011;
   localparam RX_BUSY = 3'b100;
   localparam TX_ERR = 3'b101;
   localparam TX_START = 3'b110;    //IN Token

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
logic [2:0] tb_rx_packet; 
logic tb_buffer_reserved; 
logic [6:0] tb_buffer_occupancy; 
logic tb_tx_status; 
logic tb_lock_error; 

//Outputs
logic tb_rx_data_ready; 
logic tb_rx_transfer_active; 
logic tb_rx_error; 
logic tb_tx_transfer_active; 
logic tb_tx_error; 
logic tb_d_mode; 
logic [1:0] tb_tx_packet; 
logic tb_clear; 
logic tb_lock_db; 



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
	.rx_packet(tb_rx_packet), 
	.buffer_reserved(tb_buffer_reserved), 
	.buffer_occupancy(tb_buffer_occupancy), 
	.tx_status(tb_tx_status), 
	.rx_data_ready(tb_rx_data_ready), 
	.rx_transfer_active(tb_rx_transfer_active), 
	.rx_error(tb_rx_error), 
	.tx_transfer_active(tb_tx_transfer_active), 
	.tx_error(tb_tx_error), 
	.d_mode(tb_d_mode), 
	.tx_packet(tb_tx_packet),
	.clear(tb_clear),
	.lock_db(tb_lock_db),
	.lock_error(tb_lock_error)
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



//*****************************************************************************
//*****************************************************************************
// Main TB Process
//*****************************************************************************
//*****************************************************************************
initial begin
  // Initialize Test Case Navigation Signals
	tb_test_case       = "Initilization";
	tb_test_case_num   = -1;
	tb_rx_packet = 3'b000;
	tb_buffer_reserved = 1'b0;
	tb_buffer_occupancy = 7'b0;
	tb_tx_status = 1'b0;
	tb_lock_error = 1'b0;
	@ (posedge tb_clk)
	
	reset_dut();
   @ (posedge tb_clk)
/*****************************************************************************
// RX Options 
//*****************************************************************************/
	tb_test_case     = "RX Options";
        tb_test_case_num = tb_test_case_num + 1;

	tb_rx_packet = RX_IDLE;
	tb_buffer_reserved = 1'b0;
	tb_buffer_occupancy = 7'b0;
	tb_tx_status = 1'b0;
	tb_lock_error = 1'b0;

        tb_rx_packet = RX_READY; 
        @ (posedge tb_clk)
	  #0.1
   if(tb_rx_transfer_active == 1'b1) begin
		$info("Correct output for RX Active"); 
 	end else begin
		$error("Incorrect output for Rx Active"); 
	end

	tb_rx_packet = RX_ERR; 
	@ (posedge tb_clk)
	  #0.1
	if(tb_rx_error == 1'b1 && tb_clear == 1'b1) begin
		$info("Correct output for Rx Error"); 
	end else begin
		$error("Incorrect output for Rx Error"); 
	end
   @ (posedge tb_clk)
	tb_rx_packet = RX_READY; 
	@ (posedge tb_clk)
	tb_rx_packet = RX_RECEIVED; 
   @ (posedge tb_clk)
	  #0.1
	if(tb_rx_data_ready == 1'b1) begin
		$info("Correct output for Packet Ready"); 
	end else begin
		$error("Incorrect output for Packet Ready"); 
	end

	tb_buffer_reserved = 1'b1; 
	tb_tx_status = 1'b0;
   @(posedge tb_clk)
   #0.1
	if(tb_tx_packet == 2'b11) begin
		$info("Correct Output for NacK"); 
	end else begin
		$error("Incorrect Output for Nack");
	end
	tb_buffer_reserved = 1'b0;
	@ (posedge tb_clk)
	tb_tx_status = 1'b1; 
	@ (posedge tb_clk)
	tb_rx_packet = RX_READY; 
	@ (posedge tb_clk)
	tb_rx_packet = RX_RECEIVED; 
	@ (posedge tb_clk)
	  @ (posedge tb_clk)
   #0.1
	if(tb_tx_packet == 2'b10) begin
		$info("Correct Output for Ack"); 
	end else begin
		$error("Incorrect Output for Ack");
	end

	@ (posedge tb_clk)
	  @ (posedge tb_clk)
	    @ (posedge tb_clk)
	reset_dut();
//*****************************************************************************
// TX Options 
//*****************************************************************************/
	tb_test_case     = "TX Options";
        tb_test_case_num = tb_test_case_num + 1;

	tb_rx_packet = 3'b000;
	tb_buffer_reserved = 1'b0;
	tb_buffer_occupancy = 7'b0;
	tb_tx_status = 1'b0;
	tb_lock_error = 1'b0;

	tb_rx_packet = RX_IDLE; 
	@ (posedge tb_clk)
	tb_rx_packet = TX_ERR; 
	@ (posedge tb_clk)
   #0.1
	if(tb_tx_error == 1'b1 && tb_clear == 1'b1) begin
		$info("Correct Output for Tx Error"); 
	end else begin
		$error("Incorrect Output for Tx Error");
	end
	tb_rx_packet = TX_START;
   @ (posedge tb_clk)
	@ (posedge tb_clk)
   #0.1
	if(tb_d_mode == 1'b1) begin
		$info("Correct Output for Start Tx"); 
	end else begin
		$error("Incorrect Output for Start Tx");
	end
	
	tb_buffer_reserved = 1'b0; 
	tb_tx_status = 1'b0; 
	
	@ (posedge tb_clk)
   #0.1
	if(tb_tx_transfer_active == 1'b1 && tb_tx_packet == 2'b01) begin
		$info("Correct Output for Tx Active"); 
	end else begin
		$error("Incorrect Output for Tx Active");
	end
	
	tb_tx_status = 1'b1;
	@ (posedge tb_clk)

	tb_tx_status = 1'b0;
   #0.1
	if(tb_tx_packet == 2'b10) begin
		$info("Correct Output for Tx ACK"); 
	end else begin
		$error("Incorrect Output for Tx ACK");
	end
	tb_tx_status = 1'b1; 
	@ (posedge tb_clk)
	@ (posedge tb_clk)
	tb_tx_status = 1'b0; 
	tb_buffer_reserved = 1'b1; 
	tb_rx_packet = 3'b110; 
	@ (posedge tb_clk)
	@ (posedge tb_clk)
	#0.1
	if(tb_tx_packet == 2'b11) begin
		$info("Correct Output for Tx NACK"); 
	end else begin
		$error("Incorrect Output for Tx NACK");
	end
	tb_tx_status = 1'b1; 
	@ (posedge tb_clk)
	  @ (posedge tb_clk)
	    @ (posedge tb_clk)

	reset_dut();
   
//*****************************************************************************
// TX Options 
//*****************************************************************************/
	tb_test_case     = "Buffer Options";
        tb_test_case_num = tb_test_case_num + 1;	
	
	tb_rx_packet = RX_IDLE;
	tb_buffer_reserved = 1'b0;
	tb_buffer_occupancy = 7'b0;
	tb_tx_status = 1'b0;
	tb_lock_error = 1'b0;

	tb_buffer_reserved = 1'b1; 
	@ (posedge tb_clk)
	  tb_rx_packet = RX_READY;
   #0.1
	if(tb_lock_db == 1'b1) begin
		$info("Correct Output for Buffer Reserved"); 
	end else begin
		$error("Incorrect Output for Buffer Reserved");
	end
	tb_rx_packet = 3'b001; 
	@ (posedge tb_clk)
	tb_rx_packet = 3'b100; 
	
	
end	
	

  
  



endmodule
