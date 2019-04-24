/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Wed Apr 24 11:04:42 2019
/////////////////////////////////////////////////////////////


module decoder ( clk, n_rst, d_plus_in, d_minus_in, start, d_decoded, eop );
  input clk, n_rst, d_plus_in, d_minus_in;
  output start, d_decoded, eop;
  wire   next_decoded, N43, n3, n4, n5, n6, n7, n30, n31, n32, n33, n34, n35,
         n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49,
         n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n1,
         n2, n8, n9, n15, n16, n17, n18, n19, n21, n22, n23, n24, n25, n26;
  wire   [2:0] state;

  DFFSR \state_reg[0]  ( .D(n62), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0])
         );
  DFFSR start_reg ( .D(n59), .CLK(clk), .R(n_rst), .S(1'b1), .Q(start) );
  DFFSR \state_reg[2]  ( .D(n61), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[2])
         );
  DFFSR \state_reg[1]  ( .D(n60), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1])
         );
  DFFSR d_decoded_reg ( .D(n16), .CLK(clk), .R(n_rst), .S(1'b1), .Q(d_decoded)
         );
  NAND2X1 U3 ( .A(state[2]), .B(n23), .Y(n3) );
  XOR2X1 U4 ( .A(n3), .B(state[0]), .Y(n7) );
  NAND2X1 U5 ( .A(state[2]), .B(state[1]), .Y(n4) );
  AOI22X1 U6 ( .A(d_decoded), .B(n22), .C(N43), .D(n4), .Y(n6) );
  NAND2X1 U7 ( .A(n25), .B(n7), .Y(n5) );
  OAI21X1 U8 ( .A(n7), .B(n6), .C(n5), .Y(next_decoded) );
  AND2X2 U16 ( .A(n43), .B(n44), .Y(n42) );
  AOI22X1 U32 ( .A(d_decoded), .B(n17), .C(next_decoded), .D(n31), .Y(n30) );
  OAI21X1 U33 ( .A(n32), .B(n33), .C(n34), .Y(n31) );
  AOI21X1 U34 ( .A(n34), .B(n32), .C(n33), .Y(n35) );
  NAND3X1 U35 ( .A(state[0]), .B(state[1]), .C(state[2]), .Y(n34) );
  OAI21X1 U36 ( .A(n32), .B(n36), .C(n37), .Y(n59) );
  NAND2X1 U37 ( .A(start), .B(n36), .Y(n37) );
  NAND2X1 U38 ( .A(n1), .B(n38), .Y(n60) );
  AOI22X1 U39 ( .A(state[1]), .B(n39), .C(n18), .D(n25), .Y(n38) );
  OAI21X1 U40 ( .A(n9), .B(n41), .C(n42), .Y(n40) );
  NAND2X1 U41 ( .A(n45), .B(n46), .Y(n61) );
  AOI21X1 U42 ( .A(n19), .B(n25), .C(n47), .Y(n46) );
  OAI21X1 U43 ( .A(n32), .B(n48), .C(n43), .Y(n47) );
  AOI22X1 U44 ( .A(N43), .B(n8), .C(n39), .D(state[2]), .Y(n45) );
  OR2X1 U45 ( .A(n49), .B(n50), .Y(n62) );
  OAI21X1 U46 ( .A(n36), .B(n51), .C(n52), .Y(n50) );
  OAI21X1 U47 ( .A(n39), .B(n2), .C(state[0]), .Y(n52) );
  NAND3X1 U48 ( .A(n53), .B(n44), .C(n9), .Y(n43) );
  NAND3X1 U49 ( .A(n48), .B(n55), .C(n36), .Y(n54) );
  NOR2X1 U50 ( .A(n24), .B(n56), .Y(n39) );
  OAI21X1 U51 ( .A(n19), .B(n18), .C(n41), .Y(n56) );
  OR2X1 U52 ( .A(d_minus_in), .B(d_plus_in), .Y(n41) );
  NAND2X1 U53 ( .A(state[2]), .B(n57), .Y(n48) );
  XOR2X1 U54 ( .A(state[1]), .B(state[0]), .Y(n57) );
  NAND3X1 U55 ( .A(n23), .B(n21), .C(n15), .Y(n36) );
  OAI21X1 U56 ( .A(n32), .B(n55), .C(n44), .Y(n49) );
  NAND2X1 U57 ( .A(n33), .B(n15), .Y(n44) );
  NAND2X1 U58 ( .A(n58), .B(n23), .Y(n55) );
  XOR2X1 U59 ( .A(state[2]), .B(state[0]), .Y(n58) );
  NOR2X1 U60 ( .A(n25), .B(N43), .Y(n32) );
  NAND2X1 U61 ( .A(n33), .B(state[0]), .Y(n53) );
  NOR2X1 U62 ( .A(n23), .B(state[2]), .Y(n33) );
  NAND2X1 U63 ( .A(d_plus_in), .B(n26), .Y(n51) );
  NOR2X1 U64 ( .A(n26), .B(d_plus_in), .Y(N43) );
  INVX2 U9 ( .A(n40), .Y(n1) );
  INVX2 U10 ( .A(n43), .Y(n2) );
  INVX2 U17 ( .A(n36), .Y(n8) );
  INVX2 U18 ( .A(n54), .Y(n9) );
  INVX2 U19 ( .A(state[0]), .Y(n15) );
  INVX2 U20 ( .A(n30), .Y(n16) );
  INVX2 U21 ( .A(n35), .Y(n17) );
  INVX2 U22 ( .A(n48), .Y(n18) );
  INVX2 U23 ( .A(n55), .Y(n19) );
  INVX2 U24 ( .A(n53), .Y(eop) );
  INVX2 U25 ( .A(state[2]), .Y(n21) );
  INVX2 U26 ( .A(n4), .Y(n22) );
  INVX2 U27 ( .A(state[1]), .Y(n23) );
  INVX2 U28 ( .A(n32), .Y(n24) );
  INVX2 U29 ( .A(n51), .Y(n25) );
  INVX2 U30 ( .A(d_minus_in), .Y(n26) );
endmodule


module crc_checker_5bit ( clk, nRst, din, clear, crcError );
  input clk, nRst, din, clear;
  output crcError;
  wire   N3, N4, N5, N6, N7, N8, n14, n15, n16, n17, n7, n8, n9, n10, n11, n12,
         n13;
  wire   [5:0] q;

  DFFSR \q_reg[0]  ( .D(N3), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[0]) );
  DFFSR \q_reg[1]  ( .D(N4), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[1]) );
  DFFSR \q_reg[2]  ( .D(N5), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[2]) );
  DFFSR \q_reg[3]  ( .D(N6), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[3]) );
  DFFSR \q_reg[4]  ( .D(N7), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[4]) );
  DFFSR \q_reg[5]  ( .D(N8), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[5]) );
  OR2X1 U16 ( .A(n14), .B(n15), .Y(crcError) );
  NAND3X1 U17 ( .A(n8), .B(n9), .C(n7), .Y(n15) );
  NAND3X1 U18 ( .A(n11), .B(n12), .C(n10), .Y(n14) );
  NOR2X1 U19 ( .A(clear), .B(n11), .Y(N8) );
  NOR2X1 U20 ( .A(clear), .B(n10), .Y(N7) );
  NOR2X1 U21 ( .A(clear), .B(n16), .Y(N6) );
  XNOR2X1 U22 ( .A(q[2]), .B(q[5]), .Y(n16) );
  NOR2X1 U23 ( .A(clear), .B(n8), .Y(N5) );
  NOR2X1 U24 ( .A(clear), .B(n17), .Y(N4) );
  XNOR2X1 U25 ( .A(q[0]), .B(q[5]), .Y(n17) );
  NOR2X1 U26 ( .A(n13), .B(clear), .Y(N3) );
  INVX2 U9 ( .A(q[0]), .Y(n7) );
  INVX2 U10 ( .A(q[1]), .Y(n8) );
  INVX2 U11 ( .A(q[2]), .Y(n9) );
  INVX2 U12 ( .A(q[3]), .Y(n10) );
  INVX2 U13 ( .A(q[4]), .Y(n11) );
  INVX2 U14 ( .A(q[5]), .Y(n12) );
  INVX2 U15 ( .A(din), .Y(n13) );
