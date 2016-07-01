`timescale 1ns / 1ps

module mux2to1#(parameter W = 5)
(	input [W-1:0] A, B,
	input Sel,
	output reg [W-1:0] Y
);

always @(*) begin
	if (Sel == 0) Y = A;
	else Y = B;
end

endmodule