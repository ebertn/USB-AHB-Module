module crc_checker_16bit (
	input wire clk,
	input wire nRst,
	input wire din,
	input wire clear,
	output wire crcError
);

reg [16:0] q;
wire xor1, xor2, xor3;

assign xor1 = q[0] ^ q[16];
assign xor2 = q[2] ^ q[16];
assign xor3 = q[15] ^ q[16];
assign crcError = |q;

always_ff @(posedge clk, negedge nRst) begin
	if (nRst == 1'b0) begin
		q <= '0;
	end else begin
		if (clear == 1'b1) begin
			q <= '0;
		end else begin
			q[16] <= xor3;
			q[15] <= q[14];
			q[14] <= q[13];
			q[13] <= q[12];
			q[12] <= q[11];
			q[11] <= q[10];
			q[10] <= q[9];
			q[9]  <= q[8];
			q[8]  <= q[7];
			q[7]  <= q[6];
			q[6]  <= q[5];
			q[5]  <= q[4];
			q[4]  <= q[3];
			q[3]  <= xor2;
			q[2]  <= q[1];
			q[1]  <= xor1;
			q[0]  <= din;
		end
	end
end

endmodule