endmodule


module crc_checker_16bit ( clk, nRst, din, clear, crcError );
  input clk, nRst, din, clear;
  output crcError;
  wire   N3, N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16, N17,
         N18, N19, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37,
         n38, n39, n18, n19, n20, n21, n22, n23, n24, n25;
  wire   [16:0] q;

  DFFSR \q_reg[0]  ( .D(N3), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[0]) );
  DFFSR \q_reg[1]  ( .D(N4), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[1]) );
  DFFSR \q_reg[2]  ( .D(N5), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[2]) );
  DFFSR \q_reg[3]  ( .D(N6), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[3]) );
  DFFSR \q_reg[4]  ( .D(N7), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[4]) );
  DFFSR \q_reg[5]  ( .D(N8), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[5]) );
  DFFSR \q_reg[6]  ( .D(N9), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[6]) );
  DFFSR \q_reg[7]  ( .D(N10), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[7]) );
  DFFSR \q_reg[8]  ( .D(N11), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[8]) );
  DFFSR \q_reg[9]  ( .D(N12), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[9]) );
  DFFSR \q_reg[10]  ( .D(N13), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[10]) );
  DFFSR \q_reg[11]  ( .D(N14), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[11]) );
  DFFSR \q_reg[12]  ( .D(N15), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[12]) );
  DFFSR \q_reg[13]  ( .D(N16), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[13]) );
  DFFSR \q_reg[14]  ( .D(N17), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[14]) );
  DFFSR \q_reg[15]  ( .D(N18), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[15]) );
  DFFSR \q_reg[16]  ( .D(N19), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[16]) );
  AND2X2 U20 ( .A(n18), .B(q[5]), .Y(N9) );
  AND2X2 U21 ( .A(n18), .B(q[4]), .Y(N8) );
  AND2X2 U22 ( .A(n18), .B(q[3]), .Y(N7) );
  AND2X2 U23 ( .A(din), .B(n18), .Y(N3) );
  AND2X2 U24 ( .A(n18), .B(q[12]), .Y(N16) );
  AND2X2 U25 ( .A(n18), .B(q[11]), .Y(N15) );
  AND2X2 U26 ( .A(n18), .B(q[9]), .Y(N13) );
  AND2X2 U27 ( .A(n18), .B(q[8]), .Y(N12) );
  AND2X2 U28 ( .A(n18), .B(q[6]), .Y(N10) );
  NAND2X1 U37 ( .A(n26), .B(n27), .Y(crcError) );
  NOR2X1 U38 ( .A(n28), .B(n29), .Y(n27) );
  NAND3X1 U39 ( .A(n20), .B(n21), .C(n30), .Y(n29) );
  NOR2X1 U40 ( .A(q[4]), .B(q[3]), .Y(n30) );
  NAND3X1 U41 ( .A(n31), .B(n22), .C(n32), .Y(n28) );
  NOR2X1 U42 ( .A(q[6]), .B(q[5]), .Y(n32) );
  NOR2X1 U43 ( .A(q[9]), .B(q[8]), .Y(n31) );
  NOR2X1 U44 ( .A(n33), .B(n34), .Y(n26) );
  NAND3X1 U45 ( .A(n19), .B(n23), .C(n35), .Y(n34) );
  NOR2X1 U46 ( .A(q[12]), .B(q[11]), .Y(n35) );
  NAND3X1 U47 ( .A(n24), .B(n25), .C(n36), .Y(n33) );
  NOR2X1 U48 ( .A(q[16]), .B(q[15]), .Y(n36) );
  NOR2X1 U49 ( .A(clear), .B(n37), .Y(N6) );
  XNOR2X1 U50 ( .A(q[2]), .B(q[16]), .Y(n37) );
  NOR2X1 U51 ( .A(clear), .B(n20), .Y(N5) );
  NOR2X1 U52 ( .A(clear), .B(n38), .Y(N4) );
  XNOR2X1 U53 ( .A(q[0]), .B(q[16]), .Y(n38) );
  NOR2X1 U54 ( .A(clear), .B(n39), .Y(N19) );
  XNOR2X1 U55 ( .A(q[15]), .B(q[16]), .Y(n39) );
  NOR2X1 U56 ( .A(clear), .B(n25), .Y(N18) );
  NOR2X1 U57 ( .A(clear), .B(n24), .Y(N17) );
  NOR2X1 U58 ( .A(clear), .B(n23), .Y(N14) );
  NOR2X1 U59 ( .A(clear), .B(n22), .Y(N11) );
  INVX2 U29 ( .A(clear), .Y(n18) );
  INVX2 U30 ( .A(q[0]), .Y(n19) );
  INVX2 U31 ( .A(q[1]), .Y(n20) );
  INVX2 U32 ( .A(q[2]), .Y(n21) );
  INVX2 U33 ( .A(q[7]), .Y(n22) );
  INVX2 U34 ( .A(q[10]), .Y(n23) );
  INVX2 U35 ( .A(q[13]), .Y(n24) );
  INVX2 U36 ( .A(q[14]), .Y(n25) );
