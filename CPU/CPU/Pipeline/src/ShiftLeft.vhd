library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL ; 	
use IEEE.math_real.uniform;	 
use std.textio.all;	   
use IEEE.std_logic_textio.all;
use work.p_avg.All ; 

entity ShiftLeft is
	port (
		clk : in std_logic ; 
		DataIn : in std_logic_vector(CPUSize-1 downto 0) ;  
		DataOut : out std_logic_vector(CPUSize-1 downto 0) 
	);
end ShiftLeft;	


architecture Behavioral of ShiftLeft is	
	signal my_integer : integer := to_integer(signed(DataIn)) ; 
begin	 
	  DataOut <= std_logic_vector(to_unsigned(my_integer*2, CPUSize));  
end Behavioral;