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


entity StatusRegister is
	port (													  
		clk , rst : in std_logic  ; 
		Zin , Nin , Cin , Oin  : in std_logic ; 
		Write : in std_logic ; 
		Zout , Nout , Cout , Oout  : out std_logic 
	);
end StatusRegister;		 

  -- Z N C O
architecture Structural of StatusRegister is
	signal StoredData : std_logic_vector(CPUSiZE-1 downto 0) ; 
begin
	process( clk , rst )
	begin  
		if( rising_edge( clk )) then
			if (rst = '1' ) then
				StoredData(15) <= '0' ; 
				StoredData(14) <= '0' ; 
				StoredData(13) <= '0' ; 
				StoredData(12) <= '0' ; 
			end if ; 
				if( Write = '1' ) then
					StoredData(15) <= Zin ;
					StoredData(14) <= Nin ; 
					StoredData(13) <= Cin ; 
					StoredData(12) <= Oin ; 
				end if ;
			Zout <= StoredData(15) ;
			Nout <= StoredData(14) ;
			Cout <= StoredData(13) ;
			Oout <=	StoredData(12) ; 
			 
		end if ; 
	end process;	
end Structural;