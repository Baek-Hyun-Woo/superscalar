`include "param.v"
module wb_stage(clk,rst_n,i_PCSrcW,i_RegWriteW,i_MemtoRegW,
		i_ReadDataW,i_ALUOutW,i_WA3W,
		o_PCSrcW,o_RegWriteW,o_ResultW,
		o_WA3W);

input clk,rst_n;
input i_PCSrcW,i_RegWriteW,i_MemtoRegW;
input [`D_WIDTH-1:0] i_ReadDataW,i_ALUOutW;
input [3:0] i_WA3W;

output o_PCSrcW,o_RegWriteW;
output [`D_WIDTH-1:0] o_ResultW;
output [3:0] o_WA3W;

assign o_PCSrcW = i_PCSrcW;
assign o_RegWriteW = i_RegWriteW;
assign o_WA3W = i_WA3W;

assign o_ResultW = i_MemtoRegW ? i_ReadDataW : i_ALUOutW;

endmodule
