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
	output logic get_tx_packet_data,
	output logic dplus_out,
	output logic dminus_out
);

control_fsm fsm (.clk(), .n_rst(),  .tx_packet_data(), .tx_packet_data_size(), .tx_packet(), .rollover_flag8(), .rollover_flag64(), .rollover_flag512(), .calculated_crc(), .timer_count_enable(), .timer_clear(), .timer_latch_packet_size(), .crc_clear(), .crc_shift(), .get_tx_packet_data(), .pts_shift(), .pts_load(), .data_out(), .eop());
	
encoder encoder (.clk(), .n_rst(), .serial_in(), .rollover_flag64(), .EOP(), .dplus(), .dminus());

bit_stuffer bit_stuffer(.clk(), .n_rst(), .serial_in(), .rollover_flag64(), .stuffing(), .stuffed_serial_out());

timer (.clk(), .n_rst(), .count_enable(), .tx_packet_size(), .latch_packet_size(), .clear(), .rollover_flag8(), .rollover_flag64(), .rollover_flag512());

pts_shift (.clk(), .n_rst(), .shift_enable(), .load_enable(), .parallel_in(), .serial_out());

endmodule