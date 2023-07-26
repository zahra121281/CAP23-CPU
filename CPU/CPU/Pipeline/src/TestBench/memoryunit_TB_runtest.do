SetActiveLib -work
comp -include "$dsn\src\MemoryUnit.vhd" 
comp -include "$dsn\src\TestBench\memoryunit_TB.vhd" 
asim +access +r TESTBENCH_FOR_memoryunit 
wave 
wave -noreg clk
wave -noreg rst
wave -noreg MemRead
wave -noreg Byte_Num
wave -noreg MemWrite
wave -noreg MemDataSRC
wave -noreg MemAddressSRC
wave -noreg RegData
wave -noreg AluOut
wave -noreg AddressIn
wave -noreg MemReadData
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\memoryunit_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_memoryunit 
