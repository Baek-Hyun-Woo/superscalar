`include "param.v"
module id_stage(clk,rst_n,
				i_Instruction1,i_Instruction2,i_PC,i_Flags1,i_Flags2,i_A3,i_A4,
				i_Result1W,i_Result2W,i_ALUResult1E,i_ALUResult2E,i_WE1,i_WE2,
				
				o_PCSrc1D,o_PCSrc2D,o_RegWrite1D,o_RegWrite2D,o_MemtoReg1D,o_MemtoReg2D,o_MemWrite1D,o_MemWrite2D,o_ALUControl1D,
				o_ALUControl2D,o_Branch1D,o_Branch2D,o_ALUSrc1D,o_ALUSrc2D,o_FlagWrite1D,o_FlagWrite2D,o_RegSrc1D,o_RegSrc2D,
				o_ImmSrc1D,o_ImmSrc2D,o_RD1,o_RD2,o_RD3,o_RD4,o_Rd1,o_Rd2,o_Extend1,o_Extend2,o_Flags1E,o_Flags2E,
				o_Cond1D,o_Cond2D,o_RA1D,o_RA2D,o_RA3D,o_RA4D);

input clk,rst_n;
input [`D_WIDTH-1:0] i_Instruction1,i_Instruciton2;
input [`D_WIDTH-1:0] i_PC,i_Result1W,i_Result2W,i_ALUResult1E,i_ALUResult2E;
input i_WE1,i_WE2;
input [3:0] i_Flags1,i_Flags2;
input [3:0] i_A3,i_A4;


output o_PCSrc1D,o_RegWrite1D,o_MemtoReg1D,o_MemWrite1D,o_Branch1D,o_ALUSrc1D,o_FlagWrite1D,
		o_PCSrc2D,o_RegWrite2D,o_MemtoReg2D,o_MemWrite2D,o_Branch2D,o_ALUSrc2D,o_FlagWrite2D;
output [1:0] o_ALUControl1D,o_ALUControl2D;
output [1:0] o_ImmSrc1D,o_ImmSrc2D;
output [2:0] o_RegSrc1D,o_RegSrc2D;
output [`D_WIDTH-1:0] o_RD1,o_RD2,o_RD3,o_RD4;
output [`D_WIDTH-1:0] o_Extend1,o_Extend2;
output [3:0] o_Rd1,o_Rd2;
output [3:0] o_Cond1D,o_Cond2D;
output [3:0] o_Flags1E,o_Flags2E;

output [3:0] o_RA1D,o_RA2D,o_RA3D,o_RA4D;


wire [1:0] w_Op1,w_Op2;
wire [5:0] w_Function1,w_Function2;
wire [3:0] w_Rd1,w_Rd2;
wire [3:0] w_Cond1,w_Cond2;
wire [3:0] w_Rn1,w_Rn2;
wire [3:0] w_Rm1,w_Rm2;
wire signed [23:0] w_Extend24_1,w_Extend24_2;


wire [3:0]  w_WA1,w_WA2;
wire [`D_WIDTH-1:0] w_WD1,w_WD2;

assign w_Op1 = i_Instruction1[27:26];
assign w_Function1 = i_Instruction1[25:20];
assign w_Rd1 = i_Instruction1[15:12];
assign w_Cond1 = i_Instruction1[31:28];
assign w_Rn1 = i_Instruction1[19:16];
assign w_Rm1 = i_Instruction1[3:0];
assign w_Extend24_1 = i_Instruction1[23:0];

assign w_Op2 = i_Instruction2[27:26];
assign w_Function2 = i_Instruction2[25:20];
assign w_Rd2 = i_Instruction2[15:12];
assign w_Cond2 = i_Instruction2[31:28];
assign w_Rn2 = i_Instruction2[19:16];
assign w_Rm2 = i_Instruction2[3:0];
assign w_Extend24_2 = i_Instruction2[23:0];

assign o_Rd1 = w_Rd1;
assign o_Rd2 = w_Rd2;
assign o_RA1D = (o_RegSrc1D[0] == 1'b1) ? 4'b1111 : w_Rn1;
assign o_RA3D = (o_RegSrc2D[0] == 1'b1) ? 4'b1111 : w_Rn2;
assign o_RA2D = (o_RegSrc1D[1] == 1'b1) ? w_Rd1 : w_Rm1;
assign o_RA4D = (o_RegSrc2D[1] == 1'b1) ? w_Rd2 : w_Rm2;
assign w_WA1 = (o_RegSrc1D[2] == 1'b1) ? i_A3 : 4'b1110;
assign w_WA2 = (o_RegSrc2D[2] == 1'b1) ? i_A4 : 4'b1110;
assign w_WD1 = i_Result1W;
assign w_WD2 = i_Result2W;

assign o_Flags1E = i_Flags1;
assign o_Flags2E = i_Flags2;
assign o_Cond1D = w_Cond1;
assign o_Cond2D = w_Cond2;

register_file Register_file(.clk(clk), .rst_n(rst_n), .i_A1(o_RA1D), .i_A2(o_RA2D),.i_A3(o_RA3D), .i_A4(o_RA4D), 
							.i_WA1(w_WA1), .i_WA2(w_WA2), .i_WD1(w_WD1), .i_WD2(w_WD2), .i_WE1(i_WE1), .i_WE2(i_WE2), .i_PC(i_PC + 4),
							.o_RD1(o_RD1), .o_RD2(o_RD2), .o_RD3(o_RD3), .o_RD4(o_RD4));



control_unit Control_unit1(.i_Op(w_Op1),.i_Function(w_Function1),.i_Rd(w_Rd1),
				.o_PCSrcD(o_PCSrc1D),.o_RegWriteD(o_RegWrite1D),.o_MemtoRegD(o_MemtoReg1D),
				.o_MemWriteD(o_MemWrite1D),.o_ALUControlD(o_ALUControl1D),.o_BranchD(o_Branch1D),
				.o_ALUSrcD(o_ALUSrc1D),.o_FlagWriteD(o_FlagWrite1D),.o_ImmSrcD(o_ImmSrc1D),.o_RegSrcD(o_RegSrc1D));

control_unit Control_unit2(.i_Op(w_Op2),.i_Function(w_Function2),.i_Rd(w_Rd2),
				.o_PCSrcD(o_PCSrc2D),.o_RegWriteD(o_RegWrite2D),.o_MemtoRegD(o_MemtoReg2D),
				.o_MemWriteD(o_MemWrite2D),.o_ALUControlD(o_ALUControl2D),.o_BranchD(o_Branch2D),
				.o_ALUSrcD(o_ALUSrc2D),.o_FlagWriteD(o_FlagWrite2D),.o_ImmSrcD(o_ImmSrc2D),.o_RegSrcD(o_RegSrc2D));

extend Extend(.i_Extend24_1(w_Extend24_1), .i_Extend24_2(w_Extend24_2), .i_ImmSrc1D(o_ImmSrc1D), .i_ImmSrc2D(o_ImmSrc2D),
				.o_Extend1(o_Extend1), .o_Extend2(o_Extend2));
endmodule
