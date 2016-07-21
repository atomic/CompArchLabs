`timescale 1ns / 1ps


module sign_extender( input [15:0] in, input [5:0] op, output reg [31:0] out);
	
	always @(*) begin
		if( op == 6'hD || op == 6'hE )
			out = {16'b0, in};	// zero extend for ori and xori
		else
			out = {{16{in[15]}}, in};
	end
	
endmodule