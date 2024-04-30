`include "param.v"
module exe_stage(clk,rst_n,
				i_PCSrc1E,i_RegWrite1E,i_MemtoReg1E,i_MemWrite1E,i_ALUControl1E,i_Branch1E,i_ALUSrc1E,i_FlagWrite1E,i_Cond1E,i_Flags1E,
				i_PCSrc2E,i_RegWrite2E,i_MemtoReg2E,i_MemWrite2E,i_ALUControl2E,i_Branch2E,i_ALUSrc2E,i_FlagWrite2E,i_Cond2E,i_Flags2E,
				i_RD1,i_RD2,i_ALUResult1M,i_Result1W,i_Forward1AE,i_Forward1BE,i_Extend_1,i_Rd1,
				i_RD3,i_RD4,i_ALUResult2M,i_Result2W,i_Forward2AE,i_Forward2BE,i_Extend_2,i_Rd2,

				o_PCSrc1,o_RegWrite1,o_MemtoReg1,o_MemWrite1,o_BranchTaken1E,
				o_PCSrc2,o_RegWrite2,o_MemtoReg2,o_MemWrite2,o_BranchTaken2E,
				o_ALUResult1E,o_WriteData1E,o_WA1E,o_Flags1,
				o_ALUResult2E,o_WriteData2E,o_WA2E,o_Flags2);

input clk,rst_n;
input i_PCSrc1E,i_RegWrite1E,i_MemtoReg1E,i_MemWrite1E,i_Branch1E,i_ALUSrc1E,i_FlagWrite1E,i_PCSrc2E,i_RegWrite2E,i_MemtoReg2E,i_MemWrite2E,i_Branch2E,i_ALUSrc2E,i_FlagWrite2E;
input [1:0]i_ALUControl1E,i_ALUControl2E;

input [3:0] i_Cond1E,i_Flags1E,i_Cond2E,i_Flags2E;
input [`D_WIDTH-1:0] i_RD1,i_RD2,i_RD3,i_RD4,i_ALUResult1M,i_Result1W,i_Extend_1,i_ALUResult2M,i_Result2W,i_Extend_2;
input [1:0] i_Forward1AE,i_Forward1BE,i_Forward2AE,i_Forward2BE;
input [3:0] i_Rd1,i_Rd2;

output o_PCSrc1,o_RegWrite1,o_MemtoReg1,o_MemWrite1,o_BranchTaken1E,o_PCSrc2,o_RegWrite2,o_MemtoReg2,o_MemWrite2,o_BranchTaken2E;
output [`D_WIDTH-1:0] o_ALUResult1E,o_WriteData1E,o_ALUResult2E,o_WriteData2E;
output [3:0] o_WA1E,o_WA2E;
output [3:0] o_Flags1,o_Flags2;

wire [`D_WIDTH-1:0] SrcA1E,SrcB1E,SrcA2E,SrcB2E;
wire [3:0] w_ALUFlags1,w_ALUFlags2;
wire w_CondExE1,w_CondExE1;


// ALU1
assign SrcA1E = (i_Forward1AE == `FORWARD_FROM_ID) ? i_RD1 :
		(i_Forward1AE == `FORWARD_FROM_WB) ? i_Result1W :
		(i_Forward1AE == `FORWARD_FROM_MEM) ? i_ALUResult1M : i_RD1;

assign o_WriteData1E = (i_Forward1BE == `FORWARD_FROM_ID) ? i_RD2 :
		(i_Forward1BE == `FORWARD_FROM_WB) ? i_Result1W :
		(i_Forward1BE == `FORWARD_FROM_MEM) ? i_ALUResult1M : i_RD1;

assign SrcB1E = i_ALUSrc1E ? i_Extend_1 : o_WriteData1E;

assign o_WA1E = i_Rd1;

//ALU2
assign SrcA2E = (i_Forward2AE == `FORWARD_FROM_ID) ? i_RD3 :
		(i_Forward2AE == `FORWARD_FROM_WB) ? i_Result2W :
		(i_Forward2AE == `FORWARD_FROM_MEM) ? i_ALUResult2M : i_RD3;

assign o_WriteData2E = (i_Forward2BE == `FORWARD_FROM_ID) ? i_RD4 :
		(i_Forward2BE == `FORWARD_FROM_WB) ? i_Result2W :
		(i_Forward2BE == `FORWARD_FROM_MEM) ? i_ALUResult2M : i_RD3;

assign SrcB2E = i_ALUSrc2E ? i_Extend_2 : o_WriteData2E;

assign o_WA2E = i_Rd2;



alu alu1(.i_A(SrcA1E), .i_B(SrcB1E), .i_Control(i_ALUControl1E),
	 .o_Result(o_ALUResul1E), .o_Flag(w_ALUFlags1));

alu alu2(.i_A(SrcA2E), .i_B(SrcB2E), .i_Control(i_ALUControl2E),
	 .o_Result(o_ALUResul2E), .o_Flag(w_ALUFlags2));


condition_unit Condition_unit1(.i_CondE(i_Cond1E), .i_FlagsE(i_Flags1E),
				 .i_ALUFlags(w_ALUFlags1),.i_FlagWriteE(i_FlagWrite1E),
				 .o_Flags(o_Flags1),.o_CondExE(w_CondExE1));

condition_unit Condition_unit2(.i_CondE(i_Cond2E), .i_FlagsE(i_Flags2E),
				 .i_ALUFlags(w_ALUFlags2),.i_FlagWriteE(i_FlagWrite2E),
				 .o_Flags(o_Flags2),.o_CondExE(w_CondExE2));

assign o_MemtoReg1 = i_MemtoReg1E;
assign o_MemtoReg2 = i_MemtoReg2E;

// ????...
assign o_PCSrc1 = (i_PCSrc1E && w_CondExE1);
assign o_RegWrite1 = (i_RegWrite1E && w_CondExE1);
assign o_MemWrite1 = (i_MemWrite1E && w_CondExE1);
assign o_BranchTaken1E = (i_Branch1E && w_CondExE1);

assign o_PCSrc2 = (i_PCSrc2E && w_CondExE2);
assign o_RegWrite2 = (i_RegWrite2E && w_CondExE2);
assign o_MemWrite2 = (i_MemWrite2E && w_CondExE2);
assign o_BranchTaken2E = (i_Branch2E && w_CondExE2);

endmodule