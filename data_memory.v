`include "param.v"
module data_memory(clk,rst_n,i_Address,i_WriteData,i_WE,o_RD);

input clk,rst_n;
input [`D_WIDTH-1:0] i_Address,i_WriteData;
input i_WE;

output [`D_WIDTH-1:0] o_RD;

reg [7:0] memory [255:0];

wire [`D_WIDTH-1:0] w_Start_Address_0;
wire [`D_WIDTH-1:0] w_Start_Address_1;
wire [`D_WIDTH-1:0] w_Start_Address_2;
wire [`D_WIDTH-1:0] w_Start_Address_3;

integer i;

assign w_Start_Address_0 = i_Address;
assign w_Start_Address_1 = w_Start_Address_0 + 32'd1;
assign w_Start_Address_2 = w_Start_Address_1 + 32'd1;
assign w_Start_Address_3 = w_Start_Address_2 + 32'd1;

assign o_RD = {memory[w_Start_Address_3], memory[w_Start_Address_2], memory[w_Start_Address_1], memory[w_Start_Address_0]};

always@(posedge clk,negedge rst_n) begin
	if(!rst_n) begin
		for(i = 0; i<255; i=i+1) begin
			memory[i] <= 8'b0000_0000;
		end
	end

	else begin
		if(i_WE) begin
			memory[w_Start_Address_0] <= i_WriteData[7:0];
			memory[w_Start_Address_1] <= i_WriteData[15:8];
			memory[w_Start_Address_2] <= i_WriteData[23:16];
			memory[w_Start_Address_3] <= i_WriteData[31:24];
		end
	end

end

endmodule
