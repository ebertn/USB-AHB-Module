// $Id: $
// File name:   flex_counter.sv
// Created:     2/12/2019
// Author:      Nick Ebert
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Flexible counter design

module flex_counter
#(
parameter NUM_CNT_BITS = 4
)
(
input logic clk,
input logic n_rst,
input logic clear,
input logic count_enable,
input logic [(NUM_CNT_BITS - 1):0] rollover_val,
output logic [(NUM_CNT_BITS - 1):0] count_out,
output logic rollover_flag
);

logic [(NUM_CNT_BITS - 1):0] next_count_out;
logic next_rollover_flag;

always_ff @(posedge clk, negedge n_rst) begin
	if(!n_rst) begin
		count_out <= '0;
                rollover_flag <= '0;
	end
	else begin
		count_out <= next_count_out;
                rollover_flag <= next_rollover_flag;
	end
end

always_comb begin
	next_rollover_flag = 1'b0;//rollover_flag;//1'b0;
	next_count_out = count_out;

	if (clear) begin
		next_count_out = '0;
		next_rollover_flag = '0;
	end
	else if (count_enable) begin
		next_count_out = count_out + 1;
		if(count_out == rollover_val)
			next_count_out = 1;

		next_rollover_flag = 0;
		if(count_out == rollover_val - 1)
			next_rollover_flag = 1'b1;
	end        
end

endmodule


