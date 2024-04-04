`include "param.v"
module instruction_memory(clk,rst_n,i_Address,o_Instruction1,o_Instruction2);

input clk,rst_n;
input [`D_WIDTH-1:0] i_Address;

output reg [`D_WIDTH-1:0] o_Instruction1, o_Instruction2;

reg [7:0] memory [1023:0];


always@(*) begin 
	if(!rst_n)begin
		o_Instruction1 <= 32'b0;
		o_Instruction2 <= 32'b0;
		{memory[3],memory[2],memory[1],memory[0]} = 32'h00000000; //MOV R0 ,#2
	end
	else begin
		o_Instruction1 <= {memory[i_Address],memory[i_Address+'d1],memory[i_Address+'d2],memory[i_Address+'d3]};
		o_Instruction2 <= {memory[i_Address+'d4],memory[i_Address+'d5],memory[i_Address+'d6],memory[i_Address+'d7]};
	end
end
endmodule
