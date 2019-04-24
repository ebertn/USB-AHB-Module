/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Wed Apr 24 11:42:32 2019
/////////////////////////////////////////////////////////////


module control_fsm ( clk, n_rst, tx_packet_data, tx_packet_data_size, 
        tx_packet, rollover_flag8, rollover_flag64, rollover_flag512, stuffing, 
        calculated_crc, timer_count_enable, timer_clear, 
        timer_latch_packet_size, crc_clear, crc_shift, get_tx_packet_data, 
        pts_shift, pts_load, data_out, eop );
  input [7:0] tx_packet_data;
  input [6:0] tx_packet_data_size;
  input [1:0] tx_packet;
  input [15:0] calculated_crc;
  output [7:0] data_out;
  input clk, n_rst, rollover_flag8, rollover_flag64, rollover_flag512,
         stuffing;
  output timer_count_enable, timer_clear, timer_latch_packet_size, crc_clear,
         crc_shift, get_tx_packet_data, pts_shift, pts_load, eop;
  wire   n109, n110, n111, n112, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14,
         n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42,
         n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56,
         n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70,
         n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84,
         n85, n86, n87, n88, n89, n90, n91, n92;
  wire   [3:0] state;
  assign timer_count_enable = 1'b1;

  DFFSR \state_reg[0]  ( .D(n112), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0]) );
  DFFSR \state_reg[1]  ( .D(n110), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1]) );
  DFFSR \state_reg[2]  ( .D(n109), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[2]) );
  DFFSR \state_reg[3]  ( .D(n111), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[3]) );
  OAI21X1 U7 ( .A(n5), .B(n6), .C(n7), .Y(timer_clear) );
  NOR2X1 U8 ( .A(n8), .B(n9), .Y(pts_shift) );
  OR2X1 U9 ( .A(n10), .B(stuffing), .Y(n9) );
  NAND3X1 U10 ( .A(n11), .B(n12), .C(n13), .Y(pts_load) );
  NOR2X1 U11 ( .A(n14), .B(timer_latch_packet_size), .Y(n13) );
  INVX1 U12 ( .A(n5), .Y(crc_clear) );
  INVX1 U13 ( .A(n15), .Y(eop) );
  OAI21X1 U14 ( .A(n16), .B(n17), .C(n18), .Y(n112) );
  OAI21X1 U15 ( .A(n19), .B(n20), .C(n21), .Y(n18) );
  NAND2X1 U16 ( .A(n22), .B(n23), .Y(n20) );
  NAND2X1 U17 ( .A(n24), .B(n25), .Y(n19) );
  OAI21X1 U18 ( .A(tx_packet[0]), .B(tx_packet[1]), .C(n10), .Y(n24) );
  NOR2X1 U19 ( .A(n26), .B(state[0]), .Y(n10) );
  OAI21X1 U20 ( .A(n16), .B(n27), .C(n28), .Y(n111) );
  OAI21X1 U21 ( .A(n29), .B(n30), .C(n21), .Y(n28) );
  NAND2X1 U22 ( .A(n22), .B(n31), .Y(n30) );
  NAND3X1 U23 ( .A(n32), .B(n33), .C(n34), .Y(n29) );
  OAI21X1 U24 ( .A(n16), .B(n35), .C(n36), .Y(n110) );
  OAI21X1 U25 ( .A(n37), .B(n38), .C(n21), .Y(n36) );
  NAND3X1 U26 ( .A(n39), .B(n12), .C(n31), .Y(n38) );
  NAND3X1 U27 ( .A(n33), .B(n40), .C(n7), .Y(n37) );
  OAI21X1 U28 ( .A(n16), .B(n41), .C(n42), .Y(n109) );
  OAI21X1 U29 ( .A(n43), .B(n44), .C(n21), .Y(n42) );
  NAND2X1 U30 ( .A(n45), .B(n34), .Y(n44) );
  NAND3X1 U31 ( .A(n5), .B(n46), .C(n12), .Y(n43) );
  INVX1 U32 ( .A(n47), .Y(n16) );
  OAI21X1 U33 ( .A(n48), .B(n49), .C(n21), .Y(n47) );
  AOI21X1 U34 ( .A(n6), .B(n50), .C(stuffing), .Y(n21) );
  OAI21X1 U35 ( .A(n34), .B(rollover_flag8), .C(n51), .Y(n50) );
  NAND3X1 U36 ( .A(n34), .B(n11), .C(n51), .Y(n49) );
  INVX1 U37 ( .A(n52), .Y(n51) );
  NAND3X1 U38 ( .A(n32), .B(n40), .C(n23), .Y(n52) );
  INVX1 U39 ( .A(n53), .Y(n23) );
  NAND3X1 U40 ( .A(n45), .B(n5), .C(n54), .Y(n53) );
  AND2X1 U41 ( .A(n39), .B(n31), .Y(n54) );
  NAND2X1 U42 ( .A(n55), .B(n17), .Y(n31) );
  OR2X1 U43 ( .A(n56), .B(state[0]), .Y(n39) );
  NAND3X1 U44 ( .A(state[1]), .B(state[0]), .C(n55), .Y(n34) );
  NAND3X1 U45 ( .A(n7), .B(n15), .C(n12), .Y(n48) );
  NAND3X1 U46 ( .A(state[3]), .B(state[2]), .C(n57), .Y(n15) );
  NOR2X1 U47 ( .A(state[1]), .B(state[0]), .Y(n57) );
  AND2X1 U48 ( .A(rollover_flag64), .B(n58), .Y(get_tx_packet_data) );
  OAI21X1 U49 ( .A(stuffing), .B(n45), .C(n5), .Y(n58) );
  NAND3X1 U50 ( .A(n17), .B(n35), .C(n59), .Y(n5) );
  NAND3X1 U51 ( .A(n60), .B(n22), .C(n61), .Y(data_out[7]) );
  AOI21X1 U52 ( .A(tx_packet_data[7]), .B(n62), .C(n63), .Y(n61) );
  NAND2X1 U53 ( .A(n7), .B(n33), .Y(n63) );
  INVX1 U54 ( .A(timer_latch_packet_size), .Y(n7) );
  NOR2X1 U55 ( .A(n17), .B(n26), .Y(timer_latch_packet_size) );
  NAND3X1 U56 ( .A(n41), .B(n27), .C(n35), .Y(n26) );
  INVX1 U57 ( .A(n64), .Y(n22) );
  OAI21X1 U58 ( .A(n65), .B(n66), .C(n40), .Y(n64) );
  OR2X1 U59 ( .A(n11), .B(tx_packet[0]), .Y(n66) );
  AOI22X1 U60 ( .A(calculated_crc[15]), .B(n14), .C(calculated_crc[7]), .D(n67), .Y(n60) );
  OAI21X1 U61 ( .A(n25), .B(n68), .C(n69), .Y(data_out[6]) );
  AOI22X1 U62 ( .A(tx_packet_data[6]), .B(n62), .C(calculated_crc[14]), .D(n14), .Y(n69) );
  INVX1 U63 ( .A(calculated_crc[6]), .Y(n68) );
  NAND2X1 U64 ( .A(n70), .B(n71), .Y(data_out[5]) );
  AOI21X1 U65 ( .A(tx_packet_data[5]), .B(n62), .C(n72), .Y(n71) );
  AOI22X1 U66 ( .A(calculated_crc[13]), .B(n14), .C(calculated_crc[5]), .D(n67), .Y(n70) );
  NAND2X1 U67 ( .A(n73), .B(n74), .Y(data_out[4]) );
  AOI21X1 U68 ( .A(tx_packet_data[4]), .B(n62), .C(n75), .Y(n74) );
  OAI21X1 U69 ( .A(n76), .B(n11), .C(n77), .Y(n75) );
  NAND3X1 U70 ( .A(state[0]), .B(n35), .C(n55), .Y(n77) );
  AOI22X1 U71 ( .A(calculated_crc[12]), .B(n14), .C(calculated_crc[4]), .D(n67), .Y(n73) );
  NAND2X1 U72 ( .A(n78), .B(n79), .Y(data_out[3]) );
  AOI21X1 U73 ( .A(tx_packet_data[3]), .B(n62), .C(n80), .Y(n79) );
  INVX1 U74 ( .A(n46), .Y(n80) );
  NAND3X1 U75 ( .A(n81), .B(n65), .C(tx_packet[0]), .Y(n46) );
  INVX1 U76 ( .A(tx_packet[1]), .Y(n65) );
  AOI22X1 U77 ( .A(calculated_crc[11]), .B(n14), .C(calculated_crc[3]), .D(n67), .Y(n78) );
  NAND2X1 U78 ( .A(n82), .B(n83), .Y(data_out[2]) );
  AOI21X1 U79 ( .A(tx_packet_data[2]), .B(n62), .C(n72), .Y(n83) );
  NAND2X1 U80 ( .A(n11), .B(n40), .Y(n72) );
  NAND2X1 U81 ( .A(n55), .B(n84), .Y(n40) );
  XNOR2X1 U82 ( .A(n35), .B(state[0]), .Y(n84) );
  INVX1 U83 ( .A(n81), .Y(n11) );
  AOI22X1 U84 ( .A(calculated_crc[10]), .B(n14), .C(calculated_crc[2]), .D(n67), .Y(n82) );
  OAI21X1 U85 ( .A(n25), .B(n85), .C(n86), .Y(data_out[1]) );
  AOI22X1 U86 ( .A(tx_packet_data[1]), .B(n62), .C(calculated_crc[9]), .D(n14), 
        .Y(n86) );
  INVX1 U87 ( .A(calculated_crc[1]), .Y(n85) );
  INVX1 U88 ( .A(n67), .Y(n25) );
  NAND2X1 U89 ( .A(n87), .B(n88), .Y(data_out[0]) );
  AOI21X1 U90 ( .A(tx_packet_data[0]), .B(n62), .C(n89), .Y(n88) );
  OAI21X1 U91 ( .A(n90), .B(n91), .C(n33), .Y(n89) );
  NAND2X1 U92 ( .A(n76), .B(n81), .Y(n33) );
  NOR2X1 U93 ( .A(n56), .B(n17), .Y(n81) );
  NAND3X1 U94 ( .A(n41), .B(n27), .C(state[1]), .Y(n56) );
  XNOR2X1 U95 ( .A(tx_packet[0]), .B(tx_packet[1]), .Y(n76) );
  NAND2X1 U96 ( .A(state[1]), .B(n17), .Y(n91) );
  INVX1 U97 ( .A(n55), .Y(n90) );
  NOR2X1 U98 ( .A(n27), .B(state[2]), .Y(n55) );
  INVX1 U99 ( .A(state[3]), .Y(n27) );
  NOR2X1 U100 ( .A(n12), .B(rollover_flag512), .Y(n62) );
  AOI22X1 U101 ( .A(calculated_crc[8]), .B(n14), .C(calculated_crc[0]), .D(n67), .Y(n87) );
  NOR2X1 U102 ( .A(n92), .B(n12), .Y(n67) );
  NAND3X1 U103 ( .A(n59), .B(n35), .C(state[0]), .Y(n12) );
  INVX1 U104 ( .A(state[1]), .Y(n35) );
  INVX1 U105 ( .A(rollover_flag512), .Y(n92) );
  NOR2X1 U106 ( .A(n32), .B(n6), .Y(n14) );
  INVX1 U107 ( .A(rollover_flag64), .Y(n6) );
  NAND3X1 U108 ( .A(state[0]), .B(n59), .C(state[1]), .Y(n32) );
  NOR2X1 U109 ( .A(n8), .B(n45), .Y(crc_shift) );
  NAND3X1 U110 ( .A(n59), .B(n17), .C(state[1]), .Y(n45) );
  INVX1 U111 ( .A(state[0]), .Y(n17) );
  NOR2X1 U112 ( .A(n41), .B(state[3]), .Y(n59) );
  INVX1 U113 ( .A(state[2]), .Y(n41) );
  INVX1 U114 ( .A(rollover_flag8), .Y(n8) );
