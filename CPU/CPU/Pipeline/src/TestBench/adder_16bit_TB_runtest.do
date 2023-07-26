SetActiveLib -work
comp -include "$dsn\src\16bitAdder.vhd" 
comp -include "$dsn\src\TestBench\adder_16bit_TB.vhd" 
asim +access +r TESTBENCH_FOR_adder_16bit 
wave 
wave -noreg A
wave -noreg B
wave -noreg Cin
wave -noreg Sum
wave -noreg Cout
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\adder_16bit_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_adder_16bit 
