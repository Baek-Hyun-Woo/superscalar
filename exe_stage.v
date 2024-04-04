`include "param.v"
module exe_stage(clk,rst_n,i_PCSrcE,i_RegWriteE,i_MemtoRegE,i_MemWriteE,
		i_ALUControlE,i_BranchE,i_ALUSrcE,i_FlagWriteE,i_CondE,i_FlagsE,
		i_RD1,i_RD2,i_ALUResultM,i_ResultW,i_ForwardAE,i_ForwardBE,i_Extend,i_Rd,
		o_PCSrc,o_RegWrite,o_MemtoReg,o_MemWrite,o_BranchTakenE,
		o_ALUResultE,o_WriteDataE,o_WA3E,o_Flags);

input clk,rst_n;
input i_PCSrcE,i_RegWriteE,i_MemtoRegE,i_MemWriteE,i_BranchE,i_ALUSrcE,i_FlagWriteE;
input [1:0]i_ALUControlE;

input [3:0] i_CondE,i_FlagsE;
input [`D_WIDTH-1:0] i_RD1,i_RD2,i_ALUResultM,i_ResultW,i_Extend;
input [1:0] i_ForwardAE,i_ForwardBE;
input [3:0] i_Rd;

output o_PCSrc,o_RegWrite,o_MemtoReg,o_MemWrite,o_BranchTakenE;
output [`D_WIDTH-1:0] o_ALUResultE,o_WriteDataE;
output [3:0] o_WA3E;
output [3:0] o_Flags;

wire [`D_WIDTH-1:0] SrcAE;
wire [`D_WIDTH-1:0] SrcBE;
wire [3:0] w_ALUFlags;
wire w_CondExE;

assign SrcAE = (i_ForwardAE == `FORWARD_FROM_ID) ? i_RD1 :
		(i_ForwardAE == `FORWARD_FROM_WB) ? i_ResultW :
		(i_ForwardAE == `FORWARD_FROM_MEM) ? i_ALUResultM : i_RD1;

assign o_WriteDataE = (i_ForwardBE == `FORWARD_FROM_ID) ? i_RD2 :
		(i_ForwardBE == `FORWARD_FROM_WB) ? i_ResultW :
		(i_ForwardBE == `FORWARD_FROM_MEM) ? i_ALUResultM : i_RD1;

assign SrcBE = i_ALUSrcE ? i_Extend : o_WriteDataE;

assign o_WA3E = i_Rd;



alu alu(.i_A(SrcAE), .i_B(SrcBE), .i_Control(i_ALUControlE),
	 .o_Result(o_ALUResultE), .o_Flag(w_ALUFlags));


condition_unit Condition_unit(.i_CondE(i_CondE), .i_FlagsE(i_FlagsE),
				 .i_ALUFlags(w_ALUFlags),.i_FlagWriteE(i_FlagWriteE),
				 .o_Flags(o_Flags),.o_CondExE(w_CondExE));

assign o_MemtoReg = i_MemtoRegE;

// ????...
assign o_PCSrc = (i_PCSrcE && w_CondExE);
assign o_RegWrite = (i_RegWriteE && w_CondExE);
assign o_MemWrite = (i_MemWriteE && w_CondExE);
assign o_BranchTakenE = (i_BranchE && w_CondExE);


endmodule