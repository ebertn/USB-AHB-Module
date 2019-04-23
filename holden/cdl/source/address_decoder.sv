module address_decoder (
	input wire clk,
	input wire nRst,
	
	input wire [6:0] haddr,
	input wire [1:0] hsize,
	input wire [31:0] hwdata,
	
	input reg [1:0] state,
	
	input reg [31:0] rdata,
	input reg [15:0] statusData,
	input reg [15:0] errorData,
	input reg [7:0] boData,
	input reg [7:0] ehtsData,
	
	output reg [7:0] nextEHTSData,
	output reg [31:0] hrdata,
	output reg [31:0] txData
);

localparam IDLE = 2'b00;
localparam WRITE = 2'b01;
localparam READ = 2'b10;
localparam ERROR = 2'b11;

// Internal Signals
reg [6:0] prevAddr;
reg [1:0] prevSize;


// Register to get the last address
always_ff @(posedge clk, negedge nRst) begin
	if (nRst == 1'b0) begin
		prevAddr <= '0;
	end else begin
		prevAddr <= haddr;
	end
end


// Register to get the last size
always_ff @(posedge clk, negedge nRst) begin
	if (nRst == 1'b0) begin
		prevSize <= '0;
	end else begin
		prevSize <= hsize;
	end
end


// Address Decoder
always_comb begin
	hrdata = 32'h00000000;
	txData = 32'h00000000;
	nextEHTSData = ehtsData;
	
	if (state == WRITE) begin
		if (prevAddr >= 7'h00 && prevAddr <= 7'h3F) begin			// data buffer
			if (prevSize == 2'b00) begin
				txData = {24'h000, hwdata[7:0]};
			end else if (prevSize == 2'b01) begin
				txData = {16'h00, hwdata[15:0]};
			end else if (prevSize == 2'b10) begin
				txData = hwdata;
			end
		end else if (prevAddr == 7'h48) begin						// endpoint-to-host transfer size register
			nextEHTSData = hwdata[7:0];
		end
	end else if (state == READ) begin
		if (prevAddr >= 7'h00 && prevAddr <= 7'h3F) begin			// data buffer
			if (prevSize == 2'b00) begin
				hrdata = {24'h000, rdata[7:0]};
			end else if (prevSize == 2'b01) begin
				hrdata = {16'h00, rdata[15:0]};
			end else if (prevSize == 2'b10) begin
				hrdata = rdata;
			end
		end else if (prevAddr == 7'h40 || prevAddr == 7'h41) begin	// status register
			if (prevSize == 2'b00) begin
				hrdata = (prevAddr == 7'h40) ? {24'h000, statusData[7:0]} : {24'h000, statusData[15:8]};
			end else if (prevSize == 2'b01) begin
				hrdata = {16'h00, statusData};
			end
		end else if (prevAddr == 7'h42 || prevAddr == 7'h43) begin	// error register
			if (prevSize == 2'b00) begin
				hrdata = (prevAddr == 7'h42) ? {24'h000, errorData[7:0]} : {24'h000, errorData[15:8]};
			end else if (prevSize == 2'b01) begin
				hrdata = {16'h00, errorData};
			end
		end else if (prevAddr == 7'h44) begin						// buffer occupancy register
			if (prevSize == 2'b00) begin
				hrdata = {24'h0000, boData};
			end
		end else if (prevAddr == 7'h48) begin						// endpoint-to-host transfer size register
			if (prevSize == 2'b00) begin
				hrdata = {24'h0000, ehtsData};
			end
		end
	end
end

endmodule