endmodule


module flex_counter_NUM_CNT_BITS4 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   N5, N6, N7, N8, N9, N10, N11, N12, n19, n20, n21, n22, n23, n24, n25,
         n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, N21, N19, N18,
         \mult_add_41_aco/b , n1, n2, n3, n4, n5, n6, n12, n13, n14, n15, n16,
         n17, n18, n37, n38;

  DFFSR \count_reg[3]  ( .D(n36), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR \count_reg[2]  ( .D(n35), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \count_reg[1]  ( .D(n34), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \count_reg[0]  ( .D(n33), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR r_flag_reg ( .D(n32), .CLK(clk), .R(n_rst), .S(1'b1), .Q(rollover_flag) );
  OAI22X1 U16 ( .A(\mult_add_41_aco/b ), .B(n18), .C(n19), .D(n20), .Y(n32) );
  NAND3X1 U17 ( .A(n21), .B(n22), .C(n23), .Y(n20) );
  XNOR2X1 U18 ( .A(count_out[1]), .B(N9), .Y(n23) );
  XNOR2X1 U19 ( .A(count_out[3]), .B(N11), .Y(n22) );
  XNOR2X1 U20 ( .A(count_out[2]), .B(N10), .Y(n21) );
  NAND2X1 U21 ( .A(n24), .B(n25), .Y(n19) );
  XNOR2X1 U22 ( .A(count_out[0]), .B(N8), .Y(n25) );
  NOR2X1 U23 ( .A(N12), .B(n17), .Y(n24) );
  OAI21X1 U24 ( .A(n16), .B(n18), .C(n27), .Y(n33) );
  NAND2X1 U25 ( .A(n15), .B(n26), .Y(n27) );
  OAI21X1 U26 ( .A(n14), .B(n18), .C(n28), .Y(n34) );
  NAND2X1 U27 ( .A(N5), .B(n26), .Y(n28) );
  OAI21X1 U28 ( .A(n13), .B(n18), .C(n29), .Y(n35) );
  NAND2X1 U29 ( .A(N6), .B(n26), .Y(n29) );
  OAI21X1 U30 ( .A(n12), .B(n18), .C(n30), .Y(n36) );
  NAND2X1 U31 ( .A(N7), .B(n26), .Y(n30) );
  NOR2X1 U32 ( .A(n31), .B(clear), .Y(n26) );
  NOR2X1 U33 ( .A(clear), .B(count_enable), .Y(n31) );
  NAND2X1 U6 ( .A(count_out[2]), .B(\mult_add_41_aco/b ), .Y(n1) );
  AND2X1 U9 ( .A(count_out[0]), .B(\mult_add_41_aco/b ), .Y(N18) );
  AND2X1 U10 ( .A(count_out[1]), .B(\mult_add_41_aco/b ), .Y(N19) );
  AND2X1 U11 ( .A(\mult_add_41_aco/b ), .B(count_out[3]), .Y(N21) );
  NOR2X1 U12 ( .A(rollover_val[1]), .B(rollover_val[0]), .Y(n3) );
  AOI21X1 U13 ( .A(rollover_val[0]), .B(rollover_val[1]), .C(n3), .Y(n2) );
  NAND2X1 U14 ( .A(n3), .B(n6), .Y(n4) );
  OAI21X1 U15 ( .A(n3), .B(n6), .C(n4), .Y(N10) );
  NOR2X1 U34 ( .A(n4), .B(rollover_val[3]), .Y(N12) );
  AOI21X1 U35 ( .A(n4), .B(rollover_val[3]), .C(N12), .Y(n5) );
  INVX2 U36 ( .A(rollover_val[2]), .Y(n6) );
  INVX2 U37 ( .A(rollover_val[0]), .Y(N8) );
  INVX2 U38 ( .A(n2), .Y(N9) );
  INVX2 U39 ( .A(n5), .Y(N11) );
  INVX2 U40 ( .A(count_out[3]), .Y(n12) );
  INVX2 U41 ( .A(count_out[2]), .Y(n13) );
  INVX2 U42 ( .A(count_out[1]), .Y(n14) );
  INVX2 U43 ( .A(N18), .Y(n15) );
  INVX2 U44 ( .A(count_out[0]), .Y(n16) );
  INVX2 U45 ( .A(rollover_flag), .Y(\mult_add_41_aco/b ) );
  INVX2 U46 ( .A(n26), .Y(n17) );
  INVX2 U47 ( .A(n31), .Y(n18) );
  XOR2X1 U48 ( .A(N21), .B(n37), .Y(N7) );
  NOR2X1 U49 ( .A(n38), .B(n1), .Y(n37) );
  XOR2X1 U50 ( .A(n1), .B(n38), .Y(N6) );
  NAND2X1 U51 ( .A(N19), .B(N18), .Y(n38) );
  XOR2X1 U52 ( .A(N19), .B(N18), .Y(N5) );
endmodule


module timer ( clk, n_rst, bit_period, start, byte_count );
  input [7:0] bit_period;
  input clk, n_rst, start;
  output byte_count;


  flex_counter_NUM_CNT_BITS4 BYTE ( .clk(clk), .n_rst(n_rst), .clear(1'b0), 
        .count_enable(start), .rollover_val({1'b1, 1'b0, 1'b0, 1'b0}), 
        .rollover_flag(byte_count) );
endmodule


module flex_stp_sr_8_0 ( clk, n_rst, shift_enable, serial_in, parallel_out );
  output [7:0] parallel_out;
  input clk, n_rst, shift_enable, serial_in;
  wire   n3, n10, n12, n14, n16, n18, n20, n22, n24, n26, n1, n2, n4, n5, n6,
         n7, n8, n9, n27;

  DFFSR \par_reg[7]  ( .D(n26), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[7]) );
  DFFSR \par_reg[6]  ( .D(n24), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[6]) );
  DFFSR \par_reg[5]  ( .D(n22), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[5]) );
  DFFSR \par_reg[4]  ( .D(n20), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[4]) );
  DFFSR \par_reg[3]  ( .D(n18), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[3]) );
  DFFSR \par_reg[2]  ( .D(n16), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[2]) );
  DFFSR \par_reg[1]  ( .D(n14), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[1]) );
  DFFSR \par_reg[0]  ( .D(n12), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[0]) );
  OAI21X1 U2 ( .A(n9), .B(n27), .C(n3), .Y(n12) );
  NAND2X1 U3 ( .A(parallel_out[0]), .B(n27), .Y(n3) );
  OAI22X1 U4 ( .A(n27), .B(n8), .C(n1), .D(n9), .Y(n14) );
  OAI22X1 U6 ( .A(n27), .B(n7), .C(n1), .D(n8), .Y(n16) );
  OAI22X1 U8 ( .A(n27), .B(n6), .C(n1), .D(n7), .Y(n18) );
  OAI22X1 U10 ( .A(n27), .B(n5), .C(n1), .D(n6), .Y(n20) );
  OAI22X1 U12 ( .A(n27), .B(n4), .C(n1), .D(n5), .Y(n22) );
  OAI22X1 U14 ( .A(n27), .B(n2), .C(n1), .D(n4), .Y(n24) );
  OAI21X1 U17 ( .A(n1), .B(n2), .C(n10), .Y(n26) );
  NAND2X1 U18 ( .A(serial_in), .B(n1), .Y(n10) );
  BUFX2 U5 ( .A(shift_enable), .Y(n1) );
  INVX2 U7 ( .A(parallel_out[7]), .Y(n2) );
  INVX2 U9 ( .A(parallel_out[6]), .Y(n4) );
  INVX2 U11 ( .A(parallel_out[5]), .Y(n5) );
  INVX2 U13 ( .A(parallel_out[4]), .Y(n6) );
  INVX2 U15 ( .A(parallel_out[3]), .Y(n7) );
  INVX2 U16 ( .A(parallel_out[2]), .Y(n8) );
  INVX2 U19 ( .A(parallel_out[1]), .Y(n9) );
  INVX2 U28 ( .A(n1), .Y(n27) );
