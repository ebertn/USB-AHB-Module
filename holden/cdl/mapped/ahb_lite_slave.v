/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Wed Apr 24 09:42:51 2019
/////////////////////////////////////////////////////////////


module state_controller ( clk, nRst, haddr, htrans, hsize, hwrite, hsel, state, 
        storeTxData, getRxData, hresp, hready, dataSize, txPacketSizeChanged
 );
  input [6:0] haddr;
  input [1:0] htrans;
  input [1:0] hsize;
  output [1:0] state;
  output [1:0] dataSize;
  input clk, nRst, hwrite, hsel;
  output storeTxData, getRxData, hresp, hready, txPacketSizeChanged;
  wire   N7, n23, n24, n25, n26, n27, n29, n30, n31, n32, n33, n34, n35, n36,
         n37, n38, n39, n40, n41, n42, n43, n44, n1, n2, n3, n4, n5, n6, n9,
         n10, n11, n12, n13, n14, n15;
  assign dataSize[1] = hsize[1];
  assign dataSize[0] = hsize[0];
  assign hresp = N7;

  DFFSR \state_reg[1]  ( .D(n1), .CLK(clk), .R(nRst), .S(1'b1), .Q(state[1])
         );
  DFFSR \state_reg[0]  ( .D(n2), .CLK(clk), .R(nRst), .S(1'b1), .Q(state[0])
         );
  NOR2X1 U21 ( .A(n23), .B(n24), .Y(txPacketSizeChanged) );
  NOR2X1 U22 ( .A(n24), .B(haddr[6]), .Y(storeTxData) );
  NAND3X1 U23 ( .A(n3), .B(n25), .C(hwrite), .Y(n24) );
  NOR2X1 U24 ( .A(n26), .B(n27), .Y(getRxData) );
  NAND2X1 U25 ( .A(n4), .B(n3), .Y(n27) );
  NAND2X1 U26 ( .A(hready), .B(n29), .Y(N7) );
  NAND2X1 U27 ( .A(state[1]), .B(state[0]), .Y(n29) );
  NAND2X1 U28 ( .A(n1), .B(n2), .Y(hready) );
  OAI21X1 U29 ( .A(n31), .B(n26), .C(n3), .Y(n30) );
  NAND2X1 U30 ( .A(n25), .B(n15), .Y(n26) );
  AOI21X1 U31 ( .A(n32), .B(n5), .C(n33), .Y(n31) );
  OAI21X1 U32 ( .A(n34), .B(n35), .C(haddr[6]), .Y(n33) );
  NAND2X1 U33 ( .A(n14), .B(n13), .Y(n35) );
  AOI21X1 U34 ( .A(n36), .B(n5), .C(n37), .Y(n34) );
  NOR2X1 U35 ( .A(haddr[1]), .B(haddr[0]), .Y(n36) );
  NAND3X1 U36 ( .A(haddr[6]), .B(n9), .C(n39), .Y(n38) );
  NOR2X1 U37 ( .A(haddr[2]), .B(hsize[1]), .Y(n32) );
  OAI21X1 U38 ( .A(n15), .B(n41), .C(n3), .Y(n40) );
  OAI21X1 U39 ( .A(htrans[0]), .B(htrans[1]), .C(hsel), .Y(n42) );
  OAI21X1 U40 ( .A(n4), .B(n6), .C(n25), .Y(n41) );
  NAND2X1 U41 ( .A(hsize[1]), .B(hsize[0]), .Y(n25) );
  NAND3X1 U42 ( .A(n14), .B(n13), .C(n37), .Y(n23) );
  NOR2X1 U43 ( .A(n43), .B(n44), .Y(n37) );
  NAND3X1 U44 ( .A(haddr[3]), .B(n12), .C(haddr[6]), .Y(n44) );
  NAND3X1 U45 ( .A(n11), .B(n10), .C(n39), .Y(n43) );
  NOR2X1 U46 ( .A(haddr[5]), .B(haddr[4]), .Y(n39) );
  INVX2 U4 ( .A(n40), .Y(n1) );
  INVX2 U5 ( .A(n30), .Y(n2) );
  INVX2 U7 ( .A(n42), .Y(n3) );
  INVX2 U8 ( .A(haddr[6]), .Y(n4) );
  INVX2 U9 ( .A(n38), .Y(n5) );
  INVX2 U10 ( .A(n23), .Y(n6) );
  INVX2 U11 ( .A(haddr[3]), .Y(n9) );
  INVX2 U12 ( .A(haddr[2]), .Y(n10) );
  INVX2 U13 ( .A(haddr[1]), .Y(n11) );
  INVX2 U14 ( .A(haddr[0]), .Y(n12) );
  INVX2 U15 ( .A(hsize[1]), .Y(n13) );
  INVX2 U16 ( .A(hsize[0]), .Y(n14) );
  INVX2 U17 ( .A(hwrite), .Y(n15) );
endmodule


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


module rdata_register ( clk, nRst, rxData, rdata );
  input [31:0] rxData;
  output [31:0] rdata;
  input clk, nRst;


  DFFSR \rdata_reg[31]  ( .D(rxData[31]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[31]) );
  DFFSR \rdata_reg[30]  ( .D(rxData[30]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[30]) );
  DFFSR \rdata_reg[29]  ( .D(rxData[29]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[29]) );
  DFFSR \rdata_reg[28]  ( .D(rxData[28]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[28]) );
  DFFSR \rdata_reg[27]  ( .D(rxData[27]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[27]) );
  DFFSR \rdata_reg[26]  ( .D(rxData[26]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[26]) );
  DFFSR \rdata_reg[25]  ( .D(rxData[25]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[25]) );
  DFFSR \rdata_reg[24]  ( .D(rxData[24]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[24]) );
  DFFSR \rdata_reg[23]  ( .D(rxData[23]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[23]) );
  DFFSR \rdata_reg[22]  ( .D(rxData[22]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[22]) );
  DFFSR \rdata_reg[21]  ( .D(rxData[21]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[21]) );
  DFFSR \rdata_reg[20]  ( .D(rxData[20]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[20]) );
  DFFSR \rdata_reg[19]  ( .D(rxData[19]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[19]) );
  DFFSR \rdata_reg[18]  ( .D(rxData[18]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[18]) );
  DFFSR \rdata_reg[17]  ( .D(rxData[17]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[17]) );
  DFFSR \rdata_reg[16]  ( .D(rxData[16]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[16]) );
  DFFSR \rdata_reg[15]  ( .D(rxData[15]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[15]) );
  DFFSR \rdata_reg[14]  ( .D(rxData[14]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[14]) );
  DFFSR \rdata_reg[13]  ( .D(rxData[13]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[13]) );
  DFFSR \rdata_reg[12]  ( .D(rxData[12]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[12]) );
  DFFSR \rdata_reg[11]  ( .D(rxData[11]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[11]) );
  DFFSR \rdata_reg[10]  ( .D(rxData[10]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[10]) );
  DFFSR \rdata_reg[9]  ( .D(rxData[9]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[9]) );
  DFFSR \rdata_reg[8]  ( .D(rxData[8]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[8]) );
  DFFSR \rdata_reg[7]  ( .D(rxData[7]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[7]) );
  DFFSR \rdata_reg[6]  ( .D(rxData[6]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[6]) );
  DFFSR \rdata_reg[5]  ( .D(rxData[5]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[5]) );
  DFFSR \rdata_reg[4]  ( .D(rxData[4]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[4]) );
  DFFSR \rdata_reg[3]  ( .D(rxData[3]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[3]) );
  DFFSR \rdata_reg[2]  ( .D(rxData[2]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[2]) );
  DFFSR \rdata_reg[1]  ( .D(rxData[1]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[1]) );
  DFFSR \rdata_reg[0]  ( .D(rxData[0]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        rdata[0]) );
endmodule


module address_decoder ( clk, nRst, haddr, hsize, hwdata, state, rdata, 
        statusData, errorData, boData, ehtsData, nextEHTSData, hrdata, txData
 );
  input [6:0] haddr;
  input [1:0] hsize;
  input [31:0] hwdata;
  input [1:0] state;
  input [31:0] rdata;
  input [15:0] statusData;
  input [15:0] errorData;
  input [7:0] boData;
  input [7:0] ehtsData;
  output [7:0] nextEHTSData;
  output [31:0] hrdata;
  output [31:0] txData;
  input clk, nRst;
  wire   n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93,
         n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104, n105,
         n106, n107, n108, n109, n110, n111, n112, n113, n114, n115, n116,
         n117, n118, n119, n120, n121, n122, n123, n124, n125, n126, n127,
         n128, n129, n130, n131, n132, n133, n134, n135, n136, n137, n138,
         n139, n140, n141, n142, n143, n144, n145, n146, n147, n148, n149,
         n150, n151, n152, n153, n154, n155, n156, n157, n158, n159, n160,
         n161, n162, n163, n165, n166, n167, n168, n169, n170, n171, n172,
         n173, n174, n1, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29,
         n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43,
         n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57,
         n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70;
  wire   [6:0] prevAddr;
  wire   [1:0] prevSize;

  DFFSR \prevAddr_reg[6]  ( .D(haddr[6]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        prevAddr[6]) );
  DFFSR \prevAddr_reg[5]  ( .D(haddr[5]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        prevAddr[5]) );
  DFFSR \prevAddr_reg[4]  ( .D(haddr[4]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        prevAddr[4]) );
  DFFSR \prevAddr_reg[3]  ( .D(haddr[3]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        prevAddr[3]) );
  DFFSR \prevAddr_reg[2]  ( .D(haddr[2]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        prevAddr[2]) );
  DFFSR \prevAddr_reg[1]  ( .D(haddr[1]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        prevAddr[1]) );
  DFFSR \prevAddr_reg[0]  ( .D(haddr[0]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        prevAddr[0]) );
  DFFSR \prevSize_reg[1]  ( .D(hsize[1]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        prevSize[1]) );
  DFFSR \prevSize_reg[0]  ( .D(hsize[0]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        prevSize[0]) );
  AND2X2 U15 ( .A(hwdata[9]), .B(n80), .Y(txData[9]) );
  AND2X2 U16 ( .A(hwdata[8]), .B(n80), .Y(txData[8]) );
  AND2X2 U17 ( .A(hwdata[31]), .B(n82), .Y(txData[31]) );
  AND2X2 U18 ( .A(hwdata[30]), .B(n82), .Y(txData[30]) );
  AND2X2 U19 ( .A(hwdata[29]), .B(n82), .Y(txData[29]) );
  AND2X2 U20 ( .A(hwdata[28]), .B(n82), .Y(txData[28]) );
  AND2X2 U21 ( .A(hwdata[27]), .B(n82), .Y(txData[27]) );
  AND2X2 U22 ( .A(hwdata[26]), .B(n82), .Y(txData[26]) );
  AND2X2 U23 ( .A(hwdata[25]), .B(n82), .Y(txData[25]) );
  AND2X2 U24 ( .A(hwdata[24]), .B(n82), .Y(txData[24]) );
  AND2X2 U25 ( .A(hwdata[23]), .B(n82), .Y(txData[23]) );
  AND2X2 U26 ( .A(hwdata[22]), .B(n82), .Y(txData[22]) );
  AND2X2 U27 ( .A(hwdata[21]), .B(n82), .Y(txData[21]) );
  AND2X2 U28 ( .A(hwdata[20]), .B(n82), .Y(txData[20]) );
  AND2X2 U29 ( .A(hwdata[19]), .B(n82), .Y(txData[19]) );
  AND2X2 U30 ( .A(hwdata[18]), .B(n82), .Y(txData[18]) );
  AND2X2 U31 ( .A(hwdata[17]), .B(n82), .Y(txData[17]) );
  AND2X2 U32 ( .A(hwdata[16]), .B(n82), .Y(txData[16]) );
  AND2X2 U33 ( .A(n83), .B(n21), .Y(n82) );
  AND2X2 U34 ( .A(hwdata[15]), .B(n80), .Y(txData[15]) );
  AND2X2 U35 ( .A(hwdata[14]), .B(n80), .Y(txData[14]) );
  AND2X2 U36 ( .A(hwdata[13]), .B(n80), .Y(txData[13]) );
  AND2X2 U37 ( .A(hwdata[12]), .B(n80), .Y(txData[12]) );
  AND2X2 U38 ( .A(hwdata[11]), .B(n80), .Y(txData[11]) );
  AND2X2 U39 ( .A(hwdata[10]), .B(n80), .Y(txData[10]) );
  AND2X2 U40 ( .A(rdata[31]), .B(n20), .Y(hrdata[31]) );
  AND2X2 U41 ( .A(rdata[30]), .B(n20), .Y(hrdata[30]) );
  AND2X2 U42 ( .A(rdata[29]), .B(n20), .Y(hrdata[29]) );
  AND2X2 U43 ( .A(rdata[28]), .B(n20), .Y(hrdata[28]) );
  AND2X2 U44 ( .A(rdata[27]), .B(n20), .Y(hrdata[27]) );
  AND2X2 U45 ( .A(rdata[26]), .B(n20), .Y(hrdata[26]) );
  AND2X2 U46 ( .A(rdata[25]), .B(n20), .Y(hrdata[25]) );
  AND2X2 U47 ( .A(rdata[24]), .B(n20), .Y(hrdata[24]) );
  AND2X2 U48 ( .A(rdata[23]), .B(n20), .Y(hrdata[23]) );
  AND2X2 U49 ( .A(rdata[22]), .B(n20), .Y(hrdata[22]) );
  AND2X2 U50 ( .A(rdata[21]), .B(n20), .Y(hrdata[21]) );
  AND2X2 U51 ( .A(rdata[20]), .B(n20), .Y(hrdata[20]) );
  AND2X2 U52 ( .A(rdata[19]), .B(n20), .Y(hrdata[19]) );
  AND2X2 U53 ( .A(rdata[18]), .B(n20), .Y(hrdata[18]) );
  AND2X2 U54 ( .A(rdata[17]), .B(n20), .Y(hrdata[17]) );
  AND2X2 U55 ( .A(rdata[16]), .B(n20), .Y(hrdata[16]) );
  AND2X2 U56 ( .A(n27), .B(n151), .Y(n96) );
  AND2X2 U57 ( .A(n25), .B(n151), .Y(n95) );
  AND2X2 U58 ( .A(n152), .B(n1), .Y(n151) );
  AND2X2 U59 ( .A(n30), .B(n86), .Y(n104) );
  AND2X2 U60 ( .A(prevSize[1]), .B(n36), .Y(n83) );
  AND2X2 U61 ( .A(n158), .B(n88), .Y(n107) );
  NOR2X1 U123 ( .A(n81), .B(n63), .Y(txData[7]) );
  NOR2X1 U124 ( .A(n81), .B(n64), .Y(txData[6]) );
  NOR2X1 U125 ( .A(n81), .B(n65), .Y(txData[5]) );
  NOR2X1 U126 ( .A(n81), .B(n66), .Y(txData[4]) );
  NOR2X1 U127 ( .A(n81), .B(n67), .Y(txData[3]) );
  NOR2X1 U128 ( .A(n81), .B(n68), .Y(txData[2]) );
  NOR2X1 U129 ( .A(n81), .B(n69), .Y(txData[1]) );
  NOR2X1 U130 ( .A(n84), .B(n85), .Y(n80) );
  NOR2X1 U131 ( .A(n81), .B(n70), .Y(txData[0]) );
  NAND2X1 U132 ( .A(n21), .B(n86), .Y(n81) );
  OAI22X1 U133 ( .A(n22), .B(n47), .C(n63), .D(n87), .Y(nextEHTSData[7]) );
  OAI22X1 U134 ( .A(n22), .B(n48), .C(n64), .D(n87), .Y(nextEHTSData[6]) );
  OAI22X1 U135 ( .A(n22), .B(n49), .C(n65), .D(n87), .Y(nextEHTSData[5]) );
  OAI22X1 U136 ( .A(n22), .B(n50), .C(n66), .D(n87), .Y(nextEHTSData[4]) );
  OAI22X1 U137 ( .A(n22), .B(n51), .C(n67), .D(n87), .Y(nextEHTSData[3]) );
  OAI22X1 U138 ( .A(n22), .B(n52), .C(n68), .D(n87), .Y(nextEHTSData[2]) );
  OAI22X1 U139 ( .A(n22), .B(n53), .C(n69), .D(n87), .Y(nextEHTSData[1]) );
  OAI22X1 U140 ( .A(n22), .B(n54), .C(n70), .D(n87), .Y(nextEHTSData[0]) );
  NAND2X1 U141 ( .A(n88), .B(n89), .Y(n87) );
  NAND3X1 U142 ( .A(n84), .B(n61), .C(n91), .Y(n90) );
  NOR2X1 U143 ( .A(n62), .B(n92), .Y(n91) );
  NAND2X1 U144 ( .A(n30), .B(n89), .Y(n84) );
  NOR2X1 U145 ( .A(n62), .B(state[1]), .Y(n89) );
  OAI21X1 U146 ( .A(n93), .B(n43), .C(n94), .Y(hrdata[9]) );
  AOI22X1 U147 ( .A(errorData[9]), .B(n95), .C(statusData[9]), .D(n96), .Y(n94) );
  OAI21X1 U148 ( .A(n93), .B(n44), .C(n97), .Y(hrdata[8]) );
  AOI22X1 U149 ( .A(errorData[8]), .B(n95), .C(statusData[8]), .D(n96), .Y(n97) );
  OAI21X1 U150 ( .A(n99), .B(n100), .C(n1), .Y(n98) );
  OAI21X1 U151 ( .A(n102), .B(n60), .C(n103), .Y(n100) );
  AOI22X1 U152 ( .A(rdata[7]), .B(n104), .C(errorData[15]), .D(n24), .Y(n103)
         );
  NAND2X1 U153 ( .A(n105), .B(n106), .Y(n99) );
  AOI22X1 U154 ( .A(n107), .B(ehtsData[7]), .C(boData[7]), .D(n19), .Y(n106)
         );
  AOI22X1 U155 ( .A(errorData[7]), .B(n23), .C(statusData[7]), .D(n26), .Y(
        n105) );
  OAI21X1 U156 ( .A(n109), .B(n110), .C(n1), .Y(n108) );
  OAI21X1 U157 ( .A(n102), .B(n59), .C(n111), .Y(n110) );
  AOI22X1 U158 ( .A(rdata[6]), .B(n104), .C(errorData[14]), .D(n24), .Y(n111)
         );
  NAND2X1 U159 ( .A(n112), .B(n113), .Y(n109) );
  AOI22X1 U160 ( .A(n107), .B(ehtsData[6]), .C(boData[6]), .D(n19), .Y(n113)
         );
  AOI22X1 U161 ( .A(errorData[6]), .B(n23), .C(statusData[6]), .D(n26), .Y(
        n112) );
  OAI21X1 U162 ( .A(n115), .B(n116), .C(n1), .Y(n114) );
  OAI21X1 U163 ( .A(n102), .B(n58), .C(n117), .Y(n116) );
  AOI22X1 U164 ( .A(rdata[5]), .B(n104), .C(errorData[13]), .D(n24), .Y(n117)
         );
  NAND2X1 U165 ( .A(n118), .B(n119), .Y(n115) );
  AOI22X1 U166 ( .A(n107), .B(ehtsData[5]), .C(boData[5]), .D(n19), .Y(n119)
         );
  AOI22X1 U167 ( .A(errorData[5]), .B(n23), .C(statusData[5]), .D(n26), .Y(
        n118) );
  OAI21X1 U168 ( .A(n121), .B(n122), .C(n1), .Y(n120) );
  OAI21X1 U169 ( .A(n102), .B(n57), .C(n123), .Y(n122) );
  AOI22X1 U170 ( .A(rdata[4]), .B(n104), .C(errorData[12]), .D(n24), .Y(n123)
         );
  NAND2X1 U171 ( .A(n124), .B(n125), .Y(n121) );
  AOI22X1 U172 ( .A(n107), .B(ehtsData[4]), .C(boData[4]), .D(n19), .Y(n125)
         );
  AOI22X1 U173 ( .A(errorData[4]), .B(n23), .C(statusData[4]), .D(n26), .Y(
        n124) );
  OAI21X1 U174 ( .A(n127), .B(n128), .C(n1), .Y(n126) );
  OAI21X1 U175 ( .A(n102), .B(n56), .C(n129), .Y(n128) );
  AOI22X1 U176 ( .A(rdata[3]), .B(n104), .C(errorData[11]), .D(n24), .Y(n129)
         );
  NAND2X1 U177 ( .A(n130), .B(n131), .Y(n127) );
  AOI22X1 U178 ( .A(n107), .B(ehtsData[3]), .C(boData[3]), .D(n19), .Y(n131)
         );
  AOI22X1 U179 ( .A(errorData[3]), .B(n23), .C(statusData[3]), .D(n26), .Y(
        n130) );
  OAI21X1 U180 ( .A(n133), .B(n134), .C(n1), .Y(n132) );
  OAI21X1 U181 ( .A(n102), .B(n55), .C(n135), .Y(n134) );
  AOI22X1 U182 ( .A(rdata[2]), .B(n104), .C(errorData[10]), .D(n24), .Y(n135)
         );
  NAND2X1 U183 ( .A(n136), .B(n137), .Y(n133) );
  AOI22X1 U184 ( .A(n107), .B(ehtsData[2]), .C(boData[2]), .D(n19), .Y(n137)
         );
  AOI22X1 U185 ( .A(errorData[2]), .B(n23), .C(statusData[2]), .D(n26), .Y(
        n136) );
  OAI21X1 U186 ( .A(n139), .B(n140), .C(n1), .Y(n138) );
  OAI21X1 U187 ( .A(n45), .B(n102), .C(n141), .Y(n140) );
  AOI22X1 U188 ( .A(rdata[1]), .B(n104), .C(n24), .D(errorData[9]), .Y(n141)
         );
  NAND2X1 U189 ( .A(n142), .B(n143), .Y(n139) );
  AOI22X1 U190 ( .A(n107), .B(ehtsData[1]), .C(boData[1]), .D(n19), .Y(n143)
         );
  AOI22X1 U191 ( .A(errorData[1]), .B(n23), .C(statusData[1]), .D(n26), .Y(
        n142) );
  NAND3X1 U192 ( .A(n83), .B(n30), .C(n1), .Y(n144) );
  OAI21X1 U193 ( .A(n93), .B(n37), .C(n145), .Y(hrdata[15]) );
  AOI22X1 U194 ( .A(errorData[15]), .B(n95), .C(statusData[15]), .D(n96), .Y(
        n145) );
  OAI21X1 U195 ( .A(n93), .B(n38), .C(n146), .Y(hrdata[14]) );
  AOI22X1 U196 ( .A(errorData[14]), .B(n95), .C(statusData[14]), .D(n96), .Y(
        n146) );
  OAI21X1 U197 ( .A(n93), .B(n39), .C(n147), .Y(hrdata[13]) );
  AOI22X1 U198 ( .A(errorData[13]), .B(n95), .C(statusData[13]), .D(n96), .Y(
        n147) );
  OAI21X1 U199 ( .A(n93), .B(n40), .C(n148), .Y(hrdata[12]) );
  AOI22X1 U200 ( .A(errorData[12]), .B(n95), .C(statusData[12]), .D(n96), .Y(
        n148) );
  OAI21X1 U201 ( .A(n93), .B(n41), .C(n149), .Y(hrdata[11]) );
  AOI22X1 U202 ( .A(errorData[11]), .B(n95), .C(statusData[11]), .D(n96), .Y(
        n149) );
  OAI21X1 U203 ( .A(n93), .B(n42), .C(n150), .Y(hrdata[10]) );
  AOI22X1 U204 ( .A(errorData[10]), .B(n95), .C(statusData[10]), .D(n96), .Y(
        n150) );
  NAND3X1 U205 ( .A(n30), .B(n34), .C(n1), .Y(n93) );
  OAI21X1 U206 ( .A(n154), .B(n155), .C(n1), .Y(n153) );
  NOR2X1 U207 ( .A(n61), .B(state[0]), .Y(n101) );
  OAI21X1 U208 ( .A(n46), .B(n102), .C(n156), .Y(n155) );
  AOI22X1 U209 ( .A(rdata[0]), .B(n104), .C(n24), .D(errorData[8]), .Y(n156)
         );
  NAND3X1 U210 ( .A(n158), .B(n25), .C(prevAddr[0]), .Y(n157) );
  NAND2X1 U211 ( .A(n85), .B(n35), .Y(n86) );
  NOR2X1 U212 ( .A(n83), .B(n152), .Y(n85) );
  NAND3X1 U213 ( .A(n158), .B(n27), .C(prevAddr[0]), .Y(n102) );
  NAND2X1 U214 ( .A(n159), .B(n160), .Y(n154) );
  AOI22X1 U215 ( .A(n107), .B(ehtsData[0]), .C(boData[0]), .D(n19), .Y(n160)
         );
  NAND3X1 U216 ( .A(n162), .B(n29), .C(n163), .Y(n161) );
  NOR2X1 U217 ( .A(n35), .B(n32), .Y(n163) );
  NOR2X1 U218 ( .A(prevAddr[3]), .B(n30), .Y(n162) );
  NOR2X1 U219 ( .A(n92), .B(n30), .Y(n88) );
  NAND3X1 U220 ( .A(n29), .B(n32), .C(prevAddr[3]), .Y(n92) );
  NAND3X1 U221 ( .A(n166), .B(n33), .C(n167), .Y(n165) );
  NOR2X1 U222 ( .A(prevAddr[0]), .B(n30), .Y(n167) );
  AOI22X1 U223 ( .A(errorData[0]), .B(n23), .C(statusData[0]), .D(n26), .Y(
        n159) );
  OAI21X1 U224 ( .A(n169), .B(n152), .C(n27), .Y(n168) );
  NAND3X1 U225 ( .A(prevAddr[6]), .B(n33), .C(n28), .Y(n170) );
  OAI21X1 U226 ( .A(n169), .B(n152), .C(n25), .Y(n171) );
  NAND3X1 U227 ( .A(n28), .B(prevAddr[6]), .C(prevAddr[1]), .Y(n172) );
  NAND3X1 U229 ( .A(n166), .B(n31), .C(n174), .Y(n173) );
  NOR2X1 U230 ( .A(prevAddr[2]), .B(n30), .Y(n174) );
  NOR2X1 U231 ( .A(prevAddr[5]), .B(prevAddr[4]), .Y(n166) );
  NOR2X1 U232 ( .A(n36), .B(prevSize[1]), .Y(n152) );
  NOR2X1 U233 ( .A(prevAddr[0]), .B(n35), .Y(n169) );
  NOR2X1 U234 ( .A(prevSize[1]), .B(prevSize[0]), .Y(n158) );
  INVX2 U4 ( .A(n144), .Y(n20) );
  BUFX2 U5 ( .A(n101), .Y(n1) );
  INVX2 U6 ( .A(n153), .Y(hrdata[0]) );
  INVX2 U62 ( .A(n138), .Y(hrdata[1]) );
  INVX2 U63 ( .A(n132), .Y(hrdata[2]) );
  INVX2 U64 ( .A(n126), .Y(hrdata[3]) );
  INVX2 U65 ( .A(n120), .Y(hrdata[4]) );
  INVX2 U66 ( .A(n114), .Y(hrdata[5]) );
  INVX2 U67 ( .A(n108), .Y(hrdata[6]) );
  INVX2 U68 ( .A(n98), .Y(hrdata[7]) );
  INVX2 U69 ( .A(n161), .Y(n19) );
  INVX2 U70 ( .A(n84), .Y(n21) );
  INVX2 U71 ( .A(n90), .Y(n22) );
  INVX2 U72 ( .A(n171), .Y(n23) );
  INVX2 U73 ( .A(n157), .Y(n24) );
  INVX2 U74 ( .A(n172), .Y(n25) );
  INVX2 U75 ( .A(n168), .Y(n26) );
  INVX2 U76 ( .A(n170), .Y(n27) );
  INVX2 U77 ( .A(n173), .Y(n28) );
  INVX2 U78 ( .A(n165), .Y(n29) );
  INVX2 U79 ( .A(prevAddr[6]), .Y(n30) );
  INVX2 U80 ( .A(prevAddr[3]), .Y(n31) );
  INVX2 U81 ( .A(prevAddr[2]), .Y(n32) );
  INVX2 U82 ( .A(prevAddr[1]), .Y(n33) );
  INVX2 U83 ( .A(n85), .Y(n34) );
  INVX2 U84 ( .A(n158), .Y(n35) );
  INVX2 U85 ( .A(prevSize[0]), .Y(n36) );
  INVX2 U86 ( .A(rdata[15]), .Y(n37) );
  INVX2 U87 ( .A(rdata[14]), .Y(n38) );
  INVX2 U88 ( .A(rdata[13]), .Y(n39) );
  INVX2 U89 ( .A(rdata[12]), .Y(n40) );
  INVX2 U90 ( .A(rdata[11]), .Y(n41) );
  INVX2 U91 ( .A(rdata[10]), .Y(n42) );
  INVX2 U92 ( .A(rdata[9]), .Y(n43) );
  INVX2 U93 ( .A(rdata[8]), .Y(n44) );
  INVX2 U94 ( .A(statusData[9]), .Y(n45) );
  INVX2 U95 ( .A(statusData[8]), .Y(n46) );
  INVX2 U96 ( .A(ehtsData[7]), .Y(n47) );
  INVX2 U97 ( .A(ehtsData[6]), .Y(n48) );
  INVX2 U98 ( .A(ehtsData[5]), .Y(n49) );
  INVX2 U99 ( .A(ehtsData[4]), .Y(n50) );
  INVX2 U100 ( .A(ehtsData[3]), .Y(n51) );
  INVX2 U101 ( .A(ehtsData[2]), .Y(n52) );
  INVX2 U102 ( .A(ehtsData[1]), .Y(n53) );
  INVX2 U103 ( .A(ehtsData[0]), .Y(n54) );
  INVX2 U104 ( .A(statusData[10]), .Y(n55) );
  INVX2 U105 ( .A(statusData[11]), .Y(n56) );
  INVX2 U106 ( .A(statusData[12]), .Y(n57) );
  INVX2 U107 ( .A(statusData[13]), .Y(n58) );
  INVX2 U108 ( .A(statusData[14]), .Y(n59) );
  INVX2 U109 ( .A(statusData[15]), .Y(n60) );
  INVX2 U110 ( .A(state[1]), .Y(n61) );
  INVX2 U111 ( .A(state[0]), .Y(n62) );
  INVX2 U112 ( .A(hwdata[7]), .Y(n63) );
  INVX2 U113 ( .A(hwdata[6]), .Y(n64) );
  INVX2 U114 ( .A(hwdata[5]), .Y(n65) );
  INVX2 U115 ( .A(hwdata[4]), .Y(n66) );
  INVX2 U116 ( .A(hwdata[3]), .Y(n67) );
  INVX2 U117 ( .A(hwdata[2]), .Y(n68) );
  INVX2 U118 ( .A(hwdata[1]), .Y(n69) );
  INVX2 U119 ( .A(hwdata[0]), .Y(n70) );
endmodule


module fixitFSM ( clk, nRst, txPacketSizeChanged, rxDataReady, bufferOccupancy, 
        txPacketDataSize, bufferReserved );
  input [6:0] bufferOccupancy;
  input [6:0] txPacketDataSize;
  input clk, nRst, txPacketSizeChanged, rxDataReady;
  output bufferReserved;
  wire   N9, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25,
         n26, n27, n28, n29, n30, n31, n32, n1, n2, n3, n4, n7, n8;
  wire   [1:0] nextState;
  wire   [1:0] state;
  assign bufferReserved = N9;

  DFFSR \state_reg[0]  ( .D(nextState[0]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        state[0]) );
  DFFSR \state_reg[1]  ( .D(nextState[1]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        state[1]) );
  OAI21X1 U11 ( .A(n13), .B(n14), .C(n15), .Y(nextState[1]) );
  OAI21X1 U12 ( .A(n16), .B(n8), .C(n17), .Y(n15) );
  NOR3X1 U13 ( .A(bufferOccupancy[1]), .B(bufferOccupancy[2]), .C(
        bufferOccupancy[0]), .Y(n18) );
  NAND3X1 U14 ( .A(n7), .B(n4), .C(n19), .Y(n16) );
  NOR2X1 U15 ( .A(bufferOccupancy[6]), .B(bufferOccupancy[5]), .Y(n19) );
  NAND2X1 U16 ( .A(rxDataReady), .B(n1), .Y(n14) );
  NAND2X1 U17 ( .A(n2), .B(n3), .Y(n13) );
  OAI21X1 U18 ( .A(n3), .B(n20), .C(n21), .Y(nextState[0]) );
  OAI21X1 U19 ( .A(n22), .B(n23), .C(n24), .Y(n21) );
  NAND3X1 U20 ( .A(n25), .B(n26), .C(n27), .Y(n23) );
  XNOR2X1 U21 ( .A(bufferOccupancy[6]), .B(txPacketDataSize[6]), .Y(n27) );
  XNOR2X1 U22 ( .A(bufferOccupancy[5]), .B(txPacketDataSize[5]), .Y(n26) );
  XNOR2X1 U23 ( .A(bufferOccupancy[1]), .B(txPacketDataSize[1]), .Y(n25) );
  NAND3X1 U24 ( .A(n28), .B(n29), .C(n30), .Y(n22) );
  NOR2X1 U25 ( .A(n31), .B(n32), .Y(n30) );
  XOR2X1 U26 ( .A(txPacketDataSize[4]), .B(bufferOccupancy[4]), .Y(n32) );
  XOR2X1 U27 ( .A(txPacketDataSize[3]), .B(bufferOccupancy[3]), .Y(n31) );
  XNOR2X1 U28 ( .A(bufferOccupancy[2]), .B(txPacketDataSize[2]), .Y(n29) );
  XNOR2X1 U29 ( .A(bufferOccupancy[0]), .B(txPacketDataSize[0]), .Y(n28) );
  NAND2X1 U30 ( .A(n1), .B(n2), .Y(n20) );
  OR2X1 U31 ( .A(n24), .B(n17), .Y(N9) );
  NOR2X1 U32 ( .A(n2), .B(state[0]), .Y(n17) );
  NOR2X1 U33 ( .A(n1), .B(state[1]), .Y(n24) );
  INVX2 U5 ( .A(state[0]), .Y(n1) );
  INVX2 U6 ( .A(state[1]), .Y(n2) );
  INVX2 U7 ( .A(txPacketSizeChanged), .Y(n3) );
  INVX2 U8 ( .A(bufferOccupancy[4]), .Y(n4) );
  INVX2 U9 ( .A(bufferOccupancy[3]), .Y(n7) );
  INVX2 U10 ( .A(n18), .Y(n8) );
endmodule


module ahb_lite_slave ( clk, nRst, hsel, haddr, htrans, hsize, hwrite, hwdata, 
        hburst, rxDataReady, rxTransferActive, rxError, txTransferActive, 
        txError, bufferOccupancy, rxData, hrdata, hresp, hready, 
        bufferReserved, getRxData, storeTxData, txData, dataSize, 
        txPacketDataSize );
  input [6:0] haddr;
  input [1:0] htrans;
  input [1:0] hsize;
  input [31:0] hwdata;
  input [2:0] hburst;
  input [6:0] bufferOccupancy;
  input [31:0] rxData;
  output [31:0] hrdata;
  output [31:0] txData;
  output [1:0] dataSize;
  output [6:0] txPacketDataSize;
  input clk, nRst, hsel, hwrite, rxDataReady, rxTransferActive, rxError,
         txTransferActive, txError;
  output hresp, hready, bufferReserved, getRxData, storeTxData;
  wire   txPacketSizeChanged, \ehtsData[7] ;
  wire   [1:0] state;
  wire   [7:0] nextEHTSData;
  wire   [15:0] statusData;
  wire   [15:0] errorData;
  wire   [7:0] boData;
  wire   [31:0] rdata;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7, 
        SYNOPSYS_UNCONNECTED__8, SYNOPSYS_UNCONNECTED__9, 
        SYNOPSYS_UNCONNECTED__10, SYNOPSYS_UNCONNECTED__11, 
        SYNOPSYS_UNCONNECTED__12, SYNOPSYS_UNCONNECTED__13, 
        SYNOPSYS_UNCONNECTED__14, SYNOPSYS_UNCONNECTED__15, 
        SYNOPSYS_UNCONNECTED__16, SYNOPSYS_UNCONNECTED__17, 
        SYNOPSYS_UNCONNECTED__18, SYNOPSYS_UNCONNECTED__19, 
        SYNOPSYS_UNCONNECTED__20, SYNOPSYS_UNCONNECTED__21, 
        SYNOPSYS_UNCONNECTED__22, SYNOPSYS_UNCONNECTED__23, 
        SYNOPSYS_UNCONNECTED__24, SYNOPSYS_UNCONNECTED__25, 
        SYNOPSYS_UNCONNECTED__26, SYNOPSYS_UNCONNECTED__27;

  state_controller sc ( .clk(clk), .nRst(nRst), .haddr(haddr), .htrans(htrans), 
        .hsize(hsize), .hwrite(hwrite), .hsel(hsel), .state(state), 
        .storeTxData(storeTxData), .getRxData(getRxData), .hresp(hresp), 
        .hready(hready), .dataSize(dataSize), .txPacketSizeChanged(
        txPacketSizeChanged) );
  value_registers vr ( .clk(clk), .nRst(nRst), .rxDataReady(rxDataReady), 
        .rxTransferActive(rxTransferActive), .txTransferActive(
        txTransferActive), .txError(txError), .rxError(rxError), 
        .bufferOccupancy(bufferOccupancy), .nextEHTSData(nextEHTSData), 
        .statusData({SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, statusData[9:8], 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7, 
        SYNOPSYS_UNCONNECTED__8, SYNOPSYS_UNCONNECTED__9, 
        SYNOPSYS_UNCONNECTED__10, SYNOPSYS_UNCONNECTED__11, 
        SYNOPSYS_UNCONNECTED__12, statusData[0]}), .errorData({
        SYNOPSYS_UNCONNECTED__13, SYNOPSYS_UNCONNECTED__14, 
        SYNOPSYS_UNCONNECTED__15, SYNOPSYS_UNCONNECTED__16, 
        SYNOPSYS_UNCONNECTED__17, SYNOPSYS_UNCONNECTED__18, 
        SYNOPSYS_UNCONNECTED__19, errorData[8], SYNOPSYS_UNCONNECTED__20, 
        SYNOPSYS_UNCONNECTED__21, SYNOPSYS_UNCONNECTED__22, 
        SYNOPSYS_UNCONNECTED__23, SYNOPSYS_UNCONNECTED__24, 
        SYNOPSYS_UNCONNECTED__25, SYNOPSYS_UNCONNECTED__26, errorData[0]}), 
        .boData({SYNOPSYS_UNCONNECTED__27, boData[6:0]}), .ehtsData({
        \ehtsData[7] , txPacketDataSize}) );
  rdata_register rDataReg ( .clk(clk), .nRst(nRst), .rxData(rxData), .rdata(
        rdata) );
  address_decoder decoder ( .clk(clk), .nRst(nRst), .haddr(haddr), .hsize(
        hsize), .hwdata(hwdata), .state(state), .rdata(rdata), .statusData({
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, statusData[9:8], 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, statusData[0]}), .errorData({1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, errorData[8], 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, errorData[0]}), .boData({1'b0, boData[6:0]}), .ehtsData({
        \ehtsData[7] , txPacketDataSize}), .nextEHTSData(nextEHTSData), 
        .hrdata(hrdata), .txData(txData) );
  fixitFSM fsm ( .clk(clk), .nRst(nRst), .txPacketSizeChanged(
        txPacketSizeChanged), .rxDataReady(rxDataReady), .bufferOccupancy(
        bufferOccupancy), .txPacketDataSize(txPacketDataSize), 
        .bufferReserved(bufferReserved) );
endmodule

