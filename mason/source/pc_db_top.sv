// $Id: $
// File name:   pc_db_top.sv
// Created:     4-16-19
// Author:      Mason Fritzen
// Lab Section: 002
// Version:     1.0  Initial Design Entry
// Description: Top-level file for data buffer and protocol controller

module pc_db_top
  (
   input reg 	     clk,
   input reg 	     n_rst,
   output reg 	     rx_data_ready,
   output reg 	     rx_transfer_active,
   output reg 	     rx_error,
   output reg 	     tx_transfer_active,
   output reg 	     tx_error,
   input reg 	     buffer_reserved,
   input reg [6:0]   tx_packet_data_size,
   output reg [6:0]  buffer_occupancy,
   output reg [31:0] rx_data,
   input reg 	     get_rx_data,
   input reg 	     store_tx_data,
   input reg [31:0]  tx_data,
   input reg [1:0]   data_size,
   output reg [7:0]  tx_packet_data,
   input reg 	     get_tx_packet_data,
   input reg [7:0]   rx_packet_data,
   input reg 	     store_rx_packet_data,
   output reg [1:0]  tx_packet,
   output reg 	     d_mode,
   input reg [2:0]   rx_packet,
   input reg 	     tx_status
   );

   wire 	     clear;
   
   
   protocol_controller pc (.clk(clk),
			   .n_rst(n_rst),
			   .rx_data_ready(rx_data_ready),
			   .rx_transfer_active(rx_transfer_active),
			   .rx_error(rx_error),
			   .tx_transfer_active(tx_transfer_active),
			   .tx_error(tx_error),
			   .buffer_reserved(buffer_reserved),
	        	   .buffer_occupancy(buffer_occupancy),
			   .clear(clear),
			   .tx_packet(tx_packet),
			   .d_mode(d_mode),
			   .rx_packet(rx_packet),
			   .tx_status(tx_status));

   data_buffer db (.clk(clk),
		   .n_rst(n_rst),
		   .buffer_occupancy(buffer_occupancy),
		   .rx_data(rx_data),
		   .get_rx_data(get_rx_data),
		   .store_tx_data(store_tx_data),
		   .tx_data(tx_data),
		   .data_size(data_size),
		   .tx_packet_data(tx_packet_data),
		   .get_tx_packet_data(get_tx_packet_data),
		   .rx_packet_data(rx_packet_data),
		   .store_rx_packet_data(store_rx_packet_data),
		   .clear(clear));

endmodule // pc_db_top
