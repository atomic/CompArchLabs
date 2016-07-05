`timescale 1ns / 1ps

//	Used to add 4 to PC
module adder_4#(parameter W = 32)
(
 input [W-1:0] in,
 output [W-1:0] out
);

 assign out = 4 + in;

endmodule
