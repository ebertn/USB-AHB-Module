/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Wed Apr 24 06:35:33 2019
/////////////////////////////////////////////////////////////


module value_registers ( clk, nRst, rxDataReady, rxTransferActive, 
        txTransferActive, txError, rxError, bufferOccupancy, nextEHTSData, 
        statusData, errorData, boData, ehtsData );
  input [6:0] bufferOccupancy;
  input [7:0] nextEHTSData;
  output [15:0] statusData;
  output [15:0] errorData;
  output [7:0] boData;
  output [7:0] ehtsData;
  input clk, nRst, rxDataReady, rxTransferActive, txTransferActive, txError,
         rxError;

  assign statusData[15] = 1'b0;
  assign statusData[14] = 1'b0;
  assign statusData[13] = 1'b0;
  assign statusData[12] = 1'b0;
  assign statusData[11] = 1'b0;
  assign statusData[10] = 1'b0;
  assign statusData[7] = 1'b0;
  assign statusData[6] = 1'b0;
  assign statusData[5] = 1'b0;
  assign statusData[4] = 1'b0;
  assign statusData[3] = 1'b0;
  assign statusData[2] = 1'b0;
  assign statusData[1] = 1'b0;
  assign errorData[15] = 1'b0;
  assign errorData[14] = 1'b0;
  assign errorData[13] = 1'b0;
  assign errorData[12] = 1'b0;
  assign errorData[11] = 1'b0;
  assign errorData[10] = 1'b0;
  assign errorData[9] = 1'b0;
  assign errorData[7] = 1'b0;
  assign errorData[6] = 1'b0;
  assign errorData[5] = 1'b0;
  assign errorData[4] = 1'b0;
  assign errorData[3] = 1'b0;
  assign errorData[2] = 1'b0;
  assign errorData[1] = 1'b0;
  assign boData[7] = 1'b0;

  DFFSR \statusData_reg[9]  ( .D(txTransferActive), .CLK(clk), .R(nRst), .S(
        1'b1), .Q(statusData[9]) );
  DFFSR \statusData_reg[8]  ( .D(rxTransferActive), .CLK(clk), .R(nRst), .S(
        1'b1), .Q(statusData[8]) );
  DFFSR \statusData_reg[0]  ( .D(rxDataReady), .CLK(clk), .R(nRst), .S(1'b1), 
        .Q(statusData[0]) );
  DFFSR \errorData_reg[8]  ( .D(txError), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        errorData[8]) );
  DFFSR \errorData_reg[0]  ( .D(rxError), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        errorData[0]) );
  DFFSR \boData_reg[6]  ( .D(bufferOccupancy[6]), .CLK(clk), .R(nRst), .S(1'b1), .Q(boData[6]) );
  DFFSR \boData_reg[5]  ( .D(bufferOccupancy[5]), .CLK(clk), .R(nRst), .S(1'b1), .Q(boData[5]) );
  DFFSR \boData_reg[4]  ( .D(bufferOccupancy[4]), .CLK(clk), .R(nRst), .S(1'b1), .Q(boData[4]) );
  DFFSR \boData_reg[3]  ( .D(bufferOccupancy[3]), .CLK(clk), .R(nRst), .S(1'b1), .Q(boData[3]) );
  DFFSR \boData_reg[2]  ( .D(bufferOccupancy[2]), .CLK(clk), .R(nRst), .S(1'b1), .Q(boData[2]) );
  DFFSR \boData_reg[1]  ( .D(bufferOccupancy[1]), .CLK(clk), .R(nRst), .S(1'b1), .Q(boData[1]) );
  DFFSR \boData_reg[0]  ( .D(bufferOccupancy[0]), .CLK(clk), .R(nRst), .S(1'b1), .Q(boData[0]) );
  DFFSR \ehtsData_reg[7]  ( .D(nextEHTSData[7]), .CLK(clk), .R(nRst), .S(1'b1), 
        .Q(ehtsData[7]) );
  DFFSR \ehtsData_reg[6]  ( .D(nextEHTSData[6]), .CLK(clk), .R(nRst), .S(1'b1), 
        .Q(ehtsData[6]) );
  DFFSR \ehtsData_reg[5]  ( .D(nextEHTSData[5]), .CLK(clk), .R(nRst), .S(1'b1), 
        .Q(ehtsData[5]) );
  DFFSR \ehtsData_reg[4]  ( .D(nextEHTSData[4]), .CLK(clk), .R(nRst), .S(1'b1), 
        .Q(ehtsData[4]) );
  DFFSR \ehtsData_reg[3]  ( .D(nextEHTSData[3]), .CLK(clk), .R(nRst), .S(1'b1), 
        .Q(ehtsData[3]) );
  DFFSR \ehtsData_reg[2]  ( .D(nextEHTSData[2]), .CLK(clk), .R(nRst), .S(1'b1), 
        .Q(ehtsData[2]) );
  DFFSR \ehtsData_reg[1]  ( .D(nextEHTSData[1]), .CLK(clk), .R(nRst), .S(1'b1), 
        .Q(ehtsData[1]) );
  DFFSR \ehtsData_reg[0]  ( .D(nextEHTSData[0]), .CLK(clk), .R(nRst), .S(1'b1), 
        .Q(ehtsData[0]) );
endmodule

