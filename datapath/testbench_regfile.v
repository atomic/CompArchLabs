`timescale 1ns/1ps

module testbench_regfile();

reg clock;
reg reset;

reg Regwrite;
reg [4:0] Rr1, Rr2, Wr;// index
reg [31:0] Write_Data;	// value in
wire [31:0] Rdata1, Rdata2; //value out


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
regfile dut(
	.clock(clock),
	.reset(reset),
	.regwrite(Regwrite),
	.rr1(Rr1),
	.rr2(Rr2),
	.wr(Wr),
	.write_data(Write_Data),
	.rdata1(Rdata1),
	.rdata2(Rdata2)
	);

initial begin
		// change some stuffs
		
		#20;
		//another stuffs
		
		#20;
		Regwrite = 1;
		Wr = 32'd16;
		Write_Data = 32'd100;
				
		#20;
		Regwrite = 1;
		Wr = 32'd17;
		Write_Data = 32'd150;
		
		#20;
		Regwrite = 0;
		Rr1 = 16;
		Rr2 = 17;
		
		
		
		
end
		


endmodule