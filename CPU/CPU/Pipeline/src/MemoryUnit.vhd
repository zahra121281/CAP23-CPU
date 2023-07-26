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



entity MemoryUnit is
	port (
		clk , rst : in std_logic ; 
		MemRead : in std_logic ; 
		MemWrite : in std_logic ;
		MemDataSRC : in std_logic ; 
		MemAddressSRC : in std_logic ;
		RegData : in std_logic_vector(CPUSize-1 downto 0) ; 
		AluOut :  in std_logic_vector(CPUSize-1 downto 0) ; 
		CLRaddressIn : in std_logic_vector(CPUSize-1 downto 0) ;  -- CLR ADDRESS
		MemReadData : out std_logic_vector(CPUSize-1 downto 0)  
	);
end MemoryUnit;


architecture Behavioral of MemoryUnit is 
	signal InputMemAddress : std_logic_vector(CPUSize-1 downto 0) := (others => '0') ; 
	signal InputMemData : std_logic_vector(CPUSize-1 downto 0) := (others => '0') ;	
	signal OutMemData : std_logic_vector(CPUSize-1 downto 0) := (others => '0') ;
	signal DMEMORY : Mem_Array(0 to 2999);  
begin		
	

	process( clk , rst )
	variable index : integer ; 
	variable Hi_Data_out : std_logic_vector(7 downto 0) ;   
	variable Low_Data_out : std_logic_vector(7 downto 0) ;  
	begin  
		
		if( rising_edge(clk )) then
			if( rst = '1' ) then   
				DMEMORY(0 to 2999) <= (others => (others => '0' )) ; 
				MemReadData <= (others => '0' ) ; 
			else
				Case MemAddressSRC is
					when '0' =>
						InputMemAddress <= AluOut ; 
					when '1' =>
						InputMemAddress <=	CLRaddressIn;
					when others =>
						InputMemAddress <= (others => '0' ) ; 
				end case ; 
				
				case MemDataSRC is
					when '0' =>
						InputMemData <= RegData ; 
					when others =>
						InputMemData <= (others => '0' ) ; 
				end case ; 
				index := to_integer(unsigned(InputMemAddress));	
				if( index >= 0 and index <= 2999 ) then 
					if( MemWrite = '0' and MemRead = '1' ) then 
					   		Low_Data_out := DMEMORY(index) ; 
							Hi_Data_out :=  DMEMORY(index+1) ; 
							MemReadData(15 downto 0)<= Hi_Data_out & Low_Data_out ; 
					   	end if ; 	 
					   	-- write into DMEMORY  
						if(MemWrite = '1' and MemRead = '0' ) then 	  
							-- write data in DMEMORY 
							DMEMORY(index) <= InputMemData(7 downto 0 ) ;  
							DMEMORY(index+1) <= InputMemData(15 downto 8 ) ; 
						end if ; 
				else
					-- get some error index out of range ; 
					 MemReadData <= (others => 'X' ) ; 
				end if ; 
			end if ; 
		end if ; 
	end process;	
		
end Behavioral;

