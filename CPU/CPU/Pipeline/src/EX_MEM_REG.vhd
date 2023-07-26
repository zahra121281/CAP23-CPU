library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL ; 	
use ieee.math_real.uniform;
use work.p_avg.All ;


entity EX_Mem_reg is
	port (
		clk , rst : in std_logic ; 	  
		EX_MEM_Write : in std_logic ; 		 
		
		-- from id/ex 
		RDregisterIn : in std_logic_vector(3 downto 0) ;  
		RsregisterIn : in std_logic_vector(3 downto 0) ; 
		MemReadIn : in std_logic ; 
		MemWriteIn:in std_logic ; 
		MemCLRaddressIn : in std_logic_vector(CPUSize-1 downto 0) ;
		MemDataSRCIn : in std_logic ;  
		MemAddressSRCIn :in std_logic ; 
		WriteRegisterIn : in std_logic_vector(3 downto 0) ;  -- number of write register ; 
		RegWriteIn: in std_logic ; 
		MemtoRegIn :in std_logic_vector(1 downto 0) ; 
		RD_DataIn :in std_logic_vector(CPUSize-1 downto 0) ;
		-- from exe 
	   	AluOut1 : in std_logic_vector(CPUSize-1 downto 0) ;
		Reg_DataIn :in std_logic_vector(CPUSize-1 downto 0) ;
		
		
		RDregisterOut : Out std_logic_vector(3 downto 0) ;  
		RsregisterOut : Out std_logic_vector(3 downto 0) ; 
		MemReadOut : Out std_logic ; 
		MemWriteOut:Out std_logic ; 
		RegWriteOut: Out std_logic ; 
		MemtoRegOut:Out std_logic_vector(1 downto 0) ; 
		MemCLRaddressOut : Out std_logic_vector(CPUSize-1 downto 0) ;
		MemDataSRCOut :Out std_logic ;  
		MemAddressSRCOut:Out std_logic ; 
		WriteRegisterOut: Out std_logic_vector(3 downto 0) ;  -- number of write register ; 
		RD_DataOut :Out std_logic_vector(CPUSize-1 downto 0) ;
		Reg_DataOut :out std_logic_vector(CPUSize-1 downto 0) ; 
		AluOut2 : out std_logic_vector(CPUSize-1 downto 0) 	
		
	);
end EX_Mem_reg;


architecture EX_Mem_ARC of EX_Mem_reg is
begin
	process( clk , rst )
	begin  							 
		if( rst = '1' ) then 
			RDregisterOut <= (others => '0' );
			RsregisterOut <= (others => '0' );
			MemReadOut <= '0'  ; 
			MemWriteOut <= '0'  ; 
			RegWriteOut <= '0' ; 
			MemtoRegOut <= (others => '0' );
			MemCLRaddressOut <= (others => '0' );
			MemDataSRCOut <='0' ; 
			MemAddressSRCOut <= '0' ; 
			WriteRegisterOut <= (others => '0' );
			RD_DataOut <= (others => '0' );
			Reg_DataOut <= (others => '0' );  
			AluOut2 <= (others => '0' );  
			Reg_DataOut <= (others => '0' );  
		else
			if( rising_edge( clk ) and EX_MEM_Write ='1' ) then
				RDregisterOut <= RDregisterIn;
				RsregisterOut <= RsregisterIn;
				MemReadOut <= MemReadIn ; 
				MemWriteOut <= MemWriteIn ; 
				RegWriteOut <= RegWriteIn ; 
				MemtoRegOut <=MemtoRegIn;
				MemCLRaddressOut <= MemCLRaddressIn;
				MemDataSRCOut <= MemDataSRCIn;
				MemAddressSRCOut <= MemAddressSRCIn;
				WriteRegisterOut <= WriteRegisterIn;
				RD_DataOut <= RD_DataIn;
				Reg_DataOut <= Reg_DataIn; 
				AluOut2 <= AluOut1;  
				Reg_DataOut <= Reg_DataIn;  
			end if ;
		end if ; 
	end process;	
end EX_Mem_ARC;