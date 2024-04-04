`include "param.v"
module id_stage_reg(clk,rst_n,
			i_Flush1E,i_PCSrc1D,i_RegWrite1D,i_MemtoReg1D,i_MemWrite1D,i_ALUControl1D,i_Branch1D,i_ALUSrc1D,i_FlagWrite1D,
			i_Flush2E,i_PCSrc2D,i_RegWrite2D,i_MemtoReg2D,i_MemWrite2D,i_ALUControl2D,i_Branch2D,i_ALUSrc2D,i_FlagWrite2D,
			i_Cond1,i_Flags1,i_RD1,i_RD2,i_Rd1,i_Extend_1,
			i_Cond2,i_Flags2,i_RD3,i_RD4,i_Rd2,i_Extend_2,

			o_PCSrc1E,o_RegWrite1E,o_MemtoReg1E,o_MemWrite1E,o_ALUControl1E,o_Branch1E,o_ALUSrc1E,o_FlagWrite1E,
			o_PCSrc2E,o_RegWrite2E,o_MemtoReg2E,o_MemWrite2E,o_ALUControl2E,o_Branch2E,o_ALUSrc2E,o_FlagWrite2E,
			o_Cond1E,o_Flags1E,o_RD1,o_RD2,o_Rd1,o_Extend_1,
			o_Cond2E,o_Flags2E,o_RD3,o_RD4,o_Rd2,o_Extend_2);

input clk,rst_n,i_Flush1E,i_PCSrc1D,i_RegWrite1D,i_MemtoReg1D,i_MemWrite1D,i_Branch1D,i_ALUSrc1D,i_FlagWrite1D,
			i_Flush2E,i_PCSrc2D,i_RegWrite2D,i_MemtoReg2D,i_MemWrite2D,i_Branch2D,i_ALUSrc2D,i_FlagWrite2D;
input [1:0] i_ALUControl1D,i_ALUControl2D;
input [3:0] i_Cond1,i_Flags1,i_Rd1,i_Cond2,i_Flags2,i_Rd2;
input [`D_WIDTH-1:0] i_RD1,i_RD2,i_RD3,i_RD4,i_Extend_1,i_Extend_2;

output reg o_PCSrc1E,o_RegWrite1E,o_MemtoReg1E,o_MemWrite1E,o_Branch1E,o_ALUSrc1E,o_FlagWrite1E,
			o_PCSrc2E,o_RegWrite2E,o_MemtoReg2E,o_MemWrite2E,o_Branch2E,o_ALUSrc2E,o_FlagWrite2E;
output reg [1:0] o_ALUControl1E,o_ALUControl2E;
output reg [3:0] o_Cond1E,o_Flags1E,o_Cond2E,o_Flags2E;
output reg [3:0] o_Rd1,o_Rd2;
output reg [`D_WIDTH-1:0] o_RD1,o_RD2,o_Extend_1,o_RD3,o_RD4,o_Extend_2;

always@(posedge clk,negedge rst_n) begin
if(!rst_n) begin
	o_PCSrc1E <= 0;
	o_RegWrite1E <= 0;
	o_MemtoReg1E <= 0;
	o_MemWrite1E <= 0;
	o_ALUControl1E <= 2'b00;
	o_Branch1E <= 0;
	o_ALUSrc1E <= 0;
	o_FlagWrite1E <= 0;
	o_Cond1E <= 4'b0;
	o_Flags1E <= 4'b0;
	o_Rd1 <= 4'b0;
	o_RD1 <= 32'b0;
	o_RD2 <= 32'b0;
	o_Extend_1 <= 32'b0;
	
	o_PCSrc2E <= 0;
	o_RegWrite2E <= 0;
	o_MemtoReg2E <= 0;
	o_MemWrite2E <= 0;
	o_ALUControl2E <= 2'b00;
	o_Branch2E <= 0;
	o_ALUSrc2E <= 0;
	o_FlagWrite2E <= 0;
	o_Cond2E <= 4'b0;
	o_Flags2E <= 4'b0;
	o_Rd2 <= 4'b0;
	o_RD3 <= 32'b0;
	o_RD4 <= 32'b0;
	o_Extend_2 <= 32'b0;
end

else if(clk && i_FlushE) begin
	o_PCSrcE <= 0;
	o_RegWriteE <= 0;
	o_MemtoRegE <= 0;
	o_MemWriteE <= 0;
	o_ALUControlE <= 2'b000;
	o_BranchE <= 0;
	o_ALUSrcE <= 0;
	o_FlagWriteE <= 0;
	o_CondE <= 4'b0;
	o_FlagsE <= 4'b0;
	o_Rd <= o_Rd;
	o_RD1 <= 32'b0;
	o_RD2 <= 32'b0;
	o_Extend <= 32'b0;
end

else begin
	o_PCSrcE <= i_PCSrcD;
	o_RegWriteE <= i_RegWriteD;
	o_MemtoRegE <= i_MemtoRegD;
	o_MemWriteE <= i_MemWriteD;
	o_ALUControlE <= i_ALUControlD;
	o_BranchE <= i_BranchD;
	o_ALUSrcE <= i_ALUSrcD;
	o_FlagWriteE <= i_FlagWriteD;
	o_CondE <= i_Cond;
	o_FlagsE <= i_Flags;
	o_Rd <= i_Rd;
	o_RD1 <= i_RD1;
	o_RD2 <= i_RD2;
	o_Extend <= i_Extend;
end
end

endmodule