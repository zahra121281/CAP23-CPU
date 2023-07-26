library ieee;
use ieee.std_logic_1164.all;

package p_avg is
  --type Mem_Array is array (0 to 2999) of std_logic_vector(7 downto 0); 	 
  Constant CPUSize : integer := 16 ; 				 
  type Mem_Array is array (natural range <>) of std_logic_vector(7 downto 0); 	   
  --type MY_STRING is array (0 to 254) of character; 
end package p_avg;



