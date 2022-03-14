// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (lin64) Build 2552052 Fri May 24 14:47:09 MDT 2019
// Date        : Sat Jun 13 23:06:25 2020
// Host        : aamir-sahilsemi running 64-bit Ubuntu 18.04.4 LTS
// Command     : write_verilog -force
//               /home/aamir/Desktop/sahil_semi_aamir/scripting/vivado_work/rpt/counter_impl_netlist.v -mode timesim
//               -sdf_anno true
// Design      : flag_counter
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7a200tfbg676-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

(* ECO_CHECKSUM = "33f5d382" *) 
(* NotValidForBitStream *)
module flag_counter
   (clk_p,
    clk_n,
    rst_n,
    enable,
    flag_count);
  input clk_p;
  input clk_n;
  input rst_n;
  input enable;
  output flag_count;

  (* DIFF_TERM = 0 *) (* IBUF_LOW_PWR *) wire clk_n;
  (* DIFF_TERM = 0 *) (* IBUF_LOW_PWR *) wire clk_p;
  wire \count[31]_i_10_n_0 ;
  wire \count[31]_i_2_n_0 ;
  wire \count[31]_i_3_n_0 ;
  wire \count[31]_i_4_n_0 ;
  wire \count[31]_i_6_n_0 ;
  wire \count[31]_i_7_n_0 ;
  wire \count[31]_i_8_n_0 ;
  wire \count[31]_i_9_n_0 ;
  wire \count_reg[12]_i_2_n_0 ;
  wire \count_reg[16]_i_2_n_0 ;
  wire \count_reg[20]_i_2_n_0 ;
  wire \count_reg[24]_i_2_n_0 ;
  wire \count_reg[28]_i_2_n_0 ;
  wire \count_reg[4]_i_2_n_0 ;
  wire \count_reg[8]_i_2_n_0 ;
  wire \count_reg_n_0_[0] ;
  wire \count_reg_n_0_[10] ;
  wire \count_reg_n_0_[11] ;
  wire \count_reg_n_0_[12] ;
  wire \count_reg_n_0_[13] ;
  wire \count_reg_n_0_[14] ;
  wire \count_reg_n_0_[15] ;
  wire \count_reg_n_0_[16] ;
  wire \count_reg_n_0_[17] ;
  wire \count_reg_n_0_[18] ;
  wire \count_reg_n_0_[19] ;
  wire \count_reg_n_0_[1] ;
  wire \count_reg_n_0_[20] ;
  wire \count_reg_n_0_[21] ;
  wire \count_reg_n_0_[22] ;
  wire \count_reg_n_0_[23] ;
  wire \count_reg_n_0_[24] ;
  wire \count_reg_n_0_[25] ;
  wire \count_reg_n_0_[26] ;
  wire \count_reg_n_0_[27] ;
  wire \count_reg_n_0_[28] ;
  wire \count_reg_n_0_[29] ;
  wire \count_reg_n_0_[2] ;
  wire \count_reg_n_0_[30] ;
  wire \count_reg_n_0_[31] ;
  wire \count_reg_n_0_[3] ;
  wire \count_reg_n_0_[4] ;
  wire \count_reg_n_0_[5] ;
  wire \count_reg_n_0_[6] ;
  wire \count_reg_n_0_[7] ;
  wire \count_reg_n_0_[8] ;
  wire \count_reg_n_0_[9] ;
  wire [31:1]data0;
  wire enable;
  wire enable_IBUF;
  wire flag_count;
  wire flag_count_OBUF;
  wire flag_count_i_1_n_0;
  wire [31:0]p_0_in;
  wire rst_n;
  wire rst_n_IBUF;
  wire sys_clk;
  wire sys_clk_BUFG;
  wire [2:0]\NLW_count_reg[12]_i_2_CO_UNCONNECTED ;
  wire [2:0]\NLW_count_reg[16]_i_2_CO_UNCONNECTED ;
  wire [2:0]\NLW_count_reg[20]_i_2_CO_UNCONNECTED ;
  wire [2:0]\NLW_count_reg[24]_i_2_CO_UNCONNECTED ;
  wire [2:0]\NLW_count_reg[28]_i_2_CO_UNCONNECTED ;
  wire [3:0]\NLW_count_reg[31]_i_5_CO_UNCONNECTED ;
  wire [3:3]\NLW_count_reg[31]_i_5_O_UNCONNECTED ;
  wire [2:0]\NLW_count_reg[4]_i_2_CO_UNCONNECTED ;
  wire [2:0]\NLW_count_reg[8]_i_2_CO_UNCONNECTED ;

