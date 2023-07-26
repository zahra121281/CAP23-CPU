library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL ; 	
use IEEE.math_real.uniform;	 
use std.textio.all;	   
use IEEE.std_logic_textio.all;

entity SignExtend is
    generic (
        DATA_WIDTH : integer := 8
    );
    port (
        clk : in std_logic;
        DataIN : in std_logic_vector(DATA_WIDTH - 1 downto 0);
        ExtendedData : out std_logic_vector( 15 downto 0)
    );
end SignExtend;

architecture Behavioral of SignExtend is
    signal ExtendNegative : std_logic_vector(DATA_WIDTH - 1 downto 0) := (others => '1');
    signal ExtendPositive : std_logic_vector(DATA_WIDTH - 1 downto 0) := (others => '0');
    signal SignBit : std_logic := DataIN(DATA_WIDTH - 1);
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if SignBit = '0' then
                ExtendedData <= ExtendPositive & DataIN;
            else
                ExtendedData <= ExtendNegative & DataIN;
            end if;
        end if;
    end process;
end Behavioral;