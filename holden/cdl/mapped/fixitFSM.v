/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Wed Apr 24 06:04:48 2019
/////////////////////////////////////////////////////////////


module fixitFSM ( clk, nRst, txPacketSizeChanged, rxDataReady, bufferOccupancy, 
        txPacketDataSize, bufferReserved );
  input [6:0] bufferOccupancy;
  input [6:0] txPacketDataSize;
  input clk, nRst, txPacketSizeChanged, rxDataReady;
  output bufferReserved;
  wire   N9, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32;
  wire   [1:0] nextState;
  wire   [1:0] state;
  assign bufferReserved = N9;

  DFFSR \state_reg[0]  ( .D(nextState[0]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        state[0]) );
  DFFSR \state_reg[1]  ( .D(nextState[1]), .CLK(clk), .R(nRst), .S(1'b1), .Q(
        state[1]) );
  INVX2 U5 ( .A(state[1]), .Y(n7) );
  INVX2 U6 ( .A(state[0]), .Y(n8) );
  INVX2 U7 ( .A(txPacketSizeChanged), .Y(n9) );
  INVX2 U8 ( .A(bufferOccupancy[4]), .Y(n10) );
  INVX2 U9 ( .A(bufferOccupancy[3]), .Y(n11) );
  INVX2 U10 ( .A(n18), .Y(n12) );
  OAI21X1 U11 ( .A(n13), .B(n14), .C(n15), .Y(nextState[1]) );
  OAI21X1 U12 ( .A(n16), .B(n12), .C(n17), .Y(n15) );
  NOR3X1 U13 ( .A(bufferOccupancy[1]), .B(bufferOccupancy[2]), .C(
        bufferOccupancy[0]), .Y(n18) );
  NAND3X1 U14 ( .A(n11), .B(n10), .C(n19), .Y(n16) );
  NOR2X1 U15 ( .A(bufferOccupancy[6]), .B(bufferOccupancy[5]), .Y(n19) );
  NAND2X1 U16 ( .A(rxDataReady), .B(n8), .Y(n14) );
  NAND2X1 U17 ( .A(n7), .B(n9), .Y(n13) );
  OAI21X1 U18 ( .A(n9), .B(n20), .C(n21), .Y(nextState[0]) );
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
  NAND2X1 U30 ( .A(n8), .B(n7), .Y(n20) );
  OR2X1 U31 ( .A(n24), .B(n17), .Y(N9) );
  NOR2X1 U32 ( .A(n7), .B(state[0]), .Y(n17) );
  NOR2X1 U33 ( .A(n8), .B(state[1]), .Y(n24) );
endmodule

