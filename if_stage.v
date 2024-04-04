`include "param.v"
module if_stage(clk,rst_n
		,i_StallF,i_PCSrc1W,i_PCSrc2W,i_Branch_Taken1E,i_Branch_Taken2E,
		i_Result1W,i_Result2W,i_ALUResult1E,i_ALUResult2E,
		o_PC,o_Instruction1,o_Instruction2);

input clk,rst_n;
input i_StallF,i_PCSrc1W,i_PCSrc2W;
input i_Branch_Taken1E,i_Branch_Taken2E;
input [`D_WIDTH-1:0] i_ALUResult1E,i_ALUResult2E;
input [`D_WIDTH-1:0] i_Result1W,i_Result2W;

output [`D_WIDTH-1:0] o_PC;
output [`D_WIDTH-1:0] o_Instruction1,o_Instruction2;

wire w_BranchTakenE,PCSrcW;
wire [`D_WIDTH-1:0] w_ALUResultE;
wire [`D_WIDTH-1:0] w_ResultW;

wire [`D_WIDTH-1:0] w_Mux_1;
wire [`D_WIDTH-1:0] w_PC; //== w_PC_In
wire [`D_WIDTH-1:0] w_PCF;
wire [`D_WIDTH-1:0] w_PC_Added;

assign w_BranchTakenE = i_BranchTaken1E | i_BranchTaken2E;
assign w_PCSrcW = i_PCSrc1W | i_PCSrc2W;

assign w_ALUResultE = (i_BranchTaken1E == 1'b1) ? i_ALUResult2E : i_ALUResult1E;
assign w_ResultW = (i_PCSrc1W == 1'b1) ? i_Result2W : i_Result1W;

assign w_PC = (w_Branch_TakenE == 1'b1) ? w_ALUResultE : w_Mux_1;

pc PC(.clk(clk),.rst_n(rst_n),.i_StallF(i_StallF),.i_PC(w_PC),.o_PCF(w_PCF));

assign w_PC_Added = w_PCF + 32'h8;


assign w_Mux_1 = (w_PCSrcW == 1'b1) ? w_ResultW : w_PC_Added;

assign o_PC = w_PC_Added;

instruction_memory Instruction_memory(.clk(clk), .rst_n(rst_n), .i_Address(w_PCF), .o_Instruction1(o_Instruction1), .o_Instruction2(o_Instruction2);



endmodule

