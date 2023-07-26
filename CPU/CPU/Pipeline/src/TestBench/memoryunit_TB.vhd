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

entity memoryunit_tb is
end memoryunit_tb;

architecture TB_ARCHITECTURE of memoryunit_tb is
	-- Component declaration of the tested unit
	component memoryunit
	port(
		clk : in STD_LOGIC;
		rst : in STD_LOGIC;
		MemRead : in STD_LOGIC;
		MemWrite : in STD_LOGIC;
		MemDataSRC : in STD_LOGIC;
		MemAddressSRC : in STD_LOGIC;
		RegData : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
		AluOut : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
		AddressIn : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
		MemReadData : out STD_LOGIC_VECTOR(CPUSize-1 downto 0) );
	end component;
	constant clk_period : time := 100 ns;
    constant MEM_SIZE : integer := 3000;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC := '0' ;
	signal rst : STD_LOGIC;
	signal MemRead : STD_LOGIC;
	signal Byte_Num : INTEGER;
	signal MemWrite : STD_LOGIC;
	signal MemDataSRC : STD_LOGIC;
	signal MemAddressSRC : STD_LOGIC;
	signal RegData : STD_LOGIC_VECTOR(CPUSize-1 downto 0);
	signal AluOut : STD_LOGIC_VECTOR(CPUSize-1 downto 0);
	signal AddressIn : STD_LOGIC_VECTOR(CPUSize-1 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal MemReadData : STD_LOGIC_VECTOR(CPUSize-1 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : memoryunit
		port map (
			clk => clk,
			rst => rst,
			MemRead => MemRead,
			MemWrite => MemWrite,
			MemDataSRC => MemDataSRC,
			MemAddressSRC => MemAddressSRC,
			RegData => RegData,
			AluOut => AluOut,
			AddressIn => AddressIn,
			MemReadData => MemReadData
		);

	-- Add your stimulus here ... 
	
	clk_gen : process
    begin
        while now < 100000 ns loop
            clk <= not clk;
            wait for clk_period/2;
        end loop;
        wait;
    end process clk_gen;
	
	--  MemRead : in std_logic ; 
--		MemWrite : in std_logic ;
--		MemDataSRC : in std_logic ; 
--		MemAddressSRC : in std_logic ;
--		RegData : in std_logic_vector(CPUSize-1 downto 0) ; 
--		AluOut :  in std_logic_vector(CPUSize-1 downto 0) ; 
--		AddressIn : in std_logic_vector(CPUSize-1 downto 0) ; 

	test : process is
    begin
        -- reset 	   
		rst <= '1';		
		wait for clk_period ; 
        rst <= '0';		
        wait for clk_period ; 
        -- write to memory
        MemWrite <= '1';  
		MemRead <= '0' ; 
        MemAddressSRC <= '1';
		MemDataSRC <= '0' ; 
        RegData <= "0000000000110011";
        AluOut <= "0000000000000000"; 
		AddressIn<= "0000000000000000" ; 
        wait for clk_period;
		
        MemWrite <= '1';  
		MemRead <= '0' ; 
        MemAddressSRC <= '1';
		MemDataSRC <= '0' ; 
        RegData <= "0000000000000111";
        AluOut <= "0000000000000000"; 
		AddressIn<= "0000000000000001" ; 
        wait for clk_period;   
		
		-- read from memory 
        MemWrite <= '0';  
		MemRead <= '1' ; 
        MemAddressSRC <= '1';
		MemDataSRC <= '0' ; 
        RegData <= "0000000000110011";
        AluOut <= "0000000000000000"; 
		AddressIn<= "0000000000000000" ; 
		wait for clk_period;  
	
		MemWrite <= '0';  
		MemRead <= '1' ; 
        MemAddressSRC <= '0';
		MemDataSRC <= '0' ; 
        RegData <= "0000000000110011";
        AluOut <= "0000000000000000"; 
		AddressIn<= "0000000000000001" ; 
		
        wait;
    end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_memoryunit of memoryunit_tb is
	for TB_ARCHITECTURE
		for UUT : memoryunit
			use entity work.memoryunit(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_memoryunit;

