`timescale 1ns / 1ps

module processor(

	input           clock,
	input           reset,

	//these ports are used for serial IO and 
	//must be wired up to the data_memory module
	input [7:0]     serial_in,
	input           serial_valid_in,
	input           serial_ready_in,

	output [7:0]    serial_out,
	output          serial_rden_out,
	output          serial_wren_out
);

	
	// wires for instruction fetch	
	// only put 32 bit pc
	// no need bus splitter module
	reg [31:0]      pc = 32'h0040_0000;
	wire [31:0]     pcn;    // value of PC that is to be incremented or updated

	wire [31:0]     ins;
	
	//////////// wires for instruction decode //////////////////
	
	// control unit
	wire [6:0]      signals;
	wire [5:0]      opcode, funct;
	wire            RegDst, ALUsrc, RegWrite, 
                    MemRead, MemWrite, MemToReg, Branch;
	
	// Wires for Register FIle
	wire [4:0]      r1,r2,m1;
	wire [15:0]     s;
	wire [4:0]      readWriteOut;
	
	wire [31:0]     write_data; // from data memory mux to reg file
	wire  [31:0]    rdata1, rdata2;
	wire [31:0]     extended_s;
	
	////////////////// wires for execute //////////////////////
	
	// ALU 
	wire [31:0]     alu_b;
	wire [5:0]      ALU_Ctrl;
	wire            branch, jump;
	wire [31:0]     ALU_out;
	
	/////////////////// wires for MEM //////////////////////////
	//Data Memory Component
	wire [1:0]      size;// load byte, load half word, etc
	wire [31:0]     output_data;
	
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
	inst_rom_split instruction_splitter_mod (
        .ins_in     ( ins    ) ,
        .r1_out     ( r1     ) ,
        .r2_out     ( r2     ) ,
        .m1_out     ( m1     ) ,
        .s_out      ( s      ) ,
        .opcode_out ( opcode ) ,
        .funct_out  ( funct  )
    );
	
	// control unit - instruction to rest of processor
	control_unit ControlUnit(
        .opcode   ( opcode   ) ,    // input
        .funct    ( funct    ) ,    // input
        .ALU_Ctrl ( ALU_Ctrl ) ,    // output
        .signals  ( signals  )      // output (further splitted by SignalSplitter)
    );

    signals_split SignalSplitter( 
        signals  , RegDst   , ALUsrc , RegWrite , MemRead ,
        MemWrite , MemToReg , Branch
    );
	
	// temporary selector for 2:1 mux before reg file
	mux2to1 readWrite_mux (
                            .A_in   ( r2           ) ,
                            .B_in   ( m1           ) ,
                            .sel_in ( RegDst       ) ,
                            .Y_out  ( readWriteOut )
    );
	
	// reg file stuff
    regfile RegFile ( 
                      .clock         ( clock        ) ,
                      .reset         ( reset        ) ,
                      .regwrite      ( RegWrite     ) ,
                      .rr1_in        ( r1           ) ,
                      .rr2_in        ( r2           ) ,
                      .wr_in         ( readWriteOut ) ,
                      .write_data_in ( write_data   ) ,

                      .rdata1_out    ( rdata1       ) ,
                      .rdata2_out    ( rdata2       )
    );
	
	// sign extender for last 16 bit of instruction
	sign_extender Extender( .in(s),
                            .out(extended_s)
    );
	
	// mux for ALUSrc to determine if instruction is R type or I type
    // whether 2nd operand is from register or immediate value
	mux2to1 #(32) RegFileToAlu_mux  ( 
                    .A_in   ( rdata2     ) ,
                    .B_in   ( extended_s ) ,
                    .sel_in ( ALUsrc     ) ,
                    .Y_out  ( alu_b      )
    );

	//ALU component of processor
	alu ALU(
        .Func_in    ( ALU_Ctrl ) ,
        .A_in       ( rdata1   ) ,
        .B_in       ( alu_b    ) ,
        .O_out      ( ALU_out  ) ,
        .Branch_out ( branch   ) ,
        .Jump_out   ( jump     )
    );
	
	
	data_memory #(  .INIT_PROGRAM0("blank.memh"),
					.INIT_PROGRAM1("blank.memh"),
					.INIT_PROGRAM2("blank.memh"),
					.INIT_PROGRAM3("blank.memh") )
    dMemory(
        clock       , reset    ,
        ALU_out     , rdata2   ,
        MemRead     , MemWrite , size ,

        output_data , // Read Data out

        // PORTS 
        serial_in       , serial_ready_in   , serial_valid_in , serial_out ,
        serial_rden_out , serial_wren_out);

	//  mux for data memory to determine whether to write to register
    //  the result of ALU or the value loaded from memory
	mux2to1 #(32) DmemoryToRegfile_mux (
                    .A_in   ( output_data ) ,
                    .B_in   ( ALU_out     ) ,
                    .sel_in ( MemToReg    ) ,
                    .Y_out  ( write_data  )
    );
				
	
	// add more wires and stuffs, see slides
	
	 
endmodule
