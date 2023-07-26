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

	-- Add your library and packages declaration here ...

entity file_reader_tb is
	-- Generic declarations of the tested unit
		generic(
		FILENAME : STRING := "instructions.txt" );
end file_reader_tb;

architecture TB_ARCHITECTURE of file_reader_tb is  
	 constant CLK_PERIOD : time := 100 ns;
	-- Component declaration of the tested unit
	component file_reader
		generic(
		FILENAME : STRING := "instructions.txt" );
	port(
		clk : in STD_LOGIC;
		rst : in STD_LOGIC;
		data_out : inout Mem_Array;	 
		eof : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC := '0';
	signal rst : STD_LOGIC  ;
	
	-- Observed signals - signals mapped to the output ports of tested entity
	signal data_out : Mem_Array;
	signal eof : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : file_reader
		generic map (
			FILENAME => FILENAME
		)

		port map (
			clk => clk,
			rst => rst,
			data_out => data_out, 
			eof => eof
		);

	-- Add your stimulus here ...  
	
	clk_gen : process
    begin
        while now < 100000 ns loop
            clk <= not clk;
            wait for 50ns;
        end loop;
        wait;
    end process clk_gen;
	  
	tb_process : process
  begin
    rst <= '1';
    wait for CLK_PERIOD;
    rst <= '0';
    wait for CLK_PERIOD;

    -- Wait for EOF signal to be asserted
    while eof /= '1' loop
      wait for CLK_PERIOD;
    end loop;
	
--	for
     --Print the contents of the data_out array
    --for i in data_out'range loop
--      report "data_out(" & integer'image(i) & ") = " & std_logic_vector'image(data_out(i));
--    end loop;
--
    wait;
  end process;
	

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_file_reader of file_reader_tb is
	for TB_ARCHITECTURE
		for UUT : file_reader
			use entity work.file_reader(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_file_reader;

