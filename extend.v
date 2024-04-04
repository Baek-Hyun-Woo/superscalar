`include "param.v"
module extend(i_Extend24_1,i_Extend24_2,i_ImmSrc1D,i_ImmSrc2D,o_Extend1,o_Extend2);
input signed [23:0] i_Extend24_1,i_Extend24_2;
input [1:0] i_ImmSrc1D,i_ImmSrc2D;
output reg signed  [`D_WIDTH-1:0] o_Extend1,o_Extend2;

integer i;

always@(*) begin
	case(i_ImmSrc1D)
	2'b00:begin //DPI(ADD,SUB,MOV,CMP) - src2 is immediate
		o_Extend1[7:0] = i_Extend24_1[7:0];
		for(i=8;i<32;i=i+1)
			o_Extend1[i] = i_Extend24_1[7];
	end
	2'b01:begin //DTI(LDR,STR) - offset is immediate
		o_Extend1[11:0] = i_Extend24_1[11:0];
		for(i=12;i<32;i=i+1)
			o_Extend1[i] = 32'b0;
	end
	2'b10:begin //B,BL - 24bit immediate
		o_Extend1 = {{8{i_Extend24_1[23]}},i_Extend24_1[23:0]};
	end
	default:
	o_Extend1 = 32'b0;
	endcase

	case(i_ImmSrc2D)
	2'b00:begin //DPI(ADD,SUB,MOV,CMP) - src2 is immediate
		o_Extend2[7:0] = i_Extend24_2[7:0];
		for(i=8;i<32;i=i+1)
			o_Extend2[i] = i_Extend24_2[7];
	end
	2'b01:begin //DTI(LDR,STR) - offset is immediate
		o_Extend2[11:0] = i_Extend24_2[11:0];
		for(i=12;i<32;i=i+1)
			o_Extend_2[i] = 32'b0;
	end
	2'b10:begin //B,BL - 24bit immediate
		o_Extend2 = {{8{i_Extend24_2[23]}},i_Extend24_2[23:0]};
	end
	default:
	o_Extend2 = 32'b0;
	endcase
	
end
endmodule