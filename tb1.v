`timescale 1ns/1ps
module tb_top;

parameter FILE = "C:/Users/82109/5 stage arm processor/final.hex.txt";

reg clk, rst_n;
reg i_PCSrcW,i_Branch_TakenE;

top Top(.clk(clk), .rst_n(rst_n));
  

always #5 clk = ~clk;


initial begin
clk = 0;
rst_n = 0;
#10 rst_n =1'b1;
$readmemh(FILE,Top.If_stage.Instruction_memory.memory);
#10000;

end
endmodule

