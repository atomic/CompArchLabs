`timescale 1ns / 1ps

/*
 * CSE141L Lab1: Tools of the Trade
 * University of California, San Diego
 * 
 * Written by Matt DeVuyst, 3/30/2010
 * Modified by Vikram Bhatt, 30/3/2010
 * Modified by Adrian Caulfield, 1/8/2012
 */

//
// NOTE: This verilog is non-synthesizable.
// You can only use constructs like "initial", "#10", "forever"
// inside your test bench! Do not use it in your actual design.
//

module test_adder#(parameter W = 32);

   reg          clk;
   reg  [W-1:0] a_r;
   reg  [W-1:0] b_r;
//	wire [W-1:0] a_w;// w for wire
//	wire [W-1:0] b_w;
   wire [W:0] sum;
//   wire         is_odd;

   // The design under test is our adder
//   adder dut (   .clk(clk)
//	        ,.inA(a_r)
//	        ,.inB(b_r)
//                ,.out(sum)
//                ,.isOdd(is_odd)
//             );
//				 
	adder dut ( 
		.inA(a_r), 
		.inB(b_r),
		.out(sum)
	);
   // Toggle the clock every 10 ns

   initial
     begin
        clk = 0;
        forever #10 clk = !clk;// clock run at 500MHz
     end


   initial
     begin
        a_r = 0;
        b_r = 0;
        @(negedge clk);
        a_r = 1;
        b_r = 1;
        @(negedge clk);
        a_r = 5;
        b_r = 6;
        @(negedge clk);
        a_r = 2;
        b_r = 2;
        @(negedge clk);
        a_r = 3;
        b_r = 3;
        @(negedge clk);
        a_r = 1;
        b_r = 8;
        @(negedge clk);
        a_r = 1;
			b_r = 2;
        @(negedge clk);
        a_r = 3;
			b_r = 4;
        @(negedge clk);

     end // initial begin

endmodule // test_adder
