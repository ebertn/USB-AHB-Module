


module flex_stp_sr
#(
	parameter NUM_BITS = 4, 
	parameter SHIFT_MSB = 1'b1
)
(
	input wire clk, 
	input wire n_rst, 
	input wire shift_enable, 
	input wire serial_in, 
	output wire [NUM_BITS-1:0] parallel_out
); 
	reg [NUM_BITS-1:0] par; 
	reg [NUM_BITS-1:0] next_par; 
	
	
	always_ff @ (posedge clk, negedge n_rst) begin 
		if (!n_rst) begin
			par <= '1; 
		end else begin
			par <= next_par; 
		end 
	end 
	always_comb begin
		
		if (shift_enable) begin
			if( SHIFT_MSB) begin
				next_par = {par[NUM_BITS-2:0], serial_in}; 
			end else begin
				next_par = {serial_in,par[NUM_BITS-1:1]};
			end 

		end else begin
			next_par = par; 
		end	
	end
	assign parallel_out = par; 

endmodule 	