endmodule


module sr_8bit ( clk, n_rst, shift_strobe, serial_in, byte_done, packet_data, 
        sync_byte_detected );
  output [7:0] packet_data;
  input clk, n_rst, shift_strobe, serial_in, byte_done;
  output sync_byte_detected;
  wire   n5, n6, n8, n9, n11, n1, n2, n3, n4, n7;
  wire   [7:0] temp_packet_data;

  DFFSR sync_byte_detected_reg ( .D(n11), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        sync_byte_detected) );
  NOR2X1 U5 ( .A(n4), .B(n1), .Y(packet_data[4]) );
  NOR2X1 U6 ( .A(n4), .B(n2), .Y(packet_data[3]) );
  NOR2X1 U9 ( .A(n4), .B(n3), .Y(packet_data[0]) );
  OAI21X1 U11 ( .A(n5), .B(n6), .C(n7), .Y(n11) );
  NAND3X1 U13 ( .A(packet_data[7]), .B(n3), .C(n8), .Y(n6) );
  NOR2X1 U14 ( .A(temp_packet_data[2]), .B(temp_packet_data[1]), .Y(n8) );
  NAND3X1 U17 ( .A(n2), .B(n1), .C(n9), .Y(n5) );
  NOR2X1 U18 ( .A(temp_packet_data[6]), .B(temp_packet_data[5]), .Y(n9) );
  AND2X2 U3 ( .A(byte_done), .B(temp_packet_data[6]), .Y(packet_data[6]) );
  AND2X2 U4 ( .A(byte_done), .B(temp_packet_data[5]), .Y(packet_data[5]) );
  AND2X2 U7 ( .A(byte_done), .B(temp_packet_data[2]), .Y(packet_data[2]) );
  AND2X2 U8 ( .A(byte_done), .B(temp_packet_data[1]), .Y(packet_data[1]) );
  AND2X2 U16 ( .A(temp_packet_data[7]), .B(byte_done), .Y(packet_data[7]) );
  flex_stp_sr_8_0 CORE ( .clk(clk), .n_rst(n_rst), .shift_enable(shift_strobe), 
        .serial_in(serial_in), .parallel_out(temp_packet_data) );
  INVX2 U10 ( .A(temp_packet_data[4]), .Y(n1) );
  INVX2 U12 ( .A(temp_packet_data[3]), .Y(n2) );
  INVX2 U15 ( .A(temp_packet_data[0]), .Y(n3) );
  INVX2 U19 ( .A(byte_done), .Y(n4) );
  INVX2 U20 ( .A(sync_byte_detected), .Y(n7) );
