`timescale 1ns / 1ps

module mux2to1#(parameter W = 5)
(	input [W-1:0]       A_in, B_in,
	input               sel_in,
	//output reg [W-1:0]  Y_out
	output [W-1:0]  Y_out
);
endmodule
//always @(*) begin
	if (sel_in == 0) assign Y_out = A_in;
	else assign Y_out = B_in;
//end

//endmodule
