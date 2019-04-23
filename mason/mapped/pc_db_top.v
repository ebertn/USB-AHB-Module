/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Thu Apr 18 12:33:58 2019
/////////////////////////////////////////////////////////////


module protocol_controller ( clk, n_rst, rx_packet, buffer_reserved, 
        tx_packet_data_size, buffer_occupancy, tx_status, rx_data_ready, 
        rx_transfer_active, rx_error, tx_transfer_active, tx_error, d_mode, 
        tx_packet, clear );
  input [2:0] rx_packet;
  input [6:0] tx_packet_data_size;
  input [6:0] buffer_occupancy;
  output [1:0] tx_packet;
  input clk, n_rst, buffer_reserved, tx_status;
  output rx_data_ready, rx_transfer_active, rx_error, tx_transfer_active,
         tx_error, d_mode, clear;
  wire   n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19,
         n20, n21, n22, n23, n24, n25, n27, n28, n30, n31, n32, n33, n34, n35,
         n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49,
         n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63,
         n64, n65, n66, n67, n70, n72;
  wire   [3:0] next_state;
  wire   [31:0] state;
  assign tx_transfer_active = 1'b0;

  DFFSR \state_reg[0]  ( .D(n72), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0])
         );
  DFFSR \state_reg[3]  ( .D(next_state[3]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[3]) );
  DFFSR \state_reg[2]  ( .D(next_state[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[2]) );
  DFFSR \state_reg[1]  ( .D(n70), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1])
         );
  OR2X1 U7 ( .A(n5), .B(n6), .Y(next_state[3]) );
  OAI21X1 U8 ( .A(tx_status), .B(n7), .C(n8), .Y(n6) );
  NAND3X1 U9 ( .A(n9), .B(n10), .C(n11), .Y(n5) );
  NAND3X1 U10 ( .A(n12), .B(n10), .C(n13), .Y(next_state[2]) );
  INVX1 U11 ( .A(n14), .Y(n13) );
  OAI21X1 U12 ( .A(n15), .B(tx_status), .C(n16), .Y(n14) );
  NAND2X1 U13 ( .A(n17), .B(n18), .Y(n10) );
  NOR2X1 U14 ( .A(n19), .B(n20), .Y(n18) );
  NAND3X1 U15 ( .A(n21), .B(n9), .C(n8), .Y(n20) );
  NAND3X1 U16 ( .A(n22), .B(n23), .C(n24), .Y(n19) );
  NOR2X1 U17 ( .A(n25), .B(n27), .Y(n17) );
  NAND3X1 U18 ( .A(n7), .B(n15), .C(buffer_occupancy[6]), .Y(n27) );
  AOI21X1 U19 ( .A(n28), .B(n30), .C(n31), .Y(n15) );
  INVX1 U20 ( .A(n32), .Y(n31) );
  NAND3X1 U21 ( .A(n33), .B(n34), .C(n12), .Y(n25) );
  INVX1 U22 ( .A(n23), .Y(tx_error) );
  INVX1 U23 ( .A(n8), .Y(d_mode) );
  OR2X1 U24 ( .A(n35), .B(n36), .Y(n70) );
  OAI21X1 U25 ( .A(tx_status), .B(n37), .C(n16), .Y(n36) );
  AOI21X1 U26 ( .A(n38), .B(buffer_reserved), .C(n39), .Y(n16) );
  INVX1 U27 ( .A(n40), .Y(n39) );
  NAND3X1 U28 ( .A(n41), .B(n42), .C(rx_packet[1]), .Y(n40) );
  OAI21X1 U29 ( .A(n21), .B(n41), .C(n24), .Y(n38) );
  NAND3X1 U30 ( .A(state[1]), .B(n43), .C(n30), .Y(n24) );
  OAI21X1 U31 ( .A(n44), .B(n8), .C(n45), .Y(n35) );
  AND2X1 U32 ( .A(n46), .B(n11), .Y(n45) );
  OAI21X1 U33 ( .A(rx_packet[1]), .B(n47), .C(rx_transfer_active), .Y(n46) );
  NAND3X1 U34 ( .A(state[1]), .B(state[0]), .C(n30), .Y(n8) );
  NAND3X1 U35 ( .A(n48), .B(n49), .C(n50), .Y(n72) );
  AOI21X1 U36 ( .A(rx_transfer_active), .B(n51), .C(n52), .Y(n50) );
  OAI21X1 U37 ( .A(n47), .B(n53), .C(n11), .Y(n52) );
  NAND3X1 U38 ( .A(rx_packet[2]), .B(rx_packet[0]), .C(n54), .Y(n11) );
  NOR2X1 U39 ( .A(n21), .B(n55), .Y(n54) );
  NAND2X1 U40 ( .A(n44), .B(n56), .Y(n55) );
  OAI21X1 U41 ( .A(n56), .B(n44), .C(n42), .Y(n53) );
  INVX1 U42 ( .A(n21), .Y(n42) );
  NAND2X1 U43 ( .A(n57), .B(n28), .Y(n21) );
  INVX1 U44 ( .A(buffer_reserved), .Y(n44) );
  INVX1 U45 ( .A(rx_packet[1]), .Y(n56) );
  INVX1 U46 ( .A(n41), .Y(n47) );
  NOR2X1 U47 ( .A(n58), .B(rx_packet[0]), .Y(n41) );
  NAND3X1 U48 ( .A(rx_packet[0]), .B(n58), .C(rx_packet[1]), .Y(n51) );
  INVX1 U49 ( .A(rx_packet[2]), .Y(n58) );
  NAND2X1 U50 ( .A(rx_data_ready), .B(buffer_reserved), .Y(n49) );
  INVX1 U51 ( .A(n12), .Y(rx_data_ready) );
  NAND3X1 U52 ( .A(state[1]), .B(state[0]), .C(n57), .Y(n12) );
  MUX2X1 U53 ( .B(n59), .A(n60), .S(tx_status), .Y(n48) );
  INVX1 U54 ( .A(n9), .Y(n60) );
  NAND2X1 U55 ( .A(n28), .B(n61), .Y(n9) );
  OAI21X1 U56 ( .A(n62), .B(n63), .C(n32), .Y(n59) );
  INVX1 U57 ( .A(n33), .Y(rx_transfer_active) );
  NAND2X1 U58 ( .A(n57), .B(n64), .Y(n33) );
  INVX1 U59 ( .A(n34), .Y(rx_error) );
  OAI21X1 U60 ( .A(state[0]), .B(n62), .C(n32), .Y(tx_packet[0]) );
  NAND2X1 U61 ( .A(n30), .B(n64), .Y(n32) );
  INVX1 U62 ( .A(n65), .Y(n30) );
  OAI21X1 U63 ( .A(state[1]), .B(n65), .C(n7), .Y(tx_packet[1]) );
  INVX1 U64 ( .A(n66), .Y(n7) );
  OAI21X1 U65 ( .A(n62), .B(n63), .C(n37), .Y(n66) );
  NAND3X1 U66 ( .A(n61), .B(n43), .C(state[1]), .Y(n37) );
  INVX1 U67 ( .A(n64), .Y(n63) );
  NOR2X1 U68 ( .A(n43), .B(state[1]), .Y(n64) );
  INVX1 U69 ( .A(n61), .Y(n62) );
  NAND2X1 U70 ( .A(state[2]), .B(n67), .Y(n65) );
  NAND3X1 U71 ( .A(n22), .B(n23), .C(n34), .Y(clear) );
  NAND3X1 U72 ( .A(state[1]), .B(n43), .C(n57), .Y(n34) );
  NOR2X1 U73 ( .A(state[3]), .B(state[2]), .Y(n57) );
  INVX1 U74 ( .A(state[0]), .Y(n43) );
  NAND3X1 U75 ( .A(state[0]), .B(n61), .C(state[1]), .Y(n23) );
  NOR2X1 U76 ( .A(n67), .B(state[2]), .Y(n61) );
  INVX1 U77 ( .A(state[3]), .Y(n67) );
  NAND3X1 U78 ( .A(n28), .B(state[3]), .C(state[2]), .Y(n22) );
  NOR2X1 U79 ( .A(state[0]), .B(state[1]), .Y(n28) );
endmodule


module data_buffer_DW01_add_0 ( A, B, CI, SUM, CO );
  input [31:0] A;
  input [31:0] B;
  output [31:0] SUM;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28;

  AND2X2 U1 ( .A(n15), .B(A[29]), .Y(n1) );
  AND2X2 U2 ( .A(n16), .B(A[27]), .Y(n2) );
  AND2X2 U3 ( .A(n17), .B(A[25]), .Y(n3) );
  AND2X2 U4 ( .A(n18), .B(A[23]), .Y(n4) );
  AND2X2 U5 ( .A(n19), .B(A[21]), .Y(n5) );
  AND2X2 U6 ( .A(n20), .B(A[19]), .Y(n6) );
  AND2X2 U7 ( .A(n21), .B(A[17]), .Y(n7) );
  AND2X2 U8 ( .A(n22), .B(A[15]), .Y(n8) );
  AND2X2 U9 ( .A(n23), .B(A[13]), .Y(n9) );
  AND2X2 U10 ( .A(n24), .B(A[11]), .Y(n10) );
  AND2X2 U11 ( .A(n25), .B(A[9]), .Y(n11) );
  AND2X2 U12 ( .A(n26), .B(A[7]), .Y(n12) );
  AND2X2 U13 ( .A(n27), .B(A[5]), .Y(n13) );
  AND2X2 U14 ( .A(A[2]), .B(A[3]), .Y(n14) );
  AND2X2 U15 ( .A(n2), .B(A[28]), .Y(n15) );
  AND2X2 U16 ( .A(n3), .B(A[26]), .Y(n16) );
  AND2X2 U17 ( .A(n4), .B(A[24]), .Y(n17) );
  AND2X2 U18 ( .A(n5), .B(A[22]), .Y(n18) );
  AND2X2 U19 ( .A(n6), .B(A[20]), .Y(n19) );
  AND2X2 U20 ( .A(n7), .B(A[18]), .Y(n20) );
  AND2X2 U21 ( .A(n8), .B(A[16]), .Y(n21) );
  AND2X2 U22 ( .A(n9), .B(A[14]), .Y(n22) );
  AND2X2 U23 ( .A(n10), .B(A[12]), .Y(n23) );
  AND2X2 U24 ( .A(n11), .B(A[10]), .Y(n24) );
  AND2X2 U25 ( .A(n12), .B(A[8]), .Y(n25) );
  AND2X2 U26 ( .A(n13), .B(A[6]), .Y(n26) );
  AND2X2 U27 ( .A(n14), .B(A[4]), .Y(n27) );
  AND2X2 U28 ( .A(n1), .B(A[30]), .Y(n28) );
  XOR2X1 U29 ( .A(A[31]), .B(n28), .Y(SUM[31]) );
  XOR2X1 U30 ( .A(n1), .B(A[30]), .Y(SUM[30]) );
  XOR2X1 U31 ( .A(n15), .B(A[29]), .Y(SUM[29]) );
  XOR2X1 U32 ( .A(n2), .B(A[28]), .Y(SUM[28]) );
  XOR2X1 U33 ( .A(n16), .B(A[27]), .Y(SUM[27]) );
  XOR2X1 U34 ( .A(n3), .B(A[26]), .Y(SUM[26]) );
  XOR2X1 U35 ( .A(n17), .B(A[25]), .Y(SUM[25]) );
  XOR2X1 U36 ( .A(n4), .B(A[24]), .Y(SUM[24]) );
  XOR2X1 U37 ( .A(n18), .B(A[23]), .Y(SUM[23]) );
  XOR2X1 U38 ( .A(n5), .B(A[22]), .Y(SUM[22]) );
  XOR2X1 U39 ( .A(n19), .B(A[21]), .Y(SUM[21]) );
  XOR2X1 U40 ( .A(n6), .B(A[20]), .Y(SUM[20]) );
  XOR2X1 U41 ( .A(n20), .B(A[19]), .Y(SUM[19]) );
  XOR2X1 U42 ( .A(n7), .B(A[18]), .Y(SUM[18]) );
  XOR2X1 U43 ( .A(n21), .B(A[17]), .Y(SUM[17]) );
  XOR2X1 U44 ( .A(n8), .B(A[16]), .Y(SUM[16]) );
  XOR2X1 U45 ( .A(n22), .B(A[15]), .Y(SUM[15]) );
  XOR2X1 U46 ( .A(n9), .B(A[14]), .Y(SUM[14]) );
  XOR2X1 U47 ( .A(n23), .B(A[13]), .Y(SUM[13]) );
  XOR2X1 U48 ( .A(n10), .B(A[12]), .Y(SUM[12]) );
  XOR2X1 U49 ( .A(n24), .B(A[11]), .Y(SUM[11]) );
  XOR2X1 U50 ( .A(n11), .B(A[10]), .Y(SUM[10]) );
  XOR2X1 U51 ( .A(n25), .B(A[9]), .Y(SUM[9]) );
  XOR2X1 U52 ( .A(n12), .B(A[8]), .Y(SUM[8]) );
  XOR2X1 U53 ( .A(n26), .B(A[7]), .Y(SUM[7]) );
  XOR2X1 U54 ( .A(n13), .B(A[6]), .Y(SUM[6]) );
  XOR2X1 U55 ( .A(n27), .B(A[5]), .Y(SUM[5]) );
  XOR2X1 U56 ( .A(n14), .B(A[4]), .Y(SUM[4]) );
  XOR2X1 U57 ( .A(A[2]), .B(A[3]), .Y(SUM[3]) );
endmodule


module data_buffer_DW01_add_1 ( A, B, CI, SUM, CO );
  input [31:0] A;
  input [31:0] B;
  output [31:0] SUM;
  input CI;
  output CO;
  wire   \A[0] , n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14,
         n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29;
  assign SUM[0] = \A[0] ;
  assign \A[0]  = A[0];

  AND2X2 U1 ( .A(n13), .B(A[4]), .Y(n1) );
  AND2X2 U2 ( .A(n22), .B(A[29]), .Y(n2) );
  AND2X2 U3 ( .A(n21), .B(A[10]), .Y(n3) );
  AND2X2 U4 ( .A(n28), .B(A[8]), .Y(n4) );
  AND2X2 U5 ( .A(n23), .B(A[27]), .Y(n5) );
  AND2X2 U6 ( .A(n24), .B(A[25]), .Y(n6) );
  AND2X2 U7 ( .A(n25), .B(A[21]), .Y(n7) );
  AND2X2 U8 ( .A(n26), .B(A[17]), .Y(n8) );
  AND2X2 U9 ( .A(n27), .B(A[13]), .Y(n9) );
  AND2X2 U10 ( .A(n1), .B(A[5]), .Y(n10) );
  AND2X2 U11 ( .A(A[1]), .B(A[2]), .Y(n11) );
  AND2X2 U12 ( .A(n10), .B(A[6]), .Y(n12) );
  AND2X2 U13 ( .A(n11), .B(A[3]), .Y(n13) );
  AND2X2 U14 ( .A(n7), .B(A[22]), .Y(n14) );
  AND2X2 U15 ( .A(n8), .B(A[18]), .Y(n15) );
  AND2X2 U16 ( .A(n9), .B(A[14]), .Y(n16) );
  AND2X2 U17 ( .A(n14), .B(A[23]), .Y(n17) );
  AND2X2 U18 ( .A(n15), .B(A[19]), .Y(n18) );
  AND2X2 U19 ( .A(n16), .B(A[15]), .Y(n19) );
  AND2X2 U20 ( .A(n3), .B(A[11]), .Y(n20) );
  AND2X2 U21 ( .A(n4), .B(A[9]), .Y(n21) );
  AND2X2 U22 ( .A(n5), .B(A[28]), .Y(n22) );
  AND2X2 U23 ( .A(n6), .B(A[26]), .Y(n23) );
  AND2X2 U24 ( .A(n17), .B(A[24]), .Y(n24) );
  AND2X2 U25 ( .A(n18), .B(A[20]), .Y(n25) );
  AND2X2 U26 ( .A(n19), .B(A[16]), .Y(n26) );
  AND2X2 U27 ( .A(n20), .B(A[12]), .Y(n27) );
  AND2X2 U28 ( .A(n12), .B(A[7]), .Y(n28) );
  AND2X2 U29 ( .A(n2), .B(A[30]), .Y(n29) );
  XOR2X1 U30 ( .A(A[31]), .B(n29), .Y(SUM[31]) );
  XOR2X1 U31 ( .A(n2), .B(A[30]), .Y(SUM[30]) );
  XOR2X1 U32 ( .A(n22), .B(A[29]), .Y(SUM[29]) );
  XOR2X1 U33 ( .A(n5), .B(A[28]), .Y(SUM[28]) );
  XOR2X1 U34 ( .A(n23), .B(A[27]), .Y(SUM[27]) );
  XOR2X1 U35 ( .A(n6), .B(A[26]), .Y(SUM[26]) );
  XOR2X1 U36 ( .A(n24), .B(A[25]), .Y(SUM[25]) );
  XOR2X1 U37 ( .A(n17), .B(A[24]), .Y(SUM[24]) );
  XOR2X1 U38 ( .A(n14), .B(A[23]), .Y(SUM[23]) );
  XOR2X1 U39 ( .A(n7), .B(A[22]), .Y(SUM[22]) );
  XOR2X1 U40 ( .A(n25), .B(A[21]), .Y(SUM[21]) );
  XOR2X1 U41 ( .A(n18), .B(A[20]), .Y(SUM[20]) );
  XOR2X1 U42 ( .A(n15), .B(A[19]), .Y(SUM[19]) );
  XOR2X1 U43 ( .A(n8), .B(A[18]), .Y(SUM[18]) );
  XOR2X1 U44 ( .A(n26), .B(A[17]), .Y(SUM[17]) );
  XOR2X1 U45 ( .A(n19), .B(A[16]), .Y(SUM[16]) );
  XOR2X1 U46 ( .A(n16), .B(A[15]), .Y(SUM[15]) );
  XOR2X1 U47 ( .A(n9), .B(A[14]), .Y(SUM[14]) );
  XOR2X1 U48 ( .A(n27), .B(A[13]), .Y(SUM[13]) );
  XOR2X1 U49 ( .A(n20), .B(A[12]), .Y(SUM[12]) );
  XOR2X1 U50 ( .A(n3), .B(A[11]), .Y(SUM[11]) );
  XOR2X1 U51 ( .A(n21), .B(A[10]), .Y(SUM[10]) );
  XOR2X1 U52 ( .A(n4), .B(A[9]), .Y(SUM[9]) );
  XOR2X1 U53 ( .A(n28), .B(A[8]), .Y(SUM[8]) );
  XOR2X1 U54 ( .A(n12), .B(A[7]), .Y(SUM[7]) );
  XOR2X1 U55 ( .A(n10), .B(A[6]), .Y(SUM[6]) );
  XOR2X1 U56 ( .A(n1), .B(A[5]), .Y(SUM[5]) );
  XOR2X1 U57 ( .A(n13), .B(A[4]), .Y(SUM[4]) );
  XOR2X1 U58 ( .A(n11), .B(A[3]), .Y(SUM[3]) );
  XOR2X1 U59 ( .A(A[1]), .B(A[2]), .Y(SUM[2]) );
  INVX2 U60 ( .A(A[1]), .Y(SUM[1]) );
