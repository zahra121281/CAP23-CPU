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


entity IF_Unit2 is
	port (
		clk , rst :in std_logic;  
		ZandBranch : in std_logic ; 
		Jump :in std_logic ; -- came from controller  
		BranchingDest : in std_logic_vector(CPUSize-1 downto 0) ;
		JumpingDest : in std_logic_vector(CPUSize-1 downto 0) ;
		initInstructions : in Mem_Array; 
		PC_Out : out std_logic_vector(CPUSize-1 downto 0);
		InsOut : out std_logic_vector(CPUSize-1 downto 0);
		IsFlush : out std_logic 
	);
end IF_Unit2;


architecture IF_Unit_Arc of IF_Unit2 is 
	signal PC0 : std_logic_vector(CPUSize-1 downto 0) := (others => '0' ) ; 	  
	signal PC1 : std_logic_vector(CPUSize-1 downto 0) := (others => '0' ) ; 	 
	signal PC2 : std_logic_vector(CPUSize-1 downto 0) := (others => '0' ) ; 	 
	signal PC3 : std_logic_vector(CPUSize-1 downto 0) := (others => '0' ) ; 	 
	--signal IsBranchSelector : std_logic := (IsBranch and Zflag ) ; 
	constant ReadUnit : std_logic_vector(CPUSize-1 downto 0) := "0000000000000010" ;   
	signal ReadedInstruction : std_logic_vector(CPUSize-1 downto 0)  ;
	signal JumpMidle : std_logic_vector(CPUSize-1 downto 0) := (others => '0' ) ;    
	signal ShiftLeftIN : std_logic_vector(CPUSize-1 downto 0) := (others => '0' ) ; 
	
	
	signal tmp_Cout : std_logic ; 
	
	component PC_Register is
		port (													  
			clk , rst : in std_logic  ; 							  
			PC_in : in std_logic_vector(CPUSize-1 downto 0) ; 
			PC_out : out std_logic_vector(CPUSize-1 downto 0) 
		);
	end component PC_Register;	

	component adder_16bit is
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           Cin : in STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (15 downto 0);
           Cout : out STD_LOGIC);
	end component adder_16bit;
	
	component ShiftLeft is
		port (
			clk : in std_logic ; 
			DataIn : in std_logic_vector(CPUSize-1 downto 0) ;  
			DataOut : out std_logic_vector(CPUSize-1 downto 0) 
		);
	end component ShiftLeft;	
	
	 component mux2to1 is
	  port ( 
		 w0  : in  std_logic_vector(15 downto 0);
		 w1  : in  std_logic_vector(15 downto 0);
		 s   : in  std_logic;
		 f   :out std_logic_vector(15 downto 0)
	); 
	end component mux2to1;
	
	component IMEMORY is
	port(	 
		clk,reset : in std_logic ; 
		PC_IN : in std_logic_vector(CPUSize-1  downto 0) ; 
		InitData : in Mem_Array ; -- comes from File 
		ReadInstruction : out std_logic_vector(CPUSize-1 downto 0) 
	);
	end component IMEMORY;	

	
begin	  
	PC : 
		PC_Register port map 
		(
			clk => clk ,  
			rst => rst ,  							  
			PC_in => PC0 , 
			PC_out => PC1 
		) ;  
		
	IMEM :
		IMEMORY port map 
		(
			clk => clk , 
			reset => rst , 
			PC_IN => PC1 ,
			InitData => initInstructions,
			ReadInstruction => ReadedInstruction
		); 
		
	PC_Adder : 
		adder_16bit port map 
		(
			A => ReadUnit ,
			B => PC1 ,
			Cin => '0' ,
			Sum => PC2 ,
			Cout => tmp_Cout 
		) ; 
		
	PC_MUX1 :
		mux2to1 port map
		(
		 	w0  => PC2,
		 	w1  => BranchingDest,
		 	s   => ZandBranch ,
		 	f 	=> PC3 
		); 	

		
	PC_MUX2 : 
		mux2to1 port map
		(  
			w0 => PC3 ,
			w1 => JumpingDest,
			s => Jump,
			f => PC0  --- xx might happen
		);
		
	process (clk ,rst ) 
	begin 
		if( rising_edge( clk )) then   

		  	insout <= ReadedInstruction ; 
			PC_Out <= pc2 ;  
			ISFlush <= jump or ZandBranch ;  
		end if ; 
	end process ; 
	
	
end IF_Unit_Arc;