/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Tue Apr 23 14:03:59 2019
/////////////////////////////////////////////////////////////


module decoder ( clk, n_rst, d_plus_in, d_minus_in, d_decoded, eop );
  input clk, n_rst, d_plus_in, d_minus_in;
  output d_decoded, eop;
  wire   N42, N43, N45, n23, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14,
         n15, n16, n17, n18, n19, n20, n21;
  wire   [2:0] state;
  wire   [2:0] next_state;

  LATCH \next_state_reg[0]  ( .CLK(N42), .D(N43), .Q(next_state[0]) );
  DFFSR \state_reg[0]  ( .D(next_state[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[0]) );
  LATCH \next_state_reg[1]  ( .CLK(N42), .D(n21), .Q(next_state[1]) );
  DFFSR \state_reg[1]  ( .D(next_state[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[1]) );
  LATCH \next_state_reg[2]  ( .CLK(N42), .D(N45), .Q(next_state[2]) );
  DFFSR \state_reg[2]  ( .D(next_state[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[2]) );
  DFFPOSX1 d_decoded_reg ( .D(n23), .CLK(clk), .Q(d_decoded) );
  OAI21X1 U6 ( .A(n4), .B(n5), .C(n6), .Y(n23) );
  OAI21X1 U7 ( .A(n7), .B(n8), .C(d_decoded), .Y(n6) );
  NAND2X1 U8 ( .A(d_plus_in), .B(n_rst), .Y(n8) );
  NAND2X1 U9 ( .A(n9), .B(n10), .Y(n7) );
  NAND2X1 U10 ( .A(d_minus_in), .B(n21), .Y(n5) );
  INVX1 U11 ( .A(n_rst), .Y(n4) );
  OAI21X1 U12 ( .A(n11), .B(n12), .C(n13), .Y(N45) );
  NAND2X1 U13 ( .A(n10), .B(n14), .Y(n12) );
  INVX1 U14 ( .A(d_minus_in), .Y(n10) );
  AOI21X1 U15 ( .A(d_minus_in), .B(n15), .C(n16), .Y(N43) );
  NAND3X1 U16 ( .A(n11), .B(n13), .C(n17), .Y(N42) );
  AOI21X1 U17 ( .A(n18), .B(d_plus_in), .C(n21), .Y(n17) );
  INVX1 U18 ( .A(n19), .Y(n21) );
  NAND3X1 U19 ( .A(n15), .B(n14), .C(n9), .Y(n19) );
  INVX1 U20 ( .A(d_plus_in), .Y(n14) );
  NOR2X1 U21 ( .A(d_minus_in), .B(n16), .Y(n18) );
  INVX1 U22 ( .A(n9), .Y(n16) );
  AOI21X1 U23 ( .A(state[0]), .B(state[1]), .C(state[2]), .Y(n9) );
  INVX1 U24 ( .A(eop), .Y(n13) );
  NOR2X1 U25 ( .A(n20), .B(n15), .Y(eop) );
  OR2X1 U26 ( .A(state[0]), .B(state[1]), .Y(n15) );
  NAND3X1 U27 ( .A(state[0]), .B(n20), .C(state[1]), .Y(n11) );
  INVX1 U28 ( .A(state[2]), .Y(n20) );
endmodule


module flex_counter_NUM_CNT_BITS8_DW01_inc_0 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;

  wire   [7:2] carry;

  HAX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[7]), .B(A[7]), .Y(SUM[7]) );
endmodule


module flex_counter_NUM_CNT_BITS8 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [7:0] rollover_val;
  output [7:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   n81, N4, N5, N6, N7, N8, N9, N10, N11, N26, N27, N28, N29, N30, N31,
         N32, N33, n51, n52, n53, n54, n55, n56, n57, n58, n59, n2, n3, n4, n5,
         n6, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42,
         n43, n44, n45, n46, n47, n48, n49, n50, n60, n61, n62, n63, n64, n65,
         n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79,
         n80;

  DFFSR \count_reg[0]  ( .D(n59), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR r_flag_reg ( .D(n58), .CLK(clk), .R(n_rst), .S(1'b1), .Q(n81) );
  DFFSR \count_reg[1]  ( .D(n57), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \count_reg[2]  ( .D(n56), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \count_reg[3]  ( .D(n55), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR \count_reg[4]  ( .D(n54), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[4]) );
  DFFSR \count_reg[5]  ( .D(n53), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[5]) );
  DFFSR \count_reg[6]  ( .D(n52), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[6]) );
  DFFSR \count_reg[7]  ( .D(n51), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[7]) );
  flex_counter_NUM_CNT_BITS8_DW01_inc_0 add_41_aco ( .A({N33, N32, N31, N30, 
        N29, N28, N27, N26}), .SUM({N11, N10, N9, N8, N7, N6, N5, N4}) );
  INVX2 U6 ( .A(n6), .Y(rollover_flag) );
  OAI21X1 U13 ( .A(n2), .B(n3), .C(n4), .Y(n59) );
  NAND2X1 U14 ( .A(N4), .B(n5), .Y(n4) );
  OAI21X1 U15 ( .A(n2), .B(n6), .C(n16), .Y(n58) );
  NAND3X1 U16 ( .A(n17), .B(n18), .C(n19), .Y(n16) );
  NOR2X1 U17 ( .A(n20), .B(n21), .Y(n19) );
  NAND3X1 U18 ( .A(n22), .B(n23), .C(n24), .Y(n21) );
  MUX2X1 U19 ( .B(n25), .A(n26), .S(count_out[6]), .Y(n24) );
  NOR2X1 U20 ( .A(rollover_val[6]), .B(n27), .Y(n26) );
  MUX2X1 U21 ( .B(n28), .A(n29), .S(count_out[2]), .Y(n23) );
  NOR2X1 U22 ( .A(rollover_val[2]), .B(n30), .Y(n29) );
  MUX2X1 U23 ( .B(n31), .A(n32), .S(count_out[4]), .Y(n22) );
  NOR2X1 U24 ( .A(rollover_val[4]), .B(n33), .Y(n32) );
  NAND2X1 U25 ( .A(n34), .B(n5), .Y(n20) );
  AOI22X1 U26 ( .A(n35), .B(rollover_val[6]), .C(n36), .D(rollover_val[4]), 
        .Y(n34) );
  XOR2X1 U27 ( .A(n37), .B(n33), .Y(n36) );
  INVX1 U28 ( .A(n38), .Y(n33) );
  XOR2X1 U29 ( .A(n39), .B(n27), .Y(n35) );
  INVX1 U30 ( .A(n40), .Y(n27) );
  NOR2X1 U31 ( .A(n41), .B(n42), .Y(n18) );
  NAND2X1 U32 ( .A(n43), .B(n44), .Y(n42) );
  XOR2X1 U33 ( .A(n45), .B(n46), .Y(n44) );
  OAI21X1 U34 ( .A(n31), .B(n47), .C(n40), .Y(n46) );
  XOR2X1 U35 ( .A(n48), .B(count_out[7]), .Y(n43) );
  NAND2X1 U36 ( .A(rollover_val[7]), .B(n49), .Y(n48) );
  OAI21X1 U37 ( .A(rollover_val[7]), .B(n49), .C(n50), .Y(n41) );
  XOR2X1 U38 ( .A(n60), .B(n61), .Y(n50) );
  OAI21X1 U39 ( .A(count_out[0]), .B(n62), .C(n63), .Y(n61) );
  INVX1 U40 ( .A(rollover_val[1]), .Y(n62) );
  INVX1 U41 ( .A(n25), .Y(n49) );
  NOR2X1 U42 ( .A(n40), .B(rollover_val[6]), .Y(n25) );
  NAND2X1 U43 ( .A(n31), .B(n47), .Y(n40) );
  INVX1 U44 ( .A(rollover_val[5]), .Y(n47) );
  NOR2X1 U45 ( .A(n38), .B(rollover_val[4]), .Y(n31) );
  AOI21X1 U46 ( .A(n64), .B(rollover_val[2]), .C(n65), .Y(n17) );
  NAND2X1 U47 ( .A(n66), .B(n67), .Y(n65) );
  XOR2X1 U48 ( .A(rollover_val[0]), .B(count_out[0]), .Y(n67) );
  XOR2X1 U49 ( .A(n68), .B(n69), .Y(n66) );
  OAI21X1 U50 ( .A(n28), .B(n70), .C(n38), .Y(n69) );
  NAND2X1 U51 ( .A(n28), .B(n70), .Y(n38) );
  INVX1 U52 ( .A(rollover_val[3]), .Y(n70) );
  NOR2X1 U53 ( .A(n63), .B(rollover_val[2]), .Y(n28) );
  INVX1 U54 ( .A(n30), .Y(n63) );
  XOR2X1 U55 ( .A(n71), .B(n30), .Y(n64) );
  NOR2X1 U56 ( .A(rollover_val[0]), .B(rollover_val[1]), .Y(n30) );
  INVX1 U57 ( .A(n81), .Y(n6) );
  OAI21X1 U58 ( .A(n2), .B(n60), .C(n72), .Y(n57) );
  NAND2X1 U59 ( .A(N5), .B(n5), .Y(n72) );
  OAI21X1 U60 ( .A(n2), .B(n71), .C(n73), .Y(n56) );
  NAND2X1 U61 ( .A(N6), .B(n5), .Y(n73) );
  OAI21X1 U62 ( .A(n2), .B(n68), .C(n74), .Y(n55) );
  NAND2X1 U63 ( .A(N7), .B(n5), .Y(n74) );
  OAI21X1 U64 ( .A(n2), .B(n37), .C(n75), .Y(n54) );
  NAND2X1 U65 ( .A(N8), .B(n5), .Y(n75) );
  OAI21X1 U66 ( .A(n2), .B(n45), .C(n76), .Y(n53) );
  NAND2X1 U67 ( .A(N9), .B(n5), .Y(n76) );
  OAI21X1 U68 ( .A(n2), .B(n39), .C(n77), .Y(n52) );
  NAND2X1 U69 ( .A(N10), .B(n5), .Y(n77) );
  OAI21X1 U70 ( .A(n2), .B(n78), .C(n79), .Y(n51) );
  NAND2X1 U71 ( .A(N11), .B(n5), .Y(n79) );
  NOR2X1 U72 ( .A(n80), .B(clear), .Y(n5) );
  INVX1 U73 ( .A(n80), .Y(n2) );
  NOR2X1 U74 ( .A(count_enable), .B(clear), .Y(n80) );
  NOR2X1 U75 ( .A(n81), .B(n78), .Y(N33) );
  INVX1 U76 ( .A(count_out[7]), .Y(n78) );
  NOR2X1 U77 ( .A(n81), .B(n39), .Y(N32) );
  INVX1 U78 ( .A(count_out[6]), .Y(n39) );
  NOR2X1 U79 ( .A(n81), .B(n45), .Y(N31) );
  INVX1 U80 ( .A(count_out[5]), .Y(n45) );
  NOR2X1 U81 ( .A(n81), .B(n37), .Y(N30) );
  INVX1 U82 ( .A(count_out[4]), .Y(n37) );
  NOR2X1 U83 ( .A(n81), .B(n68), .Y(N29) );
  INVX1 U84 ( .A(count_out[3]), .Y(n68) );
  NOR2X1 U85 ( .A(n81), .B(n71), .Y(N28) );
  INVX1 U86 ( .A(count_out[2]), .Y(n71) );
  NOR2X1 U87 ( .A(n81), .B(n60), .Y(N27) );
  INVX1 U88 ( .A(count_out[1]), .Y(n60) );
  NOR2X1 U89 ( .A(n81), .B(n3), .Y(N26) );
  INVX1 U90 ( .A(count_out[0]), .Y(n3) );
endmodule


module flex_counter_NUM_CNT_BITS4 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   n32, n33, n34, n35, n36, n1, n2, n3, n4, n5, n6, n12, n13, n14, n15,
         n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29,
         n30, n31, n37, n38, n39, n40, n41, n42, n43, n44;

  DFFSR \count_reg[0]  ( .D(n36), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR r_flag_reg ( .D(n35), .CLK(clk), .R(n_rst), .S(1'b1), .Q(rollover_flag) );
  DFFSR \count_reg[1]  ( .D(n34), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \count_reg[2]  ( .D(n33), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \count_reg[3]  ( .D(n32), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  OAI22X1 U6 ( .A(n1), .B(n2), .C(n3), .D(n4), .Y(n36) );
  OAI22X1 U9 ( .A(n2), .B(n5), .C(n6), .D(n12), .Y(n35) );
  NAND2X1 U10 ( .A(n13), .B(n14), .Y(n12) );
  MUX2X1 U11 ( .B(n15), .A(n16), .S(n17), .Y(n14) );
  NOR2X1 U12 ( .A(rollover_val[3]), .B(rollover_val[2]), .Y(n16) );
  OAI21X1 U13 ( .A(n18), .B(n19), .C(n20), .Y(n15) );
  NOR2X1 U14 ( .A(n21), .B(n22), .Y(n18) );
  MUX2X1 U15 ( .B(n1), .A(n23), .S(rollover_val[0]), .Y(n13) );
  OAI21X1 U16 ( .A(count_out[1]), .B(n21), .C(n1), .Y(n23) );
  NAND3X1 U17 ( .A(n24), .B(n25), .C(n26), .Y(n6) );
  OAI21X1 U18 ( .A(n20), .B(n19), .C(n17), .Y(n25) );
  INVX1 U19 ( .A(n27), .Y(n17) );
  XOR2X1 U20 ( .A(n28), .B(rollover_val[2]), .Y(n20) );
  XOR2X1 U21 ( .A(n29), .B(count_out[3]), .Y(n24) );
  OAI21X1 U22 ( .A(rollover_val[2]), .B(n27), .C(rollover_val[3]), .Y(n29) );
  NAND2X1 U23 ( .A(n22), .B(n21), .Y(n27) );
  INVX1 U24 ( .A(rollover_val[1]), .Y(n21) );
  INVX1 U25 ( .A(rollover_val[0]), .Y(n22) );
  OAI22X1 U26 ( .A(n2), .B(n19), .C(n30), .D(n4), .Y(n34) );
  XNOR2X1 U27 ( .A(n31), .B(n3), .Y(n30) );
  OAI22X1 U28 ( .A(n2), .B(n28), .C(n37), .D(n4), .Y(n33) );
  XNOR2X1 U29 ( .A(n38), .B(n39), .Y(n37) );
  INVX1 U30 ( .A(count_out[2]), .Y(n28) );
  OAI22X1 U31 ( .A(n2), .B(n40), .C(n41), .D(n4), .Y(n32) );
  INVX1 U32 ( .A(n26), .Y(n4) );
  NOR2X1 U33 ( .A(clear), .B(n42), .Y(n26) );
  XOR2X1 U34 ( .A(n43), .B(n44), .Y(n41) );
  NOR2X1 U35 ( .A(n38), .B(n39), .Y(n44) );
  NAND2X1 U36 ( .A(count_out[2]), .B(n5), .Y(n39) );
  NAND2X1 U37 ( .A(n31), .B(n3), .Y(n38) );
  NOR2X1 U38 ( .A(n1), .B(rollover_flag), .Y(n3) );
  INVX1 U39 ( .A(count_out[0]), .Y(n1) );
  NOR2X1 U40 ( .A(n19), .B(rollover_flag), .Y(n31) );
  INVX1 U41 ( .A(count_out[1]), .Y(n19) );
  NAND2X1 U42 ( .A(count_out[3]), .B(n5), .Y(n43) );
  INVX1 U43 ( .A(rollover_flag), .Y(n5) );
  INVX1 U44 ( .A(count_out[3]), .Y(n40) );
  INVX1 U45 ( .A(n42), .Y(n2) );
  NOR2X1 U46 ( .A(clear), .B(count_enable), .Y(n42) );
endmodule


module timer ( clk, n_rst, bit_period, sync_byte, shift_enable, byte_count );
  input [7:0] bit_period;
  input clk, n_rst, sync_byte;
  output shift_enable, byte_count;


  flex_counter_NUM_CNT_BITS8 SHIFT_REGISTER ( .clk(clk), .n_rst(n_rst), 
        .clear(1'b0), .count_enable(sync_byte), .rollover_val(bit_period), 
        .rollover_flag(shift_enable) );
  flex_counter_NUM_CNT_BITS4 BYTE ( .clk(clk), .n_rst(n_rst), .clear(1'b0), 
        .count_enable(sync_byte), .rollover_val({1'b1, 1'b0, 1'b0, 1'b0}), 
        .rollover_flag(byte_count) );
endmodule


module flex_stp_sr_8_0 ( clk, n_rst, shift_enable, serial_in, parallel_out );
  output [7:0] parallel_out;
  input clk, n_rst, shift_enable, serial_in;
  wire   n12, n14, n16, n18, n20, n22, n24, n26, n1, n2, n3, n4, n5, n6, n7,
         n8;

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
  INVX1 U2 ( .A(n1), .Y(n26) );
  MUX2X1 U3 ( .B(parallel_out[7]), .A(serial_in), .S(shift_enable), .Y(n1) );
  INVX1 U4 ( .A(n2), .Y(n24) );
  MUX2X1 U5 ( .B(parallel_out[6]), .A(parallel_out[7]), .S(shift_enable), .Y(
        n2) );
  INVX1 U6 ( .A(n3), .Y(n22) );
  MUX2X1 U7 ( .B(parallel_out[5]), .A(parallel_out[6]), .S(shift_enable), .Y(
        n3) );
  INVX1 U8 ( .A(n4), .Y(n20) );
  MUX2X1 U9 ( .B(parallel_out[4]), .A(parallel_out[5]), .S(shift_enable), .Y(
        n4) );
  INVX1 U10 ( .A(n5), .Y(n18) );
  MUX2X1 U11 ( .B(parallel_out[3]), .A(parallel_out[4]), .S(shift_enable), .Y(
        n5) );
  INVX1 U12 ( .A(n6), .Y(n16) );
  MUX2X1 U13 ( .B(parallel_out[2]), .A(parallel_out[3]), .S(shift_enable), .Y(
        n6) );
  INVX1 U14 ( .A(n7), .Y(n14) );
  MUX2X1 U15 ( .B(parallel_out[1]), .A(parallel_out[2]), .S(shift_enable), .Y(
        n7) );
  INVX1 U16 ( .A(n8), .Y(n12) );
  MUX2X1 U17 ( .B(parallel_out[0]), .A(parallel_out[1]), .S(shift_enable), .Y(
        n8) );
endmodule


module sr_8bit ( clk, n_rst, shift_strobe, serial_in, byte_done, packet_data, 
        sync_byte_detected );
  output [7:0] packet_data;
  input clk, n_rst, shift_strobe, serial_in, byte_done;
  output sync_byte_detected;
  wire   n11, n1, n2, n3, n4, n5, n6, n7, n8, n9;
  wire   [7:0] temp_packet_data;

  DFFSR sync_byte_detected_reg ( .D(n11), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        sync_byte_detected) );
  flex_stp_sr_8_0 CORE ( .clk(clk), .n_rst(n_rst), .shift_enable(shift_strobe), 
        .serial_in(serial_in), .parallel_out(temp_packet_data) );
  AND2X1 U3 ( .A(byte_done), .B(temp_packet_data[6]), .Y(packet_data[6]) );
  AND2X1 U4 ( .A(byte_done), .B(temp_packet_data[5]), .Y(packet_data[5]) );
  NOR2X1 U5 ( .A(n1), .B(n2), .Y(packet_data[4]) );
  NOR2X1 U6 ( .A(n1), .B(n3), .Y(packet_data[3]) );
  AND2X1 U7 ( .A(byte_done), .B(temp_packet_data[2]), .Y(packet_data[2]) );
  AND2X1 U8 ( .A(byte_done), .B(temp_packet_data[1]), .Y(packet_data[1]) );
  NOR2X1 U9 ( .A(n1), .B(n4), .Y(packet_data[0]) );
  INVX1 U10 ( .A(byte_done), .Y(n1) );
  OAI21X1 U11 ( .A(n5), .B(n6), .C(n7), .Y(n11) );
  INVX1 U12 ( .A(sync_byte_detected), .Y(n7) );
  NAND3X1 U13 ( .A(packet_data[7]), .B(n4), .C(n8), .Y(n6) );
  NOR2X1 U14 ( .A(temp_packet_data[2]), .B(temp_packet_data[1]), .Y(n8) );
  INVX1 U15 ( .A(temp_packet_data[0]), .Y(n4) );
  AND2X1 U16 ( .A(temp_packet_data[7]), .B(byte_done), .Y(packet_data[7]) );
  NAND3X1 U17 ( .A(n3), .B(n2), .C(n9), .Y(n5) );
  NOR2X1 U18 ( .A(temp_packet_data[6]), .B(temp_packet_data[5]), .Y(n9) );
  INVX1 U19 ( .A(temp_packet_data[4]), .Y(n2) );
  INVX1 U20 ( .A(temp_packet_data[3]), .Y(n3) );
endmodule


module control_fsm ( clk, n_rst, sync_byte, packet_in, eop, packet_data, 
        rx_packet, store_rx_data );
  input [7:0] packet_in;
  output [7:0] packet_data;
  output [2:0] rx_packet;
  input clk, n_rst, sync_byte, eop;
  output store_rx_data;
  wire   N75, N76, N77, N79, N80, N81, N82, N83, n5, n6, n7, n8, n9, n10, n11,
         n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25,
         n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39,
         n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53,
         n54, n55, n56, n57, n58, n59, n60, n61, n62, n63;
  wire   [3:0] state;
  wire   [3:0] next_state;

  LATCH \next_state_reg[0]  ( .CLK(N79), .D(N80), .Q(next_state[0]) );
  DFFSR \state_reg[0]  ( .D(next_state[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[0]) );
  LATCH \packet_data_reg[1]  ( .CLK(n63), .D(packet_in[1]), .Q(packet_data[1])
         );
  LATCH \packet_data_reg[2]  ( .CLK(n63), .D(packet_in[2]), .Q(packet_data[2])
         );
  LATCH \packet_data_reg[3]  ( .CLK(n63), .D(packet_in[3]), .Q(packet_data[3])
         );
  LATCH \packet_data_reg[4]  ( .CLK(n63), .D(packet_in[4]), .Q(packet_data[4])
         );
  LATCH \packet_data_reg[5]  ( .CLK(n63), .D(packet_in[5]), .Q(packet_data[5])
         );
  LATCH \packet_data_reg[6]  ( .CLK(n63), .D(packet_in[6]), .Q(packet_data[6])
         );
  LATCH \packet_data_reg[7]  ( .CLK(n63), .D(packet_in[7]), .Q(packet_data[7])
         );
  LATCH \packet_data_reg[0]  ( .CLK(n63), .D(packet_in[0]), .Q(packet_data[0])
         );
  LATCH \next_state_reg[3]  ( .CLK(N79), .D(N83), .Q(next_state[3]) );
  DFFSR \state_reg[3]  ( .D(next_state[3]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[3]) );
  LATCH \next_state_reg[2]  ( .CLK(N79), .D(N82), .Q(next_state[2]) );
  DFFSR \state_reg[2]  ( .D(next_state[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[2]) );
  LATCH \next_state_reg[1]  ( .CLK(N79), .D(N81), .Q(next_state[1]) );
  DFFSR \state_reg[1]  ( .D(next_state[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[1]) );
  LATCH \rx_packet_reg[0]  ( .CLK(N75), .D(N76), .Q(rx_packet[0]) );
  LATCH \rx_packet_reg[2]  ( .CLK(N75), .D(n62), .Q(rx_packet[2]) );
  LATCH \rx_packet_reg[1]  ( .CLK(N75), .D(N77), .Q(rx_packet[1]) );
  OAI21X1 U7 ( .A(n5), .B(n6), .C(n7), .Y(N83) );
  NOR2X1 U8 ( .A(store_rx_data), .B(n8), .Y(n7) );
  INVX1 U9 ( .A(n9), .Y(n8) );
  AND2X1 U10 ( .A(eop), .B(n63), .Y(store_rx_data) );
  INVX1 U11 ( .A(n10), .Y(n63) );
  OR2X1 U12 ( .A(n11), .B(n12), .Y(N82) );
  OAI21X1 U13 ( .A(eop), .B(n10), .C(n13), .Y(n12) );
  OAI21X1 U14 ( .A(state[2]), .B(n6), .C(n14), .Y(n11) );
  NAND3X1 U15 ( .A(n14), .B(n15), .C(n16), .Y(N81) );
  NAND3X1 U16 ( .A(n17), .B(n16), .C(n13), .Y(N80) );
  NAND3X1 U17 ( .A(n18), .B(n19), .C(sync_byte), .Y(n17) );
  OR2X1 U18 ( .A(n20), .B(n21), .Y(N79) );
  NAND3X1 U19 ( .A(n10), .B(n6), .C(n16), .Y(n21) );
  NAND3X1 U20 ( .A(state[0]), .B(n19), .C(state[1]), .Y(n6) );
  NAND3X1 U21 ( .A(state[2]), .B(n22), .C(n23), .Y(n10) );
  NOR2X1 U22 ( .A(state[3]), .B(state[1]), .Y(n23) );
  NAND3X1 U23 ( .A(n14), .B(n24), .C(n9), .Y(n20) );
  NAND2X1 U24 ( .A(state[3]), .B(n18), .Y(n9) );
  INVX1 U25 ( .A(N75), .Y(n24) );
  NAND2X1 U26 ( .A(state[2]), .B(n25), .Y(n14) );
  OAI21X1 U27 ( .A(n22), .B(n26), .C(n16), .Y(n25) );
  NAND3X1 U28 ( .A(n22), .B(n19), .C(state[1]), .Y(n16) );
  NAND2X1 U29 ( .A(n27), .B(n19), .Y(n26) );
  AOI21X1 U30 ( .A(n28), .B(n29), .C(n30), .Y(N76) );
  INVX1 U31 ( .A(n31), .Y(n28) );
  NAND2X1 U32 ( .A(n13), .B(n32), .Y(N75) );
  AOI21X1 U33 ( .A(n19), .B(n18), .C(n62), .Y(n32) );
  INVX1 U34 ( .A(n15), .Y(n62) );
  NAND3X1 U35 ( .A(packet_in[4]), .B(n33), .C(n34), .Y(n15) );
  NOR2X1 U36 ( .A(n30), .B(n35), .Y(n34) );
  NAND2X1 U37 ( .A(n36), .B(n37), .Y(n35) );
  XOR2X1 U38 ( .A(packet_in[7]), .B(packet_in[3]), .Y(n36) );
  INVX1 U39 ( .A(n38), .Y(n18) );
  NAND3X1 U40 ( .A(n27), .B(n5), .C(n22), .Y(n38) );
  INVX1 U41 ( .A(state[0]), .Y(n22) );
  INVX1 U42 ( .A(state[2]), .Y(n5) );
  INVX1 U43 ( .A(state[3]), .Y(n19) );
  AOI21X1 U44 ( .A(n39), .B(n40), .C(N77), .Y(n13) );
  INVX1 U45 ( .A(n41), .Y(N77) );
  OAI21X1 U46 ( .A(n42), .B(n31), .C(n40), .Y(n41) );
  NOR2X1 U47 ( .A(n43), .B(n44), .Y(n31) );
  NAND3X1 U48 ( .A(packet_in[7]), .B(packet_in[5]), .C(packet_in[0]), .Y(n44)
         );
  NAND3X1 U49 ( .A(n45), .B(n46), .C(n47), .Y(n43) );
  NOR2X1 U50 ( .A(packet_in[4]), .B(packet_in[3]), .Y(n47) );
  INVX1 U51 ( .A(packet_in[1]), .Y(n46) );
  XOR2X1 U52 ( .A(packet_in[6]), .B(packet_in[2]), .Y(n45) );
  NOR2X1 U53 ( .A(n48), .B(n49), .Y(n42) );
  OR2X1 U54 ( .A(n50), .B(packet_in[3]), .Y(n49) );
  INVX1 U55 ( .A(n51), .Y(n48) );
  INVX1 U56 ( .A(n30), .Y(n40) );
  NAND3X1 U57 ( .A(state[0]), .B(n27), .C(n52), .Y(n30) );
  NOR2X1 U58 ( .A(state[3]), .B(state[2]), .Y(n52) );
  INVX1 U59 ( .A(state[1]), .Y(n27) );
  OAI21X1 U60 ( .A(n53), .B(n54), .C(n29), .Y(n39) );
  NAND3X1 U61 ( .A(packet_in[3]), .B(n50), .C(n51), .Y(n29) );
  NOR2X1 U62 ( .A(n55), .B(n56), .Y(n51) );
  NAND3X1 U63 ( .A(packet_in[4]), .B(packet_in[2]), .C(packet_in[1]), .Y(n56)
         );
  NAND3X1 U64 ( .A(n57), .B(n58), .C(n37), .Y(n55) );
  INVX1 U65 ( .A(packet_in[0]), .Y(n37) );
  INVX1 U66 ( .A(packet_in[6]), .Y(n58) );
  INVX1 U67 ( .A(packet_in[5]), .Y(n57) );
  NAND2X1 U68 ( .A(packet_in[0]), .B(n33), .Y(n54) );
  INVX1 U69 ( .A(n59), .Y(n33) );
  NAND3X1 U70 ( .A(packet_in[5]), .B(packet_in[2]), .C(n60), .Y(n59) );
  NOR2X1 U71 ( .A(packet_in[6]), .B(packet_in[1]), .Y(n60) );
  NAND3X1 U72 ( .A(n61), .B(n50), .C(packet_in[3]), .Y(n53) );
  INVX1 U73 ( .A(packet_in[7]), .Y(n50) );
  INVX1 U74 ( .A(packet_in[4]), .Y(n61) );
endmodule


module usb_rx ( clk, n_rst, dplus_in, dminus_in, rx_packet, store_rx_packet, 
        rx_packet_data );
  output [2:0] rx_packet;
  output [7:0] rx_packet_data;
  input clk, n_rst, dplus_in, dminus_in;
  output store_rx_packet;
  wire   d_decoded, eop, shift_enable, byte_count, sync_byte;
  wire   [7:0] bit_period;
  wire   [7:0] packet_in;

  decoder DECODE ( .clk(clk), .n_rst(n_rst), .d_plus_in(dplus_in), 
        .d_minus_in(dminus_in), .d_decoded(d_decoded), .eop(eop) );
  timer TIME ( .clk(clk), .n_rst(n_rst), .bit_period({1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0}), .sync_byte(1'b0), .shift_enable(shift_enable), .byte_count(byte_count) );
  sr_8bit SR ( .clk(clk), .n_rst(n_rst), .shift_strobe(shift_enable), 
        .serial_in(d_decoded), .byte_done(byte_count), .packet_data(packet_in), 
        .sync_byte_detected(sync_byte) );
  control_fsm FSM ( .clk(clk), .n_rst(n_rst), .sync_byte(sync_byte), 
        .packet_in(packet_in), .eop(eop), .packet_data(rx_packet_data), 
        .rx_packet(rx_packet), .store_rx_data(store_rx_packet) );
endmodule

