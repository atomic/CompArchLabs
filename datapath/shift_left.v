`timescale 1ns / 1ps

module shift_left #(parameter W = 32) (
	input  	  [W-1:0] data_in,
	output     [W-1:0] data_out
);
	assign data_out = data_in << 2;
	
	
endmodule