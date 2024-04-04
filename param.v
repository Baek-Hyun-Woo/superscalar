`define D_WIDTH 32

//opcode
`define ARITHMATIC 2'b00
`define MEM 2'b01
`define BRANCH 2'b10

//forward from
`define FORWARD_FROM_ID 2'b00
`define FORWARD_FROM_WB 2'b01
`define FORWARD_FROM_MEM 2'b10

//condition
`define EQ 4'b0000
`define NE 4'b0001