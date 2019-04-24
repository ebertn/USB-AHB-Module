// $Id: $
// File name:   timer.sv
// Created:     4/16/2019
// Author:      Nick Ebert
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Timer

module timer
(
    input logic clk,
    input logic n_rst,
    input logic count_enable,
    input logic [6:0] tx_packet_size,
    input logic latch_packet_size,
    input logic clear,
    output logic rollover_flag8,
    output logic rollover_flag64,
    output logic rollover_flag512
);

// Check to see if clear should clear all counters
// Might need to control rollover_val64 to send ack and nack

logic [6:0] saved_packet_size;

always_ff(posedge clk, negedge n_rst) begin
	if(!n_rst)
		saved_packet_size <= '0;
	else begin
		saved_packet_size <= saved_packet_size;
		if(latch_packet_size)
			saved_packet_size <= tx_packet_size;
	end
end

flex_counter count8 #(.NUM_CNT_BITS(4)) (.clk(clk), .n_rst(n_rst),
    .clear(clear), .count_enable(count_enable), .rollover_val(4'd8),
    .count_out(), .rollover_flag(rollover_flag8));

flex_counter count64 #(.NUM_CNT_BITS(4)) (.clk(clk), .n_rst(n_rst),
    .clear(clear), .count_enable(rollover_flag8), .rollover_val(4'd8),
    .count_out(), .rollover_flag(rollover_flag64));

flex_counter count512 #(.NUM_CNT_BITS(7)) (.clk(clk), .n_rst(n_rst),
    .clear(clear), .count_enable(rollover_flag64), .rollover_val(saved_packet_size),
    .count_out(), .rollover_flag(rollover_flag512));

endmodule