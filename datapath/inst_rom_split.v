`timescale 1ns / 1ps


module inst_rom_split(
    input [31:0] ins_in,

    output [4:0] r1_out, r2_out, m1_out,
    output [15:0] s_out,
	 output [5:0] opcode_out, funct_out,
	 output [27:0] inst_shift // ASK Jack what instruction needs to times 4
);

assign r1_out     = ins_in[25:21];
assign r2_out     = ins_in[20:16];
assign m1_out     = ins_in[15:11];
assign s_out      = ins_in[15:0];
assign opcode_out = ins_in[31:26];
assign funct_out  = ins_in[5:0];
assign inst_shift = ins_in[25:0];

endmodule
