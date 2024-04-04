`include "param.v"
module control_unit(i_Op,i_Function,i_Rd,
		o_PCSrcD,o_RegWriteD,o_MemtoRegD,o_MemWriteD,o_ALUControlD,
		o_BranchD,o_ALUSrcD,o_FlagWriteD,o_ImmSrcD,o_RegSrcD);

input [1:0] i_Op; // i_Mode , i_Instruction[27:26]
input [5:0] i_Function; // i_Instruction[25:20]
input [3:0] i_Rd; // i_Instruction[15:12]

output reg o_PCSrcD,o_RegWriteD,o_MemtoRegD,o_MemWriteD,o_BranchD,o_ALUSrcD,o_FlagWriteD;
output reg [1:0] o_ALUControlD,o_ImmSrcD;
output reg [2:0] o_RegSrcD;

always@(*) begin
o_PCSrcD <=1'b0;
o_RegWriteD <=1'b0;
o_MemtoRegD <=1'b0;
o_MemWriteD <=1'b0;
o_ALUControlD <=2'b00;
o_BranchD <=1'b0;
o_ALUSrcD <=1'b0;
o_FlagWriteD <=1'b0;
o_ImmSrcD <=2'b11;		 // In extend, default is 2'b11..
o_RegSrcD <=3'b100;


case(i_Op)
	`ARITHMATIC:begin
		if(i_Function[4:1] == 4'b0100) begin // ADD
			if(i_Function[0] == 1'b1) o_FlagWriteD <= 1'b1;
				if(i_Function[5] == 1) begin //operand2 == immediate
				o_ImmSrcD <= 2'b00;
				o_ALUSrcD <= 1'b1;
				o_RegWriteD <= 1'b1;
				o_RegSrcD <=3'b110;
				end

				else begin 		     //operand2 !== immediate -> operand2 == reg(Rm)
				o_RegWriteD <= 1'b1;
				o_RegSrcD <= 3'b100;
				end
		end

		else if(i_Function[4:1] == 4'b0010) begin // SUB
			if(i_Function[0] == 1'b1) o_FlagWriteD <= 1'b1;
				if(i_Function[5] == 1) begin //operand2 == immediate
				o_ImmSrcD <= 2'b00;
				o_ALUSrcD <= 1'b1;
				o_RegWriteD <= 1'b1;
				o_RegSrcD <= 3'b110;
				o_ALUControlD <= 2'b01;
				end

				else begin 		     //operand2 !== immediate -> operand2 == reg(Rm)
				o_RegWriteD <= 1'b1;
				o_RegSrcD <= 3'b100;
				o_ALUControlD <= 2'b01;
				end
		end

		else if(i_Function[4:1] == 4'b1010)begin // CMP 
			if(i_Function[0] == 1'b1) o_FlagWriteD <= 1'b1;
				if(i_Function[5] == 1) begin //operand2 == immediate
				o_ImmSrcD <= 2'b00;
				o_ALUSrcD <= 1'b1;
				o_ALUControlD <= 2'b01;
				o_FlagWriteD <= 1'b1;
				end

				else begin 		     //operand2 !== immediate -> operand2 == reg(Rm)
				o_ALUControlD <= 2'b01;
				o_FlagWriteD <= 1'b1;
				end
		end

		else if(i_Function[4:1] == 4'b1101)begin // MOV
			if(i_Rd == 4'b1111) o_BranchD <= 1'b1;		//MOV PC,R14
			if(i_Function[0] == 1'b1) o_FlagWriteD <= 1'b1;
				if(i_Function[5] == 1) begin //operand2 == immediate
				o_RegSrcD <= 3'b110;
				o_ImmSrcD <= 2'b00;
				o_ALUControlD <= 2'b10;
				o_ALUSrcD <= 1'b1;
				o_RegWriteD <= 1'b1;
				end

				else begin 		     //operand2 !== immediate -> operand2 == reg(Rm)
				o_ALUControlD <= 2'b10;
				o_RegWriteD <= 1'b1;
				o_RegSrcD <= 3'b100;
				end
		end
	end

	`MEM:begin
		if(i_Function[0] == 1'b1) begin // LDR
			if(i_Function[5] == 0) begin //offset is immediate
				// if(i_Function[1] == 0) begin // pre-index && auto-index(X)
				o_ImmSrcD <= 2'b01;
				o_ALUSrcD <= 1'b1;
				o_ALUControlD <= 2'b00;
				o_MemtoRegD <= 1'b1;
				o_RegWriteD <= 1'b1;
				o_RegSrcD <= 3'b110;
			end
				/*
				else begin // pre-index && auto-index(O)
				
				end
				*/
		end

			/*
			else begin 		     //offset isn't immediate -> offset reg(Rm)
			
			end
			*/

		else begin // STR
			if(i_Function[5] == 1'b0) begin //offset is immediate
			o_ImmSrcD <= 2'b01;
			o_RegSrcD <= 3'd110;
			o_ALUControlD <= 2'b11;
			o_MemWriteD <= 1'b1;
				if(i_Function[4] == 1'b1) begin
					o_ALUControlD <= 2'b00;
					o_ALUSrcD <= 1'b1;
				end
			end


			/*
			else begin 		     //offset isn't immediate -> offset reg(Rm)
			
			end
			*/
		end
	end

	`BRANCH:begin
		o_ImmSrcD <= 2'b10;
		if(i_Function[4] == 0) begin // B
			o_RegSrcD <= 3'b101;
			o_ALUSrcD <= 1'b1;
			o_ALUControlD <= 2'b10;
			//o_PCSrcD <= 1'b1;
			o_BranchD <= 1'b1;
		end

		else begin // BL
		o_RegSrcD <= 3'b001;
		o_ALUSrcD <= 1'b1;
		o_ALUControlD <= 2'b10;
		//o_PCSrcD <= 1'b1;
		o_BranchD <= 1'b1;
		end
	end
endcase	
end
endmodule