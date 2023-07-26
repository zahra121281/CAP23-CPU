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


entity PC_Register is
	port (													  
		clk , rst : in std_logic  ; 							  
		PC_in : in std_logic_vector(CPUSize-1 downto 0) ; 
		PC_out : out std_logic_vector(CPUSize-1 downto 0) 
	);
end PC_Register;		 


architecture Structural of PC_Register is
	--signal StoredData : std_logic_vector(CPUSiZE-1 downto 0) ; 
begin
	process( clk , rst )
	begin  
		if( rising_edge( clk )) then
			if (rst = '1' ) then
				PC_out <= (others => '0' ) ; 
			else
				PC_out <= PC_in ; 	
			
			end if ; 
		end if ; 
	end process;	
end Structural;