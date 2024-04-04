`include "param.v"
module mem_stage(clk,rst_n,i_PCSrcM,i_RegWriteM,i_MemtoRegM,i_MemWriteM,
		i_ALUResultM,i_WriteDataM,i_WA3M,
		o_PCSrcM,o_RegWriteM,o_MemtoRegM,o_RD,o_ALUOutM,o_WA3M,o_ALUResultM);

input clk,rst_n;
input i_PCSrcM,i_RegWriteM,i_MemtoRegM,i_MemWriteM;
input [`D_WIDTH-1:0] i_ALUResultM,i_WriteDataM;
input [3:0] i_WA3M;

output o_PCSrcM,o_RegWriteM,o_MemtoRegM;
output [`D_WIDTH-1:0] o_RD,o_ALUOutM,o_ALUResultM;
output [3:0] o_WA3M;


assign o_ALUResultM = i_ALUResultM;
assign o_ALUOutM = i_ALUResultM;
assign o_WA3M = i_WA3M;
assign o_PCSrcM = i_PCSrcM;
assign o_RegWriteM = i_RegWriteM;
assign o_MemtoRegM = i_MemtoRegM;

data_memory Data_memory(.clk(clk), .rst_n(rst_n), .i_Address(i_ALUResultM), .i_WriteData(i_WriteDataM),
			 .i_WE(i_MemWriteM), .o_RD(o_RD));



endmodule