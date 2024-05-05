`include "param.v"
module wb_stage(clk,rst_n,
				i_PCSrc1W,i_RegWrite1W,i_MemtoReg1W,i_PCSrc2W,i_RegWrite2W,i_MemtoReg2W,
				i_ReadData1W,i_ALUOut1W,i_WA1W,i_ReadData2W,i_ALUOut2W,i_WA2W,
				o_PCSrc1W,o_RegWrite1W,o_Result1W,o_PCSrc2W,o_RegWrite2W,o_Result2W,
				o_WA1W,o_WA2W);

input clk,rst_n;
input i_PCSrc1W,i_RegWrite1W,i_MemtoReg1W,i_PCSrc2W,i_RegWrite2W,i_MemtoReg2W;
input [`D_WIDTH-1:0] i_ReadData1W,i_ALUOut1W,i_ReadData2W,i_ALUOut2W;
input [3:0] i_WA1W,i_WA2W;

output o_PCSrc1W,o_RegWrite1W,o_PCSrc2W,o_RegWrite2W;
output [`D_WIDTH-1:0] o_Result1W,o_Result2W;
output [3:0] o_WA1W,o_WA2W;

assign o_PCSrc1W = i_PCSrc1W;
assign o_RegWrite1W = i_RegWrite1W;
assign o_WA1W = i_WA1W;

assign o_PCSrc2W = i_PCSrc2W;
assign o_RegWrite2W = i_RegWrite2W;
assign o_WA2W = i_WA2W;

assign o_Result1W = i_MemtoReg1W ? i_ReadData1W : i_ALUOut1W;

assign o_Result2W = i_MemtoReg2W ? i_ReadData2W : i_ALUOut2W;

endmodule