initial begin
 $sdf_annotate("counter_impl_netlist.sdf",,,,"tool_control");
end
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  (* IBUF_DELAY_VALUE = "0" *) 
  (* XILINX_LEGACY_PRIM = "IBUFGDS" *) 
  IBUFDS IBUFGDS_inst
       (.I(clk_p),
        .IB(clk_n),
        .O(sys_clk));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h44444440)) 
    \count[0]_i_1 
       (.I0(\count_reg_n_0_[0] ),
        .I1(enable_IBUF),
        .I2(\count[31]_i_2_n_0 ),
        .I3(\count[31]_i_3_n_0 ),
        .I4(\count[31]_i_4_n_0 ),
        .O(p_0_in[0]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[10]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[10]),
        .O(p_0_in[10]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[11]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[11]),
        .O(p_0_in[11]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[12]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[12]),
        .O(p_0_in[12]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[13]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[13]),
        .O(p_0_in[13]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[14]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[14]),
        .O(p_0_in[14]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[15]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[15]),
        .O(p_0_in[15]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[16]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[16]),
        .O(p_0_in[16]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[17]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[17]),
        .O(p_0_in[17]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[18]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[18]),
        .O(p_0_in[18]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[19]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[19]),
        .O(p_0_in[19]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[1]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[1]),
        .O(p_0_in[1]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[20]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[20]),
        .O(p_0_in[20]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[21]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[21]),
        .O(p_0_in[21]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[22]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[22]),
        .O(p_0_in[22]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[23]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[23]),
        .O(p_0_in[23]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[24]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[24]),
        .O(p_0_in[24]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[25]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[25]),
        .O(p_0_in[25]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[26]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[26]),
        .O(p_0_in[26]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[27]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[27]),
        .O(p_0_in[27]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[28]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[28]),
        .O(p_0_in[28]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[29]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[29]),
        .O(p_0_in[29]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[2]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[2]),
        .O(p_0_in[2]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[30]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[30]),
        .O(p_0_in[30]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[31]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[31]),
        .O(p_0_in[31]));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \count[31]_i_10 
       (.I0(\count_reg_n_0_[15] ),
        .I1(\count_reg_n_0_[14] ),
        .I2(\count_reg_n_0_[17] ),
        .I3(\count_reg_n_0_[16] ),
        .O(\count[31]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \count[31]_i_2 
       (.I0(\count[31]_i_6_n_0 ),
        .I1(\count[31]_i_7_n_0 ),
        .I2(\count_reg_n_0_[31] ),
        .I3(\count_reg_n_0_[30] ),
        .I4(\count_reg_n_0_[1] ),
        .I5(\count[31]_i_8_n_0 ),
        .O(\count[31]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFBFF)) 
    \count[31]_i_3 
       (.I0(\count_reg_n_0_[4] ),
        .I1(\count_reg_n_0_[5] ),
        .I2(\count_reg_n_0_[2] ),
        .I3(\count_reg_n_0_[3] ),
        .I4(\count[31]_i_9_n_0 ),
        .O(\count[31]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \count[31]_i_4 
       (.I0(\count_reg_n_0_[12] ),
        .I1(\count_reg_n_0_[13] ),
        .I2(\count_reg_n_0_[10] ),
        .I3(\count_reg_n_0_[11] ),
        .I4(\count[31]_i_10_n_0 ),
        .O(\count[31]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \count[31]_i_6 
       (.I0(\count_reg_n_0_[23] ),
        .I1(\count_reg_n_0_[22] ),
        .I2(\count_reg_n_0_[25] ),
        .I3(\count_reg_n_0_[24] ),
        .O(\count[31]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \count[31]_i_7 
       (.I0(\count_reg_n_0_[19] ),
        .I1(\count_reg_n_0_[18] ),
        .I2(\count_reg_n_0_[21] ),
        .I3(\count_reg_n_0_[20] ),
        .O(\count[31]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \count[31]_i_8 
       (.I0(\count_reg_n_0_[27] ),
        .I1(\count_reg_n_0_[26] ),
        .I2(\count_reg_n_0_[29] ),
        .I3(\count_reg_n_0_[28] ),
        .O(\count[31]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \count[31]_i_9 
       (.I0(\count_reg_n_0_[7] ),
        .I1(\count_reg_n_0_[6] ),
        .I2(\count_reg_n_0_[9] ),
        .I3(\count_reg_n_0_[8] ),
        .O(\count[31]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[3]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[3]),
        .O(p_0_in[3]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[4]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[4]),
        .O(p_0_in[4]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[5]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[5]),
        .O(p_0_in[5]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[6]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[6]),
        .O(p_0_in[6]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[7]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[7]),
        .O(p_0_in[7]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[8]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[8]),
        .O(p_0_in[8]));
  LUT6 #(
    .INIT(64'hAAAAAAA800000000)) 
    \count[9]_i_1 
       (.I0(enable_IBUF),
        .I1(\count[31]_i_2_n_0 ),
        .I2(\count[31]_i_3_n_0 ),
        .I3(\count[31]_i_4_n_0 ),
        .I4(\count_reg_n_0_[0] ),
        .I5(data0[9]),
        .O(p_0_in[9]));
  FDCE \count_reg[0] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[0]),
        .Q(\count_reg_n_0_[0] ));
  FDCE \count_reg[10] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[10]),
        .Q(\count_reg_n_0_[10] ));
  FDCE \count_reg[11] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[11]),
        .Q(\count_reg_n_0_[11] ));
  FDCE \count_reg[12] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[12]),
        .Q(\count_reg_n_0_[12] ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \count_reg[12]_i_2 
       (.CI(\count_reg[8]_i_2_n_0 ),
        .CO({\count_reg[12]_i_2_n_0 ,\NLW_count_reg[12]_i_2_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[12:9]),
        .S({\count_reg_n_0_[12] ,\count_reg_n_0_[11] ,\count_reg_n_0_[10] ,\count_reg_n_0_[9] }));
  FDCE \count_reg[13] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[13]),
        .Q(\count_reg_n_0_[13] ));
  FDCE \count_reg[14] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[14]),
        .Q(\count_reg_n_0_[14] ));
  FDCE \count_reg[15] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[15]),
        .Q(\count_reg_n_0_[15] ));
  FDCE \count_reg[16] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[16]),
        .Q(\count_reg_n_0_[16] ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \count_reg[16]_i_2 
       (.CI(\count_reg[12]_i_2_n_0 ),
        .CO({\count_reg[16]_i_2_n_0 ,\NLW_count_reg[16]_i_2_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[16:13]),
        .S({\count_reg_n_0_[16] ,\count_reg_n_0_[15] ,\count_reg_n_0_[14] ,\count_reg_n_0_[13] }));
  FDCE \count_reg[17] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[17]),
        .Q(\count_reg_n_0_[17] ));
  FDCE \count_reg[18] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[18]),
        .Q(\count_reg_n_0_[18] ));
  FDCE \count_reg[19] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[19]),
        .Q(\count_reg_n_0_[19] ));
  FDCE \count_reg[1] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[1]),
        .Q(\count_reg_n_0_[1] ));
  FDCE \count_reg[20] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[20]),
        .Q(\count_reg_n_0_[20] ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \count_reg[20]_i_2 
       (.CI(\count_reg[16]_i_2_n_0 ),
        .CO({\count_reg[20]_i_2_n_0 ,\NLW_count_reg[20]_i_2_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[20:17]),
        .S({\count_reg_n_0_[20] ,\count_reg_n_0_[19] ,\count_reg_n_0_[18] ,\count_reg_n_0_[17] }));
  FDCE \count_reg[21] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[21]),
        .Q(\count_reg_n_0_[21] ));
  FDCE \count_reg[22] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[22]),
        .Q(\count_reg_n_0_[22] ));
  FDCE \count_reg[23] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[23]),
        .Q(\count_reg_n_0_[23] ));
  FDCE \count_reg[24] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[24]),
        .Q(\count_reg_n_0_[24] ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \count_reg[24]_i_2 
       (.CI(\count_reg[20]_i_2_n_0 ),
        .CO({\count_reg[24]_i_2_n_0 ,\NLW_count_reg[24]_i_2_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[24:21]),
        .S({\count_reg_n_0_[24] ,\count_reg_n_0_[23] ,\count_reg_n_0_[22] ,\count_reg_n_0_[21] }));
  FDCE \count_reg[25] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[25]),
        .Q(\count_reg_n_0_[25] ));
  FDCE \count_reg[26] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[26]),
        .Q(\count_reg_n_0_[26] ));
  FDCE \count_reg[27] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[27]),
        .Q(\count_reg_n_0_[27] ));
  FDCE \count_reg[28] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[28]),
        .Q(\count_reg_n_0_[28] ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \count_reg[28]_i_2 
       (.CI(\count_reg[24]_i_2_n_0 ),
        .CO({\count_reg[28]_i_2_n_0 ,\NLW_count_reg[28]_i_2_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[28:25]),
        .S({\count_reg_n_0_[28] ,\count_reg_n_0_[27] ,\count_reg_n_0_[26] ,\count_reg_n_0_[25] }));
  FDCE \count_reg[29] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[29]),
        .Q(\count_reg_n_0_[29] ));
  FDCE \count_reg[2] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[2]),
        .Q(\count_reg_n_0_[2] ));
  FDCE \count_reg[30] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[30]),
        .Q(\count_reg_n_0_[30] ));
  FDCE \count_reg[31] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[31]),
        .Q(\count_reg_n_0_[31] ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \count_reg[31]_i_5 
       (.CI(\count_reg[28]_i_2_n_0 ),
        .CO(\NLW_count_reg[31]_i_5_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_count_reg[31]_i_5_O_UNCONNECTED [3],data0[31:29]}),
        .S({1'b0,\count_reg_n_0_[31] ,\count_reg_n_0_[30] ,\count_reg_n_0_[29] }));
  FDCE \count_reg[3] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[3]),
        .Q(\count_reg_n_0_[3] ));
  FDCE \count_reg[4] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[4]),
        .Q(\count_reg_n_0_[4] ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \count_reg[4]_i_2 
       (.CI(1'b0),
        .CO({\count_reg[4]_i_2_n_0 ,\NLW_count_reg[4]_i_2_CO_UNCONNECTED [2:0]}),
        .CYINIT(\count_reg_n_0_[0] ),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[4:1]),
        .S({\count_reg_n_0_[4] ,\count_reg_n_0_[3] ,\count_reg_n_0_[2] ,\count_reg_n_0_[1] }));
  FDCE \count_reg[5] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[5]),
        .Q(\count_reg_n_0_[5] ));
  FDCE \count_reg[6] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[6]),
        .Q(\count_reg_n_0_[6] ));
  FDCE \count_reg[7] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[7]),
        .Q(\count_reg_n_0_[7] ));
  FDCE \count_reg[8] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[8]),
        .Q(\count_reg_n_0_[8] ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \count_reg[8]_i_2 
       (.CI(\count_reg[4]_i_2_n_0 ),
        .CO({\count_reg[8]_i_2_n_0 ,\NLW_count_reg[8]_i_2_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[8:5]),
        .S({\count_reg_n_0_[8] ,\count_reg_n_0_[7] ,\count_reg_n_0_[6] ,\count_reg_n_0_[5] }));
  FDCE \count_reg[9] 
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(p_0_in[9]),
        .Q(\count_reg_n_0_[9] ));
  IBUF enable_IBUF_inst
       (.I(enable),
        .O(enable_IBUF));
  OBUF flag_count_OBUF_inst
       (.I(flag_count_OBUF),
        .O(flag_count));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h00000002)) 
    flag_count_i_1
       (.I0(enable_IBUF),
        .I1(\count_reg_n_0_[0] ),
        .I2(\count[31]_i_4_n_0 ),
        .I3(\count[31]_i_3_n_0 ),
        .I4(\count[31]_i_2_n_0 ),
        .O(flag_count_i_1_n_0));
  FDCE flag_count_reg
       (.C(sys_clk_BUFG),
        .CE(1'b1),
        .CLR(rst_n_IBUF),
        .D(flag_count_i_1_n_0),
        .Q(flag_count_OBUF));
  IBUF rst_n_IBUF_inst
       (.I(rst_n),
        .O(rst_n_IBUF));
  BUFG sys_clk_BUFG_inst
       (.I(sys_clk),
        .O(sys_clk_BUFG));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
