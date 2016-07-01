`timescale 1ns / 1ps


module inst_rom_split(
    input [31:0] in,
    output [4:0] a, b, c,
    output [15:0] d
    );

assign a = in[25:21];
assign b = in[20:16];
assign c = in[15:11];
assign d = in[15:0];


endmodule
