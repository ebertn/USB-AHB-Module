module rdata_register (
	input wire clk,
	input wire nRst,
	input wire [31:0] rxData,
	output reg [31:0] rdata
);

// RDATA Register
always_ff @(posedge clk, negedge nRst) begin
	if (nRst == 1'b0) begin
		rData <= '0;
	end else begin
		rData <= rxData;
	end
end

endmodule
