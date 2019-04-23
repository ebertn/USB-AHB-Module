

module sr_8bit
(
	
	input wire clk, 
	input wire n_rst, 
	input wire shift_strobe, 
	input wire serial_in, 
	input wire byte_done, 
	output reg [7:0] packet_data,
	output reg sync_byte_detected
); 
	reg [7:0] temp_packet_data; 
	
	flex_stp_sr #(.NUM_BITS(8), .SHIFT_MSB(1'b0)) CORE( .clk(clk),
    		.n_rst(n_rst),
		.shift_enable(shift_strobe),
   		.serial_in(serial_in),
    		.parallel_out(temp_packet_data)
  	);
	
	always_comb begin
		if (byte_done == 1'b1) begin
			packet_data = temp_packet_data; 
		end else begin
			packet_data = 8'b00000000;
		end  
	end  
	always_ff @(posedge clk, negedge n_rst) begin
		if(n_rst == 1'b0) begin
			sync_byte_detected = 1'b0; 
		end else if (packet_data == 8'b10000000) begin
			sync_byte_detected = 1'b1; 
		end 
	end
	
endmodule 