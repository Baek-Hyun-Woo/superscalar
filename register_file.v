`include "param.v"
module register_file(clk,rst_n,i_A1,i_A2,i_A3,i_A4,
			i_WD1,i_WD2,i_WA1,i_WA2,i_WE1,i_WE2,i_PC,
			o_RD1,o_RD2,o_RD3,o_RD4);

input clk,rst_n;
input [3:0] i_A1,i_A2,i_A3,i_A4;
input [3:0] i_WA1,i_WA2;
input [`D_WIDTH-1:0] i_WD1,i_WD2;
input [`D_WIDTH-1:0] i_PC;
input i_WE1,i_WE2;


output reg [`D_WIDTH-1:0] o_RD1,o_RD2,o_RD3,o_RD4;

reg [`D_WIDTH-1:0] r_registers[14:0];
reg [`D_WIDTH-1:0] pc_register;

integer i = 0;

always@(posedge clk,negedge rst_n) begin
	if(!rst_n) begin
		for(i = 0; i < 15; i=i+1) begin
			r_registers[i] <= 'b0;
		end
		pc_register <= 'b0;
	end
	
	else begin
		if(i_WE1) r_registers[i_WA1] <= i_WD1;
			if(i_WA1 == 4'b1110) r_registers[14] <= i_PC - 8;
		else if(i_WE2) r_registers[i_WA2] <= i_WD2;
			if(i_WA2 == 4'b1110) r_registers[14] <= i_PC - 4;
		pc_register <= i_PC + 8;
	end

end

always@(*) begin
	if(i_A1 == 4'b1111) begin //branch
		o_RD1 <= i_PC; 
		o_RD2 <= i_PC;
	end

	else begin
		o_RD1 <= r_registers[i_A1];
		o_RD2 <= r_registers[i_A2];

	end

	if(i_A3 == 4'b1111) begin
		o_RD3 <= i_PC;
		o_RD4 <= i_PC;
	end

	else begin
		o_RD3 <= r_registers[i_A3];
		o_RD4 <= r_registers[i_A4];
	end

end
endmodule