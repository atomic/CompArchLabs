`timescale 1ns / 1ps

module regfile(
	input clock,
	input reset,
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

	// array[0] is always 0
	 // TODO: ask TA what to do with $v0-$v1, and other non-saved register

   initial begin
	 // initiall everything to zero, execptt 
//		for(i=0; i<28; i = i + 1)	begin 
//			array[i] = 0;
//		end
//		array[30] = 0;
//		array[31] = 0;
	end
	 
	 // Read --> ALU stuff -> Write (In 1 clock cycle)
    // See page 253 for more explanation
	always @(posedge clock) begin
        if	(regwrite && wr != 0)
        begin
            array[wr] <= write_data;
        end
	end
	
	// asyncrounous
	always @(*) begin
		rdata1 = array[rr1];
		rdata2 = array[rr2];
	end

    
	
endmodule
