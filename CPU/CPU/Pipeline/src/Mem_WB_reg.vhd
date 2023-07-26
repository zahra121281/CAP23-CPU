library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL ; 	
use ieee.math_real.uniform;
use work.p_avg.All ;


entity Mem_WB_reg is
	port (
	clk , rst : in std_logic ; 	  
	MEM_WB_Write : in std_logic ; 
	MemToregIn : in std_logic_vector(1 downto 0);
	AluOutIn : in std_logic_vector(CPUSize-1 downto 0) ; -- ex/mem
	MemoutIn : in std_logic_vector(CPUSize-1 downto 0) ; -- memory
	WriteRegIn : in std_logic_vector(3 downto 0) ;  -- ex/mem
	RegWriteIn : in std_logic ; -- ex/mem 
	RD_Data_In : in std_logic_vector(CPUSize-1 downto 0) ;  -- ex/mem
	-- ////////////////////////outs 
	MemToregOut : out std_logic_vector(1 downto 0) ; 
	AluOutOut : out std_logic_vector(CPUSize-1 downto 0) ; 
	MemoutOut : out std_logic_vector(CPUSize-1 downto 0) ; 
	WriteRegOut : out std_logic_vector(3 downto 0) ;
	RegWriteOut : out std_logic ; 
	RD_Data_Out : out std_logic_vector(CPUSize-1 downto 0)  
		);
end Mem_WB_reg;


architecture MEM_WB_ARC of Mem_WB_reg is
begin
	process( clk , rst )
	begin  							 
		if( rst = '1' ) then 
			MemToregOut <= (others => '0') ; 
			AluOutOut <= (others => '0') ; 
			MemoutOut <= (others => '0') ; 
			WriteRegOut <= (others => '0') ; 
			RegWriteOut <= '0' ; 
			RD_Data_Out <= (others => '0') ; 
		else
			if( rising_edge( clk ) and MEM_WB_Write ='1' ) then
				MemToregOut <= MemToregIn; 
				AluOutOut <= AluOutIn ; 
				MemoutOut <= MemoutIn;
				WriteRegOut <= WriteRegIn; 
				RegWriteOut <= RegWriteIn ; 
				RD_Data_Out <= RD_Data_In ; 
			end if ;
		end if ; 
	end process;	
end MEM_WB_ARC;