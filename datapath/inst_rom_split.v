`timescale 1ns / 1ps


module inst_rom_split(
    input [31:0] in,
    output [4:0] r1, r2, m1,
    output [15:0] s,
	 output [5:0] opcode, funct
    );

assign r1 = in[25:21];
assign r2 = in[20:16];
assign m1 = in[15:11];
assign s  = in[15:0];
assign opcode = in[31:26];
assign funct  = in[5:0];

endmodule
