`timescale 1ns / 1ps


module sign_extender( input [15:0] in, output [31:0] out);
	
	// Not sure if this works, test later
	assign out = {{16{in[15]}}, in};
	
endmodule