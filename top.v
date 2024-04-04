`include "param.v"
module top(clk,rst_n);

input clk,rst_n;

//if_stage
wire w_StallF,w_PCSrcW,w_Branch_TakenE;
wire [`D_WIDTH-1:0] w_ALUResultE,w_ResultW;

wire [`D_WIDTH-1:0] w_PC_in_IF, w_Instruction_in_IF;

// if_stage_reg
wire w_FlushD,w_StallD;
wire [`D_WIDTH-1:0] w_PC_out_ID,w_Instruction_out_ID;

//id_stage
wire w_WE;
wire [`D_WIDTH-1:0] w_PC_in_ID,w_Instruction_in_ID;
wire [3:0] w_Flags,w_A3;

wire w_PCSrcD,w_RegWriteD,w_MemtoRegD,w_BranchD,w_ALUSrcD,w_MemWriteD,w_FlagWriteD;
wire [1:0] w_ALUControlD;
wire [1:0] w_ImmSrcD;
wire [2:0] w_RegSrcD;
wire [`D_WIDTH-1:0] w_RD1_in_ID,w_RD2_in_ID;
wire [`D_WIDTH-1:0] w_Extend_in_ID;
wire [3:0] w_Rd_in_ID;
wire [3:0] w_CondD;
wire [3:0] w_FlagsE;


//id_stage_reg
wire w_FlushE;
wire [`D_WIDTH-1:0] w_RD1_out_ID,w_RD2_out_ID,w_Extend_out_ID;
wire [3:0] w_Rd_out_ID;

wire w_PCSrcE,w_RegWriteE,w_MemtoRegE,w_MemWriteE,w_BranchE,w_ALUSrcE,w_FlagWriteE;
wire [1:0] w_ALUControlE;
wire [3:0] w_CondE;

//exe_stage
wire [`D_WIDTH-1:0] w_RD1_in_EXE, w_RD2_in_EXE, w_Extend_in_EXE;
wire [3:0] w_Rd_in_EXE;
wire [`D_WIDTH-1:0] w_RD1_out_EXE, w_RD2_out_EXE, w_Extend_out_EXE;
wire [3:0] w_Rd_out_EXE;
wire [`D_WIDTH-1:0] w_ALUResultM;
wire [1:0] w_ForwardAE,w_ForwardBE;


wire w_PCSrc,w_RegWrite,w_MemtoReg,w_MemWrite,w_BranchTakenE;
wire [`D_WIDTH-1:0] w_WriteDataE;
wire [3:0] w_WA3E;


//exe_stage_reg


wire w_PCSrcM,w_RegWriteM,w_MemtoRegM,w_MemWriteM;
wire [`D_WIDTH-1:0] w_WriteDataM;
wire [3:0] w_WA3M;

//mem_stage

wire w_PCSrcM_out,w_RegWriteM_out,w_MemtoRegM_out;
wire [`D_WIDTH-1:0] w_RD,w_ALUOutM;
wire [`D_WIDTH-1:0] w_ALUResultM_out,w_ALUOutM_out;
wire [3:0] w_WA3M_out;


//mem_stage_reg


wire w_RegWriteW,w_MemtoRegW;
wire [`D_WIDTH-1:0] w_ReadDataW,w_ALUOutW;
wire [3:0] w_WA3W;

//wb_stage
wire w_PCSrcW_out,w_RegWriteW_out;
wire [3:0] w_WA3W_out;



//hazard_unit
wire [3:0] w_RA1_ID, w_RA2_ID;


//if_stage
if_stage If_stage(.clk(clk), .rst_n(rst_n), .i_StallF(w_StallF), .i_PCSrcW(w_PCSrcW), .i_Branch_TakenE(w_Branch_TakenE),
			.i_ResultW(w_ResultW), .i_ALUResultE(w_ALUResultE), .o_PC(w_PC_in_IF), .o_Instruction(w_Instruction_in_IF));


