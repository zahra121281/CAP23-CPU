library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL ; 	
use ieee.math_real.uniform;
use work.p_avg.All ;


entity IF_ID_Register is
	port (
		clk , Flush,IF_ID_Write  : in std_logic ; 	 
		Next_PC_IN : in std_logic_vector(CPUSize-1 downto 0) ; 
		Ins_In : in std_logic_vector(CPUSize-1 downto 0) ; 
		Next_PC_out : out std_logic_vector(CPUSize-1 downto 0) ; 
		Ins_out : out std_logic_vector(CPUSize-1 downto 0)  
	);
end IF_ID_Register;	 


architecture IF_ID_ARC of IF_ID_Register is
begin
	process( clk , Flush )
		
	begin  							 
		if( Flush = '1' ) then 
			Next_Pc_out <= ( others => '0' ) ; 
			Ins_out <= ( others => '0' ) ; 	 
		else
			if( rising_edge( clk ) and  IF_ID_Write ='1') then
				Next_PC_out	<= Next_PC_IN;
				Ins_out <= Ins_In ; 	
			end if ;
		end if ; 
	end process;	
end IF_ID_ARC;