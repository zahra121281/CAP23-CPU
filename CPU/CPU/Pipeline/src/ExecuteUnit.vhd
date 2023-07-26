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

entity ExecuteUnit is
	port ( 
		clk , rst : in std_logic  ;	
		Read1 :in std_logic_vector(CPUSize-1 downto 0) ; 
		Read2 :in std_logic_vector(CPUSize-1 downto 0) ;
		SigneExtendedAddress : in std_logic_vector(CPUSize-1 downto 0) ;
		ShiftedData : in std_logic_vector(CPUSize-1 downto 0) ;
		-- exe signals 
		AluSRC1 : in std_logic_vector(1 downto 0) ; 
		AluSRC2 : in std_logic_vector(1 downto 0) ; 
		BAWrite : in std_logic ; 
		AluOP : in std_logic_vector(3 downto 0) ; 
		-- out put signals 
		AluOut : out std_logic_vector(CPUSize-1 downto 0) ; -- to reg ex/mem
		Reg_data : out std_logic_vector(CPUSize-1 downto 0) ; -- to reg ex/mem; 
		Oout : out std_logic; 
		Cout : out std_logic;
    	Zout : out std_logic;
    	Nout : out std_logic
	);
end ExecuteUnit;	   


architecture Behavioral of ExecuteUnit is
	signal Selected_SRC1 : std_logic_vector(CPUSize -1 downto 0) := (others => '0');
	signal Selected_SRC2 : std_logic_vector(CPUSize -1 downto 0) := (others => '0'); 
	signal AluOutTmp : std_logic_vector(CPUSize -1 downto 0) := (others => '0');  
	signal BAReadData : std_logic_vector(CPUSize -1 downto 0) := (others => '0');   
	component ALU is
	  Port (
	    A        : in  STD_LOGIC_VECTOR(15 downto 0);
	    B        : in  STD_LOGIC_VECTOR(15 downto 0);
	    ALU_Sel  : in  STD_LOGIC_VECTOR(3 downto 0);
	    ALU_Out  : out STD_LOGIC_VECTOR(15 downto 0);
	    Carryout : out std_logic;
	    Overflow : out std_logic;
	    Z        : out std_logic;
	    N        : out std_logic
	  );
	end component; 

begin	 
	BAReg : entity work.BaseAddressReg	
	port map ( 
		clk => clk , 
		rst => rst ,
		WriteBA => BAWrite ,  							  
		WriteData => AluOutTmp ,
		ReadData => BAReadData 
	); 
	
	ALU_Unit : ALU port map(
		A => Selected_SRC1 ,
		B => Selected_SRC2 ,
	    ALU_Sel => AluOP ,
	   	ALU_Out => AluOut ,
		Carryout => Cout ,
		Overflow => Oout ,
		Z =>Zout ,
		N => Nout 
	) ; 
	process( clk, rst)
	begin  
		if( rising_edge(clk) ) then 
			if( rst = '1' ) then
				AluOut <= (others => '0' ) ;
				Reg_data <= (others => '0' ) ;
				Oout <= '0' ; 
				Cout <= '0' ; 
		    	Zout <= '0' ; 
		    	Nout <= '0' ; 
			else
				-- set alusrc1 
				case AluSRC1 is
					when "00" =>
					 	Selected_SRC1 <= Read1 ; 
					when "01" =>
						Selected_SRC1 <= ShiftedData;
					when "10" =>
						Selected_SRC1 <= SigneExtendedAddress ; 
					when others =>
						Selected_SRC1 <= (others => '0') ;	
				end case ; 	
				
				-- set alusrc2	
				case AluSRC2 is
					when "00" =>
					 	Selected_SRC2 <= Read2 ; 
					when "01" =>
						Selected_SRC2 <= BAReadData;  -- set to ba read data 
					when others =>
						Selected_SRC2 <= (others => '0') ;	
				end case ; 
				Reg_data <= Selected_SRC2;
			end if ; 
		end if ; 	
	end process;
	
end Behavioral;