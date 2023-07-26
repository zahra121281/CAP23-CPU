library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL ; 	
use ieee.math_real.uniform;


entity PCAdder is
	port (
		PC : in std_logic_vector(15  downto 0) ; 
		PC_out : out std_logic_vector(15  downto 0) 
		);
end PCAdder;	

architecture Behavioral of PCAdder is
begin
	 PC_out <= PC + 2 ; 
end Behavioral;	 

