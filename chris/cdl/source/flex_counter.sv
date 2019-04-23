


module flex_counter
#(
	parameter NUM_CNT_BITS = 4 
)
(
	input wire clk,
	input wire n_rst, 
	input wire clear, 
	input wire count_enable, 
	input wire [NUM_CNT_BITS-1:0] rollover_val, 
	output wire [NUM_CNT_BITS-1:0] count_out, 
	output wire rollover_flag
); 
 

	reg [NUM_CNT_BITS-1:0] count; 
	reg [NUM_CNT_BITS-1:0] next_count;
	reg r_flag;  
	reg next_r_flag; 

	always_ff @ (negedge n_rst, posedge clk) begin
		if (1'b0 == n_rst) begin
			count <= '0; 
			r_flag <= '0; 
		end else begin
			count <= next_count; 
			r_flag <= next_r_flag; 	
		end	
	end

	always_comb begin
		next_r_flag = r_flag; 
		next_count = count; 
		if (1'b1 == clear) begin
			next_count = '0; 
			next_r_flag = 1'b0; 
		end else if (count_enable) begin
			next_count = count + 1;
			if (r_flag) begin
				next_count = 1; 
			end
			next_r_flag = 1'b0; 
			if(count == rollover_val-1)begin
				next_r_flag = 1'b1; 
			end 
		end  
	end

	assign count_out = count; 
	assign rollover_flag = r_flag;
 
endmodule		
