# Load simulation
vsim work.testbench

#                       Group Name            Radix                 Signal(s)
#------------------------------------------------------------------------------

# processor_tb
add wave    -noupdate   -group {tb}           -radix hexadecimal    /testbench/*


# update the name of your modules

# processor
add wave    -noupdate   -group {processor}    -radix hexadecimal    /testbench/dut/*

# instruction memory
add wave    -noupdate   -group {inst_rom}         -radix hexadecimal    /testbench/dut/insROM/*

# register file
add wave    -noupdate   -group {regfile}           -radix hexadecimal    /testbench/dut/RegFile/*

# alu
add wave    -noupdate   -group {alu}          -radix hexadecimal    /testbench/dut/ALU/*

# data memory
add wave    -noupdate   -group {data_memory}         -radix hexadecimal    /testbench/dut/dMemory/*

# Use short names
configure wave -signalnamewidth 1