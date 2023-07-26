library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL ; 	
use IEEE.math_real.uniform;	 
use std.textio.all;	   
use IEEE.std_logic_textio.all;	  

entity Controller is
	port (
		clk , rst : in std_logic ; 
		OPCode : in std_logic_vector(3 downto 0) ;
		IsBA : in std_logic ; 
		Jump : out std_logic ; 
		Branch :out std_logic ;
		MemRead : out std_logic ; 
		MemWrite :out std_logic ; 
		AlUSrc1 : out std_logic_vector(1 downto 0);
		AlUSrc2 : out std_logic_vector(1 downto 0);
		BAWrite : out std_logic ; 
		MemDataSRC : out std_logic ;  
		MemAddressSRC : out std_logic ; 
		RegWrite : out std_logic ; 
		MemtoReg : out std_logic_vector(1 downto 0) ; 
		ALUOp : out std_logic_vector(3 downto 0)   -- not sure about aluop :)
	);
end Controller;

-- it does not contain hazard detection controll singals 
architecture Behavioral of Controller is
begin
	process(clk,rst )
	begin 
		if( rising_edge(clk) ) then
			if( rst = '1' ) then 
				Jump <= '0' ; 
				Branch <= '0';
				MemRead <= '0';
				MemWrite <= '0';
				MemDataSRC <= '0';
				MemAddressSRC <= '0' ; 
				AlUSrc1 <= "00";
				AlUSrc2 <= "00";
				BAWrite <= '0';
				RegWrite <= '0';
				MemtoReg <= "00";
				ALUOp <= "0000";
			 
			else
				case opcode is
	  				when "0000" => -- Add
					   	Jump <= '0' ; 
						Branch <= '0';
						MemRead <= '0';
						MemWrite <= '0';
						MemAddressSRC <= '0' ; 
						AlUSrc1 <= "00";
						AlUSrc2 <= "00";
						BAWrite <= '0';
						MemDataSRC <= '0';
						RegWrite <= '1';
						MemtoReg <= "10";
						ALUOp <= "0000";
					  
					when "0001" => -- Add with BA 
					   	Jump <= '0' ; 
						Branch <= '0';
						MemRead <= '0';
						MemWrite <= '0';
						MemAddressSRC <= '0' ; 
						AlUSrc1 <= "01";  --> immediate 
						AlUSrc2 <= "01";  --> ba
						BAWrite <= '0';
						MemDataSRC <= '0';
						RegWrite <= '1';
						MemtoReg <= "01";
						ALUOp <= "0000";
					
					when "0010" => -- sub
					   	Jump <= '0' ; 
						Branch <= '0';
						MemRead <= '0';
						MemWrite <= '0';
						MemAddressSRC <= '0' ; 
						AlUSrc1 <= "00";
						AlUSrc2 <= "00";
						BAWrite <= '0';
						MemDataSRC <= '0';
						RegWrite <= '1';
						MemtoReg <= "10";
						ALUOp <= "0010";
					
					when "0011" =>  -- Addi
					   	Jump <= '0' ; 
						Branch <= '0';
						MemRead <= '0';
						MemWrite <= '0';
						MemAddressSRC <= '0' ; 
						AlUSrc1 <= "01";
						AlUSrc2 <= "00";
						BAWrite <= '0';
						MemDataSRC <= '0';
						RegWrite <= '0';
						MemtoReg <= "10";
						ALUOp <= "0000";
					
					when "0101" => -- And
					   	Jump <= '0' ; 
						Branch <= '0';
						MemRead <= '0';
						MemWrite <= '0'; 
						MemAddressSRC <= '0' ; 
						AlUSrc1 <= "00";
						AlUSrc2 <= "00";
						BAWrite <= '0';
						MemDataSRC <= '0';
						RegWrite <= '1';
						MemtoReg <= "10";
						ALUOp <= "0101";					
					
					when "0110" => -- Sll
					   	Jump <= '0' ; 
						Branch <= '0';
						MemRead <= '0';
						MemWrite <= '0';
						MemAddressSRC <= '0' ; 
						AlUSrc1 <= "01";
						AlUSrc2 <= "00";
						BAWrite <= '0';
						MemDataSRC <= '0';
						RegWrite <= '1';
						MemtoReg <= "10";
						ALUOp <= "0110";
					
					when "0111" =>  -- LW  
					   	Jump <= '0' ; 
						Branch <= '0';
						MemRead <= '1';
						MemWrite <= '0';
						AlUSrc1 <= "01";
						AlUSrc2 <= "01";
						BAWrite <= '0';
						MemDataSRC <= '0';
						RegWrite <= '0';
						MemtoReg <= "00";
						ALUOp <= "0000";
						
					when "1001" => -- Sw
					   	Jump <= '0' ; 
						Branch <= '0';
						MemRead <= '0';
						MemWrite <= '1';	
						MemAddressSRC <= '0' ; 
						AlUSrc1 <= "01";
						AlUSrc2 <= "01";
						BAWrite <= '0';
						MemDataSRC <= '0';
						RegWrite <= '1';
						MemtoReg <= "00";
						ALUOp <= "0000";  
						
					when "1011" => -- REGCLR
					   	Jump <= '0' ; 	   -- MOVE rd , ZERO ; 
						Branch <= '0';
						MemRead <= '0';
						MemWrite <= '0';
						MemAddressSRC <= '0' ; 
						AlUSrc1 <= "00"; -- zero 
						AlUSrc2 <= "00"; -- zero 
						BAWrite <= '0';
						MemDataSRC <= '0';
						RegWrite <= '1';
						MemtoReg <= "10";
						ALUOp <= "0000"; 
					when "1000" => -- MEMCLR
					   	Jump <= '0' ; 
						Branch <= '0';
						MemRead <= '0';
						MemWrite <= '1';  
						MemAddressSRC <= '1'; 
						AlUSrc1 <= "00";
						AlUSrc2 <= "00";
						BAWrite <= '0';
						MemDataSRC <= '1';  -- put zero into mem address 
						RegWrite <= '0';
						MemtoReg <= "00";
						ALUOp <= "0000";  
						
					when "1100" => -- Mov 
					   	Jump <= '0' ; 
						Branch <= '0';
						MemRead <= '0';
						MemWrite <= '0'; 
						MemAddressSRC <= '0' ;
						MemDataSRC <= '0';
						ALUOp <= "0000";
						
						if ( IsBA = '1' ) then 
							AlUSrc1 <= "10";
							AlUSrc2 <= "10";
							BAWrite <= '1';	
							RegWrite <= '0'; 
							MemtoReg <= "00"; 
						else
							AlUSrc1 <= "10";
							AlUSrc2 <= "10"; 
							RegWrite <= '1';
							MemtoReg <= "10"; 
							BAWrite <= '0';	
						end if ; 			 
						
					when "1101" => -- CMP Rformat
					   	Jump <= '0' ; 
						Branch <= '0';
						MemRead <= '0';
						MemWrite <= '0';  
						MemAddressSRC <= '0'; 
						AlUSrc1 <= "00"; -- SELECT R1 
						AlUSrc2 <= "00"; -- SELECT R2 
						BAWrite <= '0';
						MemDataSRC <= '0';
						RegWrite <= '0';
						MemtoReg <= "00";
						ALUOp <= "0010";
					when "1110" => -- Bne
					   	Jump <= '0' ; 
						Branch <= '1' ;
						MemRead <= '0' ;
						MemWrite <= '0'; 
						MemAddressSRC <= '0'; 
						AlUSrc1 <= "00";
						AlUSrc2 <= "00";
						BAWrite <= '0';
						MemDataSRC <= '0';
						RegWrite <= '0';
						MemtoReg <= "00";
						ALUOp <= "0000";
					
					when "1111" => -- Jump
					   	Jump <= '1' ; 
						Branch <= '0';
						MemRead <= '0';
						MemWrite <= '0'; 
						MemAddressSRC <= '0' ; 
						AlUSrc1 <= "00";
						AlUSrc2 <= "00";
						BAWrite <= '0';
						MemDataSRC <= '0';
						RegWrite <= '0';
						MemtoReg <= "00";
						ALUOp <= "0000";
					when others => 	
					   	Jump <= '0' ; 
						Branch <= '0';
						MemRead <= '0';
						MemWrite <= '0'; 
						MemAddressSRC <= '0' ; 
						AlUSrc1 <= "00";
						AlUSrc2 <= "00";
						BAWrite <= '0';
						MemDataSRC <= '0';
						RegWrite <= '0';
						MemtoReg <= "00";
						ALUOp <= "0000";
				end case ; 
			end if ;
		end if ; 
	
	end process;	 
end Behavioral;


-- change the alu source to 2 bits ; 

