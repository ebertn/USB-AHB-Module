module value_registers (
	input wire clk,
	input wire nRst,
	
	input wire rxDataReady,
	input wire rxTransferActive,
	input wire txTransferActive,
	input wire txError,
	input wire rxError,
	
	input reg [6:0] bufferOccupancy,
	input reg [7:0] nextEHTSData,
	
	output logic [15:0] statusData,
	output logic [15:0] errorData,
	output logic [7:0]  boData,
	output logic [7:0]  ehtsData
);

// Internal Signals
logic [15:0] nextStatusData;
logic [15:0] nextErrorData;


// Next State Logic for Status Register
always_comb begin
	nextStatusData = 16'h00;
	nextStatusData[0] = rxDataReady;
	nextStatusData[8] = rxTransferActive;
	nextStatusData[9] = txTransferActive;
end


// Status Register
always_ff @(posedge clk, negedge nRst) begin
	if (nRst == 1'b0) begin
		statusData <= '0;
	end else begin
		statusData <= nextStatusData;
	end
end


// Next State Logic for Error Register
always_comb begin
	nextErrorData = 16'h00;
	nextErrorData[8] = txError;
	nextErrorData[0] = rxError;
end


// Error Register
always_ff @(posedge clk, negedge nRst) begin
	if (nRst == 1'b0) begin
		errorData <= '0;
	end else begin
		errorData <= nextErrorData;
	end
end


// Buffer Occupancy Register
always_ff @(posedge clk, negedge nRst) begin
	if (nRst == 1'b0) begin
		boData <= '0;
	end else begin
		boData <= {1'b0, bufferOccupancy};
	end
end


// Endpoint-to-host Transfer Size Register
always_ff @(posedge clk, negedge nRst) begin
	if (nRst == 1'b0) begin
		ehtsData <= '0;
	end else begin
		ehtsData <= nextEHTSData;
	end
end

endmodule
