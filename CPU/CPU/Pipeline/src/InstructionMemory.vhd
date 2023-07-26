library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL ; 	
use ieee.math_real.uniform;
use work.p_avg.All ; 

entity IMEMORY is
	port(	 
		clk,reset : in std_logic ; 
		PC_IN : in std_logic_vector(CPUSize-1 downto 0) ; 
		InitData : in Mem_Array  ; -- comes from File 
		ReadInstruction : out std_logic_vector(CPUSize-1 downto 0) 
	);
end IMEMORY;	  

architecture Behavioral of IMEMORY is		  
	signal Memory : Mem_Array(0 to 999) := InitData ;
	signal num_rows : integer range 0 to InitData'length - 1 := 0;
begin
    -- Get the number of rows in InitData
    num_rows <= InitData'high + 1;	--InitializingMem: 
--		process is
--		begin
--			
--			
--			
--		end process; 	
	process (clk)
	variable index : integer ; 
	variable Hi_Data_out : std_logic_vector(7 downto 0) ;   
	variable Low_Data_out : std_logic_vector(7 downto 0) ;  
	begin  		
		index := to_integer(unsigned(PC_IN));		
		if rising_edge(clk) then 
			if( reset = '0' ) then
				-- read from Imemory 
			   	Low_Data_out := Memory(index) ; 
				Hi_Data_out :=  Memory(index+1) ; 
				ReadInstruction(15 downto 0)<= Hi_Data_out & Low_Data_out ; 
			else 
				-- clear memory ?? 	if reset signal == 1 
				Memory <= (others => (others => '0' )) ; 
				ReadInstruction	<= (others => '0' ) ; 
			end if ; 
		end if ;
	
	end process;	
	
end Behavioral;

