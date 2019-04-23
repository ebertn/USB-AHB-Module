module timer
(
	input wire clk, 
	input wire n_rst, 
	input wire [7:0] bit_period, 
	input wire sync_byte, 
	output wire shift_enable, 
	output wire byte_count
	
	

); 
	reg [7:0] sr_count; 
	reg [3:0] byte_c; 
	reg dummy; 
	flex_counter #(.NUM_CNT_BITS(8)) SHIFT_REGISTER  (.clk(clk), 
				.n_rst(n_rst), 	
				.clear(dummy), 
				.count_enable(sync_byte), 
				.rollover_val(bit_period), 
				.count_out(sr_count), 
				.rollover_flag(shift_enable)
	);
	
	flex_counter #(.NUM_CNT_BITS(4)) BYTE (.clk(clk), 
				.n_rst(n_rst), 	
				.clear(dummy), 
				.count_enable(sync_byte), 
				.rollover_val(4'b1000), 
				.count_out(byte_c), 
				.rollover_flag(byte_count)
	);
	
	
	

endmodule 