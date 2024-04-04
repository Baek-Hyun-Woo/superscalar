`include "param.v"
module hazard_unit(clk,rst_n,i_RA1_ID,i_RA2_ID, i_WA_MEM,i_WA_WB, //forwarding
			i_RegWriteM,i_RegWriteW,i_RegWriteE, //forwarding
			i_MemtoRegE,i_WA_EX,i_BranchE, //hazard
			o_ForwardAE,o_ForwardBE, //forwarding
			o_StallF,o_StallD,o_FlushD,o_FlushE); //hazard

input clk,rst_n;
input [3:0] i_RA1_ID, i_RA2_ID, i_WA_MEM, i_WA_WB, i_WA_EX;
input i_RegWriteM, i_RegWriteW, i_MemtoRegE,i_BranchE;
input i_RegWriteE;

output reg [1:0] o_ForwardAE, o_ForwardBE;
output reg o_StallF, o_StallD, o_FlushD, o_FlushE;

always@(negedge clk,negedge rst_n) begin // negedge clk
	if(!rst_n) begin
		o_StallF <= 1'b0;
		o_StallD <= 1'b0;
		o_FlushD <= 1'b0;
		o_FlushE <= 1'b0;
	end
	
	
	else begin
		if(((i_RA1_ID == i_WA_EX) || (i_RA2_ID == i_WA_EX)) &&(i_MemtoRegE == 1'b1)) begin //LDR..?
			o_StallF <= 1'b1;
			o_StallD <= 1'b1;
		end
		else begin
			o_StallF <= 1'b0;
			o_StallD <= 1'b0;
		end

		if(i_BranchE == 1'b1) begin
			o_FlushD <= 1'b1;
			o_FlushE <= 1'b1;
		end
		else begin
			o_FlushD <= 1'b0;
			o_FlushE <= 1'b0;
		end
	end
end



always@(posedge clk, negedge rst_n) begin
	if(!rst_n) begin
		o_ForwardAE <= 2'b00;
		o_ForwardBE <= 2'b00;
	end
	
	else begin
		if((i_RA1_ID == i_WA_MEM) && (i_RegWriteM == 1'b1)) begin
			o_ForwardAE <= 2'b01;
			if(i_RA2_ID == i_WA_EX) begin // WB
				o_ForwardAE <= 2'b01;
				o_ForwardBE <= 2'b10;
			end
			else if(i_RA2_ID == i_WA_WB) begin
				o_ForwardAE <= 2'b10;
				o_ForwardBE <= 2'b01;
			end
		end

		else if((i_RA2_ID == i_WA_MEM) && (i_RegWriteM == 1'b1)) begin
			o_ForwardBE <= 2'b01;
			if(i_RA1_ID == i_WA_EX) begin
				o_ForwardAE <= 2'b10;
				o_ForwardBE <= 2'b01;
			end
			else if(i_RA1_ID == i_WA_WB) begin
				o_ForwardAE <= 2'b01;
				o_ForwardBE <= 2'b10; 
			end
		end
		
		else if((i_RA1_ID == i_WA_EX) && (i_RegWriteE == 1'b1)) o_ForwardAE <= 2'b10;
		else if((i_RA2_ID == i_WA_EX) && (i_RegWriteE == 1'b1)) o_ForwardBE <= 2'b10;
		

		else begin
			o_ForwardAE <= 2'b00;
			o_ForwardBE <= 2'b00;
		end
	
	end
end


endmodule
