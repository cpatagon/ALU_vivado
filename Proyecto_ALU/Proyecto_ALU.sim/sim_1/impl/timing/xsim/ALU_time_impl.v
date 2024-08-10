// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (lin64) Build 2188600 Wed Apr  4 18:39:19 MDT 2018
// Date        : Sun Aug  4 20:43:06 2024
// Host        : meteo running 64-bit Ubuntu 20.04.6 LTS
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               /home/lgomez/Documentos/MAGISTER_UBA/Bimestre05/FPGA/Proyecto_FINAL/ProyectoALU_vivado/Proyecto_ALU/Proyecto_ALU.sim/sim_1/impl/timing/xsim/ALU_time_impl.v
// Design      : ALU
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

(* ECO_CHECKSUM = "93478b3d" *) 
(* NotValidForBitStream *)
module ALU
   (A,
    B,
    ALU_Sel,
    Result,
    CarryOut);
  input [3:0]A;
  input [3:0]B;
  input [1:0]ALU_Sel;
  output [3:0]Result;
  output CarryOut;

  wire [3:0]A;
  wire [1:0]ALU_Sel;
  wire [1:0]ALU_Sel_IBUF;
  wire [3:0]A_IBUF;
  wire [3:0]B;
  wire [3:0]B_IBUF;
  wire CarryOut;
  wire CarryOut_OBUF;
  wire [3:0]Result;
  wire [3:0]Result_OBUF;
  wire \sumador_inst/aux_2 ;
  wire \sumador_inst/aux_3 ;

initial begin
 $sdf_annotate("ALU_time_impl.sdf",,,,"tool_control");
end
  IBUF \ALU_Sel_IBUF[0]_inst 
       (.I(ALU_Sel[0]),
        .O(ALU_Sel_IBUF[0]));
  IBUF \ALU_Sel_IBUF[1]_inst 
       (.I(ALU_Sel[1]),
        .O(ALU_Sel_IBUF[1]));
  IBUF \A_IBUF[0]_inst 
       (.I(A[0]),
        .O(A_IBUF[0]));
  IBUF \A_IBUF[1]_inst 
       (.I(A[1]),
        .O(A_IBUF[1]));
  IBUF \A_IBUF[2]_inst 
       (.I(A[2]),
        .O(A_IBUF[2]));
  IBUF \A_IBUF[3]_inst 
       (.I(A[3]),
        .O(A_IBUF[3]));
  IBUF \B_IBUF[0]_inst 
       (.I(B[0]),
        .O(B_IBUF[0]));
  IBUF \B_IBUF[1]_inst 
       (.I(B[1]),
        .O(B_IBUF[1]));
  IBUF \B_IBUF[2]_inst 
       (.I(B[2]),
        .O(B_IBUF[2]));
  IBUF \B_IBUF[3]_inst 
       (.I(B[3]),
        .O(B_IBUF[3]));
  OBUF CarryOut_OBUF_inst
       (.I(CarryOut_OBUF),
        .O(CarryOut));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h00005440)) 
    CarryOut_OBUF_inst_i_1
       (.I0(ALU_Sel_IBUF[0]),
        .I1(A_IBUF[3]),
        .I2(\sumador_inst/aux_3 ),
        .I3(B_IBUF[3]),
        .I4(ALU_Sel_IBUF[1]),
        .O(CarryOut_OBUF));
  OBUF \Result_OBUF[0]_inst 
       (.I(Result_OBUF[0]),
        .O(Result[0]));
  LUT4 #(
    .INIT(16'h0014)) 
    \Result_OBUF[0]_inst_i_1 
       (.I0(ALU_Sel_IBUF[0]),
        .I1(B_IBUF[0]),
        .I2(A_IBUF[0]),
        .I3(ALU_Sel_IBUF[1]),
        .O(Result_OBUF[0]));
  OBUF \Result_OBUF[1]_inst 
       (.I(Result_OBUF[1]),
        .O(Result[1]));
  LUT6 #(
    .INIT(64'h0000000041141414)) 
    \Result_OBUF[1]_inst_i_1 
       (.I0(ALU_Sel_IBUF[0]),
        .I1(B_IBUF[1]),
        .I2(A_IBUF[1]),
        .I3(A_IBUF[0]),
        .I4(B_IBUF[0]),
        .I5(ALU_Sel_IBUF[1]),
        .O(Result_OBUF[1]));
  OBUF \Result_OBUF[2]_inst 
       (.I(Result_OBUF[2]),
        .O(Result[2]));
  LUT5 #(
    .INIT(32'h00004114)) 
    \Result_OBUF[2]_inst_i_1 
       (.I0(ALU_Sel_IBUF[0]),
        .I1(B_IBUF[2]),
        .I2(A_IBUF[2]),
        .I3(\sumador_inst/aux_2 ),
        .I4(ALU_Sel_IBUF[1]),
        .O(Result_OBUF[2]));
  LUT4 #(
    .INIT(16'hEA80)) 
    \Result_OBUF[2]_inst_i_2 
       (.I0(A_IBUF[1]),
        .I1(B_IBUF[0]),
        .I2(A_IBUF[0]),
        .I3(B_IBUF[1]),
        .O(\sumador_inst/aux_2 ));
  OBUF \Result_OBUF[3]_inst 
       (.I(Result_OBUF[3]),
        .O(Result[3]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h00004114)) 
    \Result_OBUF[3]_inst_i_1 
       (.I0(ALU_Sel_IBUF[0]),
        .I1(B_IBUF[3]),
        .I2(A_IBUF[3]),
        .I3(\sumador_inst/aux_3 ),
        .I4(ALU_Sel_IBUF[1]),
        .O(Result_OBUF[3]));
  LUT6 #(
    .INIT(64'hFEEEEAAAA8888000)) 
    \Result_OBUF[3]_inst_i_2 
       (.I0(A_IBUF[2]),
        .I1(B_IBUF[1]),
        .I2(A_IBUF[0]),
        .I3(B_IBUF[0]),
        .I4(A_IBUF[1]),
        .I5(B_IBUF[2]),
        .O(\sumador_inst/aux_3 ));
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
