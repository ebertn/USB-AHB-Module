module crc_checker_5bit (
	input wire clk,
	input wire nRst,
	input wire din,
	input wire clear,
	output wire crcError
);

reg [5:0] q;
wire xor1, xor2;

assign xor1 = q[0] ^ q[5]; 
assign xor2 = q[2] ^ q[5];
assign crcError = |q;

always_ff @(posedge clk, negedge nRst) begin
	if (nRst == 1'b0) begin
		q <= '0;
	end else begin
		if (clear == 1'b1) begin
			q <= '0;
		end else begin
			q[5] <= q[4];
			q[4] <= q[3];
			q[3] <= xor2;
			q[2] <= q[1];
			q[1] <= xor1;
			q[0] <= din;
		end
	end
end

endmodule
