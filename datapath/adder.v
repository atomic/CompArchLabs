`timescale 1ns / 1ps


module adder#(parameter W = 32)
(
 input [W-1:0] inA, inB,
 output reg [W-1:0] out
);

always@(*)
begin	
	 out <= inA + inB;
end

endmodule
