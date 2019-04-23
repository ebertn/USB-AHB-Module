/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Thu Apr 18 12:31:57 2019
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
  wire   n5, n6, n104, n105, n106, n107, n108, n109, n110, n111, n112, n113,
         n114, n115, n116, n117, n118, n119, n120, n121, n122, n123, n124,
         n125, n126, n127, n128, n129, n130, n131, n132, n133, n134, n135,
         n136, n137, n138, n139, n140, n141, n142, n143, n144, n145, n146,
         n147, n148, n149, n150, n151, n152, n153, n154, n155, n156, n157,
         n158, n159, n160, n161, n162, n163, n164;
  wire   [3:0] next_state;
  wire   [31:0] state;
  assign tx_transfer_active = 1'b0;

  DFFSR \state_reg[0]  ( .D(n5), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0])
         );
  DFFSR \state_reg[3]  ( .D(next_state[3]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[3]) );
  DFFSR \state_reg[2]  ( .D(next_state[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[2]) );
  DFFSR \state_reg[1]  ( .D(n6), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1])
         );
  OAI21X1 U144 ( .A(state[1]), .B(n104), .C(n105), .Y(tx_packet[1]) );
  OAI21X1 U145 ( .A(state[0]), .B(n106), .C(n107), .Y(tx_packet[0]) );
  INVX1 U146 ( .A(n108), .Y(tx_error) );
  INVX1 U147 ( .A(n109), .Y(rx_error) );
  OR2X1 U148 ( .A(n110), .B(n111), .Y(next_state[3]) );
  OAI21X1 U149 ( .A(tx_status), .B(n105), .C(n112), .Y(n111) );
  NAND3X1 U150 ( .A(n113), .B(n114), .C(n115), .Y(n110) );
  NAND3X1 U151 ( .A(n116), .B(n114), .C(n117), .Y(next_state[2]) );
  INVX1 U152 ( .A(n118), .Y(n117) );
  OAI21X1 U153 ( .A(n119), .B(tx_status), .C(n120), .Y(n118) );
  NAND2X1 U154 ( .A(n121), .B(n122), .Y(n114) );
  NOR2X1 U155 ( .A(n123), .B(n124), .Y(n122) );
  NAND3X1 U156 ( .A(n125), .B(n113), .C(n109), .Y(n124) );
  NAND3X1 U157 ( .A(n126), .B(n108), .C(n127), .Y(n123) );
  NOR2X1 U158 ( .A(n128), .B(n129), .Y(n121) );
  NAND3X1 U159 ( .A(n119), .B(n105), .C(buffer_occupancy[6]), .Y(n129) );
  INVX1 U160 ( .A(n130), .Y(n105) );
  OAI21X1 U161 ( .A(n106), .B(n131), .C(n132), .Y(n130) );
  AOI21X1 U162 ( .A(n133), .B(n134), .C(n135), .Y(n119) );
  INVX1 U163 ( .A(n107), .Y(n135) );
  NAND3X1 U164 ( .A(n115), .B(n116), .C(n136), .Y(n128) );
  OR2X1 U165 ( .A(n137), .B(n138), .Y(n6) );
  OAI21X1 U166 ( .A(n139), .B(n115), .C(n120), .Y(n138) );
  AOI21X1 U167 ( .A(n140), .B(buffer_reserved), .C(n141), .Y(n120) );
  INVX1 U168 ( .A(n142), .Y(n141) );
  NAND3X1 U169 ( .A(n143), .B(n144), .C(rx_packet[1]), .Y(n142) );
  OAI21X1 U170 ( .A(n136), .B(n143), .C(n127), .Y(n140) );
  NAND3X1 U171 ( .A(state[1]), .B(n145), .C(n133), .Y(n127) );
  OAI21X1 U172 ( .A(tx_status), .B(n132), .C(n146), .Y(n137) );
  AND2X1 U173 ( .A(n147), .B(n112), .Y(n146) );
  OAI21X1 U174 ( .A(rx_packet[1]), .B(n148), .C(rx_transfer_active), .Y(n147)
         );
  NAND3X1 U175 ( .A(n149), .B(n145), .C(state[1]), .Y(n132) );
  NAND3X1 U176 ( .A(n150), .B(n151), .C(n152), .Y(n5) );
  AOI21X1 U177 ( .A(rx_transfer_active), .B(n153), .C(n154), .Y(n152) );
  OAI21X1 U178 ( .A(n148), .B(n155), .C(n112), .Y(n154) );
  NAND3X1 U179 ( .A(rx_packet[2]), .B(rx_packet[0]), .C(n156), .Y(n112) );
  NOR2X1 U180 ( .A(n136), .B(n157), .Y(n156) );
  NAND2X1 U181 ( .A(n139), .B(n158), .Y(n157) );
  OAI21X1 U182 ( .A(n158), .B(n139), .C(n144), .Y(n155) );
  INVX1 U183 ( .A(n136), .Y(n144) );
  NAND2X1 U184 ( .A(n134), .B(n159), .Y(n136) );
  INVX1 U185 ( .A(buffer_reserved), .Y(n139) );
  INVX1 U186 ( .A(rx_packet[1]), .Y(n158) );
  INVX1 U187 ( .A(n143), .Y(n148) );
  NOR2X1 U188 ( .A(n160), .B(rx_packet[0]), .Y(n143) );
  NAND3X1 U189 ( .A(rx_packet[0]), .B(n160), .C(rx_packet[1]), .Y(n153) );
  INVX1 U190 ( .A(rx_packet[2]), .Y(n160) );
  INVX1 U191 ( .A(n125), .Y(rx_transfer_active) );
  NAND2X1 U192 ( .A(n159), .B(n161), .Y(n125) );
  NAND2X1 U193 ( .A(rx_data_ready), .B(buffer_reserved), .Y(n151) );
  INVX1 U194 ( .A(n116), .Y(rx_data_ready) );
  NAND3X1 U195 ( .A(state[0]), .B(state[1]), .C(n159), .Y(n116) );
  MUX2X1 U196 ( .B(n162), .A(n163), .S(tx_status), .Y(n150) );
  INVX1 U197 ( .A(n113), .Y(n163) );
  NAND2X1 U198 ( .A(n134), .B(n149), .Y(n113) );
  OAI21X1 U199 ( .A(n106), .B(n131), .C(n107), .Y(n162) );
  NAND2X1 U200 ( .A(n133), .B(n161), .Y(n107) );
  INVX1 U201 ( .A(n161), .Y(n131) );
  NOR2X1 U202 ( .A(n145), .B(state[1]), .Y(n161) );
  INVX1 U203 ( .A(n149), .Y(n106) );
  INVX1 U204 ( .A(n115), .Y(d_mode) );
  NAND3X1 U205 ( .A(state[0]), .B(state[1]), .C(n133), .Y(n115) );
  INVX1 U206 ( .A(n104), .Y(n133) );
  NAND2X1 U207 ( .A(state[2]), .B(n164), .Y(n104) );
  NAND3X1 U208 ( .A(n126), .B(n108), .C(n109), .Y(clear) );
  NAND3X1 U209 ( .A(state[1]), .B(n145), .C(n159), .Y(n109) );
  NOR2X1 U210 ( .A(state[3]), .B(state[2]), .Y(n159) );
  INVX1 U211 ( .A(state[0]), .Y(n145) );
  NAND3X1 U212 ( .A(state[1]), .B(n149), .C(state[0]), .Y(n108) );
  NOR2X1 U213 ( .A(n164), .B(state[2]), .Y(n149) );
  INVX1 U214 ( .A(state[3]), .Y(n164) );
  NAND3X1 U215 ( .A(state[2]), .B(state[3]), .C(n134), .Y(n126) );
  NOR2X1 U216 ( .A(state[0]), .B(state[1]), .Y(n134) );
endmodule