endmodule


module control_fsm ( clk, n_rst, sync_byte, packet_in, eop, five_crc, 
        byte_count, sixteen_crc, five_crc_clear, sixteen_crc_clear, 
        packet_data, rx_packet, store_rx_data );
  input [7:0] packet_in;
  output [7:0] packet_data;
  output [2:0] rx_packet;
  input clk, n_rst, sync_byte, eop, five_crc, byte_count, sixteen_crc;
  output five_crc_clear, sixteen_crc_clear, store_rx_data;
  wire   n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41,
         n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55,
         n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69,
         n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n5, n6, n7, n8,
         n9, n10, n11, n12, n13, n14, n15, n16, n17, n19, n20, n21, n23, n24,
         n25, n26, n27;
  wire   [3:0] state;
  wire   [3:0] next_state;

  DFFSR \state_reg[0]  ( .D(next_state[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[0]) );
  DFFSR \state_reg[2]  ( .D(next_state[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[2]) );
  DFFSR \state_reg[3]  ( .D(next_state[3]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[3]) );
  DFFSR \state_reg[1]  ( .D(next_state[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[1]) );
  AND2X2 U7 ( .A(n43), .B(n44), .Y(n42) );
  AND2X2 U8 ( .A(n46), .B(n16), .Y(rx_packet[2]) );
  AND2X2 U9 ( .A(n55), .B(n54), .Y(n50) );
  OAI21X1 U33 ( .A(n28), .B(n29), .C(n8), .Y(rx_packet[1]) );
  OAI21X1 U34 ( .A(n28), .B(n30), .C(n8), .Y(rx_packet[0]) );
  OAI21X1 U35 ( .A(n28), .B(n32), .C(n33), .Y(n31) );
  NOR2X1 U36 ( .A(sixteen_crc_clear), .B(five_crc_clear), .Y(n33) );
  NAND3X1 U37 ( .A(n19), .B(eop), .C(sixteen_crc), .Y(n34) );
  NOR2X1 U38 ( .A(n7), .B(n36), .Y(packet_data[7]) );
  NOR2X1 U39 ( .A(n9), .B(n36), .Y(packet_data[6]) );
  NOR2X1 U40 ( .A(n10), .B(n36), .Y(packet_data[5]) );
  NOR2X1 U41 ( .A(n11), .B(n36), .Y(packet_data[4]) );
  NOR2X1 U42 ( .A(n12), .B(n36), .Y(packet_data[3]) );
  NOR2X1 U43 ( .A(n13), .B(n36), .Y(packet_data[2]) );
  NOR2X1 U44 ( .A(n14), .B(n36), .Y(packet_data[1]) );
  NOR2X1 U45 ( .A(n15), .B(n36), .Y(packet_data[0]) );
  NAND2X1 U46 ( .A(byte_count), .B(n23), .Y(n36) );
  NAND3X1 U47 ( .A(n20), .B(n25), .C(n38), .Y(next_state[3]) );
  OR2X1 U48 ( .A(n39), .B(n40), .Y(next_state[2]) );
  OAI21X1 U49 ( .A(eop), .B(n37), .C(n6), .Y(n40) );
  OAI21X1 U50 ( .A(n5), .B(n24), .C(n42), .Y(n39) );
  OAI21X1 U51 ( .A(n5), .B(n26), .C(n45), .Y(next_state[1]) );
  NOR2X1 U52 ( .A(rx_packet[2]), .B(n17), .Y(n45) );
  NAND2X1 U53 ( .A(n48), .B(n49), .Y(next_state[0]) );
  AOI21X1 U54 ( .A(n50), .B(sync_byte), .C(n51), .Y(n49) );
  OAI21X1 U55 ( .A(n26), .B(n52), .C(n20), .Y(n51) );
  OAI21X1 U56 ( .A(n37), .B(n27), .C(n35), .Y(store_rx_data) );
  NAND3X1 U57 ( .A(n53), .B(n24), .C(state[3]), .Y(n35) );
  NAND2X1 U58 ( .A(n54), .B(n21), .Y(n52) );
  AOI21X1 U59 ( .A(state[0]), .B(n47), .C(n41), .Y(n48) );
  OAI21X1 U60 ( .A(n26), .B(n56), .C(n57), .Y(n41) );
  OAI21X1 U61 ( .A(n58), .B(n59), .C(n16), .Y(n57) );
  OAI21X1 U62 ( .A(n60), .B(n61), .C(n30), .Y(n59) );
  NAND3X1 U63 ( .A(packet_in[3]), .B(n7), .C(n62), .Y(n30) );
  NAND3X1 U64 ( .A(packet_in[2]), .B(packet_in[3]), .C(n63), .Y(n61) );
  NOR2X1 U65 ( .A(n10), .B(n15), .Y(n63) );
  NAND3X1 U66 ( .A(n14), .B(n11), .C(n64), .Y(n60) );
  NOR2X1 U67 ( .A(packet_in[7]), .B(packet_in[6]), .Y(n64) );
  NAND2X1 U68 ( .A(n29), .B(n32), .Y(n58) );
  OR2X1 U69 ( .A(n65), .B(n66), .Y(n32) );
  NAND3X1 U70 ( .A(packet_in[5]), .B(packet_in[7]), .C(packet_in[0]), .Y(n66)
         );
  NAND3X1 U71 ( .A(n67), .B(n14), .C(n68), .Y(n65) );
  NOR2X1 U72 ( .A(packet_in[4]), .B(packet_in[3]), .Y(n68) );
  XNOR2X1 U73 ( .A(n9), .B(packet_in[2]), .Y(n67) );
  NAND3X1 U74 ( .A(packet_in[7]), .B(n12), .C(n62), .Y(n29) );
  NOR2X1 U75 ( .A(n69), .B(n70), .Y(n62) );
  NAND3X1 U76 ( .A(packet_in[4]), .B(packet_in[2]), .C(packet_in[1]), .Y(n70)
         );
  NAND3X1 U77 ( .A(n10), .B(n9), .C(n15), .Y(n69) );
  NAND2X1 U78 ( .A(n71), .B(n21), .Y(n56) );
  OAI22X1 U79 ( .A(n46), .B(n28), .C(n72), .D(n73), .Y(n47) );
  NAND2X1 U80 ( .A(n44), .B(n43), .Y(n73) );
  NAND2X1 U81 ( .A(n53), .B(n71), .Y(n43) );
  NAND3X1 U82 ( .A(n54), .B(state[0]), .C(state[1]), .Y(n44) );
  NAND3X1 U83 ( .A(n28), .B(n37), .C(n38), .Y(n72) );
  NAND3X1 U84 ( .A(state[0]), .B(n71), .C(state[1]), .Y(n38) );
  NAND2X1 U85 ( .A(n55), .B(n71), .Y(n37) );
  NOR2X1 U86 ( .A(n24), .B(state[3]), .Y(n71) );
  NAND2X1 U87 ( .A(n54), .B(n53), .Y(n28) );
  NOR2X1 U88 ( .A(n21), .B(state[1]), .Y(n53) );
  NOR2X1 U89 ( .A(state[2]), .B(state[3]), .Y(n54) );
  NOR2X1 U90 ( .A(n74), .B(n75), .Y(n46) );
  NAND3X1 U91 ( .A(packet_in[4]), .B(packet_in[2]), .C(packet_in[5]), .Y(n75)
         );
  NAND3X1 U92 ( .A(n76), .B(n15), .C(n77), .Y(n74) );
  NOR2X1 U93 ( .A(packet_in[6]), .B(packet_in[1]), .Y(n77) );
  XNOR2X1 U94 ( .A(n7), .B(packet_in[3]), .Y(n76) );
  NAND3X1 U95 ( .A(five_crc), .B(state[3]), .C(n79), .Y(n78) );
  NOR2X1 U96 ( .A(n27), .B(n80), .Y(n79) );
  NAND2X1 U97 ( .A(n55), .B(n24), .Y(n80) );
  NOR2X1 U98 ( .A(state[0]), .B(state[1]), .Y(n55) );
  INVX2 U10 ( .A(n47), .Y(n5) );
  INVX2 U11 ( .A(n41), .Y(n6) );
  INVX2 U12 ( .A(packet_in[7]), .Y(n7) );
  INVX2 U13 ( .A(n31), .Y(n8) );
  INVX2 U14 ( .A(packet_in[6]), .Y(n9) );
  INVX2 U15 ( .A(packet_in[5]), .Y(n10) );
  INVX2 U16 ( .A(packet_in[4]), .Y(n11) );
  INVX2 U17 ( .A(packet_in[3]), .Y(n12) );
  INVX2 U18 ( .A(packet_in[2]), .Y(n13) );
  INVX2 U19 ( .A(packet_in[1]), .Y(n14) );
  INVX2 U20 ( .A(packet_in[0]), .Y(n15) );
  INVX2 U21 ( .A(n28), .Y(n16) );
  INVX2 U22 ( .A(n43), .Y(n17) );
  INVX2 U23 ( .A(n34), .Y(sixteen_crc_clear) );
  INVX2 U24 ( .A(n35), .Y(n19) );
  INVX2 U25 ( .A(store_rx_data), .Y(n20) );
  INVX2 U26 ( .A(state[0]), .Y(n21) );
  INVX2 U27 ( .A(n78), .Y(five_crc_clear) );
  INVX2 U28 ( .A(n37), .Y(n23) );
  INVX2 U29 ( .A(state[2]), .Y(n24) );
  INVX2 U30 ( .A(state[3]), .Y(n25) );
  INVX2 U31 ( .A(state[1]), .Y(n26) );
  INVX2 U32 ( .A(eop), .Y(n27) );
endmodule


module usb_rx ( clk, n_rst, dplus_in, dminus_in, rx_packet, store_rx_packet, 
        rx_packet_data );
  output [2:0] rx_packet;
  output [7:0] rx_packet_data;
  input clk, n_rst, dplus_in, dminus_in;
  output store_rx_packet;
  wire   start, d_decoded, eop, five_crc_clear, five_crc, sixteen_crc_clear,
         sixteen_crc, byte_count, sync_byte;
  wire   [7:0] bit_period;
  wire   [7:0] packet_in;

  decoder DECODE ( .clk(clk), .n_rst(n_rst), .d_plus_in(dplus_in), 
        .d_minus_in(dminus_in), .start(start), .d_decoded(d_decoded), .eop(eop) );
  crc_checker_5bit CHECK ( .clk(clk), .nRst(n_rst), .din(d_decoded), .clear(
        five_crc_clear), .crcError(five_crc) );
  crc_checker_16bit CHECK2 ( .clk(clk), .nRst(n_rst), .din(d_decoded), .clear(
        sixteen_crc_clear), .crcError(sixteen_crc) );
  timer TIME ( .clk(clk), .n_rst(n_rst), .bit_period({1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0}), .start(start), .byte_count(byte_count) );
  sr_8bit SR ( .clk(clk), .n_rst(n_rst), .shift_strobe(start), .serial_in(
        d_decoded), .byte_done(byte_count), .packet_data(packet_in), 
        .sync_byte_detected(sync_byte) );
  control_fsm FSM ( .clk(clk), .n_rst(n_rst), .sync_byte(sync_byte), 
        .packet_in(packet_in), .eop(eop), .five_crc(five_crc), .byte_count(
        byte_count), .sixteen_crc(sixteen_crc), .five_crc_clear(five_crc_clear), .sixteen_crc_clear(sixteen_crc_clear), .packet_data(rx_packet_data), 
        .rx_packet(rx_packet), .store_rx_data(store_rx_packet) );
endmodule

