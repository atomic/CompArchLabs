`timescale 1ns / 1ps

module signals_split (
	input [6:0] signals,
	 output RegDst, ALUsrc, RegWrite, MemRead, MemWrite, MemToReg, Branch
);


assign RegDst   = signals[6];
assign ALUsrc   = signals[5];
assign RegWrite = signals[4];
assign MemRead  = signals[3];
assign MemWrite = signals[2];
assign MemToReg = signals[1];
assign Branch   = signals[0];

endmodule