endmodule


module encoder ( clk, n_rst, serial_in, rollover_flag8, rollover_flag64, EOP, 
        dplus, dminus );
  input clk, n_rst, serial_in, rollover_flag8, rollover_flag64, EOP;
  output dplus, dminus;
  wire   n89, n90, n91, n92, n93, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11,
         n12, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40;
  wire   [31:0] state;

  DFFSR \state_reg[0]  ( .D(n93), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0])
         );
  DFFSR \state_reg[1]  ( .D(n91), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1])
         );
  DFFSR \state_reg[2]  ( .D(n92), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[2])
         );
  DFFSR dplus_reg ( .D(n90), .CLK(clk), .R(1'b1), .S(n_rst), .Q(dplus) );
  DFFSR dminus_reg ( .D(n89), .CLK(clk), .R(n_rst), .S(1'b1), .Q(dminus) );
  OAI21X1 U3 ( .A(n1), .B(n2), .C(n3), .Y(n93) );
  NOR2X1 U4 ( .A(EOP), .B(n4), .Y(n3) );
  OAI21X1 U5 ( .A(n1), .B(n5), .C(n6), .Y(n92) );
  AND2X1 U6 ( .A(n7), .B(n8), .Y(n6) );
  NOR2X1 U7 ( .A(n9), .B(n10), .Y(n1) );
  OAI21X1 U8 ( .A(n11), .B(n12), .C(n18), .Y(n91) );
  NAND2X1 U9 ( .A(n19), .B(n7), .Y(n18) );
  INVX1 U10 ( .A(EOP), .Y(n7) );
  OAI21X1 U11 ( .A(n9), .B(n8), .C(n20), .Y(n19) );
  AOI22X1 U12 ( .A(serial_in), .B(n4), .C(n10), .D(state[1]), .Y(n20) );
  INVX1 U13 ( .A(n21), .Y(n10) );
  NAND3X1 U14 ( .A(n22), .B(n23), .C(n24), .Y(n21) );
  INVX1 U20 ( .A(n25), .Y(n24) );
  INVX1 U21 ( .A(n26), .Y(n4) );
  NAND3X1 U22 ( .A(n12), .B(n2), .C(n27), .Y(n26) );
  INVX1 U23 ( .A(n12), .Y(n9) );
  OAI21X1 U24 ( .A(n2), .B(n25), .C(n28), .Y(n12) );
  NOR2X1 U25 ( .A(rollover_flag8), .B(EOP), .Y(n28) );
  NAND2X1 U26 ( .A(n8), .B(n29), .Y(n25) );
  NAND3X1 U27 ( .A(state[2]), .B(n11), .C(state[0]), .Y(n8) );
  MUX2X1 U28 ( .B(n30), .A(n31), .S(n23), .Y(n90) );
  AOI22X1 U29 ( .A(n32), .B(n27), .C(n33), .D(n34), .Y(n31) );
  MUX2X1 U30 ( .B(n35), .A(dplus), .S(state[0]), .Y(n32) );
  NOR2X1 U31 ( .A(dplus), .B(n34), .Y(n35) );
  MUX2X1 U32 ( .B(n34), .A(n36), .S(n23), .Y(n89) );
  NAND3X1 U33 ( .A(state[1]), .B(n5), .C(state[0]), .Y(n23) );
  AOI22X1 U34 ( .A(n37), .B(n27), .C(n33), .D(n30), .Y(n36) );
  INVX1 U35 ( .A(n38), .Y(n33) );
  OAI21X1 U36 ( .A(state[1]), .B(n2), .C(n39), .Y(n38) );
  AND2X1 U37 ( .A(n22), .B(n29), .Y(n39) );
  NAND3X1 U38 ( .A(state[1]), .B(n2), .C(state[2]), .Y(n29) );
  INVX1 U39 ( .A(n22), .Y(n27) );
  NAND2X1 U40 ( .A(n11), .B(n5), .Y(n22) );
  INVX1 U41 ( .A(state[2]), .Y(n5) );
  INVX1 U42 ( .A(state[1]), .Y(n11) );
  MUX2X1 U43 ( .B(n2), .A(n40), .S(dminus), .Y(n37) );
  NAND2X1 U44 ( .A(n30), .B(n2), .Y(n40) );
  INVX1 U45 ( .A(dplus), .Y(n30) );
  INVX1 U46 ( .A(state[0]), .Y(n2) );
  INVX1 U47 ( .A(dminus), .Y(n34) );
endmodule


module bit_stuffer ( clk, n_rst, serial_in, rollover_flag64, stuffing, 
        stuffed_serial_out );
  input clk, n_rst, serial_in, rollover_flag64;
  output stuffing, stuffed_serial_out;
  wire   n64, n65, n66, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15;
  wire   [31:0] state;

  DFFSR \state_reg[0]  ( .D(n66), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0])
         );
  DFFSR \state_reg[1]  ( .D(n65), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1])
         );
  DFFSR \state_reg[2]  ( .D(n64), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[2])
         );
  NOR2X1 U5 ( .A(stuffing), .B(n4), .Y(stuffed_serial_out) );
  INVX1 U6 ( .A(n5), .Y(stuffing) );
  NAND3X1 U7 ( .A(state[1]), .B(state[0]), .C(state[2]), .Y(n5) );
  MUX2X1 U8 ( .B(n6), .A(n7), .S(rollover_flag64), .Y(n66) );
  NAND2X1 U9 ( .A(serial_in), .B(n8), .Y(n7) );
  MUX2X1 U10 ( .B(state[0]), .A(state[1]), .S(state[2]), .Y(n8) );
  INVX1 U11 ( .A(state[0]), .Y(n6) );
  INVX1 U12 ( .A(n9), .Y(n65) );
  MUX2X1 U13 ( .B(n10), .A(n11), .S(state[1]), .Y(n9) );
  MUX2X1 U14 ( .B(n12), .A(n13), .S(state[2]), .Y(n64) );
  AOI21X1 U15 ( .A(serial_in), .B(n14), .C(n11), .Y(n13) );
  OAI21X1 U16 ( .A(state[0]), .B(n4), .C(rollover_flag64), .Y(n11) );
  INVX1 U17 ( .A(serial_in), .Y(n4) );
  INVX1 U18 ( .A(state[1]), .Y(n14) );
  NAND2X1 U19 ( .A(n10), .B(state[1]), .Y(n12) );
  INVX1 U20 ( .A(n15), .Y(n10) );
  NAND3X1 U21 ( .A(serial_in), .B(state[0]), .C(rollover_flag64), .Y(n15) );
