/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Wed Apr 24 04:42:59 2019
/////////////////////////////////////////////////////////////


module decoder ( clk, n_rst, d_plus_in, d_minus_in, start, d_decoded, eop );
  input clk, n_rst, d_plus_in, d_minus_in;
  output start, d_decoded, eop;
  wire   n63, n64, n65, n66, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26,
         n27, n28, n29, n35, n36, n37, n38, n39, n40, n41, n42;
  wire   [2:0] state;

  DFFSR \state_reg[0]  ( .D(n66), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0])
         );
  DFFSR \state_reg[2]  ( .D(n65), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[2])
         );
  DFFSR \state_reg[1]  ( .D(n64), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1])
         );
  DFFSR start_reg ( .D(n63), .CLK(clk), .R(n_rst), .S(1'b1), .Q(start) );
  DFFSR d_decoded_reg ( .D(n42), .CLK(clk), .R(n_rst), .S(1'b1), .Q(d_decoded)
         );
  MUX2X1 U3 ( .B(n1), .A(n2), .S(n3), .Y(n42) );
  AOI21X1 U4 ( .A(n4), .B(n5), .C(n6), .Y(n3) );
  NOR2X1 U5 ( .A(n7), .B(n8), .Y(n6) );
  MUX2X1 U6 ( .B(n9), .A(n10), .S(n11), .Y(n1) );
  AND2X1 U7 ( .A(n12), .B(n13), .Y(n11) );
  OAI21X1 U8 ( .A(n2), .B(n5), .C(n14), .Y(n9) );
  INVX1 U9 ( .A(d_decoded), .Y(n2) );
  OR2X1 U10 ( .A(n15), .B(n16), .Y(n66) );
  OAI21X1 U11 ( .A(n7), .B(n12), .C(n17), .Y(n16) );
  MUX2X1 U12 ( .B(n18), .A(n19), .S(state[0]), .Y(n15) );
  NAND2X1 U13 ( .A(n10), .B(n5), .Y(n18) );
  NAND2X1 U14 ( .A(n20), .B(n21), .Y(n65) );
  AOI22X1 U15 ( .A(n22), .B(n10), .C(n23), .D(state[2]), .Y(n21) );
  AOI22X1 U16 ( .A(n24), .B(n25), .C(state[2]), .D(n26), .Y(n20) );
  OAI21X1 U17 ( .A(n7), .B(n22), .C(n13), .Y(n26) );
  INVX1 U18 ( .A(n14), .Y(n24) );
  NAND3X1 U19 ( .A(n27), .B(n5), .C(d_minus_in), .Y(n14) );
  INVX1 U20 ( .A(state[1]), .Y(n5) );
  OR2X1 U21 ( .A(n28), .B(n29), .Y(n64) );
  OAI21X1 U22 ( .A(n8), .B(n35), .C(n17), .Y(n29) );
  INVX1 U23 ( .A(n36), .Y(n17) );
  OAI21X1 U24 ( .A(n37), .B(n38), .C(n13), .Y(n36) );
  NAND2X1 U25 ( .A(n7), .B(state[1]), .Y(n38) );
  NAND2X1 U26 ( .A(n19), .B(n8), .Y(n37) );
  OAI21X1 U27 ( .A(state[1]), .B(n25), .C(n39), .Y(n35) );
  INVX1 U28 ( .A(d_minus_in), .Y(n39) );
  MUX2X1 U29 ( .B(n4), .A(n40), .S(n23), .Y(n28) );
  INVX1 U30 ( .A(n19), .Y(n23) );
  NAND2X1 U31 ( .A(d_minus_in), .B(d_plus_in), .Y(n19) );
  NAND2X1 U32 ( .A(state[1]), .B(state[2]), .Y(n40) );
  INVX1 U33 ( .A(n7), .Y(n4) );
  AOI21X1 U39 ( .A(n27), .B(d_minus_in), .C(n10), .Y(n7) );
  NOR2X1 U40 ( .A(n27), .B(d_minus_in), .Y(n10) );
  INVX1 U41 ( .A(d_plus_in), .Y(n27) );
  NAND2X1 U42 ( .A(n12), .B(n41), .Y(n63) );
  OAI21X1 U43 ( .A(state[0]), .B(state[1]), .C(start), .Y(n41) );
  INVX1 U44 ( .A(n22), .Y(n12) );
  NOR2X1 U45 ( .A(n25), .B(state[1]), .Y(n22) );
  XOR2X1 U46 ( .A(state[0]), .B(n8), .Y(n25) );
  INVX1 U47 ( .A(state[2]), .Y(n8) );
  NOR2X1 U48 ( .A(state[2]), .B(n13), .Y(eop) );
  NAND2X1 U49 ( .A(state[1]), .B(state[0]), .Y(n13) );
endmodule


module crc_checker_5bit ( clk, nRst, din, clear, crcError );
  input clk, nRst, din, clear;
  output crcError;
  wire   N3, N4, N5, N6, N7, N8, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17;
  wire   [5:0] q;

  DFFSR \q_reg[0]  ( .D(N3), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[0]) );
  DFFSR \q_reg[1]  ( .D(N4), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[1]) );
  DFFSR \q_reg[2]  ( .D(N5), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[2]) );
  DFFSR \q_reg[3]  ( .D(N6), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[3]) );
  DFFSR \q_reg[4]  ( .D(N7), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[4]) );
  DFFSR \q_reg[5]  ( .D(N8), .CLK(clk), .R(nRst), .S(1'b1), .Q(q[5]) );
  OR2X1 U9 ( .A(n7), .B(n8), .Y(crcError) );
  NAND3X1 U10 ( .A(n9), .B(n10), .C(n11), .Y(n8) );
  INVX1 U11 ( .A(q[0]), .Y(n11) );
  INVX1 U12 ( .A(q[2]), .Y(n10) );
  NAND3X1 U13 ( .A(n12), .B(n13), .C(n14), .Y(n7) );
  INVX1 U14 ( .A(q[5]), .Y(n13) );
  NOR2X1 U15 ( .A(clear), .B(n12), .Y(N8) );
  INVX1 U16 ( .A(q[4]), .Y(n12) );
  NOR2X1 U17 ( .A(clear), .B(n14), .Y(N7) );
  INVX1 U18 ( .A(q[3]), .Y(n14) );
  NOR2X1 U19 ( .A(clear), .B(n15), .Y(N6) );
  XNOR2X1 U20 ( .A(q[2]), .B(q[5]), .Y(n15) );
  NOR2X1 U21 ( .A(clear), .B(n9), .Y(N5) );
  INVX1 U22 ( .A(q[1]), .Y(n9) );
  NOR2X1 U23 ( .A(clear), .B(n16), .Y(N4) );
  XNOR2X1 U24 ( .A(q[0]), .B(q[5]), .Y(n16) );
  NOR2X1 U25 ( .A(n17), .B(clear), .Y(N3) );
  INVX1 U26 ( .A(din), .Y(n17) );
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


module control_fsm ( clk, n_rst, sync_byte, packet_in, eop, five_crc, 
        five_crc_clear, packet_data, rx_packet, store_rx_data );
  input [7:0] packet_in;
  output [7:0] packet_data;
  output [2:0] rx_packet;
  input clk, n_rst, sync_byte, eop, five_crc;
  output five_crc_clear, store_rx_data;
  wire   n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19,
         n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33,
         n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         n48, n49, n50, n51, n52, n53, n54, n55, n56, n57;
  wire   [3:0] state;
  wire   [3:0] next_state;

  DFFSR \state_reg[3]  ( .D(next_state[3]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[3]) );
  DFFSR \state_reg[2]  ( .D(next_state[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[2]) );
  DFFSR \state_reg[1]  ( .D(next_state[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[1]) );
  DFFSR \state_reg[0]  ( .D(next_state[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[0]) );
  NOR2X1 U4 ( .A(n5), .B(n6), .Y(store_rx_data) );
  NOR2X1 U8 ( .A(n7), .B(n8), .Y(rx_packet[2]) );
  OAI21X1 U9 ( .A(n9), .B(n7), .C(n10), .Y(rx_packet[1]) );
  INVX1 U10 ( .A(n11), .Y(n9) );
  OAI21X1 U11 ( .A(n12), .B(n7), .C(n10), .Y(rx_packet[0]) );
  NAND3X1 U12 ( .A(n13), .B(n14), .C(n15), .Y(n7) );
  INVX1 U13 ( .A(n16), .Y(n12) );
  OAI21X1 U14 ( .A(n17), .B(n18), .C(n19), .Y(n16) );
  NAND2X1 U15 ( .A(n20), .B(packet_in[3]), .Y(n17) );
  NOR2X1 U16 ( .A(n5), .B(n20), .Y(packet_data[7]) );
  NOR2X1 U17 ( .A(n5), .B(n21), .Y(packet_data[6]) );
  NOR2X1 U18 ( .A(n5), .B(n22), .Y(packet_data[5]) );
  INVX1 U19 ( .A(packet_in[5]), .Y(n22) );
  NOR2X1 U20 ( .A(n5), .B(n23), .Y(packet_data[4]) );
  NOR2X1 U21 ( .A(n5), .B(n24), .Y(packet_data[3]) );
  NOR2X1 U22 ( .A(n5), .B(n25), .Y(packet_data[2]) );
  INVX1 U23 ( .A(packet_in[2]), .Y(n25) );
  NOR2X1 U24 ( .A(n5), .B(n26), .Y(packet_data[1]) );
  NOR2X1 U25 ( .A(n5), .B(n27), .Y(packet_data[0]) );
  NAND3X1 U26 ( .A(state[2]), .B(n28), .C(n29), .Y(n5) );
  NOR2X1 U27 ( .A(state[3]), .B(state[1]), .Y(n29) );
  OAI21X1 U28 ( .A(n30), .B(n14), .C(n31), .Y(next_state[3]) );
  MUX2X1 U29 ( .B(n32), .A(n33), .S(state[2]), .Y(next_state[2]) );
  NOR2X1 U30 ( .A(state[3]), .B(n30), .Y(n33) );
  MUX2X1 U31 ( .B(n34), .A(state[0]), .S(state[1]), .Y(n30) );
  NOR2X1 U32 ( .A(state[0]), .B(n6), .Y(n34) );
  INVX1 U33 ( .A(eop), .Y(n6) );
  OAI21X1 U34 ( .A(n11), .B(n35), .C(n15), .Y(n32) );
  OAI21X1 U35 ( .A(n24), .B(n36), .C(n13), .Y(n35) );
  NAND2X1 U36 ( .A(n37), .B(n20), .Y(n36) );
  OAI21X1 U37 ( .A(n38), .B(n39), .C(n18), .Y(n37) );
  OAI21X1 U38 ( .A(n18), .B(n40), .C(n19), .Y(n11) );
  NAND3X1 U39 ( .A(n41), .B(n24), .C(n42), .Y(n19) );
  NOR2X1 U40 ( .A(n20), .B(n39), .Y(n42) );
  NAND3X1 U41 ( .A(packet_in[0]), .B(packet_in[5]), .C(n43), .Y(n39) );
  NOR2X1 U42 ( .A(packet_in[4]), .B(packet_in[1]), .Y(n43) );
  INVX1 U43 ( .A(packet_in[7]), .Y(n20) );
  OAI21X1 U44 ( .A(packet_in[2]), .B(n21), .C(n38), .Y(n41) );
  NAND2X1 U45 ( .A(packet_in[7]), .B(n24), .Y(n40) );
  INVX1 U46 ( .A(packet_in[3]), .Y(n24) );
  NAND3X1 U47 ( .A(n44), .B(n45), .C(n46), .Y(n18) );
  NOR2X1 U48 ( .A(n23), .B(n26), .Y(n46) );
  INVX1 U49 ( .A(packet_in[4]), .Y(n23) );
  NOR2X1 U50 ( .A(packet_in[5]), .B(packet_in[0]), .Y(n44) );
  MUX2X1 U51 ( .B(n13), .A(n47), .S(n15), .Y(next_state[1]) );
  NOR2X1 U52 ( .A(n28), .B(state[3]), .Y(n15) );
  INVX1 U53 ( .A(state[0]), .Y(n28) );
  OAI21X1 U54 ( .A(n48), .B(state[2]), .C(n13), .Y(n47) );
  MUX2X1 U55 ( .B(n49), .A(n50), .S(state[0]), .Y(next_state[0]) );
  AOI21X1 U56 ( .A(n51), .B(n8), .C(state[3]), .Y(n50) );
  INVX1 U57 ( .A(n48), .Y(n8) );
  NOR2X1 U58 ( .A(n52), .B(n53), .Y(n48) );
  NAND3X1 U59 ( .A(packet_in[4]), .B(n45), .C(packet_in[5]), .Y(n53) );
  INVX1 U60 ( .A(n38), .Y(n45) );
  NAND2X1 U61 ( .A(packet_in[2]), .B(n21), .Y(n38) );
  INVX1 U62 ( .A(packet_in[6]), .Y(n21) );
  NAND3X1 U63 ( .A(n27), .B(n26), .C(n54), .Y(n52) );
  XOR2X1 U64 ( .A(packet_in[7]), .B(packet_in[3]), .Y(n54) );
  INVX1 U65 ( .A(packet_in[1]), .Y(n26) );
  INVX1 U66 ( .A(packet_in[0]), .Y(n27) );
  NOR2X1 U67 ( .A(state[2]), .B(state[1]), .Y(n51) );
  OAI21X1 U68 ( .A(n55), .B(state[1]), .C(n31), .Y(n49) );
  INVX1 U69 ( .A(state[3]), .Y(n31) );
  AND2X1 U70 ( .A(sync_byte), .B(n14), .Y(n55) );
  INVX1 U71 ( .A(n10), .Y(five_crc_clear) );
  NAND3X1 U72 ( .A(state[3]), .B(five_crc), .C(n56), .Y(n10) );
  NOR2X1 U73 ( .A(state[0]), .B(n57), .Y(n56) );
  NAND2X1 U74 ( .A(n13), .B(n14), .Y(n57) );
  INVX1 U75 ( .A(state[2]), .Y(n14) );
  INVX1 U76 ( .A(state[1]), .Y(n13) );
endmodule


module usb_rx ( clk, n_rst, dplus_in, dminus_in, rx_packet, store_rx_packet, 
        rx_packet_data );
  output [2:0] rx_packet;
  output [7:0] rx_packet_data;
  input clk, n_rst, dplus_in, dminus_in;
  output store_rx_packet;
  wire   start, d_decoded, eop, five_crc_clear, five_crc, byte_count,
         sync_byte;
  wire   [7:0] bit_period;
  wire   [7:0] packet_in;

  decoder DECODE ( .clk(clk), .n_rst(n_rst), .d_plus_in(dplus_in), 
        .d_minus_in(dminus_in), .start(start), .d_decoded(d_decoded), .eop(eop) );
  crc_checker_5bit CHECK ( .clk(clk), .nRst(n_rst), .din(d_decoded), .clear(
        five_crc_clear), .crcError(five_crc) );
  timer TIME ( .clk(clk), .n_rst(n_rst), .bit_period({1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0}), .start(start), .byte_count(byte_count) );
  sr_8bit SR ( .clk(clk), .n_rst(n_rst), .shift_strobe(start), .serial_in(
        d_decoded), .byte_done(byte_count), .packet_data(packet_in), 
        .sync_byte_detected(sync_byte) );
  control_fsm FSM ( .clk(clk), .n_rst(n_rst), .sync_byte(sync_byte), 
        .packet_in(packet_in), .eop(eop), .five_crc(five_crc), 
        .five_crc_clear(five_crc_clear), .packet_data(rx_packet_data), 
        .rx_packet(rx_packet), .store_rx_data(store_rx_packet) );
endmodule

