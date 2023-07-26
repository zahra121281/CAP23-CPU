library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL ; 	
use IEEE.math_real.uniform;	 
use std.textio.all;	   
use IEEE.std_logic_textio.all;


entity RegisterFile is
	port ( 
		clk,rst: in std_logic;
		RegWrite : in std_logic ; 
		ReadRegister1 , ReadRegister2,WriteRegister : in std_logic_vector(3 downto 0) ; 
		WriteData : in std_logic_vector(15 downto 0) ; 
		ReadData1 , ReadData2 : out std_logic_vector(15 downto 0)  
	);
end RegisterFile; 


architecture Behavioral of RegisterFile is
	type reg_type is array (0 to 9) of std_logic_vector (15 downto 0);
	signal reg_array: reg_type;
begin  
 process(clk,rst) 
 begin
 if(rst='1') then  
	--zero 
   reg_array(0) <= x"0001";	
   -- D0 to D3
   reg_array(1) <= x"0002";
   reg_array(2) <= x"0003";
   reg_array(3) <= x"0004";
   reg_array(4) <= x"0005";
   -- A0 to A3
   reg_array(5) <= x"0006";
   reg_array(6) <= x"0007";
   reg_array(7) <= x"0008";	  
   reg_array(8) <= x"0009";
 elsif(rising_edge(clk)) then
   if(RegWrite='1') then
    reg_array(to_integer(unsigned(WriteRegister))) <= WriteData ;
   end if;
 end if;
 end process;

 ReadData1 <= x"0000" when ReadRegister1 = "0000" else reg_array(to_integer(unsigned(ReadRegister1)));
 ReadData2 <= x"0000" when ReadRegister2 = "0000" else reg_array(to_integer(unsigned(ReadRegister2)));
	
end Behavioral;

