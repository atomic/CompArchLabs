
module definition();

parameter FLIP_INS_BIT = 1; //defaults
//parameter FLIP_INS_BIT = 0; //jacks
	
// NOTE: all .memh  files have to have same starting file name
//parameter INIT_PROGRAM = 			"processor_tb/processor_tb"; 				// PASSEd (Jack's), was passing, now not passing, PASSED But testbench behave weird
//parameter INIT_PROGRAM = 			"simple_fib_tb/simple_fib_tb";			// PASSED (Jack's) : Loop forever, now pasSED

//parameter INIT_PROGRAM = 			"lab4-test/lab4-test" ;						// PASSED (3 us)
parameter INIT_PROGRAM = 			"nbhelloworld/nbhelloworld";				// PASSED (1 us)
//parameter INIT_PROGRAM = 			"hello_world/hello_world";					// PASSED (15 us)
//parameter INIT_PROGRAM = 			"fib/fib"; 										// FAILED: sra not implemented
//parameter INIT_PROGRAM = 			"fib_old/fib_old"; 							// PASSED: Loop forever

// The definitions.vh defines 5 parameters. 
// INIT_PROGRAM, DATA_MEM0, DATA_MEM1, DATA_MEM2, DATA_MEM3
// note: only need INIT_PROGRAM

endmodule