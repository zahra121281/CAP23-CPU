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
	component IF_Unit is
		port (
			clk , rst :in std_logic;  
			IsBranch :in std_logic ;-- came from controller 
			Zflag :in std_logic ; -- decoder 
			Jump :in std_logic ; -- came from controller  
			BranchingDest : in std_logic_vector(CPUSize-1 downto 0) ;
			JumpingDest : in std_logic_vector(CPUSize-1 downto 0) ;
			initInstructions : in Mem_Array; 
			PC_Out : out std_logic_vector(CPUSize-1 downto 0);
			InsOut : out std_logic_vector(CPUSize-1 downto 0);
			IsFlush : out std_logic 
		);
	end component IF_Unit;
	
	
	component IF_ID_Register is
		port (
			clk , Flush,IF_ID_Write  : in std_logic ; 	 
			Next_PC_IN : in std_logic_vector(CPUSize-1 downto 0) ; 
			Ins_In : in std_logic_vector(CPUSize-1 downto 0) ; 
			Next_PC_out : out std_logic_vector(CPUSize-1 downto 0) ; 
			Ins_out : out std_logic_vector(CPUSize-1 downto 0)  
		);
	end component IF_ID_Register;	 
	
	
	component DecoderUnit  is
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
			MemCLRaddress : out std_logic_vector(CPUSize-1 downto 0) -- to id/ex
		);
	end component DecoderUnit ; 
	
	component ID_EX_reg is
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
	end component ID_EX_reg;
	
	
	component ExecuteUnit is
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
	end component ExecuteUnit;	   
	
	
	component EX_Mem_reg is
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
	end component EX_Mem_reg;
	
	component MemoryUnit is
		port (
			clk , rst : in std_logic ; 
			MemRead : in std_logic ; 
			MemWrite : in std_logic ;
			MemDataSRC : in std_logic ; 
			MemAddressSRC : in std_logic ;
			RegData : in std_logic_vector(CPUSize-1 downto 0) ; 
			AluOut :  in std_logic_vector(CPUSize-1 downto 0) ; 
			CLRaddressIn : in std_logic_vector(CPUSize-1 downto 0) ;  -- CLR ADDRESS
			MemReadData : out std_logic_vector(CPUSize-1 downto 0)  
		);
	end component MemoryUnit;
	
	component Mem_WB_reg is
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
	end component Mem_WB_reg;
	
	component WriteBackUnit is
		port (
			clk , rst : in std_logic ; 
			MemToReg : in std_logic_vector(1 downto 0) ; 
			RD_Data : in std_logic_vector(CPUSize-1 downto 0) ; 
			MemoryOut : in std_logic_vector(CPUSize-1 downto 0) ; 
			AluOut : in std_logic_vector(CPUSize-1 downto 0) ; 	 
			DAtaToReg : out std_logic_vector(CPUSize-1 downto 0) 
		);
	end component WriteBackUnit;
	
	signal Branch_s : std_logic ; 
	signal Z_s : std_logic ; 
	signal Jump_s : std_logic ; 
	signal BranchingDest_s : std_logic_vector(CPUSize-1 downto 0)  ;  --to instruction fetch  
	signal JumpingDest_s : std_logic_vector(CPUSize-1 downto 0)  ;  --to instruction fetch   
	signal Flush_s : std_logic ; 
	signal InsOut_s : std_logic_vector(CPUSize-1 downto 0)  ;  --to instruction fetch   
	signal Next_InsOut_s  : std_logic_vector(CPUSize-1 downto 0)  ;  --to instruction fetch   
	signal PC_s : std_logic_vector(CPUSize-1 downto 0)  ;  --to instruction fetch   
	signal Next_PC_s : std_logic_vector(CPUSize-1 downto 0)  ;  --to instruction fetch   
	
	signal NAlu_s : std_logic ; 
	signal CAlu_s : std_logic ; 
	signal OAlu_s : std_logic ; 
	signal ZAlu_s : std_logic ; 
	
	
	signal writeRegister_S : std_logic_vector(3 downto 0) ;  	
	signal writeDataIN_s : std_logic_vector(CPUSize-1 downto 0) ;
	
	signal Read1_Dec : std_logic_vector(CPUSize-1 downto 0) ; 
	signal Read2_Dec : std_logic_vector(CPUSize-1 downto 0) ;   
	signal RDregister_Dec : std_logic_vector(3 downto 0) ;   
	signal Rsregister_Dec : std_logic_vector(3 downto 0) ;   
	signal WriteReg_Dec : std_logic_vector(3 downto 0) ;
	signal SigneExtendedAddress_Dec : std_logic_vector(CPUSize-1 downto 0) ;
	signal ShiftedData_Dec : std_logic_vector(CPUSize-1 downto 0) ;
	signal JumpingDest_Dec : std_logic_vector(CPUSize-1 downto 0) ;
	signal MemReadOut_Dec : std_logic  ;  
	signal MemWriteOut_Dec : std_logic ; 
	signal AlU_SrcOut_Dec1 : std_logic_vector(1 downto 0);  
	signal AlU_SrcOut_Dec2 : std_logic_vector(1 downto 0);  
	signal BAWriteOut_Dec : std_logic  ;  
	signal MemDataSRCOut_Dec : std_logic  ;
	signal MemAddressSRCOut_Dec : std_logic  ;  
	signal RegWriteOut_Dec : std_logic  ;  
	signal MemtoRegOut_Dec : std_logic_vector(1 downto 0)  ;  
	signal ALUOpOut_Dec :std_logic_vector(3 downto 0)  ; 
	signal MemCLRaddress_Dec :  std_logic_vector(CPUSize-1 downto 0) ;  -- to id/ex 
	
	
	
	signal Read1_ID_EXE_MEM_s : std_logic_vector(CPUSize-1 downto 0) ; 
	signal Read2_ID_EXE_MEM_s : std_logic_vector(CPUSize-1 downto 0) ;
	signal RDregister_ID_EXE_MEM_s :  std_logic_vector(3 downto 0) ;  
	signal Rsregister_ID_EXE_MEM_s :  std_logic_vector(3 downto 0) ; 
	signal SigneExtendedAddress_ID_EXE_MEM_s :  std_logic_vector(CPUSize-1 downto 0) ;
	signal ShiftedData_ID_EXE_MEM_s :  std_logic_vector(CPUSize-1 downto 0) ;
	signal WriteRegister_ID_EXE_MEM_s :  std_logic_vector(3 downto 0) ;  
	signal MemRead_ID_EXE_MEM_s :  std_logic ; 
	signal MemWrite_ID_EXE_MEM_s : std_logic ; 
	signal AlUSrc1_ID_EXE_MEM_s :  std_logic_vector(1 downto 0);
	signal AlUSrc2_ID_EXE_MEM_s :  std_logic_vector(1 downto 0);
	signal BAWrite_ID_EXE_MEM_s :  std_logic ; 
	signal MemDataSRt_ID_EXE_MEM_s :  std_logic ;  
	signal MemAddressSRC_ID_EXE_MEM_s :  std_logic ; 
	signal RegWrite_ID_EXE_MEM_s :  std_logic ; 
	signal MemtoReg_ID_EXE_MEM_s :  std_logic_vector(1 downto 0) ; 
	signal ALUOp_ID_EXE_MEM_s :  std_logic_vector(3 downto 0)  ; 
	signal MemCLRaddress_s :  std_logic_vector(CPUSize-1 downto 0) ; 
	
	
	signal AluOut_Ex : std_logic_vector(CPUSize-1 downto 0) ;
	signal Reg_Data_Ex : std_logic_vector(CPUSize-1 downto 0) ; -- to reg ex/mem; 

	
	signal MemtoReg_ID_MEM_WB_s : std_logic_vector(1 downto 0);
	signal AluOut_MEM_WB_s : std_logic_vector(CPUSize-1 downto 0);
	signal MemReadData_ID_MEM_WB_s : std_logic_vector(CPUSize-1 downto 0);
	signal WriteRegister_ID_MEM_WB_s : std_logic_vector(3 downto 0);
	signal RegWrite_ID_MEM_WB_s : std_logic;
	signal RD_data_MEM_WB_s : std_logic_vector(CPUSize-1 downto 0);	 
	
	signal MemDataSRC_ID_EXE_MEM_s : std_logic; 
	signal MemCLRaddress_ID_EXE_MEM_s : std_logic_vector( CPUSize-1 downto 0);	
	
	
	signal RDregister_ID_MEM_WB_s : std_logic_vector(3 downto 0);
	signal Rsregister_ID_MEM_WB_s : std_logic_vector(3 downto 0);
	signal MemRead_ID_MEM_WB_s : std_logic;
	signal MemWrite_ID_MEM_WB_s : std_logic;
	signal MemCLRaddress_ID_MEM_WB_s : std_logic_vector(CPUSize-1 downto 0);
	signal MemDataSRC_ID_MEM_WB_s : std_logic_vector(1 downto 0);
	signal MemAddressSRC_ID_MEM_WB_s : std_logic_vector(1 downto 0);
	signal Reg_data_MEM_WB_s : std_logic_vector( CPUSize-1 downto 0);	
	
	begin 
		
		
	IFU : 
		 IF_Unit port map (
		 	clk => clk ,  
		 	rst => rst ,  
			IsBranch => Branch_s , 
			Zflag => Z_s , 
			Jump => Jump_s , 
			BranchingDest => BranchingDest_s , 
			JumpingDest => JumpingDest_s , 
			initInstructions => initInsts ,  
			PC_Out => PC_s , 
			InsOut => InsOut_s , 
			IsFlush => Flush_s 
		);
	
	  
	IF_ID : 	
			IF_ID_Register port map (
				clk => clk ,  
				Flush => Flush_s , 
				IF_ID_Write => '1' , 
				Next_PC_IN =>  PC_s , 
				Ins_In => InsOut_s , 
				Next_PC_out => Next_PC_s , 
				Ins_out => Next_InsOut_s 
			);
	
	
	
	DecodeU : 
		DecoderUnit  port map (		   
			clk => clk ,  
			rst => rst , 
			RegWriteIn => RegWrite_ID_MEM_WB_s  ,
			Z  => ZAlu_s , 
			N  => NAlu_s , 
			C  => CAlu_s , 
			O  => OAlu_s , 
			Instruction => Next_InsOut_s  , 
			PC_next => Next_PC_s , 
			writeRegister => writeRegister_s , 
			writeDataIN => writeDataIN_s , 
			-- out puts 
			Read1 => Read1_Dec,
			Read2 => Read2_Dec ,
			RDregister => RDregister_Dec , 
			Rsregister => Rsregister_Dec , 
			WriteReg => WriteReg_Dec , 
			SigneExtendedAddress => SigneExtendedAddress_Dec  , 
			ShiftedData => ShiftedData_Dec , 
			BranchDest  => BranchingDest_s  ,  
			JumpingDest => JumpingDest_Dec , 
			JumpOut => jump_s , 	 --  --to instruction fetch 
			BranchOut => Branch_s , 
			MemReadOut => MemReadOut_Dec ,  -- to id/ex
			MemWriteOut => MemWriteOut_Dec  , 
			AlUSrcOut1 => AlU_SrcOut_Dec1 , 
			AlUSrcOut2 => AlU_SrcOut_Dec2 , 
			BAWriteOut => BAWriteOut_Dec , 
			MemDataSRCOut => MemDataSRCOut_Dec , 
			MemAddressSRCOut => MemAddressSRCOut_Dec , 
			RegWriteOut => RegWriteOut_Dec  , 
			MemtoRegOut => MemtoRegOut_Dec , 
			ALUOpOut => ALUOpOut_Dec , 
			Zout => Z_s ,
			Nout => Nout , 
			Cout => Cout , 
			Oout => Oout , -- z to fetch 
			MemCLRaddress => MemCLRaddress_Dec 
		);

	 
	ID_Ex : 	
		ID_EX_reg port map (	
			clk => clk ,  
			rst => rst ,  	  
			ID_EX_Write => '1' , 
			ReadIn1 => Read1_Dec , 
			ReadIn2 => Read2_Dec ,
			RDregisterIn => RDregister_Dec , 
			RsregisterIn => Rsregister_Dec  , 
			SigneExtendedAddressIn => SigneExtendedAddress_Dec  , 
			ShiftedDataIn => ShiftedData_Dec , 
			WriteRegisterIn => WriteReg_Dec , 
			MemReadIn => MemReadOut_Dec , 
			MemWriteIn => MemWriteOut_Dec , 
			AlUSrcIn1 => AlU_SrcOut_Dec1 , 
			AlUSrcIn2 => AlU_SrcOut_Dec2 , 
			BAWriteIn => BAWriteOut_Dec , 
			MemDataSRCIn => MemDataSRCOut_Dec , 
			MemAddressSRCIn => MemAddressSRCOut_Dec , 
			RegWriteIn => RegWriteOut_Dec , 
			MemtoRegIn => MemtoRegOut_Dec , 
			ALUOpIn => ALUOpOut_Dec ,
			MemCLRaddressIn => MemCLRaddress_Dec , 
			
			-- out put signals  of 	ID_EX REG 
			ReadOut1 => Read1_ID_EXE_MEM_s,
			ReadOut2  => Read2_ID_EXE_MEM_s,
			RDregisterOut => RDregister_ID_EXE_MEM_s,   
			RsregisterOut  => Rsregister_ID_EXE_MEM_s, 
			SigneExtendedAddressOut  => SigneExtendedAddress_ID_EXE_MEM_s,
			ShiftedDataOut  => ShiftedData_ID_EXE_MEM_s,
			WriteRegisterOut  => WriteRegister_ID_EXE_MEM_s, -- number of write register ; 
			MemReadOut 	 => MemRead_ID_EXE_MEM_s,
			MemWriteOut  => MemWrite_ID_EXE_MEM_s,
			AlUSrcOut1  => AlUSrc1_ID_EXE_MEM_s,
			AlUSrcOut2  => AlUSrc2_ID_EXE_MEM_s,
			BAWriteOut  => BAWrite_ID_EXE_MEM_s,
			MemDataSRCOut => MemDataSRC_ID_EXE_MEM_s ,   
			MemAddressSRCOut => MemAddressSRC_ID_EXE_MEM_s ,  
			RegWriteOut => RegWrite_ID_EXE_MEM_s,
			MemtoRegOut => MemtoReg_ID_EXE_MEM_s,  
			ALUOpOut  => ALUOp_ID_EXE_MEM_s,   
			MemCLRaddressOut => MemCLRaddress_ID_EXE_MEM_s
	);

	
	
	ExU : 
		 ExecuteUnit Port Map
			( 
				clk => clk ,  
				rst => rst , 
				Read1 => Read1_ID_EXE_MEM_s,
				Read2 => Read2_ID_EXE_MEM_s,
				SigneExtendedAddress => SigneExtendedAddress_ID_EXE_MEM_s,
				ShiftedData => ShiftedData_ID_EXE_MEM_s,
				-- exe signals 
				AluSRC1 => AlUSrc1_ID_EXE_MEM_s,
				AluSRC2 => AlUSrc2_ID_EXE_MEM_s,
				BAWrite => BAWrite_ID_EXE_MEM_s,
				AluOP => ALUOp_ID_EXE_MEM_s,		
				-- out put signals 
				AluOut => AluOut_Ex , 
				Reg_data => Reg_Data_Ex , 
				Oout => OAlu_s	,
				Cout => CAlu_s ,
		    	Zout => ZAlu_s ,
		    	Nout => NAlu_s 
			);	
			
	
	   
			
	EX_MEM : 
			EX_Mem_reg port MAP (
				clk => clk ,  
				rst => rst , 
				EX_MEM_Write => '1' , 
				
				-- from id/ex 
				RDregisterIn => RDregister_ID_EXE_MEM_s,
	            RsregisterIn => Rsregister_ID_EXE_MEM_s,
	            MemReadIn => MemRead_ID_EXE_MEM_s,
	            MemWriteIn => MemWrite_ID_EXE_MEM_s,
	            MemCLRaddressIn => MemCLRaddress_ID_EXE_MEM_s,
	            MemDataSRCIn => MemDataSRC_ID_EXE_MEM_s,
	            MemAddressSRCIn => MemAddressSRC_ID_EXE_MEM_s,
	            WriteRegisterIn => WriteRegister_ID_EXE_MEM_s,
	            RegWriteIn => RegWrite_ID_EXE_MEM_s,
	            MemtoRegIn => MemtoReg_ID_EXE_MEM_s,
	            RD_DataIn => Read2_ID_EXE_MEM_s,
				-- from exe 
			   	AluOut1 => AluOut_Ex , 
				Reg_DataIn => Reg_Data_Ex , 
				
				RDregisterOut => RDregister_ID_MEM_WB_s,
	            RsregisterOut => Rsregister_ID_MEM_WB_s,
	            MemReadOut => MemRead_ID_MEM_WB_s,
	            MemWriteOut => MemWrite_ID_MEM_WB_s,
	            MemCLRaddressOut => MemCLRaddress_ID_MEM_WB_s,
	            MemDataSRCOut => MemDataSRC_ID_MEM_WB_s,
	            MemAddressSRCOut => MemAddressSRC_ID_MEM_WB_s,
	            WriteRegisterOut => WriteRegister_ID_MEM_WB_s,
	            RegWriteOut => RegWrite_ID_MEM_WB_s,
	            MemtoRegOut => MemtoReg_ID_MEM_WB_s,
	            RD_DataOut => RD_data_MEM_WB_s,
	            Reg_DataOut => Reg_data_MEM_WB_s,
	            AluOut2 => AluOut_MEM_WB_s
					
			);	 
			

	MEMu : 
			MemoryUnit port map (
				clk => clk,
	            rst => rst,
	            MemRead => MemRead_ID_MEM_WB_s,
	            MemWrite => MemWrite_ID_MEM_WB_s,
	            MemDataSRC => MemDataSRC_ID_MEM_WB_s,
	            MemAddressSRC => MemAddressSRC_ID_MEM_WB_s,
	            RegData => Reg_data_MEM_WB_s,
	            AluOut => AluOut_MEM_WB_s,
	            CLRaddressIn => MemCLRaddress_ID_MEM_WB_s,	
				-- out put
	            MemReadData => MemReadData_ID_MEM_WB_s
			);
			
	MEM_WB_REG : 
			Mem_WB_reg port map 
			(
				clk => clk,
	            rst => rst,
	            MEM_WB_Write => '1',
	            MemToregIn => MemtoReg_ID_MEM_WB_s,
	            AluOutIn => AluOut_MEM_WB_s,
	            MemoutIn => MemReadData_ID_MEM_WB_s,
	            WriteRegIn => WriteRegister_ID_MEM_WB_s,
	            RegWriteIn => RegWrite_ID_MEM_WB_s,
	            RD_Data_In => RD_data_MEM_WB_s,
	            MemToregOut => MemToReg,
	            AluOutOut => AluOut,
	            MemoutOut => MemoryOut,
	            WriteRegOut => writeRegister_s ,
	            RegWriteOut => RegWrite_ID_MEM_WB_s,
	            RD_Data_Out => RD_data_MEM_WB_s
		);											   
		
	WR_Back : 
		WriteBackUnit port map(
			clk => clk,
            rst => rst,
            MemToReg => MemToReg,
            RD_Data => RD_Data,
            MemoryOut => MemoryOut,
            AluOut => AluOut,
            DataToReg => writeDataIN_s 
		);
		
	
end Pipeline_Arc;