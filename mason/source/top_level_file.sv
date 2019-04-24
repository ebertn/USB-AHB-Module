// $Id: $
// File name:   top_level_file.sv
// Created:     4-23-19
// Author:      Mason Fritzen, Holden Rahn, Chris Jovanovic, Nick Ebert
// Lab Section: 002
// Version:     1.0  Initial Design Entry
// Description: Top level file for CDL

//IMPORTANT: open report file and make sure critical path is <10ns

module top_level_file
(
 input reg 	   clk,
 input reg 	   n_rst,
 input reg [31:0]  hrdata,
 input reg 	   hresp,
 input reg 	   hready,
 input reg [2:0]   hburst,
 input reg 	   d_plus_in,
 input reg 	   d_minus_in,
 output reg 	   hsel,
 output reg [6:0]  haddr,
 output reg [1:0]  htrans,
 output reg [1:0]  hsize,
 output reg 	   hwrite,
 output reg [31:0] hwdata,
 output reg 	   d_mode,
 output reg 	   d_plus_out,
 output reg 	   d_minus_out
 );

   wire 	   rx_data_ready;
   wire 	   rx_transfer_active;
   wire 	   rx_error;
   wire 	   tx_transfer_active;
   wire 	   tx_error;
   wire 	   buffer_reserved;
   wire [6:0] 	   buffer_occupancy;
   wire [31:0] 	   rx_data;
   wire 	   get_rx_data;
   wire 	   store tx_data;
   wire [31:0] 	   tx_data;
   wire [1:0] 	   data_size;
   wire [6:0] 	   tx_packet_data_size;
   wire [7:0] 	   tx_packet_data;
   wire 	   get_tx_packet_data;
   wire [7:0] 	   rx_packet_data;
   wire 	   store_rx_packet_data;
   wire 	   tx_status;
   wire [1:0] 	   tx_packet;
   wire [2:0] 	   rx_packet;
   wire 	   clear;
   wire 	   lock_db;
   wire 	   lock_error;
         
   ahb_lite_slave ahb_lite_slave(
				 .clk(clk)
				 .nRst(n_rst)
				 .hsel(hsel),
				 .haddr(hresp),
				 .htrans(htrans),
				 .hsize(hsize),
				 .hwrite(hwrite),
				 .hwdata(hwdata),
				 .hburst(hburst),
				 .rxDataReady(rx_data_ready),
				 .rxTransferActive(rx_transfer_active),
				 .rxError(rx_error),
				 .txTransferActive(tx_transfer_active),
				 .txError(tx_error),
				 .bufferOccupancy(buffer_occupancy),
				 .rxData(rx_data),
				 .hrdata(hrdata),
				 .hresp(hresp),
				 .hready(hready),
				 .bufferReserved(buffer_reserved),
				 .getRxData(get_rx_data),
				 .storeTxData(store_tx_data),
				 .txData(tx_data),
				 .dataSize(data_size),
				 .txPacketDataSize(tx_packet_data_size)
				 );

   protocol_controller protocol_controller(
					   .clk(clk)
					   .n_rst(n_rst)
					   .rx_data_ready(rx_data_ready),
					   .rx_transfer_active(rx_transfer_active),
					   .rx_error(rx_error),
					   .tx_transfer_active(tx_transfer_active),
					   .tx_error(tx_error),
					   .buffer_reserved(buffer_reserved),
					   .buffer_occupancy(buffer_occupancy),
					   .clear(clear),
					   .tx_status(tx_status),
					   .tx_packet(tx_packet),
					   .d_mode(d_mode),
					   .rx_packet(rx_packet),
					   .lock_db(lock_db),
					   .lock_error(lock_error)
					   );

   data_buffer data_buffer(
			   .clk(clk)
			   .n_rst(n_rst)
			   .buffer_occupancy(buffer_occupancy),
			   .get_rx_data(get_rx_data),
			   .store_tx_data(store_tx_data),
			   .tx_data(tx_data),
			   .data_size(data_size),
			   .tx_packet_data(tx_packet_data),
			   .get_tx_packet_data(get_tx_packet_data),
			   .rx_packet_data(rx_packet_data),
			   .store_rx_packet_data(store_rx_packet_data),
			   .clear(clear),
			   .lock_db(lock_db),
			   .lock_error(lock_error)
			   );

   usb_rx usb_rx(
		 .clk(clk)
		 .n_rst(n_rst)
		 .rx_packet(rx_packet),
		 .store_rx_packet(store_rx_packet_data),
		 .rx_packet_data(rx_packet_data),
		 .dminus_in(d_minus_in),
		 .dplus_in(d_plus_in)
		 );

   usb_tx usb_tx(
		 .clk(clk)
		 .n_rst(n_rst)
		 .get_tx_packet_data(get_tx_packet_data),
		 .tx_packet_data(tx_packet_data),
		 .tx_packet_data_size(tx_packet_data_size),
		 .dminus_out(d_minus_out),
		 .dplus_out(d_plus_out),
		 .tx_packet(tx_packet),
		 .tx_status(tx_status)
		 );

endmodule // top_level_file
