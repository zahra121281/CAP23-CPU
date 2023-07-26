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


entity WriteBackUnit is
	port (
		clk , rst : in std_logic ; 
		MemToReg : in std_logic_vector(1 downto 0) ; 
		RD_Data : in std_logic_vector(CPUSize-1 downto 0) ; 
		MemoryOut : in std_logic_vector(CPUSize-1 downto 0) ; 
		AluOut : in std_logic_vector(CPUSize-1 downto 0) ; 	 
		DAtaToReg : out std_logic_vector(CPUSize-1 downto 0) 
	);
end WriteBackUnit;	


architecture Behavioral of WriteBackUnit is	 
	signal OutAdder : std_logic_vector(CPUSize-1 downto 0) := (others => '0') ; 
	signal Cout_Adder : std_logic ; 
	Component adder_16bit is
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           Cin : in STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (15 downto 0);
           Cout : out STD_LOGIC);
	end component;
begin  
	
	Adder : adder_16bit port map(
	A => RD_Data ,
	B => MemoryOut ,
	Cin => '0' ,
	Sum => OutAdder ,
	Cout => Cout_Adder 
	);
	
	process(clk , rst )
		
	begin  	
		if( rising_edge(clk ) )  then
			if(rst ='1' ) then 
				 DAtaToReg <= (others => '0' ) ; 
			 else
				case MemToReg is
					when "00" =>
						 DAtaToReg <= MemoryOut ; 
					when "01" =>
						 DataToReg <= OutAdder ; 
					when "10" =>
						 DataToReg <=  AluOut ; 
					when others =>
						DAtaToReg <= (others => '0' ) ; 
				end case ;
			end if ; 
	   end if ; 
	end process;
end Behavioral;