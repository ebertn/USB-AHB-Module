module ahb_lite_usb (
	// System Signals	
	input wire clk,
	input wire nRst,
	
	// AHB-Lite Input Signals
	input wire hsel,
	input wire [6:0] haddr,
	input wire [1:0] htrans,
	input wire [1:0] hsize,
	input wire hwrite,
	input wire [31:0] hwdata,
	input wire [2:0] hburst,

	// External USB Input Signals
	input wire dPlusIn,
	input wire dMinusIn,	

	// AHB-Lite Output Signals
	output wire [31:0] hrdata,
	output wire hresp,
	output wire hready

	// External USB Output Signals
	output wire dMode,
	output wire dPlusOut,
	output wire dMinusOut
);

	// Intermediate Signals
	wire rxDataReady;
	wire rxTransferActive;
	wire rxError;
	wire txTransferActive;
	wire txError;
	wire bufferReserved;
	wire getRxData;
	wire storeTxData;
	wire [1:0]	dataSize;
	wire [6:0]	bufferOccupancy;
	wire [6:0]	txPacketDataSize;
	wire [31:0]	txData;
	wire [31:0]	rxData;

	// AHB-Lite Slave
	ahb_lite_slave slave (
		.clk(clk),
		.nRst(nRst),
		.hsel(hsel),
		.haddr(haddr),
		.htrans(htrans),
		.hsize(hsize),
		.hwrite(hwrite),
		.hwdata(hwdata),
		.hburst(hburst),
		.rxDataReady(rxDataReady),
		.rxTransferActive(rxTransferActive),
		.rxError(rxError),
		.txTransferActive(txTransferActive),
		.txError(txError),
		.bufferOccupancy(bufferOccupancy),
		.rxData(rxData),
		.hrdata(hrdata),
		.hresp(hresp),
		.hready(hready),
		.bufferReserved(bufferReserved),
		.getRxData(getRxData),
		.storeTxData(storeTxData),
		.txData(txData),
		.dataSize(dataSize),
		.txPacketDataSize(txPacketDataSize)
	);

	// Protocol Controller


	// Data Buffer


	// USB RX


	// USB TX	

endmodule
