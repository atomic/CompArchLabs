# Copyright (C) 1991-2011 Altera Corporation
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, Altera MegaCore Function License 
# Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the 
# applicable agreement for further details.

# Quartus II Generate Tcl File for Project
# File lab1.tcl
# Generated on Tue Feb  7 212033 2012

# Load Quartus II Tcl Project package
package require ::quartus::project
package require cmdline

set need_to_close_project 0
set make_assignments 1
set options {
    {project.arg  Project Name} \
    {dir.arg  Directory} \
    {toplevel.arg Top Level Entity} \
    {tb.arg Test Bench File}
 }    
array set opts [::cmdline::getoptions quartus(args) $options]

set project_name $opts(project)
cd $opts(dir)

project_new $project_name -overwrite
set top_level_design $opts(toplevel)
set testbench $opts(tb)


# Make assignments
if {$make_assignments} {
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION "11.0 SP1"
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "16:30:00  FEBRUARY 08, 2012"
	set_global_assignment -name LAST_QUARTUS_VERSION "11.0 SP1"	    	
     	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
    	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
    	set_global_assignment -name FAMILY "Cyclone II"
    	set_global_assignment -name TOP_LEVEL_ENTITY $top_level_design
    	set_global_assignment -name DEVICE_FILTER_PIN_COUNT 484
    	set_global_assignment -name DEVICE EP2C20F484C7
    	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 1
    	set_global_assignment -name EDA_SIMULATION_TOOL "ModelSim-Altera (VHDL)"
    	set_global_assignment -name EDA_OUTPUT_DATA_FORMAT VHDL -section_id eda_simulation
    	set_global_assignment -name EDA_TEST_BENCH_ENABLE_STATUS TEST_BENCH_MODE -section_id eda_simulation
    	set_global_assignment -name EDA_NATIVELINK_SIMULATION_TEST_BENCH testbench -section_id eda_simulation
    	set_global_assignment -name EDA_TEST_BENCH_NAME testbench -section_id eda_simulation
    	set_global_assignment -name EDA_DESIGN_INSTANCE_NAME NA -section_id testbench
    	set_global_assignment -name EDA_TEST_BENCH_MODULE_NAME testbench -section_id test_adder
	set_global_assignment -name EDA_TEST_BENCH_RUN_SIM_FOR "50 us" -section_id test_adder
	set_global_assignment -name POWER_PRESET_COOLING_SOLUTION "23 MM HEAT SINK WITH 200 LFPM AIRFLOW"
    	set_global_assignment -name POWER_BOARD_THERMAL_MODEL "NONE (CONSERVATIVE)"
 
    set source_files [glob *.v]

    foreach src $source_files {
        set_global_assignment -name VERILOG_FILE $src
    }

    set_global_assignment -name VERILOG_FILE definitions.vh
    

    set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
    set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
     set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
    set_global_assignment -name EDA_TEST_BENCH_FILE ($testbench).v  -section_id testbench    
 

    
    # Commit assignments
    export_assignments

    # Close project
    if {$need_to_close_project} {
        project_close
    }
}



 