# Load simulation
vsim work.simple_fib_tb

#                       Group Name            Radix                 Signal(s)
#------------------------------------------------------------------------------

# processor_tb
add wave    -noupdate   -group {tb}           -radix hexadecimal    /simple_fib_tb/*


# update the name of your modules

# processor
add wave    -noupdate   -group {processor}    -radix hexadecimal    /simple_fib_tb/dut/*

# instruction memory
add wave    -noupdate   -group {inst_rom}         -radix hexadecimal    /simple_fib_tb/dut/insROM/*

# register file
add wave    -noupdate   -group {regfile}           -radix hexadecimal    /simple_fib_tb/dut/RegFile/*

# alu
add wave    -noupdate   -group {alu}          -radix hexadecimal    /simple_fib_tb/dut/ALU/*

# data memory
add wave    -noupdate   -group {data_memory}         -radix hexadecimal    /simple_fib_tb/dut/dMemory/*

# Use short names
configure wave -signalnamewidth 1