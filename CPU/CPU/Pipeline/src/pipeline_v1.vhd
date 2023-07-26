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

-- out puts : Address of mem, data of mem, PC, status reg, ALU output, etc

entity Pipeline is
	port (
		clk : in std_logic ; 
		rst : in std_logic ;							
		initInsts : in Mem_Array ;
		Oout : out std_logic; 
		Cout : out std_logic;
    	Zout : out std_logic;
    	Nout : out std_logic
	);
end Pipeline;

architecture Pipeline_Arc of Pipeline is    


begin
	
	
	
end Pipeline_Arc ; 