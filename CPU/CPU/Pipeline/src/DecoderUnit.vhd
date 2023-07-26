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

entity DecoderUnit2  is
	port (		   
		clk , rst : in std_logic  ;	
		RegWriteIn : in std_logic ;  
		Z , N , C , O  : in std_logic ; 
		Instruction : in std_logic_vector(CPUSize-1 downto 0) ;	  -- if/id
		PC_next : in std_logic_vector(CPUSize-1 downto 0) ;    -- if/id
		writeRegister : in std_logic_vector(3 downto 0) ;  	  -- wb 
		writeDataIN : in std_logic_vector(CPUSize-1 downto 0) ; -- wb  
		-- out puts 
		Read1 :out std_logic_vector(CPUSize-1 downto 0) ;  -- from register file 
		Read2 :out std_logic_vector(CPUSize-1 downto 0) ;  -- from register file 
		RDregister : out std_logic_vector(3 downto 0) ;  
		Rsregister : out std_logic_vector(3 downto 0) ; 
		WriteReg : out std_logic_vector(3 downto 0) ;  -- number of write register ; 
		SigneExtendedAddress : out std_logic_vector(CPUSize-1 downto 0) ;
		ShiftedData : out std_logic_vector(CPUSize-1 downto 0) ;		
		BranchDest : out std_logic_vector(CPUSize-1 downto 0)  ;  --to instruction fetch 
		JumpingDest : out std_logic_vector(CPUSize-1 downto 0);	  --to instruction fetch 
		JumpOut : out std_logic ; 	 --  --to instruction fetch 
		BranchOut :out std_logic ;	  --to instruction fetch 
		MemReadOut : out std_logic ; -- to id/ex
		MemWriteOut :out std_logic ; 
		AlUSrcOut1 : out std_logic_vector(1 downto 0);
		AlUSrcOut2 : out std_logic_vector(1 downto 0);
		BAWriteOut : out std_logic ; 
		MemDataSRCOut : out std_logic ;  
		MemAddressSRCOut : out std_logic ; 
		RegWriteOut : out std_logic ; 
		MemtoRegOut : out std_logic_vector(1 downto 0) ; 
		ALUOpOut : out std_logic_vector(3 downto 0)  ;  
		Zout , Nout , Cout , Oout  : out std_logic ; -- z to fetch 
		MemCLRaddress : out std_logic_vector(CPUSize-1 downto 0)   ; 
		ZandBranch  : out std_logic  -- to id/ex  ; 
		
	);
end DecoderUnit2 ; 



architecture Behavioral of DecoderUnit2 is 
	signal read_reg1 : std_logic_vector(3 downto 0) := Instruction(7 downto 4 ) ; 
	signal read_reg2 : std_logic_vector(3 downto 0) := Instruction(11 downto 8 ) ;
	signal Read_tmp1 : std_logic_vector(CPUSize-1 downto 0) ; 
	signal Read_tmp2 : std_logic_vector(CPUSize-1 downto 0) ; 
	signal ShiftedAddress : std_logic_vector(CPUSize-1 downto 0);
	signal Address : std_logic_vector(7 downto 0) :=Instruction ( 7 downto 0 ) ;   
	signal ExtendedAddress : std_logic_vector(CPUSize-1 downto 0) ;
	signal IsBA_in : std_logic := '0' ; 
	signal Jump0 : std_logic_vector(CPUSize-1 downto 0) := ("0000" & Instruction ( 11 downto 0 )) ; 
	signal Jump1 : std_logic_vector( CPUSize-1 downto 0)  ;	  
	signal CLRAddressIN : std_logic_vector( 11 downto 0) := Instruction(11 downto 0 )  ;	   
	signal CLRAddressOut : std_logic_vector(CPUSize-1 downto 0) ;	
	signal branch : std_logic ; 
	
	component ShiftLeft is
        port (
            clk : in std_logic;
            DataIn : in std_logic_vector(CPUSize-1 downto 0);
            DataOut : out std_logic_vector(CPUSize-1 downto 0)
        );
    end component;	
	
	component SignExtend is
        generic (
            DATA_WIDTH : integer := 8
        );
        port (
            clk : in std_logic;
            DataIN : in std_logic_vector(DATA_WIDTH - 1 downto 0);
            ExtendedData : out std_logic_vector(DATA_WIDTH + 7 downto 0)
        );
    end component; 
	
	
	component StatusRegister is
	port (													  
		clk , rst : in std_logic  ; 
		Zin , Nin , Cin , Oin  : in std_logic ; 
		Write : in std_logic ; 
		Zout , Nout , Cout , Oout  : out std_logic 
	);
	end component StatusRegister;
	
	
	component Controller is
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
		ALUOp : out std_logic_vector(3 downto 0)   
	);
	end component Controller; 
	
	
