`timescale 1ns / 1ps

// module to tell wheter alu out will be shift to left logical
module shift_left_amt #(parameter W = 32) (
	input  	  [W-1:0] data_in,
	input      [5:0]   opcode,
	input      [5:0]   funct,
	input 	  [4:0]   shamt,
	output reg [W-1:0] data_out
);

	always @(*) begin
	
	if( opcode == 6'h0 && funct == 6'h0)
		data_out = data_in << shamt;
	else
		data_out = data_in;
	end
	
endmodule