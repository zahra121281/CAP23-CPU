library IEEE;	
library Pipeline;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL ; 	
use IEEE.math_real.uniform;	 
use std.textio.all;	   
use IEEE.std_logic_textio.all;
use work.p_avg.All ;


			   
entity adder_16bit is
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           Cin : in STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (15 downto 0);
           Cout : out STD_LOGIC);
end adder_16bit;

architecture Behavioral of adder_16bit is
    signal Temp : STD_LOGIC_VECTOR (16 downto 0);
begin
    process(A, B, Cin)
        variable Carry : STD_LOGIC := Cin;
    begin
        for i in 0 to 15 loop
            Temp(i) <= A(i) xor B(i) xor Carry;
            Carry := (A(i) and B(i)) or (A(i) and Carry) or (B(i) and Carry);
        end loop;
        Temp(16) <= Carry;
        Sum <= Temp(15 downto 0);
        Cout <= Temp(16);
    end process;
end Behavioral;