`timescale 1ns/1ps

module testbench_controlunit();

reg clock;
reg reset;

reg [5:0] opcode, funct;
wire [5:0] ALU_Ctrl;
wire [6:0] signals;

//Generate clock at 100 MHz
initial begin
	clock <= 1'b0;
	reset <= 1'b1;
	forever #10 clock <= ~clock;
end

//Drop reset after 200 ns
always begin
	#200 reset <= 1'b0;
end
	
	
//instantiate the processor  "DUT"(device under test)
control_unit dut(
	.opcode(opcode),
	.funct(funct),
	.ALU_Ctrl(ALU_Ctrl),
	.signals(signals)
	);

wire RegDst, ALUsrc, RegWrite, MemRead, MemWrite, MemToReg, Branch;
// test splitter
signals_split dut_splitter(
	signals,RegDst, ALUsrc, RegWrite, MemRead, MemWrite, MemToReg, Branch
);
// signals_split dut_splitter( signals, RegDst, ALUsrc, RegWrite, MemRead, MemWrite, MemToReg, Branch);

initial begin
		// change some stuffs
		
	#20;
	opcode = 6'h23;
	funct = 6'b000000;
		
	#20;
	opcode = 6'h2b;
	
	#20;
	opcode = 6'h0;
	funct = 6'h20;
	
	#20;
	opcode = 6'h8;
	
	#20;
	opcode = 6'h0;
	funct = 6'h22;
	#20;
	opcode = 6'h0;
	funct = 6'h24;
	#20;
	opcode = 6'h0;
	funct = 6'h25;
	#20;
	opcode = 6'h0;
	funct = 6'h27;
	#20;
	opcode = 6'h0;
	funct = 6'h26;
	
		
end

endmodule