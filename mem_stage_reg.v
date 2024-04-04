`include "param.v"
module mem_stage_reg(clk,rst_n,i_PCSrcM,i_RegWriteM,i_MemtoRegM,
			i_RD,i_ALUResultM,i_WA3M,
			o_PCSrcW,o_RegWriteW,o_MemtoRegW,
			o_ReadDataW,o_ALUOutW,o_WA3W);

input clk,rst_n;
input i_PCSrcM,i_RegWriteM,i_MemtoRegM;
input [`D_WIDTH-1:0] i_RD,i_ALUResultM;
input [3:0] i_WA3M;

output reg o_PCSrcW,o_RegWriteW,o_MemtoRegW;
output reg [`D_WIDTH-1:0] o_ReadDataW,o_ALUOutW;
output reg [3:0] o_WA3W;

always@(posedge clk, negedge rst_n) begin
	if(!rst_n) begin
		o_PCSrcW <= 0;
		o_RegWriteW <= 0;
		o_MemtoRegW <= 0;
		o_ReadDataW <= 0;
		o_ALUOutW <= 0;
		o_WA3W <= 0;
	end

	else begin
		o_PCSrcW <= i_PCSrcM;
		o_RegWriteW <= i_RegWriteM;
		o_MemtoRegW <= i_MemtoRegM;
		o_ReadDataW <= i_RD;
		o_ALUOutW <= i_ALUResultM;
		o_WA3W <= i_WA3M;
	end

end
endmodule
