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

	
endmodule