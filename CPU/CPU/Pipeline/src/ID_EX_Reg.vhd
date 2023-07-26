library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL ; 	
use ieee.math_real.uniform;
use work.p_avg.All ;


entity ID_EX_reg is
	port (
		clk , rst : in std_logic ; 	  
		ID_EX_Write : in std_logic ; 
		ReadIn1 :in std_logic_vector(CPUSize-1 downto 0) ; 
		ReadIn2 :in std_logic_vector(CPUSize-1 downto 0) ;
		RDregisterIn : in std_logic_vector(3 downto 0) ;  
		RsregisterIn : in std_logic_vector(3 downto 0) ; 
		SigneExtendedAddressIn : in std_logic_vector(CPUSize-1 downto 0) ;
		ShiftedDataIn : in std_logic_vector(CPUSize-1 downto 0) ;
		WriteRegisterIn : in std_logic_vector(3 downto 0) ;  -- number of write register ; 
		MemReadIn : in std_logic ; 
		MemWriteIn :in std_logic ; 
		AlUSrcIn1 :in std_logic_vector(1 downto 0);
		AlUSrcIn2 :in std_logic_vector(1 downto 0);
		BAWriteIn :in std_logic ; 
		MemDataSRCIn : in std_logic ;  
		MemAddressSRCIn :in std_logic ; 
		RegWriteIn:in std_logic ; 
		MemtoRegIn :in std_logic_vector(1 downto 0) ; 
		ALUOpIn :in std_logic_vector(3 downto 0)  ; 
		MemCLRaddressIn : in std_logic_vector(CPUSize-1 downto 0) ; 

		ReadOut1 :out std_logic_vector(CPUSize-1 downto 0) ; 
		ReadOut2 :out std_logic_vector(CPUSize-1 downto 0) ;
		RDregisterOut : out std_logic_vector(3 downto 0) ;  
		RsregisterOut : out std_logic_vector(3 downto 0) ; 
		SigneExtendedAddressOut : out std_logic_vector(CPUSize-1 downto 0) ;
		ShiftedDataOut : out std_logic_vector(CPUSize-1 downto 0) ;
		WriteRegisterOut : out std_logic_vector(3 downto 0) ;  -- number of write register ; 
		MemReadOut : out std_logic ; 
		MemWriteOut :out std_logic ; 
		AlUSrcOut1 : out std_logic_vector(1 downto 0);
		AlUSrcOut2 : out std_logic_vector(1 downto 0);
		BAWriteOut : out std_logic ; 
		MemDataSRCOut : out std_logic ;  
		MemAddressSRCOut : out std_logic ; 
		RegWriteOut : out std_logic ; 
		MemtoRegOut : out std_logic_vector(1 downto 0) ; 
		ALUOpOut : out std_logic_vector(3 downto 0)  ; 
		MemCLRaddressOut : out std_logic_vector(CPUSize-1 downto 0) 
);
end ID_EX_reg;


architecture ID_EX_ARC of ID_EX_reg is
begin
	process( clk , rst )
	begin  							 
		if( rst = '1' ) then 
		ReadOut1 <= (others => '0') ;
		ReadOut2 <= (others => '0') ;
		RDregisterOut <= (others => '0') ;
		RsregisterOut <= (others => '0') ;
		SigneExtendedAddressOut <= (others => '0') ;
		ShiftedDataOut <= (others => '0') ;
		WriteRegisterOut <= (others => '0') ;
		MemReadOut <= '0' ; 
		MemWriteOut <= '0' ; 
		AlUSrcOut1 <= (others => '0') ;
		AlUSrcOut2 <= (others => '0') ;
		BAWriteOut <= '0' ; 
		MemDataSRCOut <= '0' ; 
		MemAddressSRCOut <= '0' ; 
		RegWriteOut <= '0' ; 
		MemtoRegOut <= (others => '0') ;
		ALUOpOut <= (others => '0') ;
		MemCLRaddressOut <= (others => '0') ;
		else
			if( rising_edge( clk ) and ID_EX_Write ='1' ) then
				ReadOut1 <= ReadIn1 ;
				ReadOut2 <= ReadIn2;
				RDregisterOut <= RDregisterIn ;
				RsregisterOut <= RsregisterIn ;
				SigneExtendedAddressOut <= SigneExtendedAddressIn ;
				ShiftedDataOut <= ShiftedDataIn ;
				WriteRegisterOut <= WriteRegisterIn ;
				MemReadOut <= MemReadIn ; 
				MemWriteOut <= MemWriteIn ; 
				AlUSrcOut1 <= AlUSrcIn1;
				AlUSrcOut2 <= AlUSrcIn2 ;
				BAWriteOut <= BAWriteIn ; 
				MemDataSRCOut <= MemDataSRCIn; 
				MemAddressSRCOut <= MemAddressSRCIn ; 
				RegWriteOut <= RegWriteIn ; 
				MemtoRegOut <= MemtoRegIn ; 
				ALUOpOut <= ALUOpIn;
				MemCLRaddressOut <= MemCLRaddressIn;
			end if ;
		end if ; 
	end process;	
end ID_EX_ARC;