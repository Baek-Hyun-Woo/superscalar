`include "param.v"
module exe_stage_reg(clk,rst_n,i_PCSrc,i_RegWrite,i_MemtoReg,i_MemWrite,
			i_ALUResultE,i_WriteDataE,i_WA3E,
			o_PCSrcM,o_RegWriteM,o_MemtoRegM,o_MemWriteM,
			o_ALUResultM,o_WriteDataM,o_WA3M);

input clk,rst_n;
input i_PCSrc,i_RegWrite,i_MemtoReg,i_MemWrite;
input [`D_WIDTH-1:0] i_ALUResultE,i_WriteDataE;
input [3:0] i_WA3E;

output reg o_PCSrcM,o_RegWriteM,o_MemtoRegM,o_MemWriteM;
output reg [`D_WIDTH-1:0] o_ALUResultM,o_WriteDataM;
output reg [3:0] o_WA3M;

always@(posedge clk, negedge rst_n) begin
	if(!rst_n) begin
		o_PCSrcM <= 0;
		o_RegWriteM <= 0;
		o_MemtoRegM <= 0;
		o_MemWriteM <= 0;
		o_ALUResultM <= 0;
		o_WriteDataM <= 0;
		o_WA3M <= 0;
	end

	else begin
		o_PCSrcM <= i_PCSrc;
		o_RegWriteM <= i_RegWrite;
		o_MemtoRegM <= i_MemtoReg;
		o_MemWriteM <= i_MemWrite;
		o_ALUResultM <= i_ALUResultE;
		o_WriteDataM <= i_WriteDataE;
		o_WA3M <= i_WA3E;
	end

end
endmodule