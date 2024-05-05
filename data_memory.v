`include "param.v"
module data_memory(clk,rst_n,i_Address1,i_Address2,i_WriteData1,i_WriteData2,i_WE1,i_WE2,o_RD1,o_RD2);

input clk,rst_n;
input [`D_WIDTH-1:0] i_Address1,i_Address2,i_WriteData1,i_WriteData2;
input i_WE1,i_WE2;

output [`D_WIDTH-1:0] o_RD1,o_RD2;

reg [7:0] memory [255:0];

wire [`D_WIDTH-1:0] w_Start_Address1_0;
wire [`D_WIDTH-1:0] w_Start_Address1_1;
wire [`D_WIDTH-1:0] w_Start_Address1_2;
wire [`D_WIDTH-1:0] w_Start_Address1_3;

wire [`D_WIDTH-1:0] w_Start_Address2_0;
wire [`D_WIDTH-1:0] w_Start_Address2_1;
wire [`D_WIDTH-1:0] w_Start_Address2_2;
wire [`D_WIDTH-1:0] w_Start_Address2_3;

integer i;

assign w_Start_Address1_0 = i_Address1;
assign w_Start_Address1_1 = w_Start_Address1_0 + 32'd1;
assign w_Start_Address1_2 = w_Start_Address1_1 + 32'd1;
assign w_Start_Address1_3 = w_Start_Address1_2 + 32'd1;

assign o_RD1 = {memory[w_Start_Address1_3], memory[w_Start_Address1_2], memory[w_Start_Address1_1], memory[w_Start_Address1_0]};

assign w_Start_Address2_0 = i_Address2;
assign w_Start_Address2_1 = w_Start_Address2_0 + 32'd1;
assign w_Start_Address2_2 = w_Start_Address2_1 + 32'd1;
assign w_Start_Address2_3 = w_Start_Address2_2 + 32'd1;

assign o_RD2 = {memory[w_Start_Address2_3], memory[w_Start_Address2_2], memory[w_Start_Address2_1], memory[w_Start_Address2_0]};



always@(posedge clk,negedge rst_n) begin
	if(!rst_n) begin
		for(i = 0; i<255; i=i+1) begin
			memory[i] <= 8'b0000_0000;
		end
	end

	else begin
		if(i_WE1==1'b1 && i_WE2==1'b0) begin
			memory[w_Start_Address1_0] <= i_WriteData1[7:0];
			memory[w_Start_Address1_1] <= i_WriteData1[15:8];
			memory[w_Start_Address1_2] <= i_WriteData1[23:16];
			memory[w_Start_Address1_3] <= i_WriteData1[31:24];
		end
		else if(i_WE1==1'b0 && i_WE2==1'b1) begin
			memory[w_Start_Address2_0] <= i_WriteData2[7:0];
			memory[w_Start_Address2_1] <= i_WriteData2[15:8];
			memory[w_Start_Address2_2] <= i_WriteData2[23:16];
			memory[w_Start_Address2_3] <= i_WriteData2[31:24];
		end
		else if(i_WE1==1'b1 && i_WE2==1'b1) begin
			memory[w_Start_Address1_0] <= i_WriteData1[7:0];
			memory[w_Start_Address1_1] <= i_WriteData1[15:8];
			memory[w_Start_Address1_2] <= i_WriteData1[23:16];
			memory[w_Start_Address1_3] <= i_WriteData1[31:24];

			memory[w_Start_Address2_0] <= i_WriteData2[7:0];
			memory[w_Start_Address2_1] <= i_WriteData2[15:8];
			memory[w_Start_Address2_2] <= i_WriteData2[23:16];
			memory[w_Start_Address2_3] <= i_WriteData2[31:24];
		end
	end

end

endmodule
