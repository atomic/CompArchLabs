# ModelSim 10.4b bug: need to delete library if it already exists because
# vlib work will seg fault otherwise.  
if {[file isdirectory work]} {
    vdel -all -lib work
}

# Create library
vlib work

# Compile .v files.
vlog -work work "processor.v"
vlog -work work "alu.v"
vlog -work work "async_memory.v"
vlog -work work "data_memory.v"
vlog -work work "inst_rom.v"
vlog -work work "inst_rom_split.v"
vlog -work work "regfile.v"
vlog -work work "serial_buf.v"
vlog -work work "control_unit.v"
vlog -work work "simple_fib_tb/simple_fib_tb.v"
vlog -work work "adder_4.v"
vlog -work work "sign_extender.v" 
vlog -work work "signals_split.v" 
vlog -work work "mux2to1.v" 
vlog -work work "inst_rom_split.v" 
vlog -work work "shift_left.v"
vlog -work work "shift_left_amt.v"
vlog -work work "adder.v"
