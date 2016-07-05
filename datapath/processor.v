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
	reg [31:0] pc = 32'h0040_0000;
	wire [31:0] pcn;
	wire [31:0] ins;
	
	// PC into instruction memory
	inst_rom #(.INIT_PROGRAM("blank.memh")	)
				insROM( clock, reset, pc, ins);
	
	// instruction memory to bus split wires(a,b,c,d see
	wire [4:0] r1,r2,m1;
	wire [15:0] s;
	inst_rom_split insSplitted( ins, r1, r2, m1, s);
	
	// Add 4 adder
	adder_4 add4toPC( pc, pcn );// TODO: how to update pc for next cycle
	always @ (posedge clock) begin
		pc <= pcn;
	end
	
	// temporary selector for 2:1 mux before reg file
	wire RegDstTemp;
	wire [4:0] readWriteOut;
	mux2to1 readWrite( r2, m1, RegDstTemp, readWriteOut);
	
	// reg file stuff
	wire RegWriteTemp;
	wire [31:0] write_data; // from data memory mux to reg file
	wire  [31:0] rdata1, rdata2;	// TODO: Error here, cant use either reg or wire
	regfile RegFile (clock, RegWriteTemp, r1, r2, readWriteOut, write_data, rdata1, rdata2);
	
	// sign extender for last 16 bit of instruction
	wire [31:0] extended_s;
	sign_extender Extender( s, extended_s);
	
	// mux for ALUSrc
	wire ALUsrcTemp;
	wire [31:0] alu_b;
	mux2to1 #(32) MuxRegFileToAlu ( rdata2, extended_s, ALusrcTemp, alu_b);
	
	//ALU component of processor
	wire [5:0] ALUopTemp;  //Not 100% sure if this is a control signal, look at lab2 diagram
	wire branch, jump;
	wire [31:0] ALU_out;
	alu ALU(ALUopTemp, rdata1, rdata2, ALU_out, branch, jump);
	
	//Data Memory Component
	wire RE, WE;
	wire [1:0] size; //Don't know what this is, ask the TA or Tutor
	wire [31:0] dMemoryOut;
	
	data_memory #(.INIT_PROGRAM0("blank.memh"),
					  .INIT_PROGRAM1("blank.memh"),
					  .INIT_PROGRAM2("blank.memh"),
					  .INIT_PROGRAM3("blank.memh") )
				dMemory( clock, reset, ALU_out, rdata2, RE, WE, size, dMemoryOut, 
							serial_in, serial_ready_in, serial_valid_in, 
							serial_out, serial_rden_out, serial_wren_out);
			
	//mux for data memory	
	wire memToRegTemp;
	mux2to1 #(32) MuxDmemoryToRegfile ( dMemoryOut, ALU_out, memToRegTemp, writedata);
				
	
	// add more wires and stuffs, see slides
	
	 
endmodule