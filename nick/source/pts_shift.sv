// $Id: $
// File name:   pts_shift.sv
// Created:     4/23/2019
// Author:      Nick Ebert
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: PtS Shift Register

module pts_shift
(
	input wire clk,
	input wire n_rst,
	input wire shift_enable,
	input wire load_enable,
	input wire [7:0] parallel_in,
	output reg serial_out
);

flex_pts_sr pts #(.NUM_BITS(8), .SHIFT_MSB(0)) (.clk(clk), .n_rst(n_rst), .shift_enable(shift_enable), 
	.load_enable(load_enable), .parallel_in(parallel_in), .serial_out(serial_out));

endmodule