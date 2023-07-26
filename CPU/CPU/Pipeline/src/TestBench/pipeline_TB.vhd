library Pipeline;
library ieee;	 
library std;
use ieee.MATH_REAL.all;
use ieee.NUMERIC_STD.all;
use ieee.STD_LOGIC_TEXTIO.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use Pipeline.p_avg.all;	
use std.TEXTIO.all;	
use ieee.STD_LOGIC_TEXTIO.all;
use ieee.std_logic_1164.all;
use work.p_avg.All ;

entity pipeline_v1_tb is
end pipeline_v1_tb;

architecture TB_ARCHITECTURE of pipeline_v1_tb is
    -- Component declaration of the tested unit
    component pipeline
    port(
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        initInsts : in Mem_Array;
        Oout : out STD_LOGIC;
        Cout : out STD_LOGIC;
        Zout : out STD_LOGIC;
        Nout : out STD_LOGIC );
    end component;
    
    constant clk_period : time := 100 ns;
    -- Stimulus signals - signals mapped to the input and inout ports of tested entity
    signal clk : STD_LOGIC := '0';
    signal rst : STD_LOGIC;
    signal initInsts : Mem_Array(3 downto 0);
    -- Observed signals - signals mapped to the output ports of tested entity
    signal Oout : STD_LOGIC;
    signal Cout : STD_LOGIC;
    signal Zout : STD_LOGIC;
    signal Nout : STD_LOGIC;

    -- Add your code here ...
    
    -- Instantiate the file reader entity
    component File_Reader
        generic (
            FILENAME : string := "Instructions.txt"
        );
        port (
            clk : in std_logic;
            rst : in std_logic;
            data_out : out Mem_Array;
            eof : out std_logic
        );
    end component;
    
    -- Signal to hold the end-of-file flag from the file reader
    signal eof : std_logic;	 
	-- Flag to stop the simulation
    signal Stop_Simulation : boolean := false;
    
begin     
    
    -- Instantiate the file reader entity and connect its ports
    File_Reader_inst : File_Reader
        generic map (
            FILENAME => "Instructions.txt"
        )
        port map (
            clk => clk,
            rst => rst,
            data_out => initInsts,
            eof => eof
        );
        
    -- Unit Under Test port map
    UUT : pipeline
        port map (
            clk => clk,
            rst => rst,
            initInsts => initInsts,
            Oout => Oout,
            Cout => Cout,
            Zout => Zout,
            Nout => Nout
        );
    
    -- Process for generating clock signal and advancing simulation time
    CLK_PROCESS : process
    begin
        while not Stop_Simulation loop
            clk <= not clk;
            wait for clk_period/2;	  
        end loop;
        wait;
    end process CLK_PROCESS;
    
   -- -- Process for initializing instructions and de-asserting reset signal
   INIT_PROCESS : process
    begin
        -- Wait for a few clock cycles before de-asserting reset signal
       
        rst <= '0';
        wait for clk_period; 
		
        -- Wait for end-of-file signal from file reader entity
        while eof /= '1' loop
            wait for clk_period;
        end loop;
        
        -- Wait for a few more clock cycles after end-of-file signal
        wait for clk_period ;	
		wait ; 
    end process INIT_PROCESS;
--	
--	
--	
    -- Process for running the pipeline	
    PIPELINE_PROCESS : process
    begin
        -- Wait for a few clock cycles to ensure the pipeline is initialized
        wait for 5*clk_period;	
        
        -- Loop through the instructions and wait for the pipeline to process each one
        for i in initInsts'range loop
            wait for clk_period;
        end loop;
        
        -- Wait for a few more clock cycles to ensure the pipeline has finished processing all instructions
        wait for 10 ns;
        
        -- Stop the simulation
        Stop_Simulation <= true;
    end process PIPELINE_PROCESS;
    
  

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_pipeline of pipeline_tb is
    for TB_ARCHITECTURE
        for UUT : pipeline
            use entity work.pipeline(pipeline_arc);
        end for;
    end for;
end TESTBENCH_FOR_pipeline;

