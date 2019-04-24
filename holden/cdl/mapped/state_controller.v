/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Wed Apr 24 06:28:40 2019
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
         n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50,
         n51, n52, n53, n54, n55, n56, n57;
  assign dataSize[1] = hsize[1];
  assign dataSize[0] = hsize[0];
  assign hresp = N7;

  DFFSR \state_reg[1]  ( .D(n46), .CLK(clk), .R(nRst), .S(1'b1), .Q(state[1])
         );
  DFFSR \state_reg[0]  ( .D(n45), .CLK(clk), .R(nRst), .S(1'b1), .Q(state[0])
         );
  NOR2X1 U21 ( .A(n23), .B(n24), .Y(txPacketSizeChanged) );
  NOR2X1 U22 ( .A(n24), .B(haddr[6]), .Y(storeTxData) );
  NAND3X1 U23 ( .A(n54), .B(n25), .C(hwrite), .Y(n24) );
  NOR2X1 U24 ( .A(n26), .B(n27), .Y(getRxData) );
  NAND2X1 U25 ( .A(n47), .B(n54), .Y(n27) );
  NAND2X1 U26 ( .A(hready), .B(n29), .Y(N7) );
  NAND2X1 U27 ( .A(state[1]), .B(state[0]), .Y(n29) );
  NAND2X1 U28 ( .A(n46), .B(n45), .Y(hready) );
  OAI21X1 U29 ( .A(n31), .B(n26), .C(n54), .Y(n30) );
  NAND2X1 U30 ( .A(n25), .B(n57), .Y(n26) );
  AOI21X1 U31 ( .A(n32), .B(n48), .C(n33), .Y(n31) );
  OAI21X1 U32 ( .A(n34), .B(n35), .C(haddr[6]), .Y(n33) );
  NAND2X1 U33 ( .A(n56), .B(n55), .Y(n35) );
  AOI21X1 U34 ( .A(n36), .B(n48), .C(n37), .Y(n34) );
  NOR2X1 U35 ( .A(haddr[1]), .B(haddr[0]), .Y(n36) );
  NAND3X1 U36 ( .A(haddr[6]), .B(n50), .C(n39), .Y(n38) );
  NOR2X1 U37 ( .A(haddr[2]), .B(dataSize[1]), .Y(n32) );
  OAI21X1 U38 ( .A(n57), .B(n41), .C(n54), .Y(n40) );
  OAI21X1 U39 ( .A(htrans[0]), .B(htrans[1]), .C(hsel), .Y(n42) );
  OAI21X1 U40 ( .A(n47), .B(n49), .C(n25), .Y(n41) );
  NAND2X1 U41 ( .A(dataSize[1]), .B(dataSize[0]), .Y(n25) );
  NAND3X1 U42 ( .A(n56), .B(n55), .C(n37), .Y(n23) );
  NOR2X1 U43 ( .A(n43), .B(n44), .Y(n37) );
  NAND3X1 U44 ( .A(haddr[3]), .B(n53), .C(haddr[6]), .Y(n44) );
  NAND3X1 U45 ( .A(n52), .B(n51), .C(n39), .Y(n43) );
  NOR2X1 U46 ( .A(haddr[5]), .B(haddr[4]), .Y(n39) );
  INVX2 U48 ( .A(n30), .Y(n45) );
  INVX2 U49 ( .A(n40), .Y(n46) );
  INVX2 U50 ( .A(haddr[6]), .Y(n47) );
  INVX2 U51 ( .A(n38), .Y(n48) );
  INVX2 U52 ( .A(n23), .Y(n49) );
  INVX2 U53 ( .A(haddr[3]), .Y(n50) );
  INVX2 U54 ( .A(haddr[2]), .Y(n51) );
  INVX2 U55 ( .A(haddr[1]), .Y(n52) );
  INVX2 U56 ( .A(haddr[0]), .Y(n53) );
  INVX2 U57 ( .A(n42), .Y(n54) );
  INVX2 U58 ( .A(dataSize[1]), .Y(n55) );
  INVX2 U59 ( .A(dataSize[0]), .Y(n56) );
  INVX2 U60 ( .A(hwrite), .Y(n57) );
endmodule

