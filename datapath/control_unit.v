`timescale 1ns / 1ps

module control_unit (
	input [5:0] opcode,
	input [5:0] funct,

	output [5:0] func_in,
	output RegDst ,
	output ALUSrc ,
	output RegWrite ,
	output MemRead ,
	output MemWrite ,
	output MemToReg ,
	output Branch
);

always @(*) begin
	case (opcode)
		6'h23:
			begin
				func_in = 6'b100000;
				RegDst  = 0;
				ALUSrc  = 1;
				RegWrite= 1;
				MemRead = 1;
				MemWrite= 0;
				MemToReg= 1;
				Branch  = 0;
			end
		
	endcase