endmodule


module flex_counter_NUM_CNT_BITS4_1 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   next_rollover_flag, n39, n40, n41, n42, n1, n2, n3, n4, n5, n6, n7,
         n8, n9, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26,
         n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n43, n44,
         n45, n46, n47, n48, n49, n50;

  DFFSR \count_out_reg[0]  ( .D(n42), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(n41), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(n40), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \count_out_reg[3]  ( .D(n39), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR rollover_flag_reg ( .D(next_rollover_flag), .CLK(clk), .R(n_rst), .S(
        1'b1), .Q(rollover_flag) );
  NOR2X1 U7 ( .A(n1), .B(n2), .Y(next_rollover_flag) );
  NAND3X1 U9 ( .A(n3), .B(count_enable), .C(n4), .Y(n2) );
  MUX2X1 U10 ( .B(n5), .A(n6), .S(n7), .Y(n4) );
  INVX1 U11 ( .A(rollover_val[0]), .Y(n7) );
  OAI21X1 U12 ( .A(n8), .B(n9), .C(count_out[0]), .Y(n6) );
  OAI21X1 U13 ( .A(count_out[1]), .B(n15), .C(n16), .Y(n5) );
  INVX1 U14 ( .A(rollover_val[1]), .Y(n15) );
  MUX2X1 U15 ( .B(n17), .A(n18), .S(n19), .Y(n3) );
  NOR2X1 U16 ( .A(rollover_val[3]), .B(rollover_val[2]), .Y(n17) );
  NAND3X1 U17 ( .A(n20), .B(n21), .C(n22), .Y(n1) );
  XNOR2X1 U18 ( .A(n23), .B(n24), .Y(n22) );
  OAI21X1 U19 ( .A(rollover_val[2]), .B(n19), .C(rollover_val[3]), .Y(n23) );
  INVX1 U20 ( .A(n8), .Y(n19) );
  OAI21X1 U21 ( .A(n25), .B(n9), .C(n8), .Y(n20) );
  NOR2X1 U22 ( .A(rollover_val[0]), .B(rollover_val[1]), .Y(n8) );
  OAI22X1 U23 ( .A(n16), .B(n26), .C(n27), .D(n28), .Y(n42) );
  INVX1 U24 ( .A(count_out[0]), .Y(n16) );
  OAI21X1 U25 ( .A(n9), .B(n26), .C(n29), .Y(n41) );
  MUX2X1 U26 ( .B(n30), .A(n31), .S(n32), .Y(n29) );
  NOR2X1 U27 ( .A(clear), .B(n27), .Y(n31) );
  NOR2X1 U28 ( .A(n28), .B(n33), .Y(n30) );
  OAI21X1 U29 ( .A(n34), .B(n26), .C(n35), .Y(n40) );
  MUX2X1 U30 ( .B(n36), .A(n37), .S(n38), .Y(n35) );
  NOR2X1 U31 ( .A(n28), .B(n43), .Y(n37) );
  AND2X1 U32 ( .A(n21), .B(n43), .Y(n36) );
  INVX1 U33 ( .A(count_out[2]), .Y(n34) );
  OAI22X1 U34 ( .A(n24), .B(n26), .C(n44), .D(n28), .Y(n39) );
  NAND2X1 U35 ( .A(n26), .B(n21), .Y(n28) );
  INVX1 U36 ( .A(clear), .Y(n21) );
  XOR2X1 U37 ( .A(n45), .B(n46), .Y(n44) );
  NOR2X1 U38 ( .A(n38), .B(n43), .Y(n46) );
  NAND2X1 U39 ( .A(n27), .B(n32), .Y(n43) );
  AND2X1 U40 ( .A(count_out[1]), .B(n47), .Y(n32) );
  INVX1 U41 ( .A(n33), .Y(n27) );
  NAND2X1 U42 ( .A(count_out[0]), .B(n47), .Y(n33) );
  NAND2X1 U43 ( .A(count_out[2]), .B(n47), .Y(n38) );
  NAND2X1 U44 ( .A(count_out[3]), .B(n47), .Y(n45) );
  NAND3X1 U45 ( .A(n48), .B(n49), .C(n50), .Y(n47) );
  AOI21X1 U46 ( .A(rollover_val[1]), .B(n9), .C(n18), .Y(n50) );
  OAI21X1 U47 ( .A(rollover_val[1]), .B(n9), .C(n25), .Y(n18) );
  XNOR2X1 U48 ( .A(count_out[2]), .B(rollover_val[2]), .Y(n25) );
  INVX1 U49 ( .A(count_out[1]), .Y(n9) );
  XNOR2X1 U50 ( .A(rollover_val[0]), .B(count_out[0]), .Y(n49) );
  XNOR2X1 U51 ( .A(rollover_val[3]), .B(count_out[3]), .Y(n48) );
  OR2X1 U52 ( .A(count_enable), .B(clear), .Y(n26) );
  INVX1 U53 ( .A(count_out[3]), .Y(n24) );
endmodule


module flex_counter_NUM_CNT_BITS4_0 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   next_rollover_flag, n1, n2, n3, n4, n5, n6, n7, n8, n9, n15, n16, n17,
         n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31,
         n32, n33, n34, n35, n36, n37, n38, n43, n44, n45, n46, n47, n48, n49,
         n50, n51, n52, n53, n54;

  DFFSR \count_out_reg[0]  ( .D(n51), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(n52), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(n53), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \count_out_reg[3]  ( .D(n54), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR rollover_flag_reg ( .D(next_rollover_flag), .CLK(clk), .R(n_rst), .S(
        1'b1), .Q(rollover_flag) );
  NOR2X1 U7 ( .A(n1), .B(n2), .Y(next_rollover_flag) );
  NAND3X1 U9 ( .A(n3), .B(count_enable), .C(n4), .Y(n2) );
  MUX2X1 U10 ( .B(n5), .A(n6), .S(n7), .Y(n4) );
  INVX1 U11 ( .A(rollover_val[0]), .Y(n7) );
  OAI21X1 U12 ( .A(n8), .B(n9), .C(count_out[0]), .Y(n6) );
  OAI21X1 U13 ( .A(count_out[1]), .B(n15), .C(n16), .Y(n5) );
  INVX1 U14 ( .A(rollover_val[1]), .Y(n15) );
  MUX2X1 U15 ( .B(n17), .A(n18), .S(n19), .Y(n3) );
  NOR2X1 U16 ( .A(rollover_val[3]), .B(rollover_val[2]), .Y(n17) );
  NAND3X1 U17 ( .A(n20), .B(n21), .C(n22), .Y(n1) );
  XNOR2X1 U18 ( .A(n23), .B(n24), .Y(n22) );
  OAI21X1 U19 ( .A(rollover_val[2]), .B(n19), .C(rollover_val[3]), .Y(n23) );
  INVX1 U20 ( .A(n8), .Y(n19) );
  OAI21X1 U21 ( .A(n25), .B(n9), .C(n8), .Y(n20) );
  NOR2X1 U22 ( .A(rollover_val[0]), .B(rollover_val[1]), .Y(n8) );
  OAI22X1 U23 ( .A(n16), .B(n26), .C(n27), .D(n28), .Y(n51) );
  INVX1 U24 ( .A(count_out[0]), .Y(n16) );
  OAI21X1 U25 ( .A(n9), .B(n26), .C(n29), .Y(n52) );
  MUX2X1 U26 ( .B(n30), .A(n31), .S(n32), .Y(n29) );
  NOR2X1 U27 ( .A(clear), .B(n27), .Y(n31) );
  NOR2X1 U28 ( .A(n28), .B(n33), .Y(n30) );
  OAI21X1 U29 ( .A(n34), .B(n26), .C(n35), .Y(n53) );
  MUX2X1 U30 ( .B(n36), .A(n37), .S(n38), .Y(n35) );
  NOR2X1 U31 ( .A(n28), .B(n43), .Y(n37) );
  AND2X1 U32 ( .A(n21), .B(n43), .Y(n36) );
  INVX1 U33 ( .A(count_out[2]), .Y(n34) );
  OAI22X1 U34 ( .A(n24), .B(n26), .C(n44), .D(n28), .Y(n54) );
  NAND2X1 U35 ( .A(n26), .B(n21), .Y(n28) );
  INVX1 U36 ( .A(clear), .Y(n21) );
  XOR2X1 U37 ( .A(n45), .B(n46), .Y(n44) );
  NOR2X1 U38 ( .A(n38), .B(n43), .Y(n46) );
  NAND2X1 U39 ( .A(n27), .B(n32), .Y(n43) );
  AND2X1 U40 ( .A(count_out[1]), .B(n47), .Y(n32) );
  INVX1 U41 ( .A(n33), .Y(n27) );
  NAND2X1 U42 ( .A(count_out[0]), .B(n47), .Y(n33) );
  NAND2X1 U43 ( .A(count_out[2]), .B(n47), .Y(n38) );
  NAND2X1 U44 ( .A(count_out[3]), .B(n47), .Y(n45) );
  NAND3X1 U45 ( .A(n48), .B(n49), .C(n50), .Y(n47) );
  AOI21X1 U46 ( .A(rollover_val[1]), .B(n9), .C(n18), .Y(n50) );
  OAI21X1 U47 ( .A(rollover_val[1]), .B(n9), .C(n25), .Y(n18) );
  XNOR2X1 U48 ( .A(count_out[2]), .B(rollover_val[2]), .Y(n25) );
  INVX1 U49 ( .A(count_out[1]), .Y(n9) );
  XNOR2X1 U50 ( .A(rollover_val[0]), .B(count_out[0]), .Y(n49) );
  XNOR2X1 U51 ( .A(rollover_val[3]), .B(count_out[3]), .Y(n48) );
  OR2X1 U52 ( .A(count_enable), .B(clear), .Y(n26) );
  INVX1 U53 ( .A(count_out[3]), .Y(n24) );
endmodule


module flex_counter_NUM_CNT_BITS7_DW01_inc_0 ( A, SUM );
  input [6:0] A;
  output [6:0] SUM;

  wire   [6:2] carry;

  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[6]), .B(A[6]), .Y(SUM[6]) );
endmodule


module flex_counter_NUM_CNT_BITS7 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [6:0] rollover_val;
  output [6:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   next_rollover_flag, N7, N8, N9, N10, N11, N12, N13, N26, N27, N28,
         N29, N30, N31, N32, n49, n50, n51, n52, n53, n54, n55, n1, n2, n3, n4,
         n5, n6, n7, n8, n9, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27,
         n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41,
         n42, n43, n44, n45, n46, n47, n48, n56, n57, n58, n59, n60, n61, n62,
         n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75;

  DFFSR \count_out_reg[0]  ( .D(n55), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(n54), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(n53), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \count_out_reg[3]  ( .D(n52), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR \count_out_reg[4]  ( .D(n51), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[4]) );
  DFFSR \count_out_reg[5]  ( .D(n50), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[5]) );
  DFFSR \count_out_reg[6]  ( .D(n49), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[6]) );
  DFFSR rollover_flag_reg ( .D(next_rollover_flag), .CLK(clk), .R(n_rst), .S(
        1'b1), .Q(rollover_flag) );
  flex_counter_NUM_CNT_BITS7_DW01_inc_0 add_46_aco ( .A({N32, N31, N30, N29, 
        N28, N27, N26}), .SUM({N13, N12, N11, N10, N9, N8, N7}) );
  NOR2X1 U7 ( .A(n1), .B(n2), .Y(next_rollover_flag) );
  NAND3X1 U8 ( .A(n3), .B(n4), .C(n5), .Y(n2) );
  NOR2X1 U13 ( .A(n6), .B(n7), .Y(n5) );
  XOR2X1 U14 ( .A(n8), .B(n9), .Y(n7) );
  MUX2X1 U15 ( .B(n18), .A(n19), .S(rollover_val[0]), .Y(n4) );
  OAI21X1 U16 ( .A(count_out[1]), .B(n20), .C(n21), .Y(n19) );
  OAI21X1 U17 ( .A(n22), .B(n23), .C(count_out[0]), .Y(n18) );
  MUX2X1 U18 ( .B(n24), .A(n25), .S(n22), .Y(n3) );
  INVX1 U19 ( .A(n26), .Y(n22) );
  NAND2X1 U20 ( .A(count_out[1]), .B(n27), .Y(n25) );
  XOR2X1 U21 ( .A(rollover_val[2]), .B(count_out[2]), .Y(n27) );
  NAND3X1 U22 ( .A(n28), .B(n29), .C(n30), .Y(n1) );
  NOR2X1 U23 ( .A(n31), .B(n32), .Y(n30) );
  OAI21X1 U24 ( .A(n8), .B(n33), .C(n34), .Y(n32) );
  OR2X1 U25 ( .A(rollover_val[5]), .B(rollover_val[6]), .Y(n33) );
  XOR2X1 U26 ( .A(n35), .B(count_out[4]), .Y(n31) );
  OAI21X1 U27 ( .A(n36), .B(n37), .C(n8), .Y(n35) );
  XOR2X1 U28 ( .A(n38), .B(n39), .Y(n29) );
  NAND2X1 U29 ( .A(n40), .B(n41), .Y(n39) );
  INVX1 U30 ( .A(n36), .Y(n41) );
  OAI21X1 U31 ( .A(rollover_val[2]), .B(n26), .C(rollover_val[3]), .Y(n40) );
  XOR2X1 U32 ( .A(n42), .B(count_out[6]), .Y(n28) );
  OAI21X1 U33 ( .A(rollover_val[5]), .B(n8), .C(rollover_val[6]), .Y(n42) );
  NAND2X1 U34 ( .A(n36), .B(n37), .Y(n8) );
  NOR3X1 U35 ( .A(rollover_val[2]), .B(rollover_val[3]), .C(n26), .Y(n36) );
  NAND2X1 U36 ( .A(n43), .B(n20), .Y(n26) );
  OAI21X1 U37 ( .A(n21), .B(n44), .C(n45), .Y(n55) );
  NAND2X1 U38 ( .A(N7), .B(n46), .Y(n45) );
  OAI21X1 U39 ( .A(n23), .B(n44), .C(n47), .Y(n54) );
  NAND2X1 U40 ( .A(N8), .B(n46), .Y(n47) );
  OAI21X1 U41 ( .A(n48), .B(n44), .C(n56), .Y(n53) );
  NAND2X1 U42 ( .A(N9), .B(n46), .Y(n56) );
  OAI21X1 U43 ( .A(n38), .B(n44), .C(n57), .Y(n52) );
  NAND2X1 U44 ( .A(N10), .B(n46), .Y(n57) );
  OAI21X1 U45 ( .A(n58), .B(n44), .C(n59), .Y(n51) );
  NAND2X1 U46 ( .A(N11), .B(n46), .Y(n59) );
  OAI21X1 U47 ( .A(n60), .B(n44), .C(n61), .Y(n50) );
  NAND2X1 U48 ( .A(N12), .B(n46), .Y(n61) );
  OAI21X1 U49 ( .A(n62), .B(n44), .C(n63), .Y(n49) );
  NAND2X1 U50 ( .A(N13), .B(n46), .Y(n63) );
  AND2X1 U51 ( .A(n44), .B(n34), .Y(n46) );
  NAND2X1 U52 ( .A(n34), .B(n6), .Y(n44) );
  INVX1 U53 ( .A(count_enable), .Y(n6) );
  INVX1 U54 ( .A(clear), .Y(n34) );
  NOR2X1 U55 ( .A(n64), .B(n62), .Y(N32) );
  INVX1 U56 ( .A(count_out[6]), .Y(n62) );
  NOR2X1 U57 ( .A(n64), .B(n60), .Y(N31) );
  NOR2X1 U58 ( .A(n64), .B(n58), .Y(N30) );
  INVX1 U59 ( .A(count_out[4]), .Y(n58) );
  NOR2X1 U60 ( .A(n64), .B(n38), .Y(N29) );
  INVX1 U61 ( .A(count_out[3]), .Y(n38) );
  NOR2X1 U62 ( .A(n64), .B(n48), .Y(N28) );
  NOR2X1 U63 ( .A(n64), .B(n23), .Y(N27) );
  NOR2X1 U64 ( .A(n64), .B(n21), .Y(N26) );
  INVX1 U65 ( .A(count_out[0]), .Y(n21) );
  INVX1 U66 ( .A(n65), .Y(n64) );
  NAND3X1 U67 ( .A(n66), .B(n67), .C(n68), .Y(n65) );
  NOR2X1 U68 ( .A(n69), .B(n70), .Y(n68) );
  NAND2X1 U69 ( .A(n71), .B(n72), .Y(n70) );
  INVX1 U70 ( .A(n24), .Y(n72) );
  OAI21X1 U71 ( .A(rollover_val[1]), .B(n23), .C(n73), .Y(n24) );
  XOR2X1 U72 ( .A(n48), .B(rollover_val[2]), .Y(n73) );
  INVX1 U73 ( .A(count_out[2]), .Y(n48) );
  INVX1 U74 ( .A(count_out[1]), .Y(n23) );
  XOR2X1 U75 ( .A(n43), .B(count_out[0]), .Y(n71) );
  INVX1 U76 ( .A(rollover_val[0]), .Y(n43) );
  OAI21X1 U77 ( .A(count_out[1]), .B(n20), .C(n9), .Y(n69) );
  XOR2X1 U78 ( .A(n60), .B(rollover_val[5]), .Y(n9) );
  INVX1 U79 ( .A(count_out[5]), .Y(n60) );
  INVX1 U80 ( .A(rollover_val[1]), .Y(n20) );
  XOR2X1 U81 ( .A(n37), .B(count_out[4]), .Y(n67) );
  INVX1 U82 ( .A(rollover_val[4]), .Y(n37) );
  NOR2X1 U83 ( .A(n74), .B(n75), .Y(n66) );
  XOR2X1 U84 ( .A(rollover_val[3]), .B(count_out[3]), .Y(n75) );
  XOR2X1 U85 ( .A(rollover_val[6]), .B(count_out[6]), .Y(n74) );
endmodule


module timer ( clk, n_rst, count_enable, tx_packet_size, latch_packet_size, 
        clear, rollover_flag8, rollover_flag64, rollover_flag512 );
  input [6:0] tx_packet_size;
  input clk, n_rst, count_enable, latch_packet_size, clear;
  output rollover_flag8, rollover_flag64, rollover_flag512;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n10, n12, n14, n16, n18, n20;
  wire   [6:0] saved_packet_size;

  DFFSR \saved_packet_size_reg[6]  ( .D(n8), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(saved_packet_size[6]) );
  DFFSR \saved_packet_size_reg[5]  ( .D(n10), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(saved_packet_size[5]) );
  DFFSR \saved_packet_size_reg[4]  ( .D(n12), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(saved_packet_size[4]) );
  DFFSR \saved_packet_size_reg[3]  ( .D(n14), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(saved_packet_size[3]) );
  DFFSR \saved_packet_size_reg[2]  ( .D(n16), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(saved_packet_size[2]) );
  DFFSR \saved_packet_size_reg[1]  ( .D(n18), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(saved_packet_size[1]) );
  DFFSR \saved_packet_size_reg[0]  ( .D(n20), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(saved_packet_size[0]) );
  flex_counter_NUM_CNT_BITS4_1 count8 ( .clk(clk), .n_rst(n_rst), .clear(clear), .count_enable(count_enable), .rollover_val({1'b1, 1'b0, 1'b0, 1'b0}), 
        .rollover_flag(rollover_flag8) );
  flex_counter_NUM_CNT_BITS4_0 count64 ( .clk(clk), .n_rst(n_rst), .clear(
        clear), .count_enable(rollover_flag8), .rollover_val({1'b1, 1'b0, 1'b0, 
        1'b0}), .rollover_flag(rollover_flag64) );
  flex_counter_NUM_CNT_BITS7 count512 ( .clk(clk), .n_rst(n_rst), .clear(clear), .count_enable(rollover_flag64), .rollover_val(saved_packet_size), 
        .rollover_flag(rollover_flag512) );
  INVX1 U3 ( .A(n1), .Y(n8) );
  MUX2X1 U4 ( .B(saved_packet_size[6]), .A(tx_packet_size[6]), .S(
        latch_packet_size), .Y(n1) );
  INVX1 U5 ( .A(n2), .Y(n10) );
  MUX2X1 U6 ( .B(saved_packet_size[5]), .A(tx_packet_size[5]), .S(
        latch_packet_size), .Y(n2) );
  INVX1 U7 ( .A(n3), .Y(n12) );
  MUX2X1 U8 ( .B(saved_packet_size[4]), .A(tx_packet_size[4]), .S(
        latch_packet_size), .Y(n3) );
  INVX1 U9 ( .A(n4), .Y(n14) );
  MUX2X1 U10 ( .B(saved_packet_size[3]), .A(tx_packet_size[3]), .S(
        latch_packet_size), .Y(n4) );
  INVX1 U11 ( .A(n5), .Y(n16) );
  MUX2X1 U12 ( .B(saved_packet_size[2]), .A(tx_packet_size[2]), .S(
        latch_packet_size), .Y(n5) );
  INVX1 U13 ( .A(n6), .Y(n18) );
  MUX2X1 U14 ( .B(saved_packet_size[1]), .A(tx_packet_size[1]), .S(
        latch_packet_size), .Y(n6) );
  INVX1 U15 ( .A(n7), .Y(n20) );
  MUX2X1 U16 ( .B(saved_packet_size[0]), .A(tx_packet_size[0]), .S(
        latch_packet_size), .Y(n7) );
endmodule


module flex_pts_sr_NUM_BITS8_SHIFT_MSB0 ( clk, n_rst, shift_enable, 
        load_enable, parallel_in, serial_out );
  input [7:0] parallel_in;
  input clk, n_rst, shift_enable, load_enable;
  output serial_out;
  wire   n29, n30, n31, n32, n33, n34, n35, n36, n9, n10, n11, n12, n13, n14,
         n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27;
  wire   [7:1] out_state;

  DFFSR \out_state_reg[7]  ( .D(n30), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        out_state[7]) );
  DFFSR \out_state_reg[6]  ( .D(n31), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        out_state[6]) );
  DFFSR \out_state_reg[5]  ( .D(n32), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        out_state[5]) );
  DFFSR \out_state_reg[4]  ( .D(n33), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        out_state[4]) );
  DFFSR \out_state_reg[3]  ( .D(n34), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        out_state[3]) );
  DFFSR \out_state_reg[2]  ( .D(n35), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        out_state[2]) );
  DFFSR \out_state_reg[1]  ( .D(n36), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        out_state[1]) );
  DFFSR \out_state_reg[0]  ( .D(n29), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        serial_out) );
  OAI21X1 U11 ( .A(n9), .B(n10), .C(n11), .Y(n36) );
  AOI22X1 U12 ( .A(out_state[1]), .B(n12), .C(out_state[2]), .D(n13), .Y(n11)
         );
  INVX1 U13 ( .A(parallel_in[1]), .Y(n10) );
  OAI21X1 U14 ( .A(n9), .B(n14), .C(n15), .Y(n35) );
  AOI22X1 U15 ( .A(out_state[2]), .B(n12), .C(out_state[3]), .D(n13), .Y(n15)
         );
  INVX1 U16 ( .A(parallel_in[2]), .Y(n14) );
  OAI21X1 U17 ( .A(n9), .B(n16), .C(n17), .Y(n34) );
  AOI22X1 U18 ( .A(out_state[3]), .B(n12), .C(out_state[4]), .D(n13), .Y(n17)
         );
  INVX1 U19 ( .A(parallel_in[3]), .Y(n16) );
  OAI21X1 U20 ( .A(n9), .B(n18), .C(n19), .Y(n33) );
  AOI22X1 U21 ( .A(out_state[4]), .B(n12), .C(out_state[5]), .D(n13), .Y(n19)
         );
  INVX1 U22 ( .A(parallel_in[4]), .Y(n18) );
  OAI21X1 U23 ( .A(n9), .B(n20), .C(n21), .Y(n32) );
  AOI22X1 U24 ( .A(out_state[5]), .B(n12), .C(out_state[6]), .D(n13), .Y(n21)
         );
  INVX1 U25 ( .A(parallel_in[5]), .Y(n20) );
  OAI21X1 U26 ( .A(n9), .B(n22), .C(n23), .Y(n31) );
  AOI22X1 U27 ( .A(out_state[6]), .B(n12), .C(out_state[7]), .D(n13), .Y(n23)
         );
  INVX1 U28 ( .A(parallel_in[6]), .Y(n22) );
  OAI21X1 U29 ( .A(n9), .B(n24), .C(n25), .Y(n30) );
  AOI21X1 U30 ( .A(out_state[7]), .B(n12), .C(n13), .Y(n25) );
  INVX1 U31 ( .A(parallel_in[7]), .Y(n24) );
  OAI21X1 U32 ( .A(n9), .B(n26), .C(n27), .Y(n29) );
  AOI22X1 U33 ( .A(serial_out), .B(n12), .C(n13), .D(out_state[1]), .Y(n27) );
  NOR2X1 U34 ( .A(load_enable), .B(n13), .Y(n12) );
  AND2X1 U35 ( .A(shift_enable), .B(n9), .Y(n13) );
  INVX1 U36 ( .A(parallel_in[0]), .Y(n26) );
  INVX1 U37 ( .A(load_enable), .Y(n9) );
endmodule


module pts_shift ( clk, n_rst, shift_enable, load_enable, parallel_in, 
        serial_out );
  input [7:0] parallel_in;
  input clk, n_rst, shift_enable, load_enable;
  output serial_out;


  flex_pts_sr_NUM_BITS8_SHIFT_MSB0 pts ( .clk(clk), .n_rst(n_rst), 
        .shift_enable(shift_enable), .load_enable(load_enable), .parallel_in(
        parallel_in), .serial_out(serial_out) );
endmodule


module crc_generator_16bit ( clk, nRst, din, shiftEn, clear, crc );
  output [15:0] crc;
  input clk, nRst, din, shiftEn, clear;
  wire   n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56,
         n57, n58, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41;

  DFFSR \crc_reg[0]  ( .D(n58), .CLK(clk), .R(nRst), .S(1'b1), .Q(crc[0]) );
  DFFSR \crc_reg[1]  ( .D(n57), .CLK(clk), .R(nRst), .S(1'b1), .Q(crc[1]) );
  DFFSR \crc_reg[2]  ( .D(n56), .CLK(clk), .R(nRst), .S(1'b1), .Q(crc[2]) );
  DFFSR \crc_reg[3]  ( .D(n55), .CLK(clk), .R(nRst), .S(1'b1), .Q(crc[3]) );
  DFFSR \crc_reg[4]  ( .D(n54), .CLK(clk), .R(nRst), .S(1'b1), .Q(crc[4]) );
  DFFSR \crc_reg[5]  ( .D(n53), .CLK(clk), .R(nRst), .S(1'b1), .Q(crc[5]) );
  DFFSR \crc_reg[6]  ( .D(n52), .CLK(clk), .R(nRst), .S(1'b1), .Q(crc[6]) );
  DFFSR \crc_reg[7]  ( .D(n51), .CLK(clk), .R(nRst), .S(1'b1), .Q(crc[7]) );
  DFFSR \crc_reg[8]  ( .D(n50), .CLK(clk), .R(nRst), .S(1'b1), .Q(crc[8]) );
  DFFSR \crc_reg[9]  ( .D(n49), .CLK(clk), .R(nRst), .S(1'b1), .Q(crc[9]) );
  DFFSR \crc_reg[10]  ( .D(n48), .CLK(clk), .R(nRst), .S(1'b1), .Q(crc[10]) );
  DFFSR \crc_reg[11]  ( .D(n47), .CLK(clk), .R(nRst), .S(1'b1), .Q(crc[11]) );
  DFFSR \crc_reg[12]  ( .D(n46), .CLK(clk), .R(nRst), .S(1'b1), .Q(crc[12]) );
  DFFSR \crc_reg[13]  ( .D(n45), .CLK(clk), .R(nRst), .S(1'b1), .Q(crc[13]) );
  DFFSR \crc_reg[14]  ( .D(n44), .CLK(clk), .R(nRst), .S(1'b1), .Q(crc[14]) );
  DFFSR \crc_reg[15]  ( .D(n43), .CLK(clk), .R(nRst), .S(1'b1), .Q(crc[15]) );
  BUFX2 U18 ( .A(n21), .Y(n17) );
  OR2X2 U19 ( .A(clear), .B(shiftEn), .Y(n18) );
  OAI22X1 U20 ( .A(n18), .B(n19), .C(n20), .D(n17), .Y(n58) );
  OAI22X1 U21 ( .A(n18), .B(n22), .C(n17), .D(n19), .Y(n57) );
  INVX1 U22 ( .A(crc[0]), .Y(n19) );
  INVX1 U23 ( .A(crc[1]), .Y(n22) );
  OAI22X1 U24 ( .A(n18), .B(n23), .C(n24), .D(n17), .Y(n56) );
  XOR2X1 U25 ( .A(crc[1]), .B(n20), .Y(n24) );
  XNOR2X1 U26 ( .A(crc[15]), .B(din), .Y(n20) );
  OAI22X1 U27 ( .A(n18), .B(n25), .C(n17), .D(n23), .Y(n55) );
  INVX1 U28 ( .A(crc[2]), .Y(n23) );
  OAI22X1 U29 ( .A(n18), .B(n26), .C(n17), .D(n25), .Y(n54) );
  INVX1 U30 ( .A(crc[3]), .Y(n25) );
  OAI22X1 U31 ( .A(n18), .B(n27), .C(n17), .D(n26), .Y(n53) );
  INVX1 U32 ( .A(crc[4]), .Y(n26) );
  OAI22X1 U33 ( .A(n18), .B(n28), .C(n17), .D(n27), .Y(n52) );
  INVX1 U34 ( .A(crc[5]), .Y(n27) );
  OAI22X1 U35 ( .A(n18), .B(n29), .C(n17), .D(n28), .Y(n51) );
  INVX1 U36 ( .A(crc[6]), .Y(n28) );
  OAI22X1 U37 ( .A(n18), .B(n30), .C(n17), .D(n29), .Y(n50) );
  INVX1 U38 ( .A(crc[7]), .Y(n29) );
  OAI22X1 U39 ( .A(n18), .B(n31), .C(n17), .D(n30), .Y(n49) );
  INVX1 U40 ( .A(crc[8]), .Y(n30) );
  OAI22X1 U41 ( .A(n18), .B(n32), .C(n17), .D(n31), .Y(n48) );
  INVX1 U42 ( .A(crc[9]), .Y(n31) );
  OAI22X1 U43 ( .A(n18), .B(n33), .C(n17), .D(n32), .Y(n47) );
  INVX1 U44 ( .A(crc[10]), .Y(n32) );
  OAI22X1 U45 ( .A(n18), .B(n34), .C(n17), .D(n33), .Y(n46) );
  INVX1 U46 ( .A(crc[11]), .Y(n33) );
  OAI22X1 U47 ( .A(n18), .B(n35), .C(n17), .D(n34), .Y(n45) );
  INVX1 U48 ( .A(crc[12]), .Y(n34) );
  OAI22X1 U49 ( .A(n18), .B(n36), .C(n17), .D(n35), .Y(n44) );
  INVX1 U50 ( .A(crc[13]), .Y(n35) );
  NAND2X1 U51 ( .A(n37), .B(n18), .Y(n21) );
  MUX2X1 U52 ( .B(n38), .A(n39), .S(crc[15]), .Y(n43) );
  INVX1 U53 ( .A(n40), .Y(n39) );
  OAI21X1 U54 ( .A(n41), .B(clear), .C(n18), .Y(n40) );
  NAND3X1 U55 ( .A(n41), .B(n37), .C(shiftEn), .Y(n38) );
  INVX1 U56 ( .A(clear), .Y(n37) );
  XNOR2X1 U57 ( .A(n36), .B(din), .Y(n41) );
  INVX1 U58 ( .A(crc[14]), .Y(n36) );
endmodule


module usb_tx ( clk, n_rst, tx_packet_data, tx_packet_data_size, tx_packet, 
        tx_status, get_tx_packet_data, dplus_out, dminus_out );
  input [7:0] tx_packet_data;
  input [6:0] tx_packet_data_size;
  input [1:0] tx_packet;
  input clk, n_rst;
  output tx_status, get_tx_packet_data, dplus_out, dminus_out;
  wire   rollover_flag8, rollover_flag64, rollover_flag512, stuffing,
         timer_clear, timer_latch_packet_size, crc_clear, crc_shift,
         pts_shift_en, pts_load, stuffed_serial_out, pts_serial_out;
  wire   [15:0] calculated_crc;
  wire   [7:0] fsm_data_out;

  control_fsm fsm ( .clk(clk), .n_rst(n_rst), .tx_packet_data(tx_packet_data), 
        .tx_packet_data_size(tx_packet_data_size), .tx_packet(tx_packet), 
        .rollover_flag8(rollover_flag8), .rollover_flag64(rollover_flag64), 
        .rollover_flag512(rollover_flag512), .stuffing(stuffing), 
        .calculated_crc(calculated_crc), .timer_clear(timer_clear), 
        .timer_latch_packet_size(timer_latch_packet_size), .crc_clear(
        crc_clear), .crc_shift(crc_shift), .get_tx_packet_data(
        get_tx_packet_data), .pts_shift(pts_shift_en), .pts_load(pts_load), 
        .data_out(fsm_data_out), .eop(tx_status) );
  encoder encoder ( .clk(clk), .n_rst(n_rst), .serial_in(stuffed_serial_out), 
        .rollover_flag8(rollover_flag8), .rollover_flag64(rollover_flag64), 
        .EOP(tx_status), .dplus(dplus_out), .dminus(dminus_out) );
  bit_stuffer bit_stuffer ( .clk(clk), .n_rst(n_rst), .serial_in(
        pts_serial_out), .rollover_flag64(rollover_flag64), .stuffing(stuffing), .stuffed_serial_out(stuffed_serial_out) );
  timer timer ( .clk(clk), .n_rst(n_rst), .count_enable(1'b1), 
        .tx_packet_size(tx_packet_data_size), .latch_packet_size(
        timer_latch_packet_size), .clear(timer_clear), .rollover_flag8(
        rollover_flag8), .rollover_flag64(rollover_flag64), .rollover_flag512(
        rollover_flag512) );
  pts_shift pts_shift ( .clk(clk), .n_rst(n_rst), .shift_enable(pts_shift_en), 
        .load_enable(pts_load), .parallel_in(fsm_data_out), .serial_out(
        pts_serial_out) );
  crc_generator_16bit crc ( .clk(clk), .nRst(n_rst), .din(pts_serial_out), 
        .shiftEn(crc_shift), .clear(crc_clear), .crc(calculated_crc) );
endmodule

