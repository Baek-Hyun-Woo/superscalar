`include "param.v"
module pc(clk,rst_n,i_StallF,i_PC,o_PCF);

input clk,rst_n;
input i_StallF;
input [`D_WIDTH-1:0] i_PC;

output reg [`D_WIDTH-1:0] o_PCF;

always@(posedge clk,negedge rst_n) begin
	if(!rst_n) o_PCF <= 0;
	else if(clk && ~i_StallF) o_PCF <= i_PC;
	else o_PCF <= o_PCF;
end
endmodule