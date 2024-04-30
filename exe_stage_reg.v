`include "param.v"
module exe_stage_reg(clk,rst_n,i_PCSrc1,i_RegWrite1,i_MemtoReg1,i_MemWrite1,
							   i_PCSrc2,i_RegWrite2,i_MemtoReg2,i_MemWrite2,
							   i_ALUResult1E,i_WriteData1E,i_WA1E,
							   i_ALUResult2E,i_WriteData2E,i_WA2E,
							   o_PCSrc1M,o_RegWrite1M,o_MemtoReg1M,o_MemWrite1M,o_ALUResult1M,o_WriteData1M,o_WA1M,
							   o_PCSrc2M,o_RegWrite2M,o_MemtoReg2M,o_MemWrite2M,o_ALUResult2M,o_WriteData2M,o_WA2M);

input clk,rst_n;
input i_PCSrc1,i_RegWrite1,i_MemtoReg1,i_MemWrite1,i_PCSrc2,i_RegWrite2,i_MemtoReg2,i_MemWrite2;
input [`D_WIDTH-1:0] i_ALUResult1E,i_WriteData1E,i_ALUResult2E,i_WriteData2E;
input [3:0] i_WA1E,i_WA2E;

output reg o_PCSrc1M,o_RegWrite1M,o_MemtoReg1M,o_MemWrite1M,o_PCSrc2M,o_RegWrite2M,o_MemtoReg2M,o_MemWrite2M;
output reg [`D_WIDTH-1:0] o_ALUResult1M,o_WriteData1M,o_ALUResult2M,o_WriteData2M;
output reg [3:0] o_WA1M,o_WA2M;

always@(posedge clk, negedge rst_n) begin
	if(!rst_n) begin
		o_PCSrc1M <= 0;
		o_RegWrite1M <= 0;
		o_MemtoReg1M <= 0;
		o_MemWrite1M <= 0;
		o_ALUResult1M <= 0;
		o_WriteData1M <= 0;
		o_WA1M <= 0;

		o_PCSrc2M <= 0;
		o_RegWrite2M <= 0;
		o_MemtoReg2M <= 0;
		o_MemWrite2M <= 0;
		o_ALUResult2M <= 0;
		o_WriteData2M <= 0;
		o_WA2M <= 0;
	end

	else begin
		o_PCSrc1M <= i_PCSrc1;
		o_RegWrite1M <= i_RegWrite1;
		o_MemtoReg1M <= i_MemtoReg1;
		o_MemWrite1M <= i_MemWrite1;
		o_ALUResult1M <= i_ALUResult1E;
		o_WriteData1M <= i_WriteData1E;
		o_WA1M <= i_WA1E;

		o_PCSrc2M <= i_PCSrc2;
		o_RegWrite2M <= i_RegWrite2;
		o_MemtoReg2M <= i_MemtoReg2;
		o_MemWrite2M <= i_MemWrite2;
		o_ALUResult2M <= i_ALUResult2E;
		o_WriteData2M <= i_WriteData2E;
		o_WA2M <= i_WA2E;
	end

end
endmodule