begin	
	
	Reg_File : entity work.RegisterFile	
		
	port map ( 
	clk => clk , 
	rst =>	rst , 		
		RegWrite  => RegWriteIn ,
		ReadRegister1 => read_reg1 ,
		ReadRegister2 => read_reg2 ,
		WriteRegister  => writeRegister ,
		WriteData  =>  writeDataIN ,
		ReadData1  => Read_tmp1 ,
		ReadData2  => Read_tmp2  
	);	
	
	SignExtendUnit: SignExtend
        generic map (
            DATA_WIDTH => 8 -- set the generic value if needed
        )			   
		
        port map (
            clk => clk,
            DataIN => Address,
            ExtendedData => ExtendedAddress
        ); 
		
	SignExtendUnitForCLR : SignExtend
        generic map (
            DATA_WIDTH => 12 -- set the generic value if needed
        )			   
		
        port map (
            clk => clk,
            DataIN => CLRAddressIN,
            ExtendedData => CLRAddressOut 
        ); 	 
		
		
	ShiftUnitForCLR : ShiftLeft port map (
        clk => clk,
        DataIn => CLRAddressOut , -- or any other signal that needs to be shifted
        DataOut => MemCLRaddress
    );	 
		
	ShiftUnit : ShiftLeft port map (
        clk => clk,
        DataIn => ExtendedAddress, -- or any other signal that needs to be shifted
        DataOut => ShiftedAddress
    );	 		
	
	
	Update_Jump : 	 
		ShiftLeft port map (
        clk => clk,
        DataIn => Jump0, -- or any other signal that needs to be shifted
        DataOut => jump1 
    );	 
	
	
	ControllUnit : 
		Controller port map(
		clk => clk , 
		rst => rst , 
		OPCode => Instruction( 15 downto 12) ,   --op_code , 
		IsBA => IsBA_in ,  
		Jump => JumpOut , 
		Branch => branch , 
		MemRead => MemReadout,
		MemWrite => MemWriteout ,
		AlUSrc1 => AlUSrcout1 ,
		AlUSrc2 => AlUSrcout2 ,
		BAWrite => BAWriteout ,
		MemDataSRC => MemDataSRCout ,
		MemAddressSRC => MemAddressSRCOut ,
		RegWrite => RegWriteOut, 
		MemtoReg => MemtoRegout ,
		ALUOp => ALUOpout 
	) ;   
	
	SR : 
		StatusRegister port map 
	(													  
		clk => clk ,  
		rst => rst , 
		Zin =>	Z, 
		Nin => N , 
		Cin => C , 
		Oin  => O , 
		Write => '1' ,
		Zout=> zout , 
		Nout => Nout , 
		Cout => Cout ,
		Oout => Oout
	);

		
		
	process( clk , rst ) is
		variable BA_reg_num : integer := 10 ; 
		variable rd_num :integer := to_integer(unsigned(read_reg2) );
		variable INPROCESS_BA : std_logic := '0' ; 
	begin
	    if ( rising_edge(clk )) then 
			if( rst = '1' ) then  
				Read1 <= ( others => '0' ); 
				Read2 <=( others => '0' ); 
				RDregister <=( others => '0' ); 
				Rsregister <=( others => '0' ); 
				SigneExtendedAddress <=( others => '0' ); 
				ShiftedData <=( others => '0' ); 
				WriteReg <=( others => '0' ); 
				BranchDest <=( others => '0' ); 
				
			else 
				-- setting 	BranchDest and isba
				if( rd_num = BA_reg_num ) then	   -- to khoode controller tashkhis dade beshe 
					IsBA_in <= '1' ; 
				else
					IsBA_in <= '0' ; 
				end if ;
				-- sign extend the address 
				SigneExtendedAddress <= ExtendedAddress ; 
				-- sll the address 
				ShiftedData <= ShiftedAddress ; 
				Read1 <= Read_tmp1 ; 
				Read2 <= Read_tmp2 ; 
				RDregister <= read_reg2 ; 
				RSregister <= read_reg1 ; 
				WriteReg <=  read_reg2 ; 
				BranchDest <= PC_next+ ShiftedAddress ;	
				 
				JumpingDest <= PC_next( 15 downto 13 ) & Jump1( 12 downto 0); 
				ZandBranch <= z and branch ; 
				BranchOut <= branch ; 
				Zout <= z ; 
			 end if ; 
		end if ; 
	end process ;	
		
end Behavioral;