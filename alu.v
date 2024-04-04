`include "param.v"
module alu(i_A,i_B,i_Control,o_Flag,o_Result);

input [`D_WIDTH-1:0] i_A,i_B;
input [1:0]i_Control; // B, A, A+B, A-B
output reg [`D_WIDTH-1:0] o_Result;
output [3:0] o_Flag;

wire w_N,w_Z;
reg r_C=0;
reg r_V=0;

always@(*) begin
if(i_Control == 2'b00) begin
	o_Result <= i_A + i_B;
	r_V <= (i_A[`D_WIDTH-1] == i_B[`D_WIDTH-1]) && (i_A[`D_WIDTH-1] == ~o_Result[`D_WIDTH-1]);
end
else if(i_Control == 2'b01) begin
	o_Result <= i_A - i_B;
	r_V <= (i_A[`D_WIDTH-1] == ~i_B[`D_WIDTH-1]) && (i_A[`D_WIDTH-1] == ~o_Result[`D_WIDTH-1]);
end

else if(i_Control == 2'b10) o_Result <= i_B;

else o_Result <= i_A; //2'b11

end


assign w_N = o_Result[31];
assign w_Z = (o_Result == 32'b0) ? 1'b1 : 1'b0;

assign o_Flag = {w_N,w_Z,r_C,r_V};

endmodule
