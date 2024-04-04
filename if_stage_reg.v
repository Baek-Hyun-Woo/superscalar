`include "param.v"
module if_stage_reg(clk,rst_n,i_Flush1D,i_Flush2D,i_Stall1D,i_Stal2D,i_PC,i_Instruction1,i_Instruction2,o_PC,o_Instruction1,o_Instruction2);

input clk,rst_n;
input i_Flush1D,i_Flush2D,i_Stall1D,i_Stal2D;
input [`D_WIDTH-1:0] i_PC;
input [`D_WIDTH-1:0] i_Instruction1,i_Instruction2;

output reg [`D_WIDTH-1:0] o_PC;
output reg [`D_WIDTH-1:0] o_Instruction1;
output reg [`D_WIDTH-1:0] o_Instruction2

always@(posedge clk,negedge rst_n) begin
	if(!rst_n) begin
		o_PC <= 32'b0;
		o_Instruction1 <= 32'b0;
		o_Instruction2 <= 32'b0;
	end
	else if(clk && i_Flush1D) begin		//delete o_PC? is it ok?
		o_PC <= 32'b0;
		o_Instruction1 <= 32'b0;
	end
	else if(clk && i_Flush2D) begin
		o_PC <= 32'b0;
		o_Instruction2 <= 32'b0;
	end
	else if(clk && ~i_Stall1D) begin
		o_PC <= i_PC;
		o_Instruction1 <= i_Instruction1;
	end
	else if(clk && ~i_Stall2D) begin
		o_PC <= i_PC;
		o_Instruction2 <= i_Instruction2;
	end
	else begin
		o_PC <= o_PC;
		o_Instruction1 <= o_Instruction1;
		o_Instruction2 <= o_Instruction2;
	end
end
endmodule