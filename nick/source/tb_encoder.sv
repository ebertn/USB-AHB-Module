// $Id: $
// File name:   tb_encoder.sv
// Created:     4/22/2019
// Author:      Nick Ebert
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Encoder Testbench

`timescale 1ns / 10ps

module tb_encoder();

  // Define parameters
  parameter CLK_PERIOD        = 2.5;
  parameter NORM_DATA_PERIOD  = (8 * CLK_PERIOD);
  
  localparam OUTPUT_CHECK_DELAY = (CLK_PERIOD - 0.2);
  localparam WORST_FAST_DATA_PERIOD = (NORM_DATA_PERIOD * 0.96);
  localparam WORST_SLOW_DATA_PERIOD = (NORM_DATA_PERIOD * 1.04);
  
  //  DUT inputs
  logic tb_clk;
  logic tb_n_rst;
  logic tb_serial_in;
  logic tb_rollover_flag64;
  logic tb_EOP;
  
  // DUT outputs
  logic tb_dplus;
  logic tb_dminus;
  
  // Test bench debug signals
  // Overall test case number for reference
  integer tb_test_num;
  string  tb_test_case;
  // Test case 'inputs' used for test stimulus
  reg [7:0] tb_test_data;
  reg       tb_test_stop_bit;
  time       tb_test_bit_period;
  reg        tb_test_data_read;
  // Test case expected output values for the test case
  reg [7:0] tb_expected_rx_data;
  reg       tb_expected_framing_error;
  reg       tb_expected_data_ready;
  reg       tb_expected_overrun;
  
  // DUT portmap
  encoder DUT
  (
    .clk(tb_clk),
    .n_rst(tb_n_rst),
    .serial_in(tb_serial_in),
    .EOP(tb_EOP),
    .dplus(tb_dplus),
    .dminus(tb_dminus)
  );
  
  // Tasks for regulating the timing of input stimulus to the design
  task send_packet;
    input  [7:0] data;
    input  time data_period;
    
    integer i;
    integer j;
  begin
    // First synchronize to away from clock's rising edge
    @(negedge tb_clk)

    // Send data bits
    for(i = 0; i < 8; i = i + 1)
    begin
      tb_serial_in = data[i];

      for(j = 0; j < 8; j = j + 1)
      begin
          tb_rollover_flag64 = 0;
          if(j == 7) tb_rollover_flag64 = 1;
          //#data_period;
          @(posedge tb_clk);
      end
      tb_rollover_flag64 = 0;
      #data_period;
    end
  end
  endtask
  
  
  
  task reset_dut;
  begin
    // Activate the design's reset (does not need to be synchronize with clock)
    tb_n_rst = 1'b0;
    
    // Wait for a couple clock cycles
    @(posedge tb_clk);
    @(posedge tb_clk);
    
    // Release the reset
    @(negedge tb_clk);
    tb_n_rst = 1;
    
    // Wait for a while before activating the design
    @(posedge tb_clk);
    @(posedge tb_clk);
  end
  endtask
  
  always
  begin : CLK_GEN
    tb_clk = 1'b0;
    #(CLK_PERIOD / 2);
    tb_clk = 1'b1;
    #(CLK_PERIOD / 2);
  end

  // Actual test bench process
  initial
  begin : TEST_PROC
    // Initialize all test bench signals
    tb_test_num               = -1;
    tb_test_case              = "TB Init";
    tb_test_data              = '1;
    tb_test_stop_bit          = 1'b1;
    tb_test_bit_period        = NORM_DATA_PERIOD;

    // Initilize all inputs to inactive/idle values
    tb_n_rst      = 1'b1; // Initially inactive
    tb_serial_in  = 1'b1; // Initially idle
    tb_EOP	  = 1'b0;
    
    // Get away from Time = 0
    #0.1; 
        
    // Test case 1: Normal data rate, Normal packet
    // Synchronize to falling edge of clock to prevent timing shifts from prior test case(s)
    @(negedge tb_clk);
    tb_test_num  = 0;
    tb_test_case = "Send Packet";
    
    // Setup packet info for debugging/verificaton signals
    tb_test_data       = 8'b11010101;
    tb_test_stop_bit   = 1'b1;
    tb_test_bit_period = NORM_DATA_PERIOD;
    tb_test_data_read  = 1'b1;
    
    // Define expected ouputs for this test case
    // For a good packet RX Data value should match data sent
    //tb_expected_rx_data       = tb_test_data;
    // Valid stop bit ('1') -> Valid data -> Active data ready output
    //tb_expected_data_ready    = tb_test_stop_bit; 
    // Framing error if and only if bad stop_bit ('0') was sent
    //tb_expected_framing_error = ~tb_test_stop_bit;
    // Not intentionally creating an overrun condition -> overrun should be 0
    //tb_expected_overrun       = 1'b0;
    
    // DUT Reset
    reset_dut;
    
    // Send packet
    send_packet(tb_test_data, tb_test_bit_period);

    tb_EOP = 1;
    
    // Wait for 2 data periods to allow DUT to finish processing the packet
    #(CLK_PERIOD);

    tb_EOP = 0;

    #(tb_test_bit_period * 3);
    
    // Test case 2: Test EOP
    // Synchronize to falling edge of clock to prevent timing shifts from prior test case(s)
    @(negedge tb_clk);
    tb_test_num  += 1;
    tb_test_case = "EOP Test";
    
    // Setup packet info for debugging/verificaton signals
    tb_test_data       = 8'b11010101;
    tb_test_stop_bit   = 1'b1;
    tb_test_bit_period = NORM_DATA_PERIOD;
    tb_test_data_read  = 1'b1;
    
    // Define expected ouputs for this test case
    // For a good packet RX Data value should match data sent
    //tb_expected_rx_data       = tb_test_data;
    // Valid stop bit ('1') -> Valid data -> Active data ready output
    //tb_expected_data_ready    = tb_test_stop_bit; 
    // Framing error if and only if bad stop_bit ('0') was sent
    //tb_expected_framing_error = ~tb_test_stop_bit;
    // Not intentionally creating an overrun condition -> overrun should be 0
    //tb_expected_overrun       = 1'b0;
    
    // DUT Reset
    reset_dut;
    
    // Send packet
    send_packet(tb_test_data, tb_test_bit_period);
    
    tb_EOP = 1;
    
    // Wait for 2 data periods to allow DUT to finish processing the packet
    #(tb_test_bit_period * 2);

    tb_EOP = 0;
  end

endmodule