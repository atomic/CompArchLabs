`timescale 1ns / 1ps

module regfile#(parameter W = 32)(
	input           clock,
	input           reset,
	input           regwrite,
	input				 jal_ra,
	input [4:0]     rr1_in, rr2_in, wr_in,	// 5 bit, 32 slot of register
	input [W-1:0]    write_data_in,
	output reg [31:0] rdata1_out, rdata2_out
);
	
	reg [W-1:0] array[31:0];
	//	The first [] is the width of the register, the second [] declares an array of them.
	
	initial begin
		array[0] = 0;
	end
	
	// Read --> ALU stuff -> Write (In 1 clock cycle)
	integer i;
//	always @(posedge clock) begin
	always @(negedge clock) begin
		if( reset ) begin
			for( i = 0; i < 32; i = i + 1) begin
				array[i] <= 0;
			end
		end
		else begin 
			if (regwrite && jal_ra) begin
				array[31]    <= write_data_in;
			end
			else if	(regwrite && wr_in != 0) begin
				array[wr_in] <= write_data_in;
			end
		end
	end
	
	// asyncrounous
	always @(*) begin
		rdata1_out = array[rr1_in];
		rdata2_out = array[rr2_in];
	end

    
	
endmodule
