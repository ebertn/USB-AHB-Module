module flex_pts_sr
#(
	parameter NUM_BITS = 4,
	parameter SHIFT_MSB = 1
)
(
	input wire clk,
	input wire n_rst,
	input wire shift_enable,
	input wire load_enable,
	input wire [NUM_BITS-1:0] parallel_in,
	output reg serial_out
);
	reg [NUM_BITS - 1:0] next_state;
	reg [NUM_BITS - 1:0] out_state;

	//next state logic
	always_comb begin
		if (load_enable == 1) begin
			next_state = parallel_in;
		end else if (shift_enable == 1 && load_enable == 0) begin
			if (SHIFT_MSB == 1) begin
				next_state = {out_state[NUM_BITS - 2:0], 1'b1};
			end else begin
				next_state = {1'b1, out_state[NUM_BITS - 1:1]};
			end
		end else begin
			next_state = out_state;
		end
	end

	//output logic
	always_comb begin
		if (SHIFT_MSB == 1) begin
			serial_out = out_state[NUM_BITS - 1];
		end else begin
			serial_out = out_state[0];
		end
	end
	
	always_ff @(posedge clk, negedge n_rst) begin
		if (n_rst == 0) begin
			out_state <= '1;
		end else begin
			out_state <= next_state;
		end
	end

endmodule
