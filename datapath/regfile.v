`timescale 1ns / 1ps

module regfile(
	input           clock,
	input           reset,
	input           regwrite,
	input [4:0]     rr1_in, rr2_in, wr_in,
	input [31:0]    write_data_in,

	output reg [31:0] rdata1_out, rdata2_out
);
	
	reg [31:0] array[31:0];
	
//	Pseudo code
//
//	if regwrite:
//		array[wr_in] = wdata
//	else:
//		rdata1_out = array[rr1_in]
//		rdata2_out = array[rr2_in]

   initial begin
	 // initiall everything to zero, execptt 
//		for(i=0; i<28; i = i + 1)	begin 
//			array[i] = 0;
//		end
//		array[30] = 0;
//		array[31] = 0;
	end
	 
	 // Read --> ALU stuff -> Write (In 1 clock cycle)
	always @(posedge clock) begin
        if	(regwrite && wr_in != 0)
        begin
            array[wr_in] <= write_data_in;
        end
	end
	
	// asyncrounous
	always @(*) begin
		rdata1_out = array[rr1_in];
		rdata2_out = array[rr2_in];
	end

    
	
endmodule