//if_stage_reg
if_stage_reg If_stage_reg(.clk(clk), .rst_n(rst_n), .i_FlushD(w_FlushD), .i_StallD(w_StallD), .i_PC(w_PC_in_IF),
			.i_Instruction(w_Instruction_in_IF), .o_PC(w_PC_out_ID), .o_Instruction(w_Instruction_out_ID));

//id_stage
id_stage Id_stage(.clk(clk), .rst_n(rst_n), .i_Instruction(w_Instruction_out_ID), .i_PC(w_PC_out_ID),.i_Flags(w_Flags), .i_ALUResultE(w_ALUResultE),
			.i_A3(w_WA3W), .i_ResultW(w_ResultW), .i_WE(w_RegWriteW), .o_PCSrcD(w_PCSrcD), .o_RegWriteD(w_RegWriteD),
			 .o_MemtoRegD(w_MemtoRegD),.o_MemWriteD(w_MemWriteD), .o_ALUControlD(w_ALUControlD), .o_BranchD(w_BranchD), 
			 .o_ALUSrcD(w_ALUSrcD), .o_FlagWriteD(w_FlagWriteD), .o_RegSrcD(w_RegSrcD),
			 .o_ImmSrcD(w_ImmSrcD), .o_RD1(w_RD1_out_ID), .o_RD2(w_RD2_out_ID), .o_Rd(w_Rd_out_ID), .o_Extend(w_Extend_out_ID),.o_CondD(w_CondD),
			 .o_FlagsE(w_FlagsE),.o_RA1D(w_RA1_ID), .o_RA2D(w_RA2_ID));
			

//id_stage_reg
id_stage_reg Id_stage_reg(.clk(clk), .rst_n(rst_n),.i_FlushE(w_FlushE), .i_PCSrcD(w_PCSrcD), .i_RegWriteD(w_RegWriteD),
			 .i_MemtoRegD(w_MemtoRegD),.i_MemWriteD(w_MemWriteD), .i_ALUControlD(w_ALUControlD), .i_BranchD(w_BranchD),
			 .i_ALUSrcD(w_ALUSrcD), .i_FlagWriteD(w_FlagWriteD), .i_Cond(w_CondD), .i_Flags(w_Flags),
			 .i_RD1(w_RD1_out_ID), .i_RD2(w_RD2_out_ID), .i_Rd(w_Rd_out_ID), .i_Extend(w_Extend_out_ID), .o_PCSrcE(w_PCSrcE),
			 .o_RegWriteE(w_RegWriteE), .o_MemtoRegE(w_MemtoRegE), .o_MemWriteE(w_MemWriteE), .o_ALUControlE(w_ALUControlE),
			 .o_BranchE(w_BranchE),.o_ALUSrcE(w_ALUSrcE), .o_FlagWriteE(w_FlagWriteE), .o_CondE(w_CondE),
			 .o_FlagsE(w_FlagsE), .o_RD1(w_RD1_out_EXE), .o_RD2(w_RD2_out_EXE), .o_Rd(w_Rd_out_EXE), .o_Extend(w_Extend_out_EXE));

//exe_stage
exe_stage Exe_stage(.clk(clk), .rst_n(rst_n), .i_PCSrcE(w_PCSrcE), .i_RegWriteE(w_RegWriteE),.i_MemtoRegE(w_MemtoRegE),
			.i_MemWriteE(w_MemWriteE), .i_ALUControlE(w_ALUControlE), .i_BranchE(w_BranchE), .i_ALUSrcE(w_ALUSrcE), .i_FlagWriteE(w_FlagWriteE),
			 .i_CondE(w_CondE),.i_FlagsE(w_FlagsE), .i_RD1(w_RD1_out_EXE), .i_RD2(w_RD2_out_EXE), 
			 .i_ALUResultM(w_ALUResultM), .i_ResultW(w_ResultW), .i_ForwardAE(w_ForwardAE), .i_ForwardBE(w_ForwardBE),
			 .i_Extend(w_Extend_out_EXE), .i_Rd(w_Rd_out_EXE), .o_PCSrc(w_PCSrc), .o_RegWrite(w_RegWrite), .o_MemtoReg(w_MemtoReg), .o_MemWrite(w_MemWrite),
			 .o_BranchTakenE(w_Branch_TakenE), .o_ALUResultE(w_ALUResultE), .o_WriteDataE(w_WriteDataE), .o_WA3E(w_WA3E), .o_Flags(w_Flags));

