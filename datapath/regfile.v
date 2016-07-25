`timescale 1ns / 1ps

module regfile#(parameter W = 32)(
	input           clock,
	input           reset,
	input           regwrite,
	input				 jal_ra,
	input [4:0]     rr1_in, rr2_in, wr_in,	// 5 bit, 32 slot of register
	input [W-1:0]    write_data_in,
	input 			 memread, // this signal is to write back on posedge
	output reg [31:0] rdata1_out, rdata2_out
);
	
	reg [W-1:0] array[31:0];
	//	The first [] is the width of the register, the second [] declares an array of them.
	
	initial begin
		array[0] = 0;
		// for PCspim in jack's tests
//		array[4]  = 32'h1;
//		array[5]  = 32'h7fffef88;
//		array[6]  = 32'h7fffef90;
		array[28] = 32'h10008000;
		array[29] = 32'h7fffeffc;
	end
	
	// Read --> ALU stuff -> Write (In 1 clock cycle)
	integer i;
//	always @(negedge clock) begin
	always @(posedge clock) begin
		if( reset ) begin
			for( i = 0; i < 32; i = i + 1) begin
//				array[i] <= 0; // Used to test jack's simple fib
			end
		end
		else if (regwrite) begin 
			array[ (jal_ra ? 31 : wr_in) ] <= write_data_in;
		end
	end

	
	// asyncrounous
	always @(*) begin
		rdata1_out = array[rr1_in];
		rdata2_out = array[rr2_in];
	end

    
	
endmodule
