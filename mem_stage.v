`include "param.v"
module mem_stage(clk,rst_n,
					i_PCSr1M,i_RegWrite1M,i_MemtoReg1M,i_MemWrite1M,
					i_PCSrc2M,i_RegWrite2M,i_MemtoReg2M,i_MemWrite2M,
					i_ALUResult1M,i_WriteData1M,i_WA1M,
					i_ALUResult2M,i_WriteData2M,i_WA2M,
					o_PCSrc1M,o_RegWrite1M,o_MemtoReg1M,o_RD1,o_ALUOut1M,o_WA1M,o_ALUResult1M,
					o_PCSrc2M,o_RegWrite2M,o_MemtoReg2M,o_RD2,o_ALUOut2M,o_WA2M,o_ALUResult2M);

input clk,rst_n;
input i_PCSr1M,i_RegWrite1M,i_MemtoReg1M,i_MemWrite1M,i_PCSrc2M,i_RegWrite2M,i_MemtoReg2M,i_MemWrite2M;
input [`D_WIDTH-1:0] i_ALUResult1M,i_WriteData1M,i_ALUResult2M,i_WriteData2M;
input [3:0] i_WA1M,i_WA2M;

output o_PCSrc1M,o_RegWrite1M,o_MemtoReg1M,o_PCSrc2M,o_RegWrite2M,o_MemtoReg2M;
output [`D_WIDTH-1:0] o_RD1,o_ALUOut1M,o_ALUResult1M,o_RD2,o_ALUOut2M,o_ALUResult2M;
output [3:0] o_WA1M,o_WA2M;


assign o_ALUResult1M = i_ALUResult1M;
assign o_ALUOut1M = i_ALUResult1M;
assign o_WA1M = i_WA1M;
assign o_PCSrc1M = i_PCSrc1M;
assign o_RegWrite1M = i_RegWrite1M;
assign o_MemtoReg1M = i_MemtoReg1M;

assign o_ALUResult2M = i_ALUResult2M;
assign o_ALUOut2M = i_ALUResult2M;
assign o_WA2M = i_WA2M;
assign o_PCSrc2M = i_PCSrc2M;
assign o_RegWrite2M = i_RegWrite2M;
assign o_MemtoReg2M = i_MemtoReg2M;


data_memory Data_memory(.clk(clk), .rst_n(rst_n), .i_Address1(i_ALUResult1M), .i_Address2(i_ALUResult2M), 
						.i_WriteData1(i_WriteData1M), .i_WriteData2(i_WriteData2M), .i_WE1(i_MemWrite1M), .i_WE2(i_MemWrite2M),
						.o_RD1(o_RD1), .o_RD2(o_RD2));



endmodule