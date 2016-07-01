`timescale 1ns / 1ps
/*
 * CSE141L Lab1: Be a Hardware Hacker!
 * University of Califo`rnia, San Diego
 * 
 * Written by Donghwan Jeon, 4/1/2007
 */
 
module adder#(parameter W = 32)
(
 input [W-1:0] inA, inB,
 output reg [W:0] out
 //output isOdd 
);

// reg [W-1:0] regA, regB;
// reg [W:0] regOut;
// reg regOdd;
//wire [W:0] wireOut;

//assign wireOut = regA + regB;
//assign isOdd = regOdd;

always@(*)
begin	
//	 regA <= inA;
//    regB <= inB;
//    regOut <= wireOut;
//    regOdd <= regA[0] ^ regB[0]; // fixed delay
    // regOdd <= (out[0] == 1) ? 1: 0; // old one
	 out <= inA + inB;
end

endmodule
