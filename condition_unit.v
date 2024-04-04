`include "param.v"
module condition_unit(i_CondE,i_FlagsE,i_ALUFlags,i_FlagWriteE,o_Flags,o_CondExE);

input i_FlagWriteE;
input [3:0] i_CondE,i_FlagsE,i_ALUFlags;

output reg [3:0] o_Flags; //wire
output reg o_CondExE;

wire w_N,w_Z,w_C,w_V;

assign {w_N,w_Z,w_C,w_V} = i_FlagsE;

always @(*) begin
o_CondExE <= 1'b1;

case(i_CondE)
	`EQ: begin
		if(w_Z == 1'b1) o_CondExE <= 1'b1;
	     end

	`NE: begin
		if(w_Z == 1'b0) o_CondExE <= 1'b1;
	     end
	default: begin
		o_CondExE <= 1'b0;
	     end
endcase

end



always @(*) begin
	if(i_FlagWriteE) o_Flags <= i_ALUFlags;
	else o_Flags <= o_Flags;
end


endmodule