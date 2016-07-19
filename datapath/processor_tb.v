/******************************************************************************
 *
 * Primitive MIPS processor test bench, driven by processor_tb.asm
 *     Modify register file module's object name and register array name under
 *     the second initial block if needed
 *
 *  Change Log:
 *  07/08/2016 - Chao (Jack) Li - Initial Implementation
 *
 */

`timescale 1ns/1ps

module processor_tb();

   reg clock;
   reg reset;

   wire [7:0] 	    serial_out;
   wire 			    serial_wren;

   initial begin
   	clock            <= 1'b0;
   	reset            <= 1'b1;
   	forever #5 clock <= ~clock;
   end

   always begin
   	#200 reset <= 1'b0;
   end
   	
   processor dut(
   	.clock           ( clock),
   	.reset           ( reset),
   	.serial_in       ( 8'b0),
   	.serial_valid_in ( 1'b0),   // active-high - we never have anything to read from the serial port
   	.serial_ready_in ( 1'b1),   // active-high - we are always ready to print serial data
   	.serial_rden_out ( ),       // active-high
   	.serial_out      ( serial_out),
   	.serial_wren_out ( serial_wren) //active-high
   );


   reg [31:0] instr_count;
   always@(posedge clock) begin
      if(dut.reset) begin
         instr_count <= 0;
      end
      else begin
         instr_count <= instr_count + 1;
      end
   end //always_ff

	
   initial begin

      wait(dut.RegFile.array[25] == 1);
		
		if(dut.RegFile.array[16] == 31'h0000600D && dut.RegFile.array[17] == 31'h0000BEEF) begin
         $display("Processor test bench: passed");
      end
      else if(dut.RegFile.array[16] == 31'h0000DEAD && dut.RegFile.array[17] == 31'h0000BEEF) begin 
         $display("Processor test bench: failed");
         $display("PC: [%h]", dut.insROM.addr_in);
         $display("Instruction: [%h]", dut.insROM.data_out);
      end
      else 
         $display("Error: test bench did not behave properly.");

      $stop;

   end // end initial

endmodule
