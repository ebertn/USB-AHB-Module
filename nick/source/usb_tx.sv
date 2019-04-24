// $Id: $
// File name:   usb_tx.sv
// Created:     4/16/2019
// Author:      Nick Ebert
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Top level file for tx connections

module usb_tx
(
	input logic clk,
	input logic n_rst, 
	input logic [7:0] tx_packet_data,
	input logic [6:0] tx_packet_data_size,
	input logic [1:0] tx_packet,
	output logic tx_status,
	output logic get_tx_packet_data,
	output logic dplus_out,
	output logic dminus_out
);

logic rollover_flag8, rollover_flag64, rollover_flag512, timer_count_enable, timer_clear, timer_latch_packet_size, crc_clear, crc_shift
logic pts_shift_en, pts_load, pts_serial_out, stuffing, stuffed_serial_out;
logic [15:0] calculated_crc;
logic [7:0] fsm_data_out;

control_fsm fsm (.clk(clk), .n_rst(n_rst),  .tx_packet_data(tx_packet_data), .tx_packet_data_size(tx_packet_data_size), 
	.tx_packet(tx_packet), .rollover_flag8(rollover_flag8), .rollover_flag64(rollover_flag64), .rollover_flag512(rollover_flag512), 
	.stuffing(stuffing), .calculated_crc(calculated_crc), .timer_count_enable(timer_count_enable), .timer_clear(timer_clear), 
	.timer_latch_packet_size(timer_latch_packet_size), .crc_clear(crc_clear), .crc_shift(crc_shift), 
	.get_tx_packet_data(get_tx_packet_data), .pts_shift(pts_shift_en), .pts_load(pts_load), .data_out(fsm_data_out), .eop(tx_status));
	
encoder encoder (.clk(clk), .n_rst(n_rst), .serial_in(), .rollover_flag64(rollover_flag64), .EOP(tx_status), .dplus(dplus_out), .dminus(dminus_out));

bit_stuffer bit_stuffer(.clk(clk), .n_rst(n_rst), .serial_in(pts_serial_out), .rollover_flag64(rollover_flag64), .stuffing(stuffing), .stuffed_serial_out(stuffed_serial_out));

timer timer (.clk(clk), .n_rst(n_rst), .count_enable(timer_count_enable), .tx_packet_size(tx_packet_data_size), 
	.latch_packet_size(timer_latch_packet_size), .clear(timer_clear), .rollover_flag8(rollover_flag8), 
	.rollover_flag64(rollover_flag64), .rollover_flag512(rollover_flag512));

pts_shift pts_shift (.clk(clk), .n_rst(n_rst), .shift_enable(pts_shift_en), .load_enable(pts_load), .parallel_in(fsm_data_out), .serial_out(pts_serial_out));

crc_generator_16bit crc (.clk(clk), .nRst(n_rst), .din(pts_serial_out), .shiftEn(crc_shift), .clear(crc_clear), .crc(calculated_crc));

endmodule