//exe_stage_reg
exe_stage_reg Exe_stage_reg(.clk(clk), .rst_n(rst_n), .i_PCSrc(w_PCSrc), .i_RegWrite(w_RegWrite),.i_MemtoReg(w_MemtoReg),
			.i_MemWrite(w_MemWrite), .i_ALUResultE(w_ALUResultE), .i_WriteDataE(w_WriteDataE), .i_WA3E(w_WA3E), .o_PCSrcM(w_PCSrcM),
			 .o_RegWriteM(w_RegWriteM),.o_MemtoRegM(w_MemtoRegM), .o_MemWriteM(w_MemWriteM), .o_ALUResultM(w_ALUResultM), 
			 .o_WriteDataM(w_WriteDataM), .o_WA3M(w_WA3M));

//mem_stage
mem_stage Mem_stage(.clk(clk), .rst_n(rst_n), .i_PCSrcM(w_PCSrcM), .i_RegWriteM(w_RegWriteM),.i_MemtoRegM(w_MemtoRegM),
			.i_MemWriteM(w_MemWriteM), .i_ALUResultM(w_ALUResultM), .i_WriteDataM(w_WriteDataM), .i_WA3M(w_WA3M), .o_PCSrcM(w_PCSrcM_out),
			 .o_RegWriteM(w_RegWriteM_out),.o_MemtoRegM(w_MemtoRegM_out), .o_RD(w_RD), .o_ALUOutM(w_ALUOutM_out), 
			 .o_ALUResultM(w_ALUResultM_out), .o_WA3M(w_WA3M_out));

//mem_stage_reg
mem_stage_reg Mem_stage_reg(.clk(clk), .rst_n(rst_n), .i_PCSrcM(w_PCSrcM), .i_RegWriteM(w_RegWriteM),.i_MemtoRegM(w_MemtoRegM),
			.i_RD(w_RD), .i_ALUResultM(w_ALUResultM), .i_WA3M(w_WA3M), .o_PCSrcW(w_PCSrcW),
			 .o_RegWriteW(w_RegWriteW),.o_MemtoRegW(w_MemtoRegW), .o_ReadDataW(w_ReadDataW), .o_ALUOutW(w_ALUOutW), 
			 .o_WA3W(w_WA3W));

//wb_stage
wb_stage Wb_stage(.clk(clk), .rst_n(rst_n), .i_PCSrcW(w_PCSrcW), .i_RegWriteW(w_RegWriteW),.i_MemtoRegW(w_MemtoRegW),
			.i_ReadDataW(w_ReadDataW), .i_ALUOutW(w_ALUOutW), .i_WA3W(w_WA3W), .o_PCSrcW(w_PCSrcW_out),
			 .o_RegWriteW(w_RegWriteW_out),.o_ResultW(w_ResultW), .o_WA3W(w_WA3W_out));

//hazard_unit
hazard_unit Hazard_unit(.clk(clk), .rst_n(rst_n), .i_RA1_ID(w_RA1_ID), .i_RA2_ID(w_RA2_ID), .i_WA_MEM(w_WA3M), .i_WA_WB(w_WA3W), .i_RegWriteM(w_RegWriteM),.i_RegWriteW(w_RegWriteW),
			 .i_RegWriteE(w_RegWriteE), .i_MemtoRegE(w_MemtoRegE), .i_WA_EX(w_WA3E), .i_BranchE(w_BranchE), .o_ForwardAE(w_ForwardAE),
			 .o_ForwardBE(w_ForwardBE), .o_StallF(w_StallF), .o_StallD(w_StallD), .o_FlushD(w_FlushD), .o_FlushE(w_FlushE));



endmodule