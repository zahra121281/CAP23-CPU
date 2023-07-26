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


entity BaseAddressReg is
	port (													  
		clk , rst : in std_logic  ; 
		WriteBA : in std_logic ; 							  
		WriteData : in std_logic_vector(CPUSize-1 downto 0) ; 
		ReadData : out std_logic_vector(CPUSize-1 downto 0) 
	);
end BaseAddressReg;		 


architecture Structural of BaseAddressReg is
	signal StoredData : std_logic_vector(CPUSiZE-1 downto 0) ; 
begin
	process( clk , rst )
	begin  
		if( rising_edge( clk )) then
			if (rst = '1' ) then
				ReadData <= (others => '0' ) ; 
				StoredData <=(others => '0' ) ;  
			else
				if( WriteBA = '1' ) then
					StoredData <= WriteData	;
				end if ;
				ReadData <= StoredData ;
			end if ; 
		end if ; 
	end process;	
end Structural;