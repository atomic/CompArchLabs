`timescale 1ns / 1ps

module regfile(
	input clock,
	input regwrite,
	input [4:0] rr1, rr2, wr,
	input [31:0] write_data,
	output reg [31:0] rdata1, rdata2
);
	
	reg [31:0] array[31:0];
	
//	Pseudo code
//
//	if regwrite:
//		array[wr] = wdata
//	else:
//		rdata1 = array[rr1]
//		rdata2 = array[rr2]

	always @(posedge clock) begin
		if	(regwrite)
			array[wr] <= write_data;
		else begin
			rdata1 <= array[rr1];
			rdata2 <= array[rr2];
		end
	end
	
endmodule