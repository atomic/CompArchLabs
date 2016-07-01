`timescale 1ns / 1ps

module processor(
	input clock,
	input reset,

	//these ports are used for serial IO and 
	//must be wired up to the data_memory module
	input [7:0] serial_in,
	input serial_valid_in,
	input serial_ready_in,
	output [7:0] serial_out,
	output serial_rden_out,
	output serial_wren_out
);

	// only put 32 bit pc
	// no need bus splitter module
	reg [31:0] pc;
	wire [31:0] ins;
	inst_rom insROM( clock, reset, pc, ins);
	
//	inst_rom_split insSplitted( ins, )
	// add more wires and stuffs, see slides
	 
endmodule