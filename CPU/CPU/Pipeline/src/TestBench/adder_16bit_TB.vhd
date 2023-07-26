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

entity adder_16bit_tb is
end adder_16bit_tb;

architecture TB_ARCHITECTURE of adder_16bit_tb is
	-- Component declaration of the tested unit
	component adder_16bit
	port(
		A : in STD_LOGIC_VECTOR(15 downto 0);
		B : in STD_LOGIC_VECTOR(15 downto 0);
		Cin : in STD_LOGIC;
		Sum : out STD_LOGIC_VECTOR(15 downto 0);
		Cout : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal A : STD_LOGIC_VECTOR(15 downto 0);
	signal B : STD_LOGIC_VECTOR(15 downto 0);
	signal Cin : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal Sum : STD_LOGIC_VECTOR(15 downto 0);
	signal Cout : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : adder_16bit
		port map (
			A => A,
			B => B,
			Cin => Cin,
			Sum => Sum,
			Cout => Cout
		);

	-- Add your stimulus here ...
	 process
    begin
        A <= "0000000000000000";
        B <= "0000000000000000";
        Cin <= '0';
        wait for 10 ns;
        
        A <= "0000000000000001";
        B <= "0000000000000001";
        Cin <= '0';
        wait for 10 ns;

        A <= "1111111111111111";
        B <= "0000000000000001";
        Cin <= '0';
        wait for 10 ns;

        A <= "1111111111111111";
        B <= "1111111111111111";
        Cin <= '0';
        wait for 10 ns;

        A <= "0000000000000000";
        B <= "0000000000000000";
        Cin <= '1';
        wait for 10 ns;

        A <= "0000000000000001";
        B <= "0000000000000001";
        Cin <= '1';
        wait for 10 ns;

        A <= "0000000000001111";
        B <= "0000000000000001";
        Cin <= '1';
        wait for 10 ns;

        A <= "1111111111111111";
        B <= "1111111111111111";
        Cin <= '1';
        wait for 10 ns;

        wait;
    end process;


end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_adder_16bit of adder_16bit_tb is
	for TB_ARCHITECTURE
		for UUT : adder_16bit
			use entity work.adder_16bit(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_adder_16bit;

