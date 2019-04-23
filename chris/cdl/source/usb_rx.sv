module usb_rx
(
	input wire clk,
	input wire n_rst,
	input wire dplus_in, 
	input wire dminus_in, 
	output wire [2:0] rx_packet, 
	output wire store_rx_packet, 
	output wire [7:0] rx_packet_data
); 
	
	logic eop; 
	logic d_decoded; 
	logic shift_enable; 
	logic byte_count; 
	logic sync_byte; 
	reg [7:0] packet_in; 
	logic [7:0] bit_period; 

	decoder DECODE (.clk(clk), 
		.n_rst(n_rst), 
		.d_plus_in(dplus_in), 
		.d_minus_in(dminus_in), 
		.d_decoded(d_decoded), 
		.eop(eop)
	); 
		
	timer TIME (.clk(clk), 
		.n_rst(n_rst), 
		.bit_period(bit_period),
		.shift_enable(shift_enable),
		.byte_count(byte_count)
	); 
	
	sr_8bit SR (.clk(clk), 
		.n_rst(n_rst), 
		.shift_strobe(shift_enable), 
		.serial_in(d_decoded), 
		.byte_done(byte_count), 
		.packet_data(packet_in),
		.sync_byte_detected(sync_byte)
	); 

	
	control_fsm FSM(.clk(clk), 
		.n_rst(n_rst), 
		.sync_byte(sync_byte),
		.packet_in(packet_in), 
		.eop(eop), 
		.packet_data(rx_packet_data),
		.rx_packet(rx_packet), 
		.store_rx_data(store_rx_packet)
	); 

endmodule

		
		
