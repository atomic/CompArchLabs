# Load simulation
vsim work.testbench

#                       Group Name            Radix                 Signal(s)
#------------------------------------------------------------------------------

# processor_tb
add wave    -noupdate   -group {tb}           -radix hexadecimal    /testbench/*

add wave    -noupdate   -group {essential}    -radix hexadecimal    /testbench/dut/pc
add wave    -noupdate   -group {essential}    -radix hexadecimal    /testbench/dut/pcn
add wave    -noupdate   -group {essential}    -radix hexadecimal    /testbench/dut/ins
add wave    -noupdate   -group {essential}    -radix decimal        /testbench/dut/RegFile/array
# add wave    -noupdate   -group {essential}    -radix decimal        /testbench/dut/dMemory/*
add wave    -noupdate   -group {essential/data}    -radix hexadecimal        /testbench/dut/dMemory/data_seg/mem0
add wave    -noupdate   -group {essential/data}    -radix hexadecimal        /testbench/dut/dMemory/data_seg/mem1
add wave    -noupdate   -group {essential/data}    -radix hexadecimal        /testbench/dut/dMemory/data_seg/mem2
add wave    -noupdate   -group {essential/data}    -radix hexadecimal        /testbench/dut/dMemory/data_seg/mem3
add wave    -noupdate   -group {essential/stack}    -radix hexadecimal        /testbench/dut/dMemory/stack_seg/mem0
add wave    -noupdate   -group {essential/stack}    -radix hexadecimal        /testbench/dut/dMemory/stack_seg/mem1
add wave    -noupdate   -group {essential/stack}    -radix hexadecimal        /testbench/dut/dMemory/stack_seg/mem2
add wave    -noupdate   -group {essential/stack}    -radix hexadecimal        /testbench/dut/dMemory/stack_seg/mem3



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
# add wave    -noupdate   -group {data_memory}         -radix hexadecimal    /testbench/dut/dMemory/*

# Use short names
configure wave -signalnamewidth 1