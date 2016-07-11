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

	
	// wires for instruction fetch	
	// only put 32 bit pc
	// no need bus splitter module
	reg [31:0] pc = 32'h0040_0000;
	
	wire [31:0] pcn;
	wire [31:0] ins;
	
	//////////// wires for instruction decode //////////////////
	
	// control unit
	wire [6:0] signals;
	wire [5:0] opcode, funct;
	wire RegDst, ALUsrc, RegWrite, MemRead, MemWrite, MemToReg, Branch;
	
	// Wires for Register FIle
	wire [4:0] r1,r2,m1;
	wire [15:0] s;
	wire [4:0] readWriteOut;
	
	wire [31:0] write_data; // from data memory mux to reg file
	wire  [31:0] rdata1, rdata2;
	wire [31:0] extended_s;
	
	////////////////// wires for execute //////////////////////
	
	// ALU 
	wire [31:0] alu_b;
	wire [5:0] ALU_Ctrl;
	wire [5:0] ALUopTemp;  //Not 100% sure if this is a control signal, look at lab2 diagram
	wire branch, jump;
	wire [31:0] ALU_out;
	
	/////////////////// wires for MEM //////////////////////////
	//Data Memory Component
	wire RE, WE;
	wire [1:0] size;// load byte, load half word, etc
	wire [31:0] output_data;
	
	// wires for writeback
	

	
	// PC into instruction memory
	inst_rom #(.INIT_PROGRAM("processor.inst_rom.memh")	)
				insROM( clock, reset, pc, ins);
				
	// Add 4 adder
	adder_4 add4toPC( pc, pcn );
	always @ (negedge clock) begin // update after being sent to
		if(!reset)
			pc <= pcn;
	end
	
	// instruction memory to bus split wires(a,b,c,d see
	inst_rom_split insSplitted( ins, r1, r2, m1, s, opcode, funct);
	
	// control unit - instruction to rest of processor
	control_unit ControlUnit(opcode, funct, ALU_Ctrl, signals);
	signals_split SignalSplitter( signals, RegDst, ALUsrc, RegWrite, MemRead, MemWrite, MemToReg, Branch);
	
	// temporary selector for 2:1 mux before reg file
	mux2to1 readWrite( r2, m1, RegDst, readWriteOut);
	
	// reg file stuff
	regfile RegFile (clock, reset, RegWrite, r1, r2, readWriteOut, write_data, rdata1, rdata2);
	
	// sign extender for last 16 bit of instruction
	sign_extender Extender( s, extended_s);
	
	// mux for ALUSrc
	mux2to1 #(32) MuxRegFileToAlu ( rdata2, extended_s, ALUsrc, alu_b);
	
	//ALU component of processor

	alu ALU(ALU_Ctrl, rdata1, rdata2, ALU_out, branch, jump);
	

	
	data_memory #(.INIT_PROGRAM0("blank.memh"),
					  .INIT_PROGRAM1("blank.memh"),
					  .INIT_PROGRAM2("blank.memh"),
					  .INIT_PROGRAM3("blank.memh") )
				dMemory( clock, reset, ALU_out, rdata2, MemRead, MemWrite, size, output_data, 
							serial_in, serial_ready_in, serial_valid_in, 
							serial_out, serial_rden_out, serial_wren_out);
			
	//mux for data memory	
	mux2to1 #(32) MuxDmemoryToRegfile ( output_data, ALU_out, MemToReg, write_data);
				
	
	// add more wires and stuffs, see slides
	
	 
endmodule