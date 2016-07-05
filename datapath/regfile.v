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

    // TODO: write instruction is edge triggered later
    //       read instruction is edge triggered earlier
	always @(posedge clock) begin
		if	(!regwrite)
		begin
			rdata1 <= array[rr1];
			rdata2 <= array[rr2];
		end
	end

    // Read --> ALU stuff -> Write (In 1 clock cycle)
    // See page 253 for more explanation
	always @(negedge clock) begin
        if	(regwrite)
        begin
            array[wr] <= write_data;
        end
	end
	
endmodule
