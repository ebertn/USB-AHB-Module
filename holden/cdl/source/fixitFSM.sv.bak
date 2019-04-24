module fixitFSM (
	input wire clk,
	input wire nRst,
	input wire txPacketSizeChanged,
	input wire rxDataReady,
	input wire [6:0] bufferOccupancy,
	input wire [6:0] txPacketDataSize,
	output wire bufferReserved
);

localparam IDLE = 2'b00;
localparam WRITE = 2'b01;
localparam READ = 2'b10;

reg [1:0] nextState
reg [1:0] state;

// next state logic
always_comb begin
	nextState = IDLE;
	if (state == IDLE) begin
		if (txPacketSizeChanged == 1'b1) begin
			nextState = WRITE;
		end else if (rxDataReady == 1'b1) begin
			nextState = READ;
		end else begin
			nextState = IDLE;
		end
	end else if (state == WRITE) begin
		nextState = (txPacketDataSize == bufferOccupancy) ? IDLE : WRITE;
	end else if (state == READ) begin
		nextState = (bufferOccupancy == '0) ? IDLE : READ;
	end
end

// state register
always_ff @(posedge clk, negedge nRst) begin
	if (nRst == 1'b0) begin
		state <= 2'b00;
	end else begin
		state <= nextState;
	end
end

// output logic
assign bufferReserved = ((state == WRITE) || (state == READ)) ? 1'b1 : 1'b0

endmodule