endmodule


module data_buffer_DW01_inc_0 ( A, SUM );
  input [31:0] A;
  output [31:0] SUM;

  wire   [31:2] carry;

  HAX1 U1_1_30 ( .A(A[30]), .B(carry[30]), .YC(carry[31]), .YS(SUM[30]) );
  HAX1 U1_1_29 ( .A(A[29]), .B(carry[29]), .YC(carry[30]), .YS(SUM[29]) );
  HAX1 U1_1_28 ( .A(A[28]), .B(carry[28]), .YC(carry[29]), .YS(SUM[28]) );
  HAX1 U1_1_27 ( .A(A[27]), .B(carry[27]), .YC(carry[28]), .YS(SUM[27]) );
  HAX1 U1_1_26 ( .A(A[26]), .B(carry[26]), .YC(carry[27]), .YS(SUM[26]) );
  HAX1 U1_1_25 ( .A(A[25]), .B(carry[25]), .YC(carry[26]), .YS(SUM[25]) );
  HAX1 U1_1_24 ( .A(A[24]), .B(carry[24]), .YC(carry[25]), .YS(SUM[24]) );
  HAX1 U1_1_23 ( .A(A[23]), .B(carry[23]), .YC(carry[24]), .YS(SUM[23]) );
  HAX1 U1_1_22 ( .A(A[22]), .B(carry[22]), .YC(carry[23]), .YS(SUM[22]) );
  HAX1 U1_1_21 ( .A(A[21]), .B(carry[21]), .YC(carry[22]), .YS(SUM[21]) );
  HAX1 U1_1_20 ( .A(A[20]), .B(carry[20]), .YC(carry[21]), .YS(SUM[20]) );
  HAX1 U1_1_19 ( .A(A[19]), .B(carry[19]), .YC(carry[20]), .YS(SUM[19]) );
  HAX1 U1_1_18 ( .A(A[18]), .B(carry[18]), .YC(carry[19]), .YS(SUM[18]) );
  HAX1 U1_1_17 ( .A(A[17]), .B(carry[17]), .YC(carry[18]), .YS(SUM[17]) );
  HAX1 U1_1_16 ( .A(A[16]), .B(carry[16]), .YC(carry[17]), .YS(SUM[16]) );
  HAX1 U1_1_15 ( .A(A[15]), .B(carry[15]), .YC(carry[16]), .YS(SUM[15]) );
  HAX1 U1_1_14 ( .A(A[14]), .B(carry[14]), .YC(carry[15]), .YS(SUM[14]) );
  HAX1 U1_1_13 ( .A(A[13]), .B(carry[13]), .YC(carry[14]), .YS(SUM[13]) );
  HAX1 U1_1_12 ( .A(A[12]), .B(carry[12]), .YC(carry[13]), .YS(SUM[12]) );
  HAX1 U1_1_11 ( .A(A[11]), .B(carry[11]), .YC(carry[12]), .YS(SUM[11]) );
  HAX1 U1_1_10 ( .A(A[10]), .B(carry[10]), .YC(carry[11]), .YS(SUM[10]) );
  HAX1 U1_1_9 ( .A(A[9]), .B(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  HAX1 U1_1_8 ( .A(A[8]), .B(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  HAX1 U1_1_7 ( .A(A[7]), .B(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  HAX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[31]), .B(A[31]), .Y(SUM[31]) );
endmodule


module data_buffer_DW01_inc_1 ( A, SUM );
  input [31:0] A;
  output [31:0] SUM;

  wire   [31:2] carry;

  HAX1 U1_1_30 ( .A(A[30]), .B(carry[30]), .YC(carry[31]), .YS(SUM[30]) );
  HAX1 U1_1_29 ( .A(A[29]), .B(carry[29]), .YC(carry[30]), .YS(SUM[29]) );
  HAX1 U1_1_28 ( .A(A[28]), .B(carry[28]), .YC(carry[29]), .YS(SUM[28]) );
  HAX1 U1_1_27 ( .A(A[27]), .B(carry[27]), .YC(carry[28]), .YS(SUM[27]) );
  HAX1 U1_1_26 ( .A(A[26]), .B(carry[26]), .YC(carry[27]), .YS(SUM[26]) );
  HAX1 U1_1_25 ( .A(A[25]), .B(carry[25]), .YC(carry[26]), .YS(SUM[25]) );
  HAX1 U1_1_24 ( .A(A[24]), .B(carry[24]), .YC(carry[25]), .YS(SUM[24]) );
  HAX1 U1_1_23 ( .A(A[23]), .B(carry[23]), .YC(carry[24]), .YS(SUM[23]) );
  HAX1 U1_1_22 ( .A(A[22]), .B(carry[22]), .YC(carry[23]), .YS(SUM[22]) );
  HAX1 U1_1_21 ( .A(A[21]), .B(carry[21]), .YC(carry[22]), .YS(SUM[21]) );
  HAX1 U1_1_20 ( .A(A[20]), .B(carry[20]), .YC(carry[21]), .YS(SUM[20]) );
  HAX1 U1_1_19 ( .A(A[19]), .B(carry[19]), .YC(carry[20]), .YS(SUM[19]) );
  HAX1 U1_1_18 ( .A(A[18]), .B(carry[18]), .YC(carry[19]), .YS(SUM[18]) );
  HAX1 U1_1_17 ( .A(A[17]), .B(carry[17]), .YC(carry[18]), .YS(SUM[17]) );
  HAX1 U1_1_16 ( .A(A[16]), .B(carry[16]), .YC(carry[17]), .YS(SUM[16]) );
  HAX1 U1_1_15 ( .A(A[15]), .B(carry[15]), .YC(carry[16]), .YS(SUM[15]) );
  HAX1 U1_1_14 ( .A(A[14]), .B(carry[14]), .YC(carry[15]), .YS(SUM[14]) );
  HAX1 U1_1_13 ( .A(A[13]), .B(carry[13]), .YC(carry[14]), .YS(SUM[13]) );
  HAX1 U1_1_12 ( .A(A[12]), .B(carry[12]), .YC(carry[13]), .YS(SUM[12]) );
  HAX1 U1_1_11 ( .A(A[11]), .B(carry[11]), .YC(carry[12]), .YS(SUM[11]) );
  HAX1 U1_1_10 ( .A(A[10]), .B(carry[10]), .YC(carry[11]), .YS(SUM[10]) );
  HAX1 U1_1_9 ( .A(A[9]), .B(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  HAX1 U1_1_8 ( .A(A[8]), .B(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  HAX1 U1_1_7 ( .A(A[7]), .B(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  HAX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  INVX1 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[31]), .B(A[31]), .Y(SUM[31]) );
endmodule


module data_buffer_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [6:0] A;
  input [6:0] B;
  output [6:0] DIFF;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7;
  wire   [7:0] carry;

  FAX1 U2_6 ( .A(A[6]), .B(n7), .C(carry[6]), .YS(DIFF[6]) );
  FAX1 U2_5 ( .A(A[5]), .B(n6), .C(carry[5]), .YC(carry[6]), .YS(DIFF[5]) );
  FAX1 U2_4 ( .A(A[4]), .B(n5), .C(carry[4]), .YC(carry[5]), .YS(DIFF[4]) );
  FAX1 U2_3 ( .A(A[3]), .B(n4), .C(carry[3]), .YC(carry[4]), .YS(DIFF[3]) );
  FAX1 U2_2 ( .A(A[2]), .B(n3), .C(carry[2]), .YC(carry[3]), .YS(DIFF[2]) );
  FAX1 U2_1 ( .A(A[1]), .B(n2), .C(carry[1]), .YC(carry[2]), .YS(DIFF[1]) );
  INVX1 U1 ( .A(B[0]), .Y(n1) );
  OR2X1 U2 ( .A(A[0]), .B(n1), .Y(carry[1]) );
  XNOR2X1 U3 ( .A(n1), .B(A[0]), .Y(DIFF[0]) );
  INVX2 U4 ( .A(B[1]), .Y(n2) );
  INVX2 U5 ( .A(B[2]), .Y(n3) );
  INVX2 U6 ( .A(B[3]), .Y(n4) );
  INVX2 U7 ( .A(B[4]), .Y(n5) );
  INVX2 U8 ( .A(B[5]), .Y(n6) );
  INVX2 U9 ( .A(B[6]), .Y(n7) );
endmodule


module data_buffer_DW01_add_2 ( A, B, CI, SUM, CO );
  input [31:0] A;
  input [31:0] B;
  output [31:0] SUM;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29;
  wire   [31:1] carry;
  assign carry[1] = A[0];

  AND2X2 U1 ( .A(n13), .B(A[4]), .Y(n1) );
  AND2X2 U2 ( .A(n22), .B(A[29]), .Y(n2) );
  AND2X2 U3 ( .A(n21), .B(A[10]), .Y(n3) );
  AND2X2 U4 ( .A(n28), .B(A[8]), .Y(n4) );
  AND2X2 U5 ( .A(n23), .B(A[27]), .Y(n5) );
  AND2X2 U6 ( .A(n24), .B(A[25]), .Y(n6) );
  AND2X2 U7 ( .A(n25), .B(A[21]), .Y(n7) );
  AND2X2 U8 ( .A(n26), .B(A[17]), .Y(n8) );
  AND2X2 U9 ( .A(n27), .B(A[13]), .Y(n9) );
  AND2X2 U10 ( .A(n1), .B(A[5]), .Y(n10) );
  AND2X2 U11 ( .A(carry[2]), .B(A[2]), .Y(n11) );
  AND2X2 U12 ( .A(n10), .B(A[6]), .Y(n12) );
  AND2X2 U13 ( .A(n11), .B(A[3]), .Y(n13) );
  AND2X2 U14 ( .A(n7), .B(A[22]), .Y(n14) );
  AND2X2 U15 ( .A(n8), .B(A[18]), .Y(n15) );
  AND2X2 U16 ( .A(n9), .B(A[14]), .Y(n16) );
  AND2X2 U17 ( .A(n14), .B(A[23]), .Y(n17) );
  AND2X2 U18 ( .A(n15), .B(A[19]), .Y(n18) );
  AND2X2 U19 ( .A(n16), .B(A[15]), .Y(n19) );
  AND2X2 U20 ( .A(n3), .B(A[11]), .Y(n20) );
  AND2X2 U21 ( .A(n4), .B(A[9]), .Y(n21) );
  AND2X2 U22 ( .A(n5), .B(A[28]), .Y(n22) );
  AND2X2 U23 ( .A(n6), .B(A[26]), .Y(n23) );
  AND2X2 U24 ( .A(n17), .B(A[24]), .Y(n24) );
  AND2X2 U25 ( .A(n18), .B(A[20]), .Y(n25) );
  AND2X2 U26 ( .A(n19), .B(A[16]), .Y(n26) );
  AND2X2 U27 ( .A(n20), .B(A[12]), .Y(n27) );
  AND2X2 U28 ( .A(n12), .B(A[7]), .Y(n28) );
  AND2X2 U29 ( .A(n2), .B(A[30]), .Y(n29) );
  OR2X1 U30 ( .A(A[1]), .B(carry[1]), .Y(carry[2]) );
  XNOR2X1 U31 ( .A(carry[1]), .B(A[1]), .Y(SUM[1]) );
  XOR2X1 U32 ( .A(A[31]), .B(n29), .Y(SUM[31]) );
  XOR2X1 U33 ( .A(n2), .B(A[30]), .Y(SUM[30]) );
  XOR2X1 U34 ( .A(n22), .B(A[29]), .Y(SUM[29]) );
  XOR2X1 U35 ( .A(n5), .B(A[28]), .Y(SUM[28]) );
  XOR2X1 U36 ( .A(n23), .B(A[27]), .Y(SUM[27]) );
  XOR2X1 U37 ( .A(n6), .B(A[26]), .Y(SUM[26]) );
  XOR2X1 U38 ( .A(n24), .B(A[25]), .Y(SUM[25]) );
  XOR2X1 U39 ( .A(n17), .B(A[24]), .Y(SUM[24]) );
  XOR2X1 U40 ( .A(n14), .B(A[23]), .Y(SUM[23]) );
  XOR2X1 U41 ( .A(n7), .B(A[22]), .Y(SUM[22]) );
  XOR2X1 U42 ( .A(n25), .B(A[21]), .Y(SUM[21]) );
  XOR2X1 U43 ( .A(n18), .B(A[20]), .Y(SUM[20]) );
  XOR2X1 U44 ( .A(n15), .B(A[19]), .Y(SUM[19]) );
  XOR2X1 U45 ( .A(n8), .B(A[18]), .Y(SUM[18]) );
  XOR2X1 U46 ( .A(n26), .B(A[17]), .Y(SUM[17]) );
  XOR2X1 U47 ( .A(n19), .B(A[16]), .Y(SUM[16]) );
  XOR2X1 U48 ( .A(n16), .B(A[15]), .Y(SUM[15]) );
  XOR2X1 U49 ( .A(n9), .B(A[14]), .Y(SUM[14]) );
  XOR2X1 U50 ( .A(n27), .B(A[13]), .Y(SUM[13]) );
  XOR2X1 U51 ( .A(n20), .B(A[12]), .Y(SUM[12]) );
  XOR2X1 U52 ( .A(n3), .B(A[11]), .Y(SUM[11]) );
  XOR2X1 U53 ( .A(n21), .B(A[10]), .Y(SUM[10]) );
  XOR2X1 U54 ( .A(n4), .B(A[9]), .Y(SUM[9]) );
  XOR2X1 U55 ( .A(n28), .B(A[8]), .Y(SUM[8]) );
  XOR2X1 U56 ( .A(n12), .B(A[7]), .Y(SUM[7]) );
  XOR2X1 U57 ( .A(n10), .B(A[6]), .Y(SUM[6]) );
  XOR2X1 U58 ( .A(n1), .B(A[5]), .Y(SUM[5]) );
  XOR2X1 U59 ( .A(n13), .B(A[4]), .Y(SUM[4]) );
  XOR2X1 U60 ( .A(n11), .B(A[3]), .Y(SUM[3]) );
  XOR2X1 U61 ( .A(carry[2]), .B(A[2]), .Y(SUM[2]) );
  INVX2 U62 ( .A(carry[1]), .Y(SUM[0]) );
endmodule


module data_buffer ( clk, n_rst, clear, get_rx_data, store_tx_data, tx_data, 
        data_size, get_tx_packet_data, rx_packet_data, store_rx_packet_data, 
        buffer_occupancy, rx_data, tx_packet_data );
  input [31:0] tx_data;
  input [1:0] data_size;
  input [7:0] rx_packet_data;
  output [6:0] buffer_occupancy;
  output [31:0] rx_data;
  output [7:0] tx_packet_data;
  input clk, n_rst, clear, get_rx_data, store_tx_data, get_tx_packet_data,
         store_rx_packet_data;
  wire   N243, N244, N255, N256, N257, N259, N262, N356, N357, N358, N359,
         N360, N361, N362, N363, N364, N365, N366, N367, N368, N369, N370,
         N371, N372, N373, N374, N375, N376, N377, N378, N379, N380, N381,
         N382, N383, N384, N385, N386, N387, N388, N389, N390, N391, N392,
         N393, N394, N395, N396, N397, N398, N399, N400, N401, N402, N403,
         N404, N405, N406, N407, N408, N409, N410, N411, N412, N413, N414,
         N415, N416, N484, N485, N486, N487, N488, N489, N490, N491, N492,
         N493, N494, N495, N496, N497, N498, N499, N500, N501, N502, N503,
         N504, N505, N506, N507, N508, N509, N510, N511, N512, N513, N514,
         N515, \data[7][3] , \data[7][2] , \data[7][1] , \data[7][0] ,
         \data[6][3] , \data[6][2] , \data[6][1] , \data[6][0] , \data[5][3] ,
         \data[5][2] , \data[5][1] , \data[5][0] , \data[4][3] , \data[4][2] ,
         \data[4][1] , \data[4][0] , \data[3][3] , \data[3][2] , \data[3][1] ,
         \data[3][0] , \data[2][3] , \data[2][2] , \data[2][1] , \data[2][0] ,
         \data[1][3] , \data[1][2] , \data[1][1] , \data[1][0] , \data[0][3] ,
         \data[0][2] , \data[0][1] , \data[0][0] , N902, N903, N904, N905,
         N929, N930, N931, N932, N940, N941, N942, N943, N995, N996, N997,
         N998, N1006, N1007, N1008, N1009, N1257, N1258, N1259, N1260, N1261,
         N1262, N1263, N1264, N1265, N1266, N1267, N1268, N1269, N1270, N1271,
         N1272, N1273, N1274, N1275, N1276, N1277, N1278, N1279, N1280, N1281,
         N1282, N1283, N1284, N1285, N1286, N1287, N1288, N1353, N1354, N1355,
         N1356, N1357, N1358, N1359, N1360, N1361, N1362, N1363, N1364, N1365,
         N1366, N1367, N1368, N1369, N1370, N1371, N1372, N1373, N1374, N1375,
         N1376, N1377, N1378, N1379, N1380, N1381, N1382, N1383, N1384,
         \U3/U1/Z_0 , \U3/U1/Z_1 , \U3/U1/Z_2 , \U3/U1/Z_3 , \U3/U1/Z_4 ,
         \U3/U1/Z_5 , \U3/U1/Z_6 , \U3/U1/Z_7 , \U3/U1/Z_8 , \U3/U1/Z_9 ,
         \U3/U1/Z_10 , \U3/U1/Z_11 , \U3/U1/Z_12 , \U3/U1/Z_13 , \U3/U1/Z_14 ,
         \U3/U1/Z_15 , \U3/U1/Z_16 , \U3/U1/Z_17 , \U3/U1/Z_18 , \U3/U1/Z_19 ,
         \U3/U1/Z_20 , \U3/U1/Z_21 , \U3/U1/Z_22 , \U3/U1/Z_23 , \U3/U1/Z_24 ,
         \U3/U1/Z_25 , \U3/U1/Z_26 , \U3/U1/Z_27 , \U3/U1/Z_28 , \U3/U1/Z_29 ,
         \U3/U1/Z_30 , \U3/U1/Z_31 , n730, n731, n732, n733, n734, n735, n736,
         n737, n738, n739, n740, n741, n742, n743, n744, n745, n746, n747,
         n748, n749, n750, n751, n752, n753, n754, n755, n756, n757, n758,
         n759, n760, n761, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26,
         n27, n28, n29, n30, n31, n32, n33, n34, n36, n38, n39, n40, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n154, n155, n156,
         n157, n158, n159, n160, n161, n162, n163, n164, n165, n166, n167,
         n168, n169, n170, n171, n172, n173, n174, n175, n176, n177, n178,
         n179, n180, n181, n182, n183, n184, n185, n186, n187, n188, n189,
         n190, n191, n192, n193, n194, n195, n196, n197, n198, n199, n200,
         n201, n202, n203, n204, n205, n206, n207, n208, n209, n210, n211,
         n212, n213, n214, n215, n216, n217, n218, n219, n220, n221, n222,
         n223, n224, n225, n226, n227, n228, n229, n230, n231, n232, n233,
         n234, n235, n236, n237, n238, n239, n240, n241, n242, n243, n244,
         n245, n246, n247, n248, n249, n250, n251, n252, n253, n254, n255,
         n256, n257, n258, n259, n260, n261, n262, n263, n264, n265, n266,
         n267, n268, n269, n270, n271, n272, n273, n274, n275, n276, n277,
         n278, n279, n280, n281, n282, n283, n284, n285, n286, n287, n288,
         n289, n290, n291, n292, n293, n294, n295, n296, n297, n298, n299,
         n300, n301, n302, n303, n304, n305, n306, n307, n308, n309, n310,
         n311, n312, n313, n314, n315, n316, n317, n318, n319, n320, n321,
         n322, n323, n324, n325, n326, n327, n328, n329, n330, n331, n332,
         n333, n334, n335, n336, n337, n338, n339, n340, n341, n342, n343,
         n344, n345, n346, n347, n348, n349, n350, n351, n352, n353, n354,
         n355, n356, n357, n358, n359, n360, n361, n362, n363, n364, n365,
         n366, n367, n368, n369, n370, n371, n372, n373, n374, n375, n376,
         n377, n378, n379, n380, n381, n382, n383, n384, n385, n386, n387,
         n388, n389, n390, n391, n392, n393, n394, n395, n396, n397, n398,
         n399, n400, n401, n402, n403, n404, n405, n406, n407, n408, n409,
         n410, n411, n412, n413, n414, n415, n416, n417, n418, n419, n420,
         n421, n422, n423, n424, n425, n426, n427, n428, n429, n430, n431,
         n432, n433, n434, n435, n436, n437, n438, n439, n440, n441, n442,
         n443, n444, n445, n446, n447, n448, n449, n450, n451, n452, n453,
         n454, n455, n456, n457, n458, n459, n460, n461, n462, n463, n464,
         n465, n466, n467, n468, n469, n470, n471, n472, n473, n474, n475,
         n476, n477, n478, n479, n480, n481, n482, n483, n484, n485, n486,
         n487, n488, n489, n490, n491, n492, n493, n494, n495, n496, n497,
         n498, n499, n500, n501, n502, n503, n504, n505, n506, n507, n508,
         n509, n510, n511, n512, n513, n514, n515, n516, n517, n518, n519,
         n520, n521, n522, n523, n524, n525, n526, n527, n528, n529, n530,
         n531, n532, n533, n534, n535, n536, n537, n538, n539, n540, n541,
         n542, n543, n544, n545, n546, n547, n548, n549, n550, n551, n552,
         n553, n554, n555, n556, n557, n558, n559, n560, n561, n562, n563,
         n564, n565, n566, n567, n568, n569, n570, n571, n572, n573, n574,
         n575, n576, n577, n578, n579, n580, n581, n582, n583, n584, n585,
         n586, n587, n588, n589, n590, n591, n592, n593, n594, n595, n596,
         n597, n598, n599, n600, n601, n602, n603, n604, n605, n606, n607,
         n608, n609, n610, n611, n612, n613, n614, n615, n616, n617, n618,
         n619, n620, n621, n622, n623, n624, n625, n626, n627, n628, n629,
         n630, n631, n632, n633, n634, n635, n636, n637, n638, n639, n640,
         n641, n642, n643, n644, n645, n646, n647, n648, n649, n650, n651,
         n652, n653, n654, n655, n656, n657, n658, n659, n660, n661, n662,
         n663, n664, n665, n666, n667, n668, n669, n670, n671, n672, n673,
         n674, n675, n676, n677, n678, n679, n680, n681, n682, n683, n684,
         n685, n686, n687, n688, n689, n690, n691, n692, n693, n694, n695,
         n696, n697, n698, n699, n700, n701, n702, n703, n704, n705, n706,
         n707, n708, n709, n710, n711, n712, n713, n714, n715, n716, n717,
         n718, n719, n720, n721, n722, n723, n724, n725, n726, n727, n728,
         n729, n762, n763, n764, n765, n766, n767, n768, n769, n770, n771,
         n772, n773, n774, n775, n776, n777, n778, n779, n780, n781, n782,
         n783, n784, n785, n786, n787, n788, n789, n790, n791, n792, n793,
         n794, n795, n796, n797, n798, n799, n800, n801, n802, n803, n804,
         n805, n806, n807, n808, n809, n810, n811, n812, n813, n814, n815,
         n816, n817, n818, n819, n820, n821, n822, n823, n824, n825, n826,
         n827, n828, n829, n830, n831, n832, n833, n834, n835, n836, n837,
         n838, n839, n840, n841, n842, n843, n844, n845, n846, n847, n848,
         n849, n850, n851, n852, n853, n858, n859, n860;
  wire   [2:0] next_state;
  wire   [31:0] state;
  wire   [31:0] next_count1;
  wire   [31:0] next_count2;
  wire   [31:0] count1;
  wire   [31:0] count2;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2;
  assign tx_packet_data[4] = 1'b0;
  assign rx_data[4] = 1'b0;
  assign tx_packet_data[5] = 1'b0;
  assign rx_data[5] = 1'b0;
  assign tx_packet_data[6] = 1'b0;
  assign rx_data[6] = 1'b0;
  assign tx_packet_data[7] = 1'b0;
  assign rx_data[7] = 1'b0;
  assign rx_data[12] = 1'b0;
  assign rx_data[13] = 1'b0;
  assign rx_data[14] = 1'b0;
  assign rx_data[15] = 1'b0;
  assign rx_data[20] = 1'b0;
  assign rx_data[21] = 1'b0;
  assign rx_data[22] = 1'b0;
  assign rx_data[23] = 1'b0;
  assign rx_data[28] = 1'b0;
  assign rx_data[29] = 1'b0;
  assign rx_data[30] = 1'b0;
  assign rx_data[31] = 1'b0;

  DFFSR \state_reg[2]  ( .D(next_state[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[2]) );
  DFFSR \state_reg[1]  ( .D(next_state[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[1]) );
  DFFSR \state_reg[0]  ( .D(next_state[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[0]) );
  DFFSR \count1_reg[0]  ( .D(next_count1[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[0]) );
  DFFSR \count1_reg[31]  ( .D(next_count1[31]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[31]) );
  DFFSR \count1_reg[1]  ( .D(next_count1[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[1]) );
  DFFSR \count1_reg[2]  ( .D(next_count1[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[2]) );
  DFFSR \count1_reg[3]  ( .D(next_count1[3]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[3]) );
  DFFSR \count1_reg[4]  ( .D(next_count1[4]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[4]) );
  DFFSR \count1_reg[5]  ( .D(next_count1[5]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[5]) );
  DFFSR \count1_reg[6]  ( .D(next_count1[6]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[6]) );
  DFFSR \count1_reg[7]  ( .D(next_count1[7]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[7]) );
  DFFSR \count1_reg[8]  ( .D(next_count1[8]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[8]) );
  DFFSR \count1_reg[9]  ( .D(next_count1[9]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[9]) );
  DFFSR \count1_reg[10]  ( .D(next_count1[10]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[10]) );
  DFFSR \count1_reg[11]  ( .D(next_count1[11]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[11]) );
  DFFSR \count1_reg[12]  ( .D(next_count1[12]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[12]) );
  DFFSR \count1_reg[13]  ( .D(next_count1[13]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[13]) );
  DFFSR \count1_reg[14]  ( .D(next_count1[14]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[14]) );
  DFFSR \count1_reg[15]  ( .D(next_count1[15]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[15]) );
  DFFSR \count1_reg[16]  ( .D(next_count1[16]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[16]) );
  DFFSR \count1_reg[17]  ( .D(next_count1[17]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[17]) );
  DFFSR \count1_reg[18]  ( .D(next_count1[18]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[18]) );
  DFFSR \count1_reg[19]  ( .D(next_count1[19]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[19]) );
  DFFSR \count1_reg[20]  ( .D(next_count1[20]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[20]) );
  DFFSR \count1_reg[21]  ( .D(next_count1[21]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[21]) );
  DFFSR \count1_reg[22]  ( .D(next_count1[22]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[22]) );
  DFFSR \count1_reg[23]  ( .D(next_count1[23]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[23]) );
  DFFSR \count1_reg[24]  ( .D(next_count1[24]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[24]) );
  DFFSR \count1_reg[25]  ( .D(next_count1[25]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[25]) );
  DFFSR \count1_reg[26]  ( .D(next_count1[26]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[26]) );
  DFFSR \count1_reg[27]  ( .D(next_count1[27]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[27]) );
  DFFSR \count1_reg[28]  ( .D(next_count1[28]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[28]) );
  DFFSR \count1_reg[29]  ( .D(next_count1[29]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[29]) );
  DFFSR \count1_reg[30]  ( .D(next_count1[30]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count1[30]) );
  DFFSR \count2_reg[31]  ( .D(next_count2[31]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[31]) );
  DFFSR \count2_reg[0]  ( .D(next_count2[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(N257) );
  DFFSR \count2_reg[1]  ( .D(next_count2[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(N243) );
  DFFSR \count2_reg[2]  ( .D(next_count2[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(N244) );
  DFFSR \count2_reg[3]  ( .D(next_count2[3]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[3]) );
  DFFSR \count2_reg[4]  ( .D(next_count2[4]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[4]) );
  DFFSR \count2_reg[5]  ( .D(next_count2[5]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[5]) );
  DFFSR \count2_reg[6]  ( .D(next_count2[6]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[6]) );
  DFFSR \count2_reg[7]  ( .D(next_count2[7]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[7]) );
  DFFSR \count2_reg[8]  ( .D(next_count2[8]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[8]) );
  DFFSR \count2_reg[9]  ( .D(next_count2[9]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[9]) );
  DFFSR \count2_reg[10]  ( .D(next_count2[10]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[10]) );
  DFFSR \count2_reg[11]  ( .D(next_count2[11]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[11]) );
  DFFSR \count2_reg[12]  ( .D(next_count2[12]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[12]) );
  DFFSR \count2_reg[13]  ( .D(next_count2[13]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[13]) );
  DFFSR \count2_reg[14]  ( .D(next_count2[14]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[14]) );
  DFFSR \count2_reg[15]  ( .D(next_count2[15]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[15]) );
  DFFSR \count2_reg[16]  ( .D(next_count2[16]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[16]) );
  DFFSR \count2_reg[17]  ( .D(next_count2[17]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[17]) );
  DFFSR \count2_reg[18]  ( .D(next_count2[18]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[18]) );
  DFFSR \count2_reg[19]  ( .D(next_count2[19]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[19]) );
  DFFSR \count2_reg[20]  ( .D(next_count2[20]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[20]) );
  DFFSR \count2_reg[21]  ( .D(next_count2[21]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[21]) );
  DFFSR \count2_reg[22]  ( .D(next_count2[22]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[22]) );
  DFFSR \count2_reg[23]  ( .D(next_count2[23]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[23]) );
  DFFSR \count2_reg[24]  ( .D(next_count2[24]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[24]) );
  DFFSR \count2_reg[25]  ( .D(next_count2[25]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[25]) );
  DFFSR \count2_reg[26]  ( .D(next_count2[26]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[26]) );
  DFFSR \count2_reg[27]  ( .D(next_count2[27]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[27]) );
  DFFSR \count2_reg[28]  ( .D(next_count2[28]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[28]) );
  DFFSR \count2_reg[29]  ( .D(next_count2[29]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[29]) );
  DFFSR \count2_reg[30]  ( .D(next_count2[30]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count2[30]) );
  DFFSR \data_reg[7][3]  ( .D(n761), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[7][3] ) );
  DFFSR \data_reg[7][2]  ( .D(n760), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[7][2] ) );
  DFFSR \data_reg[7][1]  ( .D(n759), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[7][1] ) );
  DFFSR \data_reg[7][0]  ( .D(n758), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[7][0] ) );
  DFFSR \data_reg[6][3]  ( .D(n757), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[6][3] ) );
  DFFSR \data_reg[6][2]  ( .D(n756), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[6][2] ) );
  DFFSR \data_reg[6][1]  ( .D(n755), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[6][1] ) );
  DFFSR \data_reg[6][0]  ( .D(n754), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[6][0] ) );
  DFFSR \data_reg[5][3]  ( .D(n753), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[5][3] ) );
  DFFSR \data_reg[5][2]  ( .D(n752), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[5][2] ) );
  DFFSR \data_reg[5][1]  ( .D(n751), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[5][1] ) );
  DFFSR \data_reg[5][0]  ( .D(n750), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[5][0] ) );
  DFFSR \data_reg[4][3]  ( .D(n749), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[4][3] ) );
  DFFSR \data_reg[4][2]  ( .D(n748), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[4][2] ) );
  DFFSR \data_reg[4][1]  ( .D(n747), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[4][1] ) );
  DFFSR \data_reg[4][0]  ( .D(n746), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[4][0] ) );
  DFFSR \data_reg[3][3]  ( .D(n745), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[3][3] ) );
  DFFSR \data_reg[3][2]  ( .D(n744), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[3][2] ) );
  DFFSR \data_reg[3][1]  ( .D(n743), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[3][1] ) );
  DFFSR \data_reg[3][0]  ( .D(n742), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[3][0] ) );
  DFFSR \data_reg[2][3]  ( .D(n741), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[2][3] ) );
  DFFSR \data_reg[2][2]  ( .D(n740), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[2][2] ) );
  DFFSR \data_reg[2][1]  ( .D(n739), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[2][1] ) );
  DFFSR \data_reg[2][0]  ( .D(n738), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[2][0] ) );
  DFFSR \data_reg[1][3]  ( .D(n737), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[1][3] ) );
  DFFSR \data_reg[1][2]  ( .D(n736), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[1][2] ) );
  DFFSR \data_reg[1][1]  ( .D(n735), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[1][1] ) );
  DFFSR \data_reg[1][0]  ( .D(n734), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[1][0] ) );
  DFFSR \data_reg[0][3]  ( .D(n733), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[0][3] ) );
  DFFSR \data_reg[0][2]  ( .D(n732), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[0][2] ) );
  DFFSR \data_reg[0][1]  ( .D(n731), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[0][1] ) );
  DFFSR \data_reg[0][0]  ( .D(n730), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \data[0][0] ) );
  data_buffer_DW01_add_0 r478 ( .A({\U3/U1/Z_31 , \U3/U1/Z_30 , \U3/U1/Z_29 , 
        \U3/U1/Z_28 , \U3/U1/Z_27 , \U3/U1/Z_26 , \U3/U1/Z_25 , \U3/U1/Z_24 , 
        \U3/U1/Z_23 , \U3/U1/Z_22 , \U3/U1/Z_21 , \U3/U1/Z_20 , \U3/U1/Z_19 , 
        \U3/U1/Z_18 , \U3/U1/Z_17 , \U3/U1/Z_16 , \U3/U1/Z_15 , \U3/U1/Z_14 , 
        \U3/U1/Z_13 , \U3/U1/Z_12 , \U3/U1/Z_11 , \U3/U1/Z_10 , \U3/U1/Z_9 , 
        \U3/U1/Z_8 , \U3/U1/Z_7 , \U3/U1/Z_6 , \U3/U1/Z_5 , \U3/U1/Z_4 , 
        \U3/U1/Z_3 , \U3/U1/Z_2 , \U3/U1/Z_1 , \U3/U1/Z_0 }), .B({1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0}), .CI(1'b0), .SUM({N384, N383, 
        N382, N381, N380, N379, N378, N377, N376, N375, N374, N373, N372, N371, 
        N370, N369, N368, N367, N366, N365, N364, N363, N362, N361, N360, N359, 
        N358, N357, N356, SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2}) );
  data_buffer_DW01_add_1 add_211 ( .A({count1[31:2], n10, n12}), .B({1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0}), .CI(1'b0), .SUM({N1288, 
        N1287, N1286, N1285, N1284, N1283, N1282, N1281, N1280, N1279, N1278, 
        N1277, N1276, N1275, N1274, N1273, N1272, N1271, N1270, N1269, N1268, 
        N1267, N1266, N1265, N1264, N1263, N1262, N1261, N1260, N1259, N1258, 
        N1257}) );
  data_buffer_DW01_inc_0 r441 ( .A({count1[31:2], n10, n12}), .SUM({N416, N415, 
        N414, N413, N412, N411, N410, N409, N408, N407, N406, N405, N404, N403, 
        N402, N401, N400, N399, N398, N397, N396, N395, N394, N393, N392, N391, 
        N390, N389, N388, N387, N386, N385}) );
  data_buffer_DW01_inc_1 r107 ( .A({count2[31:3], N244, N243, n206}), .SUM({
        N515, N514, N513, N512, N511, N510, N509, N508, N507, N506, N505, N504, 
        N503, N502, N501, N500, N499, N498, N497, N496, N495, N494, N493, N492, 
        N491, N490, N489, N488, N487, N486, N485, N484}) );
  data_buffer_DW01_sub_0 sub_131 ( .A({count1[6:2], n10, n12}), .B({
        count2[6:3], N244, N243, N257}), .CI(1'b0), .DIFF(buffer_occupancy) );
  data_buffer_DW01_add_2 add_212 ( .A({count1[31:2], n10, n12}), .B({1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1}), .CI(1'b0), .SUM({N1384, 
        N1383, N1382, N1381, N1380, N1379, N1378, N1377, N1376, N1375, N1374, 
        N1373, N1372, N1371, N1370, N1369, N1368, N1367, N1366, N1365, N1364, 
        N1363, N1362, N1361, N1360, N1359, N1358, N1357, N1356, N1355, N1354, 
        N1353}) );
  INVX2 U7 ( .A(n408), .Y(n13) );
  NOR2X1 U8 ( .A(n44), .B(n43), .Y(n1) );
  NOR2X1 U9 ( .A(n34), .B(n33), .Y(n2) );
  NOR2X1 U10 ( .A(n28), .B(n27), .Y(n3) );
  NOR2X1 U17 ( .A(n22), .B(n21), .Y(n4) );
  NOR2X1 U20 ( .A(n248), .B(n247), .Y(n5) );
  NOR2X1 U21 ( .A(n242), .B(n241), .Y(n6) );
  NOR2X1 U22 ( .A(n260), .B(n259), .Y(n7) );
  NOR2X1 U27 ( .A(n254), .B(n253), .Y(n8) );
  INVX1 U28 ( .A(count1[1]), .Y(n9) );
  INVX2 U29 ( .A(n9), .Y(n10) );
  INVX1 U30 ( .A(count1[0]), .Y(n11) );
  INVX2 U35 ( .A(n11), .Y(n12) );
  INVX8 U36 ( .A(n13), .Y(n14) );
  INVX2 U37 ( .A(N257), .Y(n858) );
  INVX1 U38 ( .A(n206), .Y(n236) );
  INVX1 U43 ( .A(N257), .Y(n49) );
  INVX2 U44 ( .A(n322), .Y(n345) );
  INVX2 U45 ( .A(n655), .Y(n15) );
  INVX2 U46 ( .A(n808), .Y(n16) );
  INVX2 U51 ( .A(n342), .Y(n808) );
  NOR2X1 U52 ( .A(n834), .B(N243), .Y(n46) );
  NOR2X1 U53 ( .A(n834), .B(n860), .Y(n45) );
  AOI22X1 U54 ( .A(\data[4][0] ), .B(n46), .C(\data[6][0] ), .D(n45), .Y(n18)
         );
  NOR2X1 U59 ( .A(N243), .B(N244), .Y(n48) );
  NOR2X1 U60 ( .A(n860), .B(N244), .Y(n47) );
  AOI22X1 U61 ( .A(\data[0][0] ), .B(n48), .C(\data[2][0] ), .D(n47), .Y(n17)
         );
  AOI21X1 U62 ( .A(n18), .B(n17), .C(N257), .Y(n22) );
  AOI22X1 U67 ( .A(\data[5][0] ), .B(n46), .C(\data[7][0] ), .D(n45), .Y(n20)
         );
  AOI22X1 U68 ( .A(\data[1][0] ), .B(n48), .C(\data[3][0] ), .D(n47), .Y(n19)
         );
  AOI21X1 U69 ( .A(n20), .B(n19), .C(n49), .Y(n21) );
  AOI22X1 U70 ( .A(\data[4][1] ), .B(n46), .C(\data[6][1] ), .D(n45), .Y(n24)
         );
  AOI22X1 U138 ( .A(\data[0][1] ), .B(n48), .C(\data[2][1] ), .D(n47), .Y(n23)
         );
  AOI21X1 U139 ( .A(n24), .B(n23), .C(N257), .Y(n28) );
  AOI22X1 U140 ( .A(\data[5][1] ), .B(n46), .C(\data[7][1] ), .D(n45), .Y(n26)
         );
  AOI22X1 U141 ( .A(\data[1][1] ), .B(n48), .C(\data[3][1] ), .D(n47), .Y(n25)
         );
  AOI21X1 U142 ( .A(n26), .B(n25), .C(n49), .Y(n27) );
  AOI22X1 U143 ( .A(\data[4][2] ), .B(n46), .C(\data[6][2] ), .D(n45), .Y(n30)
         );
  AOI22X1 U144 ( .A(\data[0][2] ), .B(n48), .C(\data[2][2] ), .D(n47), .Y(n29)
         );
  AOI21X1 U145 ( .A(n30), .B(n29), .C(N257), .Y(n34) );
  AOI22X1 U146 ( .A(\data[5][2] ), .B(n46), .C(\data[7][2] ), .D(n45), .Y(n32)
         );
  AOI22X1 U147 ( .A(\data[1][2] ), .B(n48), .C(\data[3][2] ), .D(n47), .Y(n31)
         );
  AOI21X1 U148 ( .A(n32), .B(n31), .C(n49), .Y(n33) );
  AOI22X1 U149 ( .A(\data[4][3] ), .B(n46), .C(\data[6][3] ), .D(n45), .Y(n38)
         );
  AOI22X1 U150 ( .A(\data[0][3] ), .B(n48), .C(\data[2][3] ), .D(n47), .Y(n36)
         );
  AOI21X1 U151 ( .A(n38), .B(n36), .C(N257), .Y(n44) );
  AOI22X1 U152 ( .A(\data[5][3] ), .B(n46), .C(\data[7][3] ), .D(n45), .Y(n40)
         );
  AOI22X1 U153 ( .A(\data[1][3] ), .B(n48), .C(\data[3][3] ), .D(n47), .Y(n39)
         );
  AOI21X1 U154 ( .A(n40), .B(n39), .C(n49), .Y(n43) );
  NOR2X1 U155 ( .A(n177), .B(N255), .Y(n174) );
  NOR2X1 U156 ( .A(n177), .B(n859), .Y(n173) );
  AOI22X1 U157 ( .A(\data[4][0] ), .B(n174), .C(\data[6][0] ), .D(n173), .Y(
        n51) );
  NOR2X1 U158 ( .A(N255), .B(N256), .Y(n176) );
  NOR2X1 U159 ( .A(n859), .B(N256), .Y(n175) );
  AOI22X1 U160 ( .A(\data[0][0] ), .B(n176), .C(\data[2][0] ), .D(n175), .Y(
        n50) );
  AOI21X1 U161 ( .A(n51), .B(n50), .C(n858), .Y(n154) );
  AOI22X1 U162 ( .A(\data[5][0] ), .B(n174), .C(\data[7][0] ), .D(n173), .Y(
        n53) );
  AOI22X1 U163 ( .A(\data[1][0] ), .B(n176), .C(\data[3][0] ), .D(n175), .Y(
        n52) );
  AOI21X1 U164 ( .A(n53), .B(n52), .C(n206), .Y(n54) );
  OR2X1 U165 ( .A(n154), .B(n54), .Y(N905) );
  AOI22X1 U166 ( .A(\data[4][1] ), .B(n174), .C(\data[6][1] ), .D(n173), .Y(
        n156) );
  AOI22X1 U167 ( .A(\data[0][1] ), .B(n176), .C(\data[2][1] ), .D(n175), .Y(
        n155) );
  AOI21X1 U168 ( .A(n156), .B(n155), .C(n858), .Y(n160) );
  AOI22X1 U169 ( .A(\data[5][1] ), .B(n174), .C(\data[7][1] ), .D(n173), .Y(
        n158) );
  AOI22X1 U170 ( .A(\data[1][1] ), .B(n176), .C(\data[3][1] ), .D(n175), .Y(
        n157) );
  AOI21X1 U171 ( .A(n158), .B(n157), .C(n206), .Y(n159) );
  OR2X1 U172 ( .A(n160), .B(n159), .Y(N904) );
  AOI22X1 U173 ( .A(\data[4][2] ), .B(n174), .C(\data[6][2] ), .D(n173), .Y(
        n162) );
  AOI22X1 U174 ( .A(\data[0][2] ), .B(n176), .C(\data[2][2] ), .D(n175), .Y(
        n161) );
  AOI21X1 U175 ( .A(n162), .B(n161), .C(n858), .Y(n166) );
  AOI22X1 U176 ( .A(\data[5][2] ), .B(n174), .C(\data[7][2] ), .D(n173), .Y(
        n164) );
  AOI22X1 U177 ( .A(\data[1][2] ), .B(n176), .C(\data[3][2] ), .D(n175), .Y(
        n163) );
  AOI21X1 U178 ( .A(n164), .B(n163), .C(n206), .Y(n165) );
  OR2X1 U179 ( .A(n166), .B(n165), .Y(N903) );
  AOI22X1 U180 ( .A(\data[4][3] ), .B(n174), .C(\data[6][3] ), .D(n173), .Y(
        n168) );
  AOI22X1 U181 ( .A(\data[0][3] ), .B(n176), .C(\data[2][3] ), .D(n175), .Y(
        n167) );
  AOI21X1 U182 ( .A(n168), .B(n167), .C(n858), .Y(n172) );
  AOI22X1 U183 ( .A(\data[5][3] ), .B(n174), .C(\data[7][3] ), .D(n173), .Y(
        n170) );
  AOI22X1 U184 ( .A(\data[1][3] ), .B(n176), .C(\data[3][3] ), .D(n175), .Y(
        n169) );
  AOI21X1 U185 ( .A(n170), .B(n169), .C(n206), .Y(n171) );
  OR2X1 U186 ( .A(n172), .B(n171), .Y(N902) );
  INVX2 U187 ( .A(N256), .Y(n177) );
  NOR2X1 U188 ( .A(n177), .B(N255), .Y(n203) );
  NOR2X1 U189 ( .A(n177), .B(n859), .Y(n202) );
  AOI22X1 U190 ( .A(\data[4][0] ), .B(n203), .C(\data[6][0] ), .D(n202), .Y(
        n179) );
  NOR2X1 U191 ( .A(N255), .B(N256), .Y(n205) );
  NOR2X1 U192 ( .A(n859), .B(N256), .Y(n204) );
  AOI22X1 U193 ( .A(\data[0][0] ), .B(n205), .C(\data[2][0] ), .D(n204), .Y(
        n178) );
  AOI21X1 U194 ( .A(n179), .B(n178), .C(n858), .Y(n183) );
  AOI22X1 U195 ( .A(\data[5][0] ), .B(n203), .C(\data[7][0] ), .D(n202), .Y(
        n181) );
  AOI22X1 U196 ( .A(\data[1][0] ), .B(n205), .C(\data[3][0] ), .D(n204), .Y(
        n180) );
  AOI21X1 U197 ( .A(n181), .B(n180), .C(n206), .Y(n182) );
  OR2X1 U198 ( .A(n183), .B(n182), .Y(N932) );
  AOI22X1 U199 ( .A(\data[4][1] ), .B(n203), .C(\data[6][1] ), .D(n202), .Y(
        n185) );
  AOI22X1 U200 ( .A(\data[0][1] ), .B(n205), .C(\data[2][1] ), .D(n204), .Y(
        n184) );
  AOI21X1 U201 ( .A(n185), .B(n184), .C(n858), .Y(n189) );
  AOI22X1 U202 ( .A(\data[5][1] ), .B(n203), .C(\data[7][1] ), .D(n202), .Y(
        n187) );
  AOI22X1 U203 ( .A(\data[1][1] ), .B(n205), .C(\data[3][1] ), .D(n204), .Y(
        n186) );
  AOI21X1 U204 ( .A(n187), .B(n186), .C(n206), .Y(n188) );
  OR2X1 U205 ( .A(n189), .B(n188), .Y(N931) );
  AOI22X1 U206 ( .A(\data[4][2] ), .B(n203), .C(\data[6][2] ), .D(n202), .Y(
        n191) );
  AOI22X1 U207 ( .A(\data[0][2] ), .B(n205), .C(\data[2][2] ), .D(n204), .Y(
        n190) );
  AOI21X1 U208 ( .A(n191), .B(n190), .C(n858), .Y(n195) );
  AOI22X1 U209 ( .A(\data[5][2] ), .B(n203), .C(\data[7][2] ), .D(n202), .Y(
        n193) );
  AOI22X1 U210 ( .A(\data[1][2] ), .B(n205), .C(\data[3][2] ), .D(n204), .Y(
        n192) );
  AOI21X1 U211 ( .A(n193), .B(n192), .C(n206), .Y(n194) );
  OR2X1 U212 ( .A(n195), .B(n194), .Y(N930) );
  AOI22X1 U213 ( .A(\data[4][3] ), .B(n203), .C(\data[6][3] ), .D(n202), .Y(
        n197) );
  AOI22X1 U214 ( .A(\data[0][3] ), .B(n205), .C(\data[2][3] ), .D(n204), .Y(
        n196) );
  AOI21X1 U215 ( .A(n197), .B(n196), .C(n858), .Y(n201) );
  AOI22X1 U216 ( .A(\data[5][3] ), .B(n203), .C(\data[7][3] ), .D(n202), .Y(
        n199) );
  AOI22X1 U217 ( .A(\data[1][3] ), .B(n205), .C(\data[3][3] ), .D(n204), .Y(
        n198) );
  AOI21X1 U218 ( .A(n199), .B(n198), .C(n206), .Y(n200) );
  OR2X1 U219 ( .A(n201), .B(n200), .Y(N929) );
  INVX2 U220 ( .A(n858), .Y(n206) );
  NOR2X1 U221 ( .A(n235), .B(n860), .Y(n232) );
  NOR2X1 U222 ( .A(n235), .B(N243), .Y(n231) );
  AOI22X1 U223 ( .A(\data[4][0] ), .B(n232), .C(\data[6][0] ), .D(n231), .Y(
        n208) );
  NOR2X1 U224 ( .A(n860), .B(N259), .Y(n234) );
  NOR2X1 U225 ( .A(N243), .B(N259), .Y(n233) );
  AOI22X1 U226 ( .A(\data[0][0] ), .B(n234), .C(\data[2][0] ), .D(n233), .Y(
        n207) );
  AOI21X1 U227 ( .A(n208), .B(n207), .C(N257), .Y(n212) );
  AOI22X1 U228 ( .A(\data[5][0] ), .B(n232), .C(\data[7][0] ), .D(n231), .Y(
        n210) );
  AOI22X1 U229 ( .A(\data[1][0] ), .B(n234), .C(\data[3][0] ), .D(n233), .Y(
        n209) );
  AOI21X1 U230 ( .A(n210), .B(n209), .C(n236), .Y(n211) );
  OR2X1 U231 ( .A(n212), .B(n211), .Y(N943) );
  AOI22X1 U232 ( .A(\data[4][1] ), .B(n232), .C(\data[6][1] ), .D(n231), .Y(
        n214) );
  AOI22X1 U233 ( .A(\data[0][1] ), .B(n234), .C(\data[2][1] ), .D(n233), .Y(
        n213) );
  AOI21X1 U234 ( .A(n214), .B(n213), .C(N257), .Y(n218) );
  AOI22X1 U235 ( .A(\data[5][1] ), .B(n232), .C(\data[7][1] ), .D(n231), .Y(
        n216) );
  AOI22X1 U236 ( .A(\data[1][1] ), .B(n234), .C(\data[3][1] ), .D(n233), .Y(
        n215) );
  AOI21X1 U237 ( .A(n216), .B(n215), .C(n236), .Y(n217) );
  OR2X1 U238 ( .A(n218), .B(n217), .Y(N942) );
  AOI22X1 U239 ( .A(\data[4][2] ), .B(n232), .C(\data[6][2] ), .D(n231), .Y(
        n220) );
  AOI22X1 U240 ( .A(\data[0][2] ), .B(n234), .C(\data[2][2] ), .D(n233), .Y(
        n219) );
  AOI21X1 U241 ( .A(n220), .B(n219), .C(N257), .Y(n224) );
  AOI22X1 U242 ( .A(\data[5][2] ), .B(n232), .C(\data[7][2] ), .D(n231), .Y(
        n222) );
  AOI22X1 U243 ( .A(\data[1][2] ), .B(n234), .C(\data[3][2] ), .D(n233), .Y(
        n221) );
  AOI21X1 U244 ( .A(n222), .B(n221), .C(n236), .Y(n223) );
  OR2X1 U245 ( .A(n224), .B(n223), .Y(N941) );
  AOI22X1 U246 ( .A(\data[4][3] ), .B(n232), .C(\data[6][3] ), .D(n231), .Y(
        n226) );
  AOI22X1 U247 ( .A(\data[0][3] ), .B(n234), .C(\data[2][3] ), .D(n233), .Y(
        n225) );
  AOI21X1 U248 ( .A(n226), .B(n225), .C(N257), .Y(n230) );
  AOI22X1 U249 ( .A(\data[5][3] ), .B(n232), .C(\data[7][3] ), .D(n231), .Y(
        n228) );
  AOI22X1 U250 ( .A(\data[1][3] ), .B(n234), .C(\data[3][3] ), .D(n233), .Y(
        n227) );
  AOI21X1 U251 ( .A(n228), .B(n227), .C(n236), .Y(n229) );
  OR2X1 U252 ( .A(n230), .B(n229), .Y(N940) );
  INVX2 U253 ( .A(N259), .Y(n235) );
  NOR2X1 U254 ( .A(n177), .B(N255), .Y(n262) );
  NOR2X1 U255 ( .A(n177), .B(n859), .Y(n261) );
  AOI22X1 U256 ( .A(\data[4][0] ), .B(n262), .C(\data[6][0] ), .D(n261), .Y(
        n238) );
  NOR2X1 U257 ( .A(N255), .B(N256), .Y(n264) );
  NOR2X1 U258 ( .A(n859), .B(N256), .Y(n263) );
  AOI22X1 U259 ( .A(\data[0][0] ), .B(n264), .C(\data[2][0] ), .D(n263), .Y(
        n237) );
  AOI21X1 U260 ( .A(n238), .B(n237), .C(n858), .Y(n242) );
  AOI22X1 U261 ( .A(\data[5][0] ), .B(n262), .C(\data[7][0] ), .D(n261), .Y(
        n240) );
  AOI22X1 U262 ( .A(\data[1][0] ), .B(n264), .C(\data[3][0] ), .D(n263), .Y(
        n239) );
  AOI21X1 U263 ( .A(n240), .B(n239), .C(n206), .Y(n241) );
  AOI22X1 U264 ( .A(\data[4][1] ), .B(n262), .C(\data[6][1] ), .D(n261), .Y(
        n244) );
  AOI22X1 U265 ( .A(\data[0][1] ), .B(n264), .C(\data[2][1] ), .D(n263), .Y(
        n243) );
  AOI21X1 U266 ( .A(n244), .B(n243), .C(n858), .Y(n248) );
  AOI22X1 U267 ( .A(\data[5][1] ), .B(n262), .C(\data[7][1] ), .D(n261), .Y(
        n246) );
  AOI22X1 U268 ( .A(\data[1][1] ), .B(n264), .C(\data[3][1] ), .D(n263), .Y(
        n245) );
  AOI21X1 U269 ( .A(n246), .B(n245), .C(n206), .Y(n247) );
  AOI22X1 U270 ( .A(\data[4][2] ), .B(n262), .C(\data[6][2] ), .D(n261), .Y(
        n250) );
  AOI22X1 U271 ( .A(\data[0][2] ), .B(n264), .C(\data[2][2] ), .D(n263), .Y(
        n249) );
  AOI21X1 U272 ( .A(n250), .B(n249), .C(n858), .Y(n254) );
  AOI22X1 U273 ( .A(\data[5][2] ), .B(n262), .C(\data[7][2] ), .D(n261), .Y(
        n252) );
  AOI22X1 U274 ( .A(\data[1][2] ), .B(n264), .C(\data[3][2] ), .D(n263), .Y(
        n251) );
  AOI21X1 U275 ( .A(n252), .B(n251), .C(n206), .Y(n253) );
  AOI22X1 U276 ( .A(\data[4][3] ), .B(n262), .C(\data[6][3] ), .D(n261), .Y(
        n256) );
  AOI22X1 U277 ( .A(\data[0][3] ), .B(n264), .C(\data[2][3] ), .D(n263), .Y(
        n255) );
  AOI21X1 U278 ( .A(n256), .B(n255), .C(n858), .Y(n260) );
  AOI22X1 U279 ( .A(\data[5][3] ), .B(n262), .C(\data[7][3] ), .D(n261), .Y(
        n258) );
  AOI22X1 U280 ( .A(\data[1][3] ), .B(n264), .C(\data[3][3] ), .D(n263), .Y(
        n257) );
  AOI21X1 U281 ( .A(n258), .B(n257), .C(n206), .Y(n259) );
  NOR2X1 U282 ( .A(n235), .B(n860), .Y(n290) );
  NOR2X1 U283 ( .A(n235), .B(N243), .Y(n289) );
  AOI22X1 U284 ( .A(\data[4][0] ), .B(n290), .C(\data[6][0] ), .D(n289), .Y(
        n266) );
  NOR2X1 U285 ( .A(n860), .B(N259), .Y(n292) );
  NOR2X1 U286 ( .A(N243), .B(N259), .Y(n291) );
  AOI22X1 U287 ( .A(\data[0][0] ), .B(n292), .C(\data[2][0] ), .D(n291), .Y(
        n265) );
  AOI21X1 U288 ( .A(n266), .B(n265), .C(N257), .Y(n270) );
  AOI22X1 U289 ( .A(\data[5][0] ), .B(n290), .C(\data[7][0] ), .D(n289), .Y(
        n268) );
  AOI22X1 U290 ( .A(\data[1][0] ), .B(n292), .C(\data[3][0] ), .D(n291), .Y(
        n267) );
  AOI21X1 U291 ( .A(n268), .B(n267), .C(n236), .Y(n269) );
  OR2X1 U292 ( .A(n270), .B(n269), .Y(N998) );
  AOI22X1 U293 ( .A(\data[4][1] ), .B(n290), .C(\data[6][1] ), .D(n289), .Y(
        n272) );
  AOI22X1 U294 ( .A(\data[0][1] ), .B(n292), .C(\data[2][1] ), .D(n291), .Y(
        n271) );
  AOI21X1 U295 ( .A(n272), .B(n271), .C(N257), .Y(n276) );
  AOI22X1 U296 ( .A(\data[5][1] ), .B(n290), .C(\data[7][1] ), .D(n289), .Y(
        n274) );
  AOI22X1 U297 ( .A(\data[1][1] ), .B(n292), .C(\data[3][1] ), .D(n291), .Y(
        n273) );
  AOI21X1 U298 ( .A(n274), .B(n273), .C(n49), .Y(n275) );
  OR2X1 U299 ( .A(n276), .B(n275), .Y(N997) );
  AOI22X1 U300 ( .A(\data[4][2] ), .B(n290), .C(\data[6][2] ), .D(n289), .Y(
        n278) );
  AOI22X1 U301 ( .A(\data[0][2] ), .B(n292), .C(\data[2][2] ), .D(n291), .Y(
        n277) );
  AOI21X1 U302 ( .A(n278), .B(n277), .C(n206), .Y(n282) );
  AOI22X1 U303 ( .A(\data[5][2] ), .B(n290), .C(\data[7][2] ), .D(n289), .Y(
        n280) );
  AOI22X1 U304 ( .A(\data[1][2] ), .B(n292), .C(\data[3][2] ), .D(n291), .Y(
        n279) );
  AOI21X1 U305 ( .A(n280), .B(n279), .C(n236), .Y(n281) );
  OR2X1 U306 ( .A(n282), .B(n281), .Y(N996) );
  AOI22X1 U307 ( .A(\data[4][3] ), .B(n290), .C(\data[6][3] ), .D(n289), .Y(
        n284) );
  AOI22X1 U308 ( .A(\data[0][3] ), .B(n292), .C(\data[2][3] ), .D(n291), .Y(
        n283) );
  AOI21X1 U309 ( .A(n284), .B(n283), .C(n206), .Y(n288) );
  AOI22X1 U310 ( .A(\data[5][3] ), .B(n290), .C(\data[7][3] ), .D(n289), .Y(
        n286) );
  AOI22X1 U311 ( .A(\data[1][3] ), .B(n292), .C(\data[3][3] ), .D(n291), .Y(
        n285) );
  AOI21X1 U312 ( .A(n286), .B(n285), .C(n236), .Y(n287) );
  OR2X1 U313 ( .A(n288), .B(n287), .Y(N995) );
  NOR2X1 U314 ( .A(n321), .B(n859), .Y(n318) );
  NOR2X1 U315 ( .A(n321), .B(N255), .Y(n317) );
  AOI22X1 U316 ( .A(\data[4][0] ), .B(n318), .C(\data[6][0] ), .D(n317), .Y(
        n294) );
  NOR2X1 U317 ( .A(n859), .B(N262), .Y(n320) );
  NOR2X1 U318 ( .A(N255), .B(N262), .Y(n319) );
  AOI22X1 U319 ( .A(\data[0][0] ), .B(n320), .C(\data[2][0] ), .D(n319), .Y(
        n293) );
  AOI21X1 U320 ( .A(n294), .B(n293), .C(n858), .Y(n298) );
  AOI22X1 U321 ( .A(\data[5][0] ), .B(n318), .C(\data[7][0] ), .D(n317), .Y(
        n296) );
  AOI22X1 U322 ( .A(\data[1][0] ), .B(n320), .C(\data[3][0] ), .D(n319), .Y(
        n295) );
  AOI21X1 U323 ( .A(n296), .B(n295), .C(n206), .Y(n297) );
  OR2X1 U324 ( .A(n298), .B(n297), .Y(N1009) );
  AOI22X1 U325 ( .A(\data[4][1] ), .B(n318), .C(\data[6][1] ), .D(n317), .Y(
        n300) );
  AOI22X1 U326 ( .A(\data[0][1] ), .B(n320), .C(\data[2][1] ), .D(n319), .Y(
        n299) );
  AOI21X1 U327 ( .A(n300), .B(n299), .C(n858), .Y(n304) );
  AOI22X1 U328 ( .A(\data[5][1] ), .B(n318), .C(\data[7][1] ), .D(n317), .Y(
        n302) );
  AOI22X1 U329 ( .A(\data[1][1] ), .B(n320), .C(\data[3][1] ), .D(n319), .Y(
        n301) );
  AOI21X1 U330 ( .A(n302), .B(n301), .C(n206), .Y(n303) );
  OR2X1 U331 ( .A(n304), .B(n303), .Y(N1008) );
  AOI22X1 U332 ( .A(\data[4][2] ), .B(n318), .C(\data[6][2] ), .D(n317), .Y(
        n306) );
  AOI22X1 U333 ( .A(\data[0][2] ), .B(n320), .C(\data[2][2] ), .D(n319), .Y(
        n305) );
  AOI21X1 U334 ( .A(n306), .B(n305), .C(n858), .Y(n310) );
  AOI22X1 U335 ( .A(\data[5][2] ), .B(n318), .C(\data[7][2] ), .D(n317), .Y(
        n308) );
  AOI22X1 U336 ( .A(\data[1][2] ), .B(n320), .C(\data[3][2] ), .D(n319), .Y(
        n307) );
  AOI21X1 U337 ( .A(n308), .B(n307), .C(n206), .Y(n309) );
  OR2X1 U338 ( .A(n310), .B(n309), .Y(N1007) );
  AOI22X1 U339 ( .A(\data[4][3] ), .B(n318), .C(\data[6][3] ), .D(n317), .Y(
        n312) );
  AOI22X1 U340 ( .A(\data[0][3] ), .B(n320), .C(\data[2][3] ), .D(n319), .Y(
        n311) );
  AOI21X1 U341 ( .A(n312), .B(n311), .C(n858), .Y(n316) );
  AOI22X1 U342 ( .A(\data[5][3] ), .B(n318), .C(\data[7][3] ), .D(n317), .Y(
        n314) );
  AOI22X1 U343 ( .A(\data[1][3] ), .B(n320), .C(\data[3][3] ), .D(n319), .Y(
        n313) );
  AOI21X1 U344 ( .A(n314), .B(n313), .C(n206), .Y(n315) );
  OR2X1 U345 ( .A(n316), .B(n315), .Y(N1006) );
  INVX2 U346 ( .A(N262), .Y(n321) );
  NOR2X1 U347 ( .A(n322), .B(n1), .Y(tx_packet_data[3]) );
  NOR2X1 U348 ( .A(n322), .B(n2), .Y(tx_packet_data[2]) );
  NOR2X1 U349 ( .A(n322), .B(n3), .Y(tx_packet_data[1]) );
  NOR2X1 U350 ( .A(n322), .B(n4), .Y(tx_packet_data[0]) );
  OAI21X1 U351 ( .A(n323), .B(n5), .C(n324), .Y(rx_data[9]) );
  AOI22X1 U352 ( .A(N904), .B(n325), .C(N931), .D(n326), .Y(n324) );
  OAI21X1 U353 ( .A(n323), .B(n6), .C(n327), .Y(rx_data[8]) );
  AOI22X1 U354 ( .A(N905), .B(n325), .C(N932), .D(n326), .Y(n327) );
  NOR2X1 U355 ( .A(n1), .B(n328), .Y(rx_data[3]) );
  NOR2X1 U356 ( .A(n2), .B(n328), .Y(rx_data[2]) );
  AND2X1 U357 ( .A(N1006), .B(n329), .Y(rx_data[27]) );
  AND2X1 U358 ( .A(N1007), .B(n329), .Y(rx_data[26]) );
  AND2X1 U359 ( .A(N1008), .B(n329), .Y(rx_data[25]) );
  AND2X1 U360 ( .A(N1009), .B(n329), .Y(rx_data[24]) );
  NOR2X1 U361 ( .A(n3), .B(n328), .Y(rx_data[1]) );
  OAI21X1 U362 ( .A(n323), .B(n7), .C(n330), .Y(rx_data[11]) );
  AOI22X1 U363 ( .A(N902), .B(n325), .C(N929), .D(n326), .Y(n330) );
  OAI21X1 U364 ( .A(n323), .B(n8), .C(n331), .Y(rx_data[10]) );
  AOI22X1 U365 ( .A(N903), .B(n325), .C(N930), .D(n326), .Y(n331) );
  INVX1 U366 ( .A(n332), .Y(n325) );
  NAND3X1 U367 ( .A(n333), .B(n334), .C(data_size[0]), .Y(n332) );
  NOR2X1 U368 ( .A(n4), .B(n328), .Y(rx_data[0]) );
  NAND2X1 U369 ( .A(n335), .B(n336), .Y(next_state[2]) );
  NAND3X1 U370 ( .A(n337), .B(n338), .C(store_rx_packet_data), .Y(n336) );
  NOR2X1 U371 ( .A(n337), .B(n339), .Y(next_state[1]) );
  NAND2X1 U372 ( .A(n335), .B(n338), .Y(n339) );
  INVX1 U373 ( .A(store_tx_data), .Y(n338) );
  INVX1 U374 ( .A(clear), .Y(n335) );
  NOR2X1 U375 ( .A(get_tx_packet_data), .B(get_rx_data), .Y(n337) );
  OAI21X1 U376 ( .A(get_rx_data), .B(n340), .C(n341), .Y(next_state[0]) );
  NOR2X1 U377 ( .A(store_tx_data), .B(clear), .Y(n341) );
  INVX1 U378 ( .A(get_tx_packet_data), .Y(n340) );
  OAI21X1 U379 ( .A(n16), .B(n343), .C(n344), .Y(next_count2[9]) );
  NAND2X1 U380 ( .A(N493), .B(n345), .Y(n344) );
  OAI21X1 U381 ( .A(n16), .B(n346), .C(n347), .Y(next_count2[8]) );
  NAND2X1 U382 ( .A(N492), .B(n345), .Y(n347) );
  OAI21X1 U383 ( .A(n16), .B(n348), .C(n349), .Y(next_count2[7]) );
  NAND2X1 U384 ( .A(N491), .B(n345), .Y(n349) );
  OAI21X1 U385 ( .A(n16), .B(n350), .C(n351), .Y(next_count2[6]) );
  NAND2X1 U386 ( .A(N490), .B(n345), .Y(n351) );
  OAI21X1 U387 ( .A(n16), .B(n352), .C(n353), .Y(next_count2[5]) );
  NAND2X1 U388 ( .A(N489), .B(n345), .Y(n353) );
  OAI21X1 U389 ( .A(n16), .B(n354), .C(n355), .Y(next_count2[4]) );
  NAND2X1 U390 ( .A(N488), .B(n345), .Y(n355) );
  OAI21X1 U391 ( .A(n16), .B(n356), .C(n357), .Y(next_count2[3]) );
  NAND2X1 U392 ( .A(N487), .B(n345), .Y(n357) );
  OAI21X1 U393 ( .A(n16), .B(n358), .C(n359), .Y(next_count2[31]) );
  NAND2X1 U394 ( .A(N515), .B(n345), .Y(n359) );
  OAI21X1 U395 ( .A(n16), .B(n360), .C(n361), .Y(next_count2[30]) );
  NAND2X1 U396 ( .A(N514), .B(n345), .Y(n361) );
  OAI21X1 U397 ( .A(\U3/U1/Z_2 ), .B(n342), .C(n362), .Y(next_count2[2]) );
  NAND2X1 U398 ( .A(N486), .B(n345), .Y(n362) );
  OAI21X1 U399 ( .A(n16), .B(n363), .C(n364), .Y(next_count2[29]) );
  NAND2X1 U400 ( .A(N513), .B(n345), .Y(n364) );
  OAI21X1 U401 ( .A(n16), .B(n365), .C(n366), .Y(next_count2[28]) );
  NAND2X1 U402 ( .A(N512), .B(n345), .Y(n366) );
  OAI21X1 U403 ( .A(n16), .B(n367), .C(n368), .Y(next_count2[27]) );
  NAND2X1 U404 ( .A(N511), .B(n345), .Y(n368) );
  OAI21X1 U405 ( .A(n16), .B(n369), .C(n370), .Y(next_count2[26]) );
  NAND2X1 U406 ( .A(N510), .B(n345), .Y(n370) );
  OAI21X1 U407 ( .A(n16), .B(n371), .C(n372), .Y(next_count2[25]) );
  NAND2X1 U408 ( .A(N509), .B(n345), .Y(n372) );
  OAI21X1 U409 ( .A(n16), .B(n373), .C(n374), .Y(next_count2[24]) );
  NAND2X1 U410 ( .A(N508), .B(n345), .Y(n374) );
  OAI21X1 U411 ( .A(n16), .B(n375), .C(n376), .Y(next_count2[23]) );
  NAND2X1 U412 ( .A(N507), .B(n345), .Y(n376) );
  OAI21X1 U413 ( .A(n16), .B(n377), .C(n378), .Y(next_count2[22]) );
  NAND2X1 U414 ( .A(N506), .B(n345), .Y(n378) );
  OAI21X1 U415 ( .A(n16), .B(n379), .C(n380), .Y(next_count2[21]) );
  NAND2X1 U416 ( .A(N505), .B(n345), .Y(n380) );
  OAI21X1 U417 ( .A(n16), .B(n381), .C(n382), .Y(next_count2[20]) );
  NAND2X1 U418 ( .A(N504), .B(n345), .Y(n382) );
  OAI21X1 U419 ( .A(n383), .B(n342), .C(n384), .Y(next_count2[1]) );
  NAND2X1 U420 ( .A(N485), .B(n345), .Y(n384) );
  OAI21X1 U421 ( .A(n16), .B(n385), .C(n386), .Y(next_count2[19]) );
  NAND2X1 U422 ( .A(N503), .B(n345), .Y(n386) );
  OAI21X1 U423 ( .A(n16), .B(n387), .C(n388), .Y(next_count2[18]) );
  NAND2X1 U424 ( .A(N502), .B(n345), .Y(n388) );
  OAI21X1 U425 ( .A(n16), .B(n389), .C(n390), .Y(next_count2[17]) );
  NAND2X1 U426 ( .A(N501), .B(n345), .Y(n390) );
  OAI21X1 U427 ( .A(n16), .B(n391), .C(n392), .Y(next_count2[16]) );
  NAND2X1 U428 ( .A(N500), .B(n345), .Y(n392) );
  OAI21X1 U429 ( .A(n16), .B(n393), .C(n394), .Y(next_count2[15]) );
  NAND2X1 U430 ( .A(N499), .B(n345), .Y(n394) );
  OAI21X1 U431 ( .A(n16), .B(n395), .C(n396), .Y(next_count2[14]) );
  NAND2X1 U432 ( .A(N498), .B(n345), .Y(n396) );
  OAI21X1 U433 ( .A(n342), .B(n397), .C(n398), .Y(next_count2[13]) );
  NAND2X1 U434 ( .A(N497), .B(n345), .Y(n398) );
  OAI21X1 U435 ( .A(n342), .B(n399), .C(n400), .Y(next_count2[12]) );
  NAND2X1 U436 ( .A(N496), .B(n345), .Y(n400) );
  OAI21X1 U437 ( .A(n342), .B(n401), .C(n402), .Y(next_count2[11]) );
  NAND2X1 U438 ( .A(N495), .B(n345), .Y(n402) );
  OAI21X1 U439 ( .A(n342), .B(n403), .C(n404), .Y(next_count2[10]) );
  NAND2X1 U440 ( .A(N494), .B(n345), .Y(n404) );
  OAI21X1 U441 ( .A(n405), .B(n342), .C(n406), .Y(next_count2[0]) );
  NAND2X1 U442 ( .A(N484), .B(n345), .Y(n406) );
  NAND3X1 U443 ( .A(state[0]), .B(n407), .C(state[1]), .Y(n322) );
  OAI22X1 U444 ( .A(n343), .B(n14), .C(n15), .D(n410), .Y(next_count1[9]) );
  INVX1 U445 ( .A(N394), .Y(n410) );
  INVX1 U446 ( .A(N362), .Y(n343) );
  OAI22X1 U447 ( .A(n346), .B(n14), .C(n15), .D(n411), .Y(next_count1[8]) );
  INVX1 U448 ( .A(N393), .Y(n411) );
  INVX1 U449 ( .A(N361), .Y(n346) );
  OAI22X1 U450 ( .A(n348), .B(n14), .C(n15), .D(n412), .Y(next_count1[7]) );
  INVX1 U451 ( .A(N360), .Y(n348) );
  OAI22X1 U452 ( .A(n350), .B(n14), .C(n15), .D(n413), .Y(next_count1[6]) );
  INVX1 U453 ( .A(N359), .Y(n350) );
  OAI22X1 U454 ( .A(n352), .B(n14), .C(n15), .D(n414), .Y(next_count1[5]) );
  INVX1 U455 ( .A(N358), .Y(n352) );
  OAI22X1 U456 ( .A(n354), .B(n14), .C(n15), .D(n415), .Y(next_count1[4]) );
  INVX1 U457 ( .A(N357), .Y(n354) );
  OAI22X1 U458 ( .A(n356), .B(n14), .C(n15), .D(n416), .Y(next_count1[3]) );
  INVX1 U459 ( .A(N356), .Y(n356) );
  OAI22X1 U460 ( .A(n358), .B(n14), .C(n15), .D(n417), .Y(next_count1[31]) );
  INVX1 U461 ( .A(N416), .Y(n417) );
  INVX1 U462 ( .A(N384), .Y(n358) );
  OAI22X1 U463 ( .A(n360), .B(n14), .C(n15), .D(n418), .Y(next_count1[30]) );
  INVX1 U464 ( .A(N415), .Y(n418) );
  INVX1 U465 ( .A(N383), .Y(n360) );
  OAI22X1 U466 ( .A(\U3/U1/Z_2 ), .B(n14), .C(n15), .D(n419), .Y(
        next_count1[2]) );
  OAI22X1 U467 ( .A(n14), .B(n363), .C(n15), .D(n420), .Y(next_count1[29]) );
  INVX1 U468 ( .A(N382), .Y(n363) );
  OAI22X1 U469 ( .A(n14), .B(n365), .C(n15), .D(n421), .Y(next_count1[28]) );
  INVX1 U470 ( .A(N381), .Y(n365) );
  OAI22X1 U471 ( .A(n14), .B(n367), .C(n15), .D(n422), .Y(next_count1[27]) );
  INVX1 U472 ( .A(N412), .Y(n422) );
  INVX1 U473 ( .A(N380), .Y(n367) );
  OAI22X1 U474 ( .A(n14), .B(n369), .C(n15), .D(n423), .Y(next_count1[26]) );
  INVX1 U475 ( .A(N411), .Y(n423) );
  INVX1 U476 ( .A(N379), .Y(n369) );
  OAI22X1 U477 ( .A(n14), .B(n371), .C(n15), .D(n424), .Y(next_count1[25]) );
  INVX1 U478 ( .A(N378), .Y(n371) );
  OAI22X1 U479 ( .A(n14), .B(n373), .C(n15), .D(n425), .Y(next_count1[24]) );
  INVX1 U480 ( .A(N377), .Y(n373) );
  OAI22X1 U481 ( .A(n14), .B(n375), .C(n15), .D(n426), .Y(next_count1[23]) );
  INVX1 U482 ( .A(N408), .Y(n426) );
  INVX1 U483 ( .A(N376), .Y(n375) );
  OAI22X1 U484 ( .A(n14), .B(n377), .C(n15), .D(n427), .Y(next_count1[22]) );
  INVX1 U485 ( .A(N407), .Y(n427) );
  INVX1 U486 ( .A(N375), .Y(n377) );
  OAI22X1 U487 ( .A(n14), .B(n379), .C(n15), .D(n428), .Y(next_count1[21]) );
  INVX1 U488 ( .A(N374), .Y(n379) );
  OAI22X1 U489 ( .A(n14), .B(n381), .C(n15), .D(n429), .Y(next_count1[20]) );
  INVX1 U490 ( .A(N373), .Y(n381) );
  OAI22X1 U491 ( .A(n383), .B(n14), .C(n15), .D(n430), .Y(next_count1[1]) );
  INVX1 U492 ( .A(\U3/U1/Z_1 ), .Y(n383) );
  OAI22X1 U493 ( .A(n14), .B(n385), .C(n409), .D(n431), .Y(next_count1[19]) );
  INVX1 U494 ( .A(N372), .Y(n385) );
  OAI22X1 U495 ( .A(n14), .B(n387), .C(n409), .D(n432), .Y(next_count1[18]) );
  INVX1 U496 ( .A(N371), .Y(n387) );
  OAI22X1 U497 ( .A(n14), .B(n389), .C(n409), .D(n433), .Y(next_count1[17]) );
  INVX1 U498 ( .A(N370), .Y(n389) );
  OAI22X1 U499 ( .A(n14), .B(n391), .C(n409), .D(n434), .Y(next_count1[16]) );
  INVX1 U500 ( .A(N401), .Y(n434) );
  INVX1 U501 ( .A(N369), .Y(n391) );
  OAI22X1 U502 ( .A(n14), .B(n393), .C(n409), .D(n435), .Y(next_count1[15]) );
  INVX1 U503 ( .A(N400), .Y(n435) );
  INVX1 U504 ( .A(N368), .Y(n393) );
  OAI22X1 U505 ( .A(n14), .B(n395), .C(n409), .D(n436), .Y(next_count1[14]) );
  INVX1 U506 ( .A(N367), .Y(n395) );
  OAI22X1 U507 ( .A(n14), .B(n397), .C(n409), .D(n437), .Y(next_count1[13]) );
  INVX1 U508 ( .A(N366), .Y(n397) );
  OAI22X1 U509 ( .A(n14), .B(n399), .C(n409), .D(n438), .Y(next_count1[12]) );
  INVX1 U510 ( .A(N365), .Y(n399) );
  OAI22X1 U511 ( .A(n14), .B(n401), .C(n409), .D(n439), .Y(next_count1[11]) );
  INVX1 U512 ( .A(N364), .Y(n401) );
  OAI22X1 U513 ( .A(n14), .B(n403), .C(n409), .D(n440), .Y(next_count1[10]) );
  INVX1 U514 ( .A(N363), .Y(n403) );
  OAI22X1 U515 ( .A(n405), .B(n14), .C(n12), .D(n409), .Y(next_count1[0]) );
  INVX1 U516 ( .A(\U3/U1/Z_0 ), .Y(n405) );
  INVX1 U517 ( .A(n441), .Y(rx_data[16]) );
  AOI22X1 U518 ( .A(N943), .B(n326), .C(N998), .D(n329), .Y(n441) );
  INVX1 U519 ( .A(n442), .Y(rx_data[17]) );
  AOI22X1 U520 ( .A(N942), .B(n326), .C(N997), .D(n329), .Y(n442) );
  INVX1 U521 ( .A(n443), .Y(rx_data[18]) );
  AOI22X1 U522 ( .A(N941), .B(n326), .C(N996), .D(n329), .Y(n443) );
  INVX1 U523 ( .A(n444), .Y(rx_data[19]) );
  AOI22X1 U524 ( .A(N940), .B(n326), .C(N995), .D(n329), .Y(n444) );
  INVX1 U525 ( .A(n323), .Y(n329) );
  NAND3X1 U526 ( .A(data_size[0]), .B(n333), .C(data_size[1]), .Y(n323) );
  INVX1 U527 ( .A(n445), .Y(n326) );
  NAND3X1 U528 ( .A(n333), .B(n446), .C(data_size[1]), .Y(n445) );
  INVX1 U529 ( .A(N255), .Y(n859) );
  NAND2X1 U530 ( .A(n447), .B(n448), .Y(n761) );
  AOI21X1 U531 ( .A(n449), .B(n450), .C(n451), .Y(n448) );
  OAI22X1 U532 ( .A(n452), .B(n453), .C(n454), .D(n455), .Y(n451) );
  AOI22X1 U533 ( .A(\data[7][3] ), .B(n456), .C(n457), .D(n458), .Y(n447) );
  NAND2X1 U534 ( .A(n459), .B(n460), .Y(n760) );
  AOI21X1 U535 ( .A(n461), .B(n450), .C(n462), .Y(n460) );
  OAI22X1 U536 ( .A(n463), .B(n453), .C(n455), .D(n464), .Y(n462) );
  AOI22X1 U537 ( .A(\data[7][2] ), .B(n456), .C(n465), .D(n458), .Y(n459) );
  NAND2X1 U538 ( .A(n466), .B(n467), .Y(n759) );
  AOI21X1 U539 ( .A(n468), .B(n450), .C(n469), .Y(n467) );
  OAI22X1 U540 ( .A(n470), .B(n453), .C(n455), .D(n471), .Y(n469) );
  AOI22X1 U541 ( .A(\data[7][1] ), .B(n456), .C(n472), .D(n458), .Y(n466) );
  NAND2X1 U542 ( .A(n473), .B(n474), .Y(n758) );
  AOI21X1 U543 ( .A(n475), .B(n450), .C(n476), .Y(n474) );
  OAI22X1 U544 ( .A(n477), .B(n453), .C(n455), .D(n478), .Y(n476) );
  OR2X1 U545 ( .A(n479), .B(n458), .Y(n455) );
  NAND2X1 U546 ( .A(n480), .B(n481), .Y(n453) );
  INVX1 U547 ( .A(n482), .Y(n450) );
  NAND3X1 U548 ( .A(n479), .B(n483), .C(n484), .Y(n482) );
  AOI22X1 U549 ( .A(\data[7][0] ), .B(n456), .C(n485), .D(n458), .Y(n473) );
  INVX1 U550 ( .A(n483), .Y(n458) );
  INVX1 U551 ( .A(n480), .Y(n456) );
  OAI21X1 U552 ( .A(n486), .B(n487), .C(n481), .Y(n480) );
  OAI21X1 U553 ( .A(n484), .B(n488), .C(n13), .Y(n481) );
  NAND2X1 U554 ( .A(n479), .B(n483), .Y(n488) );
  NAND3X1 U555 ( .A(N1354), .B(n489), .C(N1355), .Y(n483) );
  NAND3X1 U556 ( .A(N1257), .B(n490), .C(N1259), .Y(n479) );
  AND2X1 U557 ( .A(n491), .B(n492), .Y(n484) );
  NAND2X1 U558 ( .A(n493), .B(n494), .Y(n757) );
  AOI21X1 U559 ( .A(n495), .B(n449), .C(n496), .Y(n494) );
  OAI22X1 U560 ( .A(n452), .B(n497), .C(n454), .D(n498), .Y(n496) );
  AOI22X1 U561 ( .A(\data[6][3] ), .B(n499), .C(n500), .D(n457), .Y(n493) );
  NAND2X1 U562 ( .A(n501), .B(n502), .Y(n756) );
  AOI21X1 U563 ( .A(n495), .B(n461), .C(n503), .Y(n502) );
  OAI22X1 U564 ( .A(n463), .B(n497), .C(n464), .D(n498), .Y(n503) );
  AOI22X1 U565 ( .A(\data[6][2] ), .B(n499), .C(n500), .D(n465), .Y(n501) );
  NAND2X1 U566 ( .A(n504), .B(n505), .Y(n755) );
  AOI21X1 U567 ( .A(n495), .B(n468), .C(n506), .Y(n505) );
  OAI22X1 U568 ( .A(n470), .B(n497), .C(n471), .D(n498), .Y(n506) );
  AOI22X1 U569 ( .A(\data[6][1] ), .B(n499), .C(n500), .D(n472), .Y(n504) );
  NAND2X1 U570 ( .A(n507), .B(n508), .Y(n754) );
  AOI21X1 U571 ( .A(n495), .B(n475), .C(n509), .Y(n508) );
  OAI22X1 U572 ( .A(n477), .B(n497), .C(n478), .D(n498), .Y(n509) );
  NAND2X1 U573 ( .A(n510), .B(n511), .Y(n497) );
  AND2X1 U574 ( .A(n512), .B(n513), .Y(n495) );
  AOI22X1 U575 ( .A(\data[6][0] ), .B(n499), .C(n500), .D(n485), .Y(n507) );
  INVX1 U576 ( .A(n513), .Y(n500) );
  INVX1 U577 ( .A(n510), .Y(n499) );
  OAI21X1 U578 ( .A(n486), .B(n514), .C(n511), .Y(n510) );
  OAI21X1 U579 ( .A(n512), .B(n515), .C(n13), .Y(n511) );
  NAND2X1 U580 ( .A(n498), .B(n513), .Y(n515) );
  NAND3X1 U581 ( .A(N1355), .B(N1354), .C(n516), .Y(n513) );
  NAND3X1 U582 ( .A(n490), .B(n11), .C(N1259), .Y(n498) );
  AND2X1 U583 ( .A(n517), .B(n492), .Y(n512) );
  NOR2X1 U584 ( .A(n430), .B(n419), .Y(n492) );
  NAND2X1 U585 ( .A(n518), .B(n519), .Y(n753) );
  AOI21X1 U586 ( .A(n520), .B(n449), .C(n521), .Y(n519) );
  OAI22X1 U587 ( .A(n452), .B(n522), .C(n454), .D(n523), .Y(n521) );
  AOI22X1 U588 ( .A(\data[5][3] ), .B(n524), .C(n525), .D(n457), .Y(n518) );
  NAND2X1 U589 ( .A(n526), .B(n527), .Y(n752) );
  AOI21X1 U590 ( .A(n520), .B(n461), .C(n528), .Y(n527) );
  OAI22X1 U591 ( .A(n463), .B(n522), .C(n464), .D(n523), .Y(n528) );
  AOI22X1 U592 ( .A(\data[5][2] ), .B(n524), .C(n525), .D(n465), .Y(n526) );
  NAND2X1 U593 ( .A(n529), .B(n530), .Y(n751) );
  AOI21X1 U594 ( .A(n520), .B(n468), .C(n531), .Y(n530) );
  OAI22X1 U595 ( .A(n470), .B(n522), .C(n471), .D(n523), .Y(n531) );
  AOI22X1 U596 ( .A(\data[5][1] ), .B(n524), .C(n525), .D(n472), .Y(n529) );
  NAND2X1 U597 ( .A(n532), .B(n533), .Y(n750) );
  AOI21X1 U598 ( .A(n520), .B(n475), .C(n534), .Y(n533) );
  OAI22X1 U599 ( .A(n477), .B(n522), .C(n478), .D(n523), .Y(n534) );
  OR2X1 U600 ( .A(n535), .B(n525), .Y(n523) );
  NAND2X1 U601 ( .A(n536), .B(n537), .Y(n522) );
  INVX1 U602 ( .A(n538), .Y(n520) );
  NAND3X1 U603 ( .A(n535), .B(n539), .C(n540), .Y(n538) );
  AOI22X1 U604 ( .A(\data[5][0] ), .B(n524), .C(n525), .D(n485), .Y(n532) );
  INVX1 U605 ( .A(n539), .Y(n525) );
  INVX1 U606 ( .A(n536), .Y(n524) );
  OAI21X1 U607 ( .A(n486), .B(n541), .C(n537), .Y(n536) );
  OAI21X1 U608 ( .A(n540), .B(n542), .C(n13), .Y(n537) );
  NAND2X1 U609 ( .A(n535), .B(n539), .Y(n542) );
  NAND3X1 U610 ( .A(n489), .B(n543), .C(N1355), .Y(n539) );
  NAND3X1 U611 ( .A(N1259), .B(N1257), .C(n544), .Y(n535) );
  AND2X1 U612 ( .A(n545), .B(n491), .Y(n540) );
  NAND2X1 U613 ( .A(n546), .B(n547), .Y(n749) );
  AOI21X1 U614 ( .A(n548), .B(n449), .C(n549), .Y(n547) );
  OAI22X1 U615 ( .A(n452), .B(n550), .C(n454), .D(n551), .Y(n549) );
  AOI22X1 U616 ( .A(\data[4][3] ), .B(n552), .C(n553), .D(n457), .Y(n546) );
  NAND2X1 U617 ( .A(n554), .B(n555), .Y(n748) );
  AOI21X1 U618 ( .A(n548), .B(n461), .C(n556), .Y(n555) );
  OAI22X1 U619 ( .A(n463), .B(n550), .C(n464), .D(n551), .Y(n556) );
  AOI22X1 U620 ( .A(\data[4][2] ), .B(n552), .C(n553), .D(n465), .Y(n554) );
  NAND2X1 U621 ( .A(n557), .B(n558), .Y(n747) );
  AOI21X1 U622 ( .A(n548), .B(n468), .C(n559), .Y(n558) );
  OAI22X1 U623 ( .A(n470), .B(n550), .C(n471), .D(n551), .Y(n559) );
  AOI22X1 U624 ( .A(\data[4][1] ), .B(n552), .C(n553), .D(n472), .Y(n557) );
  NAND2X1 U625 ( .A(n560), .B(n561), .Y(n746) );
  AOI21X1 U626 ( .A(n548), .B(n475), .C(n562), .Y(n561) );
  OAI22X1 U627 ( .A(n477), .B(n550), .C(n478), .D(n551), .Y(n562) );
  NAND2X1 U628 ( .A(n563), .B(n564), .Y(n550) );
  AND2X1 U629 ( .A(n565), .B(n566), .Y(n548) );
  AOI22X1 U630 ( .A(\data[4][0] ), .B(n552), .C(n553), .D(n485), .Y(n560) );
  INVX1 U631 ( .A(n566), .Y(n553) );
  INVX1 U632 ( .A(n563), .Y(n552) );
  OAI21X1 U633 ( .A(n486), .B(n567), .C(n564), .Y(n563) );
  OAI21X1 U634 ( .A(n565), .B(n568), .C(n13), .Y(n564) );
  NAND2X1 U635 ( .A(n551), .B(n566), .Y(n568) );
  NAND3X1 U636 ( .A(N1355), .B(n543), .C(n516), .Y(n566) );
  NAND3X1 U637 ( .A(N1259), .B(n11), .C(n544), .Y(n551) );
  AND2X1 U638 ( .A(n545), .B(n517), .Y(n565) );
  NOR2X1 U639 ( .A(n419), .B(N386), .Y(n545) );
  INVX1 U640 ( .A(N387), .Y(n419) );
  NAND2X1 U641 ( .A(n569), .B(count1[2]), .Y(n486) );
  NAND2X1 U642 ( .A(n570), .B(n571), .Y(n745) );
  AOI21X1 U643 ( .A(n572), .B(n449), .C(n573), .Y(n571) );
  OAI22X1 U644 ( .A(n452), .B(n574), .C(n454), .D(n575), .Y(n573) );
  AOI22X1 U645 ( .A(\data[3][3] ), .B(n576), .C(n577), .D(n457), .Y(n570) );
  NAND2X1 U646 ( .A(n578), .B(n579), .Y(n744) );
  AOI21X1 U647 ( .A(n572), .B(n461), .C(n580), .Y(n579) );
  OAI22X1 U648 ( .A(n463), .B(n574), .C(n464), .D(n575), .Y(n580) );
  AOI22X1 U649 ( .A(\data[3][2] ), .B(n576), .C(n577), .D(n465), .Y(n578) );
  NAND2X1 U650 ( .A(n581), .B(n582), .Y(n743) );
  AOI21X1 U651 ( .A(n572), .B(n468), .C(n583), .Y(n582) );
  OAI22X1 U652 ( .A(n470), .B(n574), .C(n471), .D(n575), .Y(n583) );
  AOI22X1 U653 ( .A(\data[3][1] ), .B(n576), .C(n577), .D(n472), .Y(n581) );
  NAND2X1 U654 ( .A(n584), .B(n585), .Y(n742) );
  AOI21X1 U655 ( .A(n572), .B(n475), .C(n586), .Y(n585) );
  OAI22X1 U656 ( .A(n477), .B(n574), .C(n478), .D(n575), .Y(n586) );
  OR2X1 U657 ( .A(n587), .B(n577), .Y(n575) );
  NAND2X1 U658 ( .A(n588), .B(n589), .Y(n574) );
  INVX1 U659 ( .A(n590), .Y(n572) );
  NAND3X1 U660 ( .A(n587), .B(n591), .C(n592), .Y(n590) );
  AOI22X1 U661 ( .A(\data[3][0] ), .B(n576), .C(n577), .D(n485), .Y(n584) );
  INVX1 U662 ( .A(n591), .Y(n577) );
  INVX1 U663 ( .A(n588), .Y(n576) );
  OAI21X1 U664 ( .A(n593), .B(n487), .C(n589), .Y(n588) );
  OAI21X1 U665 ( .A(n592), .B(n594), .C(n13), .Y(n589) );
  NAND2X1 U666 ( .A(n587), .B(n591), .Y(n594) );
  NAND3X1 U667 ( .A(n489), .B(n595), .C(N1354), .Y(n591) );
  NAND3X1 U668 ( .A(n490), .B(n596), .C(N1257), .Y(n587) );
  AND2X1 U669 ( .A(n597), .B(n491), .Y(n592) );
  NAND2X1 U670 ( .A(n12), .B(n10), .Y(n487) );
  NAND2X1 U671 ( .A(n598), .B(n599), .Y(n741) );
  AOI21X1 U672 ( .A(n600), .B(n449), .C(n601), .Y(n599) );
  OAI22X1 U673 ( .A(n452), .B(n602), .C(n454), .D(n603), .Y(n601) );
  AOI22X1 U674 ( .A(\data[2][3] ), .B(n604), .C(n605), .D(n457), .Y(n598) );
  NAND2X1 U675 ( .A(n606), .B(n607), .Y(n740) );
  AOI21X1 U676 ( .A(n600), .B(n461), .C(n608), .Y(n607) );
  OAI22X1 U677 ( .A(n463), .B(n602), .C(n464), .D(n603), .Y(n608) );
  AOI22X1 U678 ( .A(\data[2][2] ), .B(n604), .C(n605), .D(n465), .Y(n606) );
  NAND2X1 U679 ( .A(n609), .B(n610), .Y(n739) );
  AOI21X1 U680 ( .A(n600), .B(n468), .C(n611), .Y(n610) );
  OAI22X1 U681 ( .A(n470), .B(n602), .C(n471), .D(n603), .Y(n611) );
  AOI22X1 U682 ( .A(\data[2][1] ), .B(n604), .C(n605), .D(n472), .Y(n609) );
  NAND2X1 U683 ( .A(n612), .B(n613), .Y(n738) );
  AOI21X1 U684 ( .A(n600), .B(n475), .C(n614), .Y(n613) );
  OAI22X1 U685 ( .A(n477), .B(n602), .C(n478), .D(n603), .Y(n614) );
  NAND2X1 U686 ( .A(n615), .B(n616), .Y(n602) );
  AND2X1 U687 ( .A(n617), .B(n618), .Y(n600) );
  AOI22X1 U688 ( .A(\data[2][0] ), .B(n604), .C(n605), .D(n485), .Y(n612) );
  INVX1 U689 ( .A(n618), .Y(n605) );
  INVX1 U690 ( .A(n615), .Y(n604) );
  OAI21X1 U691 ( .A(n593), .B(n514), .C(n616), .Y(n615) );
  OAI21X1 U692 ( .A(n617), .B(n619), .C(n13), .Y(n616) );
  NAND2X1 U693 ( .A(n603), .B(n618), .Y(n619) );
  NAND3X1 U694 ( .A(N1354), .B(n595), .C(n516), .Y(n618) );
  NAND3X1 U695 ( .A(n596), .B(n11), .C(n490), .Y(n603) );
  AND2X1 U696 ( .A(N1258), .B(n620), .Y(n490) );
  AND2X1 U697 ( .A(n597), .B(n517), .Y(n617) );
  NOR2X1 U698 ( .A(n430), .B(N387), .Y(n597) );
  INVX1 U699 ( .A(N386), .Y(n430) );
  NAND2X1 U700 ( .A(n10), .B(n11), .Y(n514) );
  NAND2X1 U701 ( .A(n621), .B(n622), .Y(n737) );
  AOI21X1 U702 ( .A(n623), .B(n449), .C(n624), .Y(n622) );
  OAI22X1 U703 ( .A(n452), .B(n625), .C(n454), .D(n626), .Y(n624) );
  AOI22X1 U704 ( .A(\data[1][3] ), .B(n627), .C(n628), .D(n457), .Y(n621) );
  NAND2X1 U705 ( .A(n629), .B(n630), .Y(n736) );
  AOI21X1 U706 ( .A(n623), .B(n461), .C(n631), .Y(n630) );
  OAI22X1 U707 ( .A(n463), .B(n625), .C(n464), .D(n626), .Y(n631) );
  AOI22X1 U708 ( .A(\data[1][2] ), .B(n627), .C(n628), .D(n465), .Y(n629) );
  NAND2X1 U709 ( .A(n632), .B(n633), .Y(n735) );
  AOI21X1 U710 ( .A(n623), .B(n468), .C(n634), .Y(n633) );
  OAI22X1 U711 ( .A(n470), .B(n625), .C(n471), .D(n626), .Y(n634) );
  AOI22X1 U712 ( .A(\data[1][1] ), .B(n627), .C(n628), .D(n472), .Y(n632) );
  NAND2X1 U713 ( .A(n635), .B(n636), .Y(n734) );
  AOI21X1 U714 ( .A(n623), .B(n475), .C(n637), .Y(n636) );
  OAI22X1 U715 ( .A(n477), .B(n625), .C(n478), .D(n626), .Y(n637) );
  OR2X1 U716 ( .A(n638), .B(n628), .Y(n626) );
  NAND2X1 U717 ( .A(n639), .B(n640), .Y(n625) );
  INVX1 U718 ( .A(n641), .Y(n623) );
  NAND3X1 U719 ( .A(n638), .B(n642), .C(n643), .Y(n641) );
  AOI22X1 U720 ( .A(\data[1][0] ), .B(n627), .C(n628), .D(n485), .Y(n635) );
  INVX1 U721 ( .A(n642), .Y(n628) );
  INVX1 U722 ( .A(n639), .Y(n627) );
  OAI21X1 U723 ( .A(n593), .B(n541), .C(n640), .Y(n639) );
  OAI21X1 U724 ( .A(n643), .B(n644), .C(n13), .Y(n640) );
  NAND2X1 U725 ( .A(n638), .B(n642), .Y(n644) );
  NAND3X1 U726 ( .A(n543), .B(n595), .C(n489), .Y(n642) );
  AND2X1 U727 ( .A(N1353), .B(n645), .Y(n489) );
  NAND3X1 U728 ( .A(N1257), .B(n596), .C(n544), .Y(n638) );
  AND2X1 U729 ( .A(n646), .B(n491), .Y(n643) );
  NOR2X1 U730 ( .A(n647), .B(n648), .Y(n491) );
  INVX1 U731 ( .A(N385), .Y(n647) );
  NAND2X1 U732 ( .A(n12), .B(n9), .Y(n541) );
  NAND2X1 U733 ( .A(n649), .B(n650), .Y(n733) );
  AOI21X1 U734 ( .A(n651), .B(n449), .C(n652), .Y(n650) );
  OAI22X1 U735 ( .A(n452), .B(n653), .C(n454), .D(n654), .Y(n652) );
  NAND2X1 U736 ( .A(tx_data[19]), .B(n13), .Y(n454) );
  AOI22X1 U737 ( .A(rx_packet_data[3]), .B(n655), .C(tx_data[3]), .D(n13), .Y(
        n452) );
  AND2X1 U738 ( .A(tx_data[11]), .B(n13), .Y(n449) );
  AOI22X1 U739 ( .A(n656), .B(n457), .C(\data[0][3] ), .D(n657), .Y(n649) );
  AND2X1 U740 ( .A(tx_data[27]), .B(n13), .Y(n457) );
  NAND2X1 U741 ( .A(n658), .B(n659), .Y(n732) );
  AOI21X1 U742 ( .A(n651), .B(n461), .C(n660), .Y(n659) );
  OAI22X1 U743 ( .A(n463), .B(n653), .C(n464), .D(n654), .Y(n660) );
  NAND2X1 U744 ( .A(tx_data[18]), .B(n13), .Y(n464) );
  AOI22X1 U745 ( .A(rx_packet_data[2]), .B(n655), .C(tx_data[2]), .D(n13), .Y(
        n463) );
  AND2X1 U746 ( .A(tx_data[10]), .B(n13), .Y(n461) );
  AOI22X1 U747 ( .A(n656), .B(n465), .C(\data[0][2] ), .D(n657), .Y(n658) );
  AND2X1 U748 ( .A(tx_data[26]), .B(n13), .Y(n465) );
  NAND2X1 U749 ( .A(n661), .B(n662), .Y(n731) );
  AOI21X1 U750 ( .A(n651), .B(n468), .C(n663), .Y(n662) );
  OAI22X1 U751 ( .A(n470), .B(n653), .C(n471), .D(n654), .Y(n663) );
  NAND2X1 U752 ( .A(tx_data[17]), .B(n13), .Y(n471) );
  AOI22X1 U753 ( .A(rx_packet_data[1]), .B(n655), .C(tx_data[1]), .D(n13), .Y(
        n470) );
  AND2X1 U754 ( .A(tx_data[9]), .B(n13), .Y(n468) );
  AOI22X1 U755 ( .A(n656), .B(n472), .C(\data[0][1] ), .D(n657), .Y(n661) );
  AND2X1 U756 ( .A(tx_data[25]), .B(n13), .Y(n472) );
  NAND2X1 U757 ( .A(n664), .B(n665), .Y(n730) );
  AOI21X1 U758 ( .A(n651), .B(n475), .C(n666), .Y(n665) );
  OAI22X1 U759 ( .A(n477), .B(n653), .C(n478), .D(n654), .Y(n666) );
  NAND2X1 U760 ( .A(tx_data[16]), .B(n13), .Y(n478) );
  NAND2X1 U761 ( .A(n667), .B(n668), .Y(n653) );
  AOI22X1 U762 ( .A(rx_packet_data[0]), .B(n655), .C(tx_data[0]), .D(n13), .Y(
        n477) );
  AND2X1 U763 ( .A(tx_data[8]), .B(n13), .Y(n475) );
  AND2X1 U764 ( .A(n669), .B(n670), .Y(n651) );
  AOI22X1 U765 ( .A(\data[0][0] ), .B(n657), .C(n656), .D(n485), .Y(n664) );
  AND2X1 U766 ( .A(tx_data[24]), .B(n13), .Y(n485) );
  INVX1 U767 ( .A(n670), .Y(n656) );
  INVX1 U768 ( .A(n667), .Y(n657) );
  OAI21X1 U769 ( .A(n593), .B(n567), .C(n668), .Y(n667) );
  OAI21X1 U770 ( .A(n669), .B(n671), .C(n13), .Y(n668) );
  NAND2X1 U771 ( .A(n654), .B(n670), .Y(n671) );
  NAND3X1 U772 ( .A(n543), .B(n595), .C(n516), .Y(n670) );
  AND2X1 U773 ( .A(n645), .B(n12), .Y(n516) );
  AND2X1 U774 ( .A(n672), .B(n673), .Y(n645) );
  NOR2X1 U775 ( .A(n674), .B(n675), .Y(n673) );
  NAND3X1 U776 ( .A(n676), .B(n677), .C(n678), .Y(n675) );
  NOR2X1 U777 ( .A(N1370), .B(n679), .Y(n678) );
  OR2X1 U778 ( .A(N1372), .B(N1371), .Y(n679) );
  NOR2X1 U779 ( .A(N1376), .B(N1375), .Y(n677) );
  NOR2X1 U780 ( .A(N1374), .B(N1373), .Y(n676) );
  NAND3X1 U781 ( .A(n680), .B(n681), .C(n682), .Y(n674) );
  AND2X1 U782 ( .A(n683), .B(n684), .Y(n682) );
  NOR2X1 U783 ( .A(N1384), .B(N1383), .Y(n684) );
  NOR2X1 U784 ( .A(N1382), .B(N1381), .Y(n683) );
  NOR2X1 U785 ( .A(N1380), .B(N1379), .Y(n681) );
  NOR2X1 U786 ( .A(N1378), .B(N1377), .Y(n680) );
  NOR2X1 U787 ( .A(n685), .B(n686), .Y(n672) );
  NAND3X1 U788 ( .A(n687), .B(n688), .C(n689), .Y(n686) );
  NOR2X1 U789 ( .A(N1356), .B(n690), .Y(n689) );
  OR2X1 U790 ( .A(N1358), .B(N1357), .Y(n690) );
  NOR2X1 U791 ( .A(N1362), .B(N1361), .Y(n688) );
  NOR2X1 U792 ( .A(N1360), .B(N1359), .Y(n687) );
  NAND3X1 U793 ( .A(n691), .B(n692), .C(n693), .Y(n685) );
  NOR2X1 U794 ( .A(N1363), .B(n694), .Y(n693) );
  OR2X1 U795 ( .A(N1365), .B(N1364), .Y(n694) );
  NOR2X1 U796 ( .A(N1369), .B(N1368), .Y(n692) );
  NOR2X1 U797 ( .A(N1367), .B(N1366), .Y(n691) );
  INVX1 U798 ( .A(N1355), .Y(n595) );
  INVX1 U799 ( .A(N1354), .Y(n543) );
  NAND3X1 U800 ( .A(n596), .B(n11), .C(n544), .Y(n654) );
  AND2X1 U801 ( .A(n620), .B(n10), .Y(n544) );
  AND2X1 U802 ( .A(n695), .B(n696), .Y(n620) );
  NOR2X1 U803 ( .A(n697), .B(n698), .Y(n696) );
  NAND3X1 U804 ( .A(n699), .B(n700), .C(n701), .Y(n698) );
  NOR2X1 U805 ( .A(N1274), .B(n702), .Y(n701) );
  OR2X1 U806 ( .A(N1276), .B(N1275), .Y(n702) );
  NOR2X1 U807 ( .A(N1280), .B(N1279), .Y(n700) );
  NOR2X1 U808 ( .A(N1278), .B(N1277), .Y(n699) );
  NAND3X1 U809 ( .A(n703), .B(n704), .C(n705), .Y(n697) );
  AND2X1 U810 ( .A(n706), .B(n707), .Y(n705) );
  NOR2X1 U811 ( .A(N1288), .B(N1287), .Y(n707) );
  NOR2X1 U812 ( .A(N1286), .B(N1285), .Y(n706) );
  NOR2X1 U813 ( .A(N1284), .B(N1283), .Y(n704) );
  NOR2X1 U814 ( .A(N1282), .B(N1281), .Y(n703) );
  NOR2X1 U815 ( .A(n708), .B(n709), .Y(n695) );
  NAND3X1 U816 ( .A(n710), .B(n711), .C(n712), .Y(n709) );
  NOR2X1 U817 ( .A(N1260), .B(n713), .Y(n712) );
  OR2X1 U818 ( .A(N1262), .B(N1261), .Y(n713) );
  NOR2X1 U819 ( .A(N1266), .B(N1265), .Y(n711) );
  NOR2X1 U820 ( .A(N1264), .B(N1263), .Y(n710) );
  NAND3X1 U821 ( .A(n714), .B(n715), .C(n716), .Y(n708) );
  NOR2X1 U822 ( .A(N1267), .B(n717), .Y(n716) );
  OR2X1 U823 ( .A(N1269), .B(N1268), .Y(n717) );
  NOR2X1 U824 ( .A(N1273), .B(N1272), .Y(n715) );
  NOR2X1 U825 ( .A(N1271), .B(N1270), .Y(n714) );
  INVX1 U826 ( .A(N1259), .Y(n596) );
  AND2X1 U827 ( .A(n646), .B(n517), .Y(n669) );
  NOR2X1 U828 ( .A(n648), .B(n11), .Y(n517) );
  NAND3X1 U829 ( .A(n718), .B(n719), .C(n720), .Y(n648) );
  AND2X1 U830 ( .A(n721), .B(n722), .Y(n720) );
  NOR2X1 U831 ( .A(n723), .B(n724), .Y(n722) );
  NAND3X1 U832 ( .A(n425), .B(n424), .C(n725), .Y(n724) );
  NOR2X1 U833 ( .A(N412), .B(N411), .Y(n725) );
  INVX1 U834 ( .A(N410), .Y(n424) );
  INVX1 U835 ( .A(N409), .Y(n425) );
  NAND3X1 U836 ( .A(n421), .B(n420), .C(n726), .Y(n723) );
  NOR2X1 U837 ( .A(N416), .B(N415), .Y(n726) );
  INVX1 U838 ( .A(N414), .Y(n420) );
  INVX1 U839 ( .A(N413), .Y(n421) );
  NOR2X1 U840 ( .A(n727), .B(n728), .Y(n721) );
  NAND3X1 U841 ( .A(n432), .B(n431), .C(n433), .Y(n728) );
  INVX1 U842 ( .A(N402), .Y(n433) );
  INVX1 U843 ( .A(N404), .Y(n431) );
  INVX1 U844 ( .A(N403), .Y(n432) );
  NAND3X1 U845 ( .A(n429), .B(n428), .C(n729), .Y(n727) );
  NOR2X1 U846 ( .A(N408), .B(N407), .Y(n729) );
  INVX1 U847 ( .A(N406), .Y(n428) );
  INVX1 U848 ( .A(N405), .Y(n429) );
  NOR2X1 U849 ( .A(n762), .B(n763), .Y(n719) );
  NAND3X1 U850 ( .A(n439), .B(n438), .C(n440), .Y(n763) );
  INVX1 U851 ( .A(N395), .Y(n440) );
  INVX1 U852 ( .A(N397), .Y(n438) );
  INVX1 U853 ( .A(N396), .Y(n439) );
  NAND3X1 U854 ( .A(n437), .B(n436), .C(n764), .Y(n762) );
  NOR2X1 U855 ( .A(N401), .B(N400), .Y(n764) );
  INVX1 U856 ( .A(N399), .Y(n436) );
  INVX1 U857 ( .A(N398), .Y(n437) );
  NOR2X1 U858 ( .A(n765), .B(n766), .Y(n718) );
  NAND3X1 U859 ( .A(n415), .B(n414), .C(n416), .Y(n766) );
  INVX1 U860 ( .A(N388), .Y(n416) );
  INVX1 U861 ( .A(N390), .Y(n414) );
  INVX1 U862 ( .A(N389), .Y(n415) );
  NAND3X1 U863 ( .A(n413), .B(n412), .C(n767), .Y(n765) );
  NOR2X1 U864 ( .A(N394), .B(N393), .Y(n767) );
  INVX1 U865 ( .A(N392), .Y(n412) );
  INVX1 U866 ( .A(N391), .Y(n413) );
  NOR2X1 U867 ( .A(N387), .B(N386), .Y(n646) );
  NAND2X1 U868 ( .A(n11), .B(n9), .Y(n567) );
  NAND2X1 U869 ( .A(n569), .B(n768), .Y(n593) );
  INVX1 U870 ( .A(n769), .Y(n569) );
  NAND3X1 U871 ( .A(n770), .B(n771), .C(n772), .Y(n769) );
  AND2X1 U872 ( .A(n773), .B(n774), .Y(n772) );
  NOR2X1 U873 ( .A(n775), .B(n776), .Y(n774) );
  NAND3X1 U874 ( .A(n777), .B(n778), .C(n779), .Y(n776) );
  NOR2X1 U875 ( .A(count1[5]), .B(count1[4]), .Y(n779) );
  NAND3X1 U876 ( .A(n780), .B(n781), .C(n782), .Y(n775) );
  NOR2X1 U877 ( .A(count1[9]), .B(count1[8]), .Y(n782) );
  NOR2X1 U878 ( .A(n783), .B(n784), .Y(n773) );
  NAND3X1 U879 ( .A(n785), .B(n786), .C(n787), .Y(n784) );
  NAND3X1 U880 ( .A(n788), .B(n789), .C(n790), .Y(n783) );
  NOR2X1 U881 ( .A(count1[30]), .B(count1[29]), .Y(n790) );
  NOR2X1 U882 ( .A(n791), .B(n792), .Y(n771) );
  NAND3X1 U883 ( .A(n793), .B(n794), .C(n795), .Y(n792) );
  NOR2X1 U884 ( .A(count1[19]), .B(count1[18]), .Y(n795) );
  NAND3X1 U885 ( .A(n796), .B(n797), .C(n798), .Y(n791) );
  NOR2X1 U886 ( .A(count1[23]), .B(count1[22]), .Y(n798) );
  NOR2X1 U887 ( .A(n799), .B(n800), .Y(n770) );
  OAI21X1 U888 ( .A(n13), .B(n655), .C(n801), .Y(n800) );
  NOR2X1 U889 ( .A(count1[11]), .B(count1[10]), .Y(n801) );
  INVX1 U890 ( .A(n409), .Y(n655) );
  NAND3X1 U891 ( .A(n802), .B(n407), .C(state[1]), .Y(n409) );
  NAND3X1 U892 ( .A(n803), .B(n804), .C(n805), .Y(n799) );
  NOR2X1 U893 ( .A(count1[15]), .B(count1[14]), .Y(n805) );
  OAI21X1 U894 ( .A(n14), .B(n806), .C(n807), .Y(\U3/U1/Z_9 ) );
  NAND2X1 U895 ( .A(count2[9]), .B(n808), .Y(n807) );
  INVX1 U896 ( .A(count1[9]), .Y(n806) );
  OAI21X1 U897 ( .A(n14), .B(n809), .C(n810), .Y(\U3/U1/Z_8 ) );
  NAND2X1 U898 ( .A(count2[8]), .B(n808), .Y(n810) );
  INVX1 U899 ( .A(count1[8]), .Y(n809) );
  OAI21X1 U900 ( .A(n14), .B(n781), .C(n811), .Y(\U3/U1/Z_7 ) );
  NAND2X1 U901 ( .A(count2[7]), .B(n808), .Y(n811) );
  INVX1 U902 ( .A(count1[7]), .Y(n781) );
  OAI21X1 U903 ( .A(n14), .B(n780), .C(n812), .Y(\U3/U1/Z_6 ) );
  NAND2X1 U904 ( .A(count2[6]), .B(n808), .Y(n812) );
  INVX1 U905 ( .A(count1[6]), .Y(n780) );
  OAI21X1 U906 ( .A(n14), .B(n813), .C(n814), .Y(\U3/U1/Z_5 ) );
  NAND2X1 U907 ( .A(count2[5]), .B(n808), .Y(n814) );
  INVX1 U908 ( .A(count1[5]), .Y(n813) );
  OAI21X1 U909 ( .A(n14), .B(n815), .C(n816), .Y(\U3/U1/Z_4 ) );
  NAND2X1 U910 ( .A(count2[4]), .B(n808), .Y(n816) );
  INVX1 U911 ( .A(count1[4]), .Y(n815) );
  OAI21X1 U912 ( .A(n14), .B(n777), .C(n817), .Y(\U3/U1/Z_31 ) );
  NAND2X1 U913 ( .A(count2[31]), .B(n808), .Y(n817) );
  INVX1 U914 ( .A(count1[31]), .Y(n777) );
  OAI21X1 U915 ( .A(n14), .B(n818), .C(n819), .Y(\U3/U1/Z_30 ) );
  NAND2X1 U916 ( .A(count2[30]), .B(n808), .Y(n819) );
  INVX1 U917 ( .A(count1[30]), .Y(n818) );
  OAI21X1 U918 ( .A(n14), .B(n778), .C(n820), .Y(\U3/U1/Z_3 ) );
  NAND2X1 U919 ( .A(count2[3]), .B(n808), .Y(n820) );
  INVX1 U920 ( .A(count1[3]), .Y(n778) );
  OAI21X1 U921 ( .A(n14), .B(n821), .C(n822), .Y(\U3/U1/Z_29 ) );
  NAND2X1 U922 ( .A(count2[29]), .B(n808), .Y(n822) );
  INVX1 U923 ( .A(count1[29]), .Y(n821) );
  OAI21X1 U924 ( .A(n14), .B(n789), .C(n823), .Y(\U3/U1/Z_28 ) );
  NAND2X1 U925 ( .A(count2[28]), .B(n808), .Y(n823) );
  INVX1 U926 ( .A(count1[28]), .Y(n789) );
  OAI21X1 U927 ( .A(n14), .B(n788), .C(n824), .Y(\U3/U1/Z_27 ) );
  NAND2X1 U928 ( .A(count2[27]), .B(n808), .Y(n824) );
  INVX1 U929 ( .A(count1[27]), .Y(n788) );
  OAI21X1 U930 ( .A(n14), .B(n786), .C(n825), .Y(\U3/U1/Z_26 ) );
  NAND2X1 U931 ( .A(count2[26]), .B(n808), .Y(n825) );
  INVX1 U932 ( .A(count1[26]), .Y(n786) );
  OAI21X1 U933 ( .A(n14), .B(n785), .C(n826), .Y(\U3/U1/Z_25 ) );
  NAND2X1 U934 ( .A(count2[25]), .B(n808), .Y(n826) );
  INVX1 U935 ( .A(count1[25]), .Y(n785) );
  OAI21X1 U936 ( .A(n14), .B(n787), .C(n827), .Y(\U3/U1/Z_24 ) );
  NAND2X1 U937 ( .A(count2[24]), .B(n808), .Y(n827) );
  INVX1 U938 ( .A(count1[24]), .Y(n787) );
  OAI21X1 U939 ( .A(n14), .B(n828), .C(n829), .Y(\U3/U1/Z_23 ) );
  NAND2X1 U940 ( .A(count2[23]), .B(n808), .Y(n829) );
  INVX1 U941 ( .A(count1[23]), .Y(n828) );
  OAI21X1 U942 ( .A(n14), .B(n830), .C(n831), .Y(\U3/U1/Z_22 ) );
  NAND2X1 U943 ( .A(count2[22]), .B(n808), .Y(n831) );
  INVX1 U944 ( .A(count1[22]), .Y(n830) );
  OAI21X1 U945 ( .A(n14), .B(n797), .C(n832), .Y(\U3/U1/Z_21 ) );
  NAND2X1 U946 ( .A(count2[21]), .B(n808), .Y(n832) );
  INVX1 U947 ( .A(count1[21]), .Y(n797) );
  OAI21X1 U948 ( .A(n14), .B(n796), .C(n833), .Y(\U3/U1/Z_20 ) );
  NAND2X1 U949 ( .A(count2[20]), .B(n808), .Y(n833) );
  INVX1 U950 ( .A(count1[20]), .Y(n796) );
  OAI22X1 U951 ( .A(n14), .B(n768), .C(n342), .D(n834), .Y(\U3/U1/Z_2 ) );
  INVX1 U952 ( .A(count1[2]), .Y(n768) );
  OAI21X1 U953 ( .A(n14), .B(n835), .C(n836), .Y(\U3/U1/Z_19 ) );
  NAND2X1 U954 ( .A(count2[19]), .B(n808), .Y(n836) );
  INVX1 U955 ( .A(count1[19]), .Y(n835) );
  OAI21X1 U956 ( .A(n14), .B(n837), .C(n838), .Y(\U3/U1/Z_18 ) );
  NAND2X1 U957 ( .A(count2[18]), .B(n808), .Y(n838) );
  INVX1 U958 ( .A(count1[18]), .Y(n837) );
  OAI21X1 U959 ( .A(n14), .B(n794), .C(n839), .Y(\U3/U1/Z_17 ) );
  NAND2X1 U960 ( .A(count2[17]), .B(n808), .Y(n839) );
  INVX1 U961 ( .A(count1[17]), .Y(n794) );
  OAI21X1 U962 ( .A(n14), .B(n793), .C(n840), .Y(\U3/U1/Z_16 ) );
  NAND2X1 U963 ( .A(count2[16]), .B(n808), .Y(n840) );
  INVX1 U964 ( .A(count1[16]), .Y(n793) );
  OAI21X1 U965 ( .A(n14), .B(n841), .C(n842), .Y(\U3/U1/Z_15 ) );
  NAND2X1 U966 ( .A(count2[15]), .B(n808), .Y(n842) );
  INVX1 U967 ( .A(count1[15]), .Y(n841) );
  OAI21X1 U968 ( .A(n14), .B(n843), .C(n844), .Y(\U3/U1/Z_14 ) );
  NAND2X1 U969 ( .A(count2[14]), .B(n808), .Y(n844) );
  INVX1 U970 ( .A(count1[14]), .Y(n843) );
  OAI21X1 U971 ( .A(n14), .B(n804), .C(n845), .Y(\U3/U1/Z_13 ) );
  NAND2X1 U972 ( .A(count2[13]), .B(n808), .Y(n845) );
  INVX1 U973 ( .A(count1[13]), .Y(n804) );
  OAI21X1 U974 ( .A(n14), .B(n803), .C(n846), .Y(\U3/U1/Z_12 ) );
  NAND2X1 U975 ( .A(count2[12]), .B(n808), .Y(n846) );
  INVX1 U976 ( .A(count1[12]), .Y(n803) );
  OAI21X1 U977 ( .A(n14), .B(n847), .C(n848), .Y(\U3/U1/Z_11 ) );
  NAND2X1 U978 ( .A(count2[11]), .B(n808), .Y(n848) );
  INVX1 U979 ( .A(count1[11]), .Y(n847) );
  OAI21X1 U980 ( .A(n14), .B(n849), .C(n850), .Y(\U3/U1/Z_10 ) );
  NAND2X1 U981 ( .A(count2[10]), .B(n808), .Y(n850) );
  INVX1 U982 ( .A(count1[10]), .Y(n849) );
  OAI22X1 U983 ( .A(n14), .B(n9), .C(n860), .D(n342), .Y(\U3/U1/Z_1 ) );
  OAI22X1 U984 ( .A(n14), .B(n11), .C(n858), .D(n342), .Y(\U3/U1/Z_0 ) );
  NAND3X1 U985 ( .A(n446), .B(n334), .C(n333), .Y(n342) );
  INVX1 U986 ( .A(n328), .Y(n333) );
  NAND3X1 U987 ( .A(n802), .B(n851), .C(state[2]), .Y(n328) );
  INVX1 U988 ( .A(state[0]), .Y(n802) );
  INVX1 U989 ( .A(data_size[1]), .Y(n334) );
  INVX1 U990 ( .A(data_size[0]), .Y(n446) );
  NAND3X1 U991 ( .A(n851), .B(n407), .C(state[0]), .Y(n408) );
  INVX1 U992 ( .A(state[2]), .Y(n407) );
  INVX1 U993 ( .A(state[1]), .Y(n851) );
  XOR2X1 U994 ( .A(n834), .B(n852), .Y(N262) );
  NOR2X1 U995 ( .A(n206), .B(N255), .Y(n852) );
  XOR2X1 U996 ( .A(N244), .B(N243), .Y(N259) );
  XOR2X1 U997 ( .A(n834), .B(n853), .Y(N256) );
  NAND2X1 U998 ( .A(N243), .B(n206), .Y(n853) );
  INVX1 U999 ( .A(N244), .Y(n834) );
  XNOR2X1 U1000 ( .A(n860), .B(N257), .Y(N255) );
  INVX1 U1001 ( .A(N243), .Y(n860) );
endmodule


module pc_db_top ( clk, n_rst, rx_data_ready, rx_transfer_active, rx_error, 
        tx_transfer_active, tx_error, buffer_reserved, tx_packet_data_size, 
        buffer_occupancy, rx_data, get_rx_data, store_tx_data, tx_data, 
        data_size, tx_packet_data, get_tx_packet_data, rx_packet_data, 
        store_rx_packet_data, tx_packet, d_mode, rx_packet, tx_status );
  input [6:0] tx_packet_data_size;
  output [6:0] buffer_occupancy;
  output [31:0] rx_data;
  input [31:0] tx_data;
  input [1:0] data_size;
  output [7:0] tx_packet_data;
  input [7:0] rx_packet_data;
  output [1:0] tx_packet;
  input [2:0] rx_packet;
  input clk, n_rst, buffer_reserved, get_rx_data, store_tx_data,
         get_tx_packet_data, store_rx_packet_data, tx_status;
  output rx_data_ready, rx_transfer_active, rx_error, tx_transfer_active,
         tx_error, d_mode;
  wire   clear;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7, 
        SYNOPSYS_UNCONNECTED__8, SYNOPSYS_UNCONNECTED__9, 
        SYNOPSYS_UNCONNECTED__10, SYNOPSYS_UNCONNECTED__11, 
        SYNOPSYS_UNCONNECTED__12, SYNOPSYS_UNCONNECTED__13, 
        SYNOPSYS_UNCONNECTED__14, SYNOPSYS_UNCONNECTED__15, 
        SYNOPSYS_UNCONNECTED__16, SYNOPSYS_UNCONNECTED__17, 
        SYNOPSYS_UNCONNECTED__18, SYNOPSYS_UNCONNECTED__19;
  assign tx_transfer_active = 1'b0;
  assign rx_data[31] = 1'b0;
  assign rx_data[30] = 1'b0;
  assign rx_data[29] = 1'b0;
  assign rx_data[28] = 1'b0;
  assign rx_data[23] = 1'b0;
  assign rx_data[22] = 1'b0;
  assign rx_data[21] = 1'b0;
  assign rx_data[20] = 1'b0;
  assign rx_data[15] = 1'b0;
  assign rx_data[14] = 1'b0;
  assign rx_data[13] = 1'b0;
  assign rx_data[12] = 1'b0;
  assign rx_data[7] = 1'b0;
  assign rx_data[6] = 1'b0;
  assign rx_data[5] = 1'b0;
  assign rx_data[4] = 1'b0;
  assign tx_packet_data[7] = 1'b0;
  assign tx_packet_data[6] = 1'b0;
  assign tx_packet_data[5] = 1'b0;
  assign tx_packet_data[4] = 1'b0;

  protocol_controller pc ( .clk(clk), .n_rst(n_rst), .rx_packet(rx_packet), 
        .buffer_reserved(buffer_reserved), .tx_packet_data_size(
        tx_packet_data_size), .buffer_occupancy(buffer_occupancy), .tx_status(
        tx_status), .rx_data_ready(rx_data_ready), .rx_transfer_active(
        rx_transfer_active), .rx_error(rx_error), .tx_error(tx_error), 
        .d_mode(d_mode), .tx_packet(tx_packet), .clear(clear) );
  data_buffer db ( .clk(clk), .n_rst(n_rst), .clear(clear), .get_rx_data(
        get_rx_data), .store_tx_data(store_tx_data), .tx_data(tx_data), 
        .data_size(data_size), .get_tx_packet_data(get_tx_packet_data), 
        .rx_packet_data(rx_packet_data), .store_rx_packet_data(
        store_rx_packet_data), .buffer_occupancy(buffer_occupancy), .rx_data({
        SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, rx_data[27:24], 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7, rx_data[19:16], 
        SYNOPSYS_UNCONNECTED__8, SYNOPSYS_UNCONNECTED__9, 
        SYNOPSYS_UNCONNECTED__10, SYNOPSYS_UNCONNECTED__11, rx_data[11:8], 
        SYNOPSYS_UNCONNECTED__12, SYNOPSYS_UNCONNECTED__13, 
        SYNOPSYS_UNCONNECTED__14, SYNOPSYS_UNCONNECTED__15, rx_data[3:0]}), 
        .tx_packet_data({SYNOPSYS_UNCONNECTED__16, SYNOPSYS_UNCONNECTED__17, 
        SYNOPSYS_UNCONNECTED__18, SYNOPSYS_UNCONNECTED__19, 
        tx_packet_data[3:0]}) );
endmodule

