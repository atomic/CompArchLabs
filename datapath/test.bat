:: ----------------------------
:: setting the project variable 
:: ----------------------------
echo off

set PATH_TO_QUARTUS=C:/Altera/15.0/quartus
set MODELSIM_FOLDER=C:/Altera/15.0/quartus
set TEST_DIR=/home/koushik/Desktop/lab2/nbhelloworld
set TEST_LIST=nbhelloworld
set TOP_LEVEL=adder
set TESTBENCH=test_adder 
set PROJECT=CSE141L
set SIM_RUN_TIME=5us
:: ----------------------------
:: Change this to the folder where the project is saved
:: ----------------------------
pushd \\Mort.archnet.ucsd.edu\Users\Sundaram Meenakshi\Desktop\lab1

:: ---------------------------------
:: DO NOT CHANGE ANYTHING BELOW THIS
:: --------------------------------
set PATH=%PATH%;%PATH_TO_QUARTUS%\bin
set MODELSIM=%MODELSIM_FOLDER%/modelsim.ini
set PATH_TO_MODELSIM=%MODELSIM%/altera/verilog
set PATH_TO_BIN=%MODELSIM%/win32aloem
set PATH=%PATH%;%PATH_TO_BIN%
set DEF_FILE=definitions.vh

set BUILD_DIR=%CD%
set PATH_TO_SCRIPTS=%CD%

FOR /F %%A in ('dir /b *.v') do SET SOURCE=%%A


:: ---------------------------------
:: call the command
:: ---------------------------------
call :_BUILD
echo on
call :_SIM

GOTO :EOF
:_BUILD
quartus_sh -t "%PATH_TO_SCRIPTS%/build.tcl" -project %PROJECT% -dir "%BUILD_DIR%" -toplevel %TOP_LEVEL% -tb %TESTBENCH%
quartus_map %PROJECT%
GOTO :EOF
    
:_SIM
    @echo set path_to_quartus %PATH_TO_QUARTUS% >support.tcl
    @echo set path_to_modelsim %PATH_TO_MODELSIM% >>support.tcl
    @echo vlib cycloneii_ver >>support.tcl
    @echo vmap cycloneii_ver cycloneii_ver >>support.tcl
    @echo vlib work >>support.tcl
    @echo vlog -work cycloneii_ver $path_to_quartus/eda/sim_lib/cycloneii_atoms.v >>support.tcl
    @echo vmap lpm $path_to_modelsim/220model/ >>support.tcl
    @echo vmap altera_mf $path_to_modelsim/altera_mf >>support.tcl
    @echo set top_level %TESTBENCH% >>support.tcl
    @echo set sim_run_time %SIM_RUN_TIME% >>support.tcl
    @echo do sim.tcl >>support.tcl
    @echo %TEST_LIST%

    for	/f "tokens=* delims= " %%a in ("%TEST_LIST%") do call :_MAKE_DEF %%a    

GOTO :EOF

:_MAKE_DEF
echo `define INIT_PROGRAM "%TEST_DIR%/%1.inst_rom.memh"" >%DEF_FILE% 
echo \`define DATA_MEM3 "%TEST_DIR%/%1.data_ram3.memh"">>%DEF_FILE%
echo \`define DATA_MEM2 "%TEST_DIR%/%1.data_ram2.memh"">>%DEF_FILE%
echo \`define DATA_MEM1 "%TEST_DIR%/%1.data_ram1.memh"">>%DEF_FILE%
echo \`define DATA_MEM0 "%TEST_DIR%/%1.data_ram0.memh"">>%DEF_FILE%
::vsim -c -do support.tcl
GOTO :EOF


