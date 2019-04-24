/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Tue Apr 23 18:31:16 2019
/////////////////////////////////////////////////////////////


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
         n173, n174, n175, n176, n177, n178, n179, n180, n181, n182, n183,
         n185, n193, n194, n195, n196, n197, n198, n199, n200, n201, n202,
         n203, n204, n205, n206, n207, n208, n209, n210, n211, n212, n213,
         n214, n215, n216, n217, n218, n219, n220, n221, n222, n223, n224,
         n225, n226, n227, n228, n229, n230, n231, n232, n233, n234, n235;
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
  AND2X2 U33 ( .A(n83), .B(n195), .Y(n82) );
  AND2X2 U34 ( .A(hwdata[15]), .B(n80), .Y(txData[15]) );
  AND2X2 U35 ( .A(hwdata[14]), .B(n80), .Y(txData[14]) );
  AND2X2 U36 ( .A(hwdata[13]), .B(n80), .Y(txData[13]) );
  AND2X2 U37 ( .A(hwdata[12]), .B(n80), .Y(txData[12]) );
  AND2X2 U38 ( .A(hwdata[11]), .B(n80), .Y(txData[11]) );
  AND2X2 U39 ( .A(hwdata[10]), .B(n80), .Y(txData[10]) );
  AND2X2 U40 ( .A(rdata[31]), .B(n185), .Y(hrdata[31]) );
  AND2X2 U41 ( .A(rdata[30]), .B(n185), .Y(hrdata[30]) );
  AND2X2 U42 ( .A(rdata[29]), .B(n185), .Y(hrdata[29]) );
  AND2X2 U43 ( .A(rdata[28]), .B(n185), .Y(hrdata[28]) );
  AND2X2 U44 ( .A(rdata[27]), .B(n185), .Y(hrdata[27]) );
  AND2X2 U45 ( .A(rdata[26]), .B(n185), .Y(hrdata[26]) );
  AND2X2 U46 ( .A(rdata[25]), .B(n185), .Y(hrdata[25]) );
  AND2X2 U47 ( .A(rdata[24]), .B(n185), .Y(hrdata[24]) );
  AND2X2 U48 ( .A(rdata[23]), .B(n185), .Y(hrdata[23]) );
  AND2X2 U49 ( .A(rdata[22]), .B(n185), .Y(hrdata[22]) );
  AND2X2 U50 ( .A(rdata[21]), .B(n185), .Y(hrdata[21]) );
  AND2X2 U51 ( .A(rdata[20]), .B(n185), .Y(hrdata[20]) );
  AND2X2 U52 ( .A(rdata[19]), .B(n185), .Y(hrdata[19]) );
  AND2X2 U53 ( .A(rdata[18]), .B(n185), .Y(hrdata[18]) );
  AND2X2 U54 ( .A(rdata[17]), .B(n185), .Y(hrdata[17]) );
  AND2X2 U55 ( .A(rdata[16]), .B(n185), .Y(hrdata[16]) );
  AND2X2 U56 ( .A(n226), .B(n151), .Y(n96) );
  AND2X2 U57 ( .A(n224), .B(n151), .Y(n95) );
  AND2X2 U58 ( .A(n152), .B(n175), .Y(n151) );
  AND2X2 U59 ( .A(n229), .B(n86), .Y(n104) );
  AND2X2 U60 ( .A(prevSize[1]), .B(n235), .Y(n83) );
  AND2X2 U61 ( .A(n158), .B(n88), .Y(n107) );
  NOR2X1 U123 ( .A(n81), .B(n176), .Y(txData[7]) );
  NOR2X1 U124 ( .A(n81), .B(n177), .Y(txData[6]) );
  NOR2X1 U125 ( .A(n81), .B(n178), .Y(txData[5]) );
  NOR2X1 U126 ( .A(n81), .B(n179), .Y(txData[4]) );
  NOR2X1 U127 ( .A(n81), .B(n180), .Y(txData[3]) );
  NOR2X1 U128 ( .A(n81), .B(n181), .Y(txData[2]) );
  NOR2X1 U129 ( .A(n81), .B(n182), .Y(txData[1]) );
  NOR2X1 U130 ( .A(n84), .B(n85), .Y(n80) );
  NOR2X1 U131 ( .A(n81), .B(n183), .Y(txData[0]) );
  NAND2X1 U132 ( .A(n195), .B(n86), .Y(n81) );
  OAI22X1 U133 ( .A(n193), .B(n213), .C(n176), .D(n87), .Y(nextEHTSData[7]) );
  OAI22X1 U134 ( .A(n193), .B(n214), .C(n177), .D(n87), .Y(nextEHTSData[6]) );
  OAI22X1 U135 ( .A(n193), .B(n215), .C(n178), .D(n87), .Y(nextEHTSData[5]) );
  OAI22X1 U136 ( .A(n193), .B(n216), .C(n179), .D(n87), .Y(nextEHTSData[4]) );
  OAI22X1 U137 ( .A(n193), .B(n217), .C(n180), .D(n87), .Y(nextEHTSData[3]) );
  OAI22X1 U138 ( .A(n193), .B(n218), .C(n181), .D(n87), .Y(nextEHTSData[2]) );
  OAI22X1 U139 ( .A(n193), .B(n219), .C(n182), .D(n87), .Y(nextEHTSData[1]) );
  OAI22X1 U140 ( .A(n193), .B(n220), .C(n183), .D(n87), .Y(nextEHTSData[0]) );
  NAND2X1 U141 ( .A(n88), .B(n89), .Y(n87) );
  NAND3X1 U142 ( .A(n84), .B(n194), .C(n91), .Y(n90) );
  NOR2X1 U143 ( .A(n196), .B(n92), .Y(n91) );
  NAND2X1 U144 ( .A(n229), .B(n89), .Y(n84) );
  NOR2X1 U145 ( .A(n196), .B(state[1]), .Y(n89) );
  OAI21X1 U146 ( .A(n93), .B(n203), .C(n94), .Y(hrdata[9]) );
  AOI22X1 U147 ( .A(errorData[9]), .B(n95), .C(statusData[9]), .D(n96), .Y(n94) );
  OAI21X1 U148 ( .A(n93), .B(n204), .C(n97), .Y(hrdata[8]) );
  AOI22X1 U149 ( .A(errorData[8]), .B(n95), .C(statusData[8]), .D(n96), .Y(n97) );
  OAI21X1 U150 ( .A(n99), .B(n100), .C(n175), .Y(n98) );
  OAI21X1 U151 ( .A(n102), .B(n205), .C(n103), .Y(n100) );
  AOI22X1 U152 ( .A(rdata[7]), .B(n104), .C(errorData[15]), .D(n223), .Y(n103)
         );
  NAND2X1 U153 ( .A(n105), .B(n106), .Y(n99) );
  AOI22X1 U154 ( .A(n107), .B(ehtsData[7]), .C(boData[7]), .D(n221), .Y(n106)
         );
  AOI22X1 U155 ( .A(errorData[7]), .B(n222), .C(statusData[7]), .D(n225), .Y(
        n105) );
  OAI21X1 U156 ( .A(n109), .B(n110), .C(n175), .Y(n108) );
  OAI21X1 U157 ( .A(n102), .B(n206), .C(n111), .Y(n110) );
  AOI22X1 U158 ( .A(rdata[6]), .B(n104), .C(errorData[14]), .D(n223), .Y(n111)
         );
  NAND2X1 U159 ( .A(n112), .B(n113), .Y(n109) );
  AOI22X1 U160 ( .A(n107), .B(ehtsData[6]), .C(boData[6]), .D(n221), .Y(n113)
         );
  AOI22X1 U161 ( .A(errorData[6]), .B(n222), .C(statusData[6]), .D(n225), .Y(
        n112) );
  OAI21X1 U162 ( .A(n115), .B(n116), .C(n175), .Y(n114) );
  OAI21X1 U163 ( .A(n102), .B(n207), .C(n117), .Y(n116) );
  AOI22X1 U164 ( .A(rdata[5]), .B(n104), .C(errorData[13]), .D(n223), .Y(n117)
         );
  NAND2X1 U165 ( .A(n118), .B(n119), .Y(n115) );
  AOI22X1 U166 ( .A(n107), .B(ehtsData[5]), .C(boData[5]), .D(n221), .Y(n119)
         );
  AOI22X1 U167 ( .A(errorData[5]), .B(n222), .C(statusData[5]), .D(n225), .Y(
        n118) );
  OAI21X1 U168 ( .A(n121), .B(n122), .C(n175), .Y(n120) );
  OAI21X1 U169 ( .A(n102), .B(n208), .C(n123), .Y(n122) );
  AOI22X1 U170 ( .A(rdata[4]), .B(n104), .C(errorData[12]), .D(n223), .Y(n123)
         );
  NAND2X1 U171 ( .A(n124), .B(n125), .Y(n121) );
  AOI22X1 U172 ( .A(n107), .B(ehtsData[4]), .C(boData[4]), .D(n221), .Y(n125)
         );
  AOI22X1 U173 ( .A(errorData[4]), .B(n222), .C(statusData[4]), .D(n225), .Y(
        n124) );
  OAI21X1 U174 ( .A(n127), .B(n128), .C(n175), .Y(n126) );
  OAI21X1 U175 ( .A(n102), .B(n209), .C(n129), .Y(n128) );
  AOI22X1 U176 ( .A(rdata[3]), .B(n104), .C(errorData[11]), .D(n223), .Y(n129)
         );
  NAND2X1 U177 ( .A(n130), .B(n131), .Y(n127) );
  AOI22X1 U178 ( .A(n107), .B(ehtsData[3]), .C(boData[3]), .D(n221), .Y(n131)
         );
  AOI22X1 U179 ( .A(errorData[3]), .B(n222), .C(statusData[3]), .D(n225), .Y(
        n130) );
  OAI21X1 U180 ( .A(n133), .B(n134), .C(n175), .Y(n132) );
  OAI21X1 U181 ( .A(n102), .B(n210), .C(n135), .Y(n134) );
  AOI22X1 U182 ( .A(rdata[2]), .B(n104), .C(errorData[10]), .D(n223), .Y(n135)
         );
  NAND2X1 U183 ( .A(n136), .B(n137), .Y(n133) );
  AOI22X1 U184 ( .A(n107), .B(ehtsData[2]), .C(boData[2]), .D(n221), .Y(n137)
         );
  AOI22X1 U185 ( .A(errorData[2]), .B(n222), .C(statusData[2]), .D(n225), .Y(
        n136) );
  OAI21X1 U186 ( .A(n139), .B(n140), .C(n175), .Y(n138) );
  OAI21X1 U187 ( .A(n211), .B(n102), .C(n141), .Y(n140) );
  AOI22X1 U188 ( .A(rdata[1]), .B(n104), .C(n223), .D(errorData[9]), .Y(n141)
         );
  NAND2X1 U189 ( .A(n142), .B(n143), .Y(n139) );
  AOI22X1 U190 ( .A(n107), .B(ehtsData[1]), .C(boData[1]), .D(n221), .Y(n143)
         );
  AOI22X1 U191 ( .A(errorData[1]), .B(n222), .C(statusData[1]), .D(n225), .Y(
        n142) );
  NAND3X1 U192 ( .A(n83), .B(n229), .C(n175), .Y(n144) );
  OAI21X1 U193 ( .A(n93), .B(n197), .C(n145), .Y(hrdata[15]) );
  AOI22X1 U194 ( .A(errorData[15]), .B(n95), .C(statusData[15]), .D(n96), .Y(
        n145) );
  OAI21X1 U195 ( .A(n93), .B(n198), .C(n146), .Y(hrdata[14]) );
  AOI22X1 U196 ( .A(errorData[14]), .B(n95), .C(statusData[14]), .D(n96), .Y(
        n146) );
  OAI21X1 U197 ( .A(n93), .B(n199), .C(n147), .Y(hrdata[13]) );
  AOI22X1 U198 ( .A(errorData[13]), .B(n95), .C(statusData[13]), .D(n96), .Y(
        n147) );
  OAI21X1 U199 ( .A(n93), .B(n200), .C(n148), .Y(hrdata[12]) );
  AOI22X1 U200 ( .A(errorData[12]), .B(n95), .C(statusData[12]), .D(n96), .Y(
        n148) );
  OAI21X1 U201 ( .A(n93), .B(n201), .C(n149), .Y(hrdata[11]) );
  AOI22X1 U202 ( .A(errorData[11]), .B(n95), .C(statusData[11]), .D(n96), .Y(
        n149) );
  OAI21X1 U203 ( .A(n93), .B(n202), .C(n150), .Y(hrdata[10]) );
  AOI22X1 U204 ( .A(errorData[10]), .B(n95), .C(statusData[10]), .D(n96), .Y(
        n150) );
  NAND3X1 U205 ( .A(n229), .B(n233), .C(n175), .Y(n93) );
  OAI21X1 U206 ( .A(n154), .B(n155), .C(n175), .Y(n153) );
  NOR2X1 U207 ( .A(n194), .B(state[0]), .Y(n101) );
  OAI21X1 U208 ( .A(n212), .B(n102), .C(n156), .Y(n155) );
  AOI22X1 U209 ( .A(rdata[0]), .B(n104), .C(n223), .D(errorData[8]), .Y(n156)
         );
  NAND3X1 U210 ( .A(n158), .B(n224), .C(prevAddr[0]), .Y(n157) );
  NAND2X1 U211 ( .A(n85), .B(n234), .Y(n86) );
  NOR2X1 U212 ( .A(n83), .B(n152), .Y(n85) );
  NAND3X1 U213 ( .A(n158), .B(n226), .C(prevAddr[0]), .Y(n102) );
  NAND2X1 U214 ( .A(n159), .B(n160), .Y(n154) );
  AOI22X1 U215 ( .A(n107), .B(ehtsData[0]), .C(boData[0]), .D(n221), .Y(n160)
         );
  NAND3X1 U216 ( .A(n162), .B(n228), .C(n163), .Y(n161) );
  NOR2X1 U217 ( .A(n234), .B(n231), .Y(n163) );
  NOR2X1 U218 ( .A(prevAddr[3]), .B(n229), .Y(n162) );
  NOR2X1 U219 ( .A(n92), .B(n229), .Y(n88) );
  NAND3X1 U220 ( .A(n228), .B(n231), .C(prevAddr[3]), .Y(n92) );
  NAND3X1 U221 ( .A(n166), .B(n232), .C(n167), .Y(n165) );
  NOR2X1 U222 ( .A(prevAddr[0]), .B(n229), .Y(n167) );
  AOI22X1 U223 ( .A(errorData[0]), .B(n222), .C(statusData[0]), .D(n225), .Y(
        n159) );
  OAI21X1 U224 ( .A(n169), .B(n152), .C(n226), .Y(n168) );
  NAND3X1 U225 ( .A(prevAddr[6]), .B(n232), .C(n227), .Y(n170) );
  OAI21X1 U226 ( .A(n169), .B(n152), .C(n224), .Y(n171) );
  NAND3X1 U227 ( .A(n227), .B(prevAddr[6]), .C(prevAddr[1]), .Y(n172) );
  NAND3X1 U229 ( .A(n166), .B(n230), .C(n174), .Y(n173) );
  NOR2X1 U230 ( .A(prevAddr[2]), .B(n229), .Y(n174) );
  NOR2X1 U231 ( .A(prevAddr[5]), .B(prevAddr[4]), .Y(n166) );
  NOR2X1 U232 ( .A(n235), .B(prevSize[1]), .Y(n152) );
  NOR2X1 U233 ( .A(prevAddr[0]), .B(n234), .Y(n169) );
  NOR2X1 U234 ( .A(prevSize[1]), .B(prevSize[0]), .Y(n158) );
  INVX2 U235 ( .A(n144), .Y(n185) );
  BUFX2 U236 ( .A(n101), .Y(n175) );
  INVX2 U237 ( .A(hwdata[7]), .Y(n176) );
  INVX2 U238 ( .A(hwdata[6]), .Y(n177) );
  INVX2 U239 ( .A(hwdata[5]), .Y(n178) );
  INVX2 U240 ( .A(hwdata[4]), .Y(n179) );
  INVX2 U241 ( .A(hwdata[3]), .Y(n180) );
  INVX2 U242 ( .A(hwdata[2]), .Y(n181) );
  INVX2 U243 ( .A(hwdata[1]), .Y(n182) );
  INVX2 U244 ( .A(hwdata[0]), .Y(n183) );
  INVX2 U245 ( .A(n153), .Y(hrdata[0]) );
  INVX2 U246 ( .A(n138), .Y(hrdata[1]) );
  INVX2 U247 ( .A(n132), .Y(hrdata[2]) );
  INVX2 U248 ( .A(n126), .Y(hrdata[3]) );
  INVX2 U249 ( .A(n120), .Y(hrdata[4]) );
  INVX2 U250 ( .A(n114), .Y(hrdata[5]) );
  INVX2 U251 ( .A(n108), .Y(hrdata[6]) );
  INVX2 U252 ( .A(n98), .Y(hrdata[7]) );
  INVX2 U253 ( .A(n90), .Y(n193) );
  INVX2 U254 ( .A(state[1]), .Y(n194) );
  INVX2 U255 ( .A(n84), .Y(n195) );
  INVX2 U256 ( .A(state[0]), .Y(n196) );
  INVX2 U257 ( .A(rdata[15]), .Y(n197) );
  INVX2 U258 ( .A(rdata[14]), .Y(n198) );
  INVX2 U259 ( .A(rdata[13]), .Y(n199) );
  INVX2 U260 ( .A(rdata[12]), .Y(n200) );
  INVX2 U261 ( .A(rdata[11]), .Y(n201) );
  INVX2 U262 ( .A(rdata[10]), .Y(n202) );
  INVX2 U263 ( .A(rdata[9]), .Y(n203) );
  INVX2 U264 ( .A(rdata[8]), .Y(n204) );
  INVX2 U265 ( .A(statusData[15]), .Y(n205) );
  INVX2 U266 ( .A(statusData[14]), .Y(n206) );
  INVX2 U267 ( .A(statusData[13]), .Y(n207) );
  INVX2 U268 ( .A(statusData[12]), .Y(n208) );
  INVX2 U269 ( .A(statusData[11]), .Y(n209) );
  INVX2 U270 ( .A(statusData[10]), .Y(n210) );
  INVX2 U271 ( .A(statusData[9]), .Y(n211) );
  INVX2 U272 ( .A(statusData[8]), .Y(n212) );
  INVX2 U273 ( .A(ehtsData[7]), .Y(n213) );
  INVX2 U274 ( .A(ehtsData[6]), .Y(n214) );
  INVX2 U275 ( .A(ehtsData[5]), .Y(n215) );
  INVX2 U276 ( .A(ehtsData[4]), .Y(n216) );
  INVX2 U277 ( .A(ehtsData[3]), .Y(n217) );
  INVX2 U278 ( .A(ehtsData[2]), .Y(n218) );
  INVX2 U279 ( .A(ehtsData[1]), .Y(n219) );
  INVX2 U280 ( .A(ehtsData[0]), .Y(n220) );
  INVX2 U281 ( .A(n161), .Y(n221) );
  INVX2 U282 ( .A(n171), .Y(n222) );
  INVX2 U283 ( .A(n157), .Y(n223) );
  INVX2 U284 ( .A(n172), .Y(n224) );
  INVX2 U285 ( .A(n168), .Y(n225) );
  INVX2 U286 ( .A(n170), .Y(n226) );
  INVX2 U287 ( .A(n173), .Y(n227) );
  INVX2 U288 ( .A(n165), .Y(n228) );
  INVX2 U289 ( .A(prevAddr[6]), .Y(n229) );
  INVX2 U290 ( .A(prevAddr[3]), .Y(n230) );
  INVX2 U291 ( .A(prevAddr[2]), .Y(n231) );
  INVX2 U292 ( .A(prevAddr[1]), .Y(n232) );
  INVX2 U293 ( .A(n85), .Y(n233) );
  INVX2 U294 ( .A(n158), .Y(n234) );
  INVX2 U295 ( .A(prevSize[0]), .Y(n235) );
endmodule

