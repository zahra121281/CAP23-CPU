-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : Pipeline
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : F:\uni\CA\project\CPU (3)\CPU\Pipeline\compile\insidePipeline.vhd
-- Generated   : Mon Jul 10 08:02:30 2023
-- From        : F:\uni\CA\project\CPU (3)\CPU\Pipeline\src\insidePipeline.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library IEEE;
library work;
use IEEE.std_logic_1164.all;
use work.p_avg.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_unsigned.all;

entity Fub2 is
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       initInsts : in Mem_Array;
       Oout : out STD_LOGIC;
       Cout : out STD_LOGIC;
       Zout : out STD_LOGIC;
       Nout : out STD_LOGIC
  );
end Fub2;

architecture insidePipeline of Fub2 is

---- Component declarations -----

component DecoderUnit2
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       RegWriteIn : in STD_LOGIC;
       Z : in STD_LOGIC;
       N : in STD_LOGIC;
       C : in STD_LOGIC;
       O : in STD_LOGIC;
       Instruction : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       PC_next : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       writeRegister : in STD_LOGIC_VECTOR(3 downto 0);
       writeDataIN : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       Read1 : out STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       Read2 : out STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       RDregister : out STD_LOGIC_VECTOR(3 downto 0);
       Rsregister : out STD_LOGIC_VECTOR(3 downto 0);
       WriteReg : out STD_LOGIC_VECTOR(3 downto 0);
       SigneExtendedAddress : out STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       ShiftedData : out STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       BranchDest : out STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       JumpingDest : out STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       JumpOut : out STD_LOGIC;
       BranchOut : out STD_LOGIC;
       MemReadOut : out STD_LOGIC;
       MemWriteOut : out STD_LOGIC;
       AlUSrcOut1 : out STD_LOGIC_VECTOR(1 downto 0);
       AlUSrcOut2 : out STD_LOGIC_VECTOR(1 downto 0);
       BAWriteOut : out STD_LOGIC;
       MemDataSRCOut : out STD_LOGIC;
       MemAddressSRCOut : out STD_LOGIC;
       RegWriteOut : out STD_LOGIC;
       MemtoRegOut : out STD_LOGIC_VECTOR(1 downto 0);
       ALUOpOut : out STD_LOGIC_VECTOR(3 downto 0);
       Zout : out STD_LOGIC;
       Nout : out STD_LOGIC;
       Cout : out STD_LOGIC;
       Oout : out STD_LOGIC;
       MemCLRaddress : out STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       ZandBranch : out STD_LOGIC
  );
end component;
component ExecuteUnit
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       Read1 : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       Read2 : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       SigneExtendedAddress : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       ShiftedData : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       AluSRC1 : in STD_LOGIC_VECTOR(1 downto 0);
       AluSRC2 : in STD_LOGIC_VECTOR(1 downto 0);
       BAWrite : in STD_LOGIC;
       AluOP : in STD_LOGIC_VECTOR(3 downto 0);
       AluOut : out STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       Reg_data : out STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       Oout : out STD_LOGIC;
       Cout : out STD_LOGIC;
       Zout : out STD_LOGIC;
       Nout : out STD_LOGIC
  );
end component;
component EX_Mem_reg
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       EX_MEM_Write : in STD_LOGIC;
       RDregisterIn : in STD_LOGIC_VECTOR(3 downto 0);
       RsregisterIn : in STD_LOGIC_VECTOR(3 downto 0);
       MemReadIn : in STD_LOGIC;
       MemWriteIn : in STD_LOGIC;
       MemCLRaddressIn : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       MemDataSRCIn : in STD_LOGIC;
       MemAddressSRCIn : in STD_LOGIC;
       WriteRegisterIn : in STD_LOGIC_VECTOR(3 downto 0);
       RegWriteIn : in STD_LOGIC;
       MemtoRegIn : in STD_LOGIC_VECTOR(1 downto 0);
       RD_DataIn : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       AluOut1 : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       Reg_DataIn : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       RDregisterOut : out STD_LOGIC_VECTOR(3 downto 0);
       RsregisterOut : out STD_LOGIC_VECTOR(3 downto 0);
       MemReadOut : out STD_LOGIC;
       MemWriteOut : out STD_LOGIC;
       RegWriteOut : out STD_LOGIC;
       MemtoRegOut : out STD_LOGIC_VECTOR(1 downto 0);
       MemCLRaddressOut : out STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       MemDataSRCOut : out STD_LOGIC;
       MemAddressSRCOut : out STD_LOGIC;
       WriteRegisterOut : out STD_LOGIC_VECTOR(3 downto 0);
       RD_DataOut : out STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       Reg_DataOut : out STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       AluOut2 : out STD_LOGIC_VECTOR(CPUSize-1 downto 0)
  );
end component;
component ID_EX_reg
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       ID_EX_Write : in STD_LOGIC;
       ReadIn1 : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       ReadIn2 : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       RDregisterIn : in STD_LOGIC_VECTOR(3 downto 0);
       RsregisterIn : in STD_LOGIC_VECTOR(3 downto 0);
       SigneExtendedAddressIn : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       ShiftedDataIn : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       WriteRegisterIn : in STD_LOGIC_VECTOR(3 downto 0);
       MemReadIn : in STD_LOGIC;
       MemWriteIn : in STD_LOGIC;
       AlUSrcIn1 : in STD_LOGIC_VECTOR(1 downto 0);
       AlUSrcIn2 : in STD_LOGIC_VECTOR(1 downto 0);
       BAWriteIn : in STD_LOGIC;
       MemDataSRCIn : in STD_LOGIC;
       MemAddressSRCIn : in STD_LOGIC;
       RegWriteIn : in STD_LOGIC;
       MemtoRegIn : in STD_LOGIC_VECTOR(1 downto 0);
       ALUOpIn : in STD_LOGIC_VECTOR(3 downto 0);
       MemCLRaddressIn : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       ReadOut1 : out STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       ReadOut2 : out STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       RDregisterOut : out STD_LOGIC_VECTOR(3 downto 0);
       RsregisterOut : out STD_LOGIC_VECTOR(3 downto 0);
       SigneExtendedAddressOut : out STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       ShiftedDataOut : out STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       WriteRegisterOut : out STD_LOGIC_VECTOR(3 downto 0);
       MemReadOut : out STD_LOGIC;
       MemWriteOut : out STD_LOGIC;
       AlUSrcOut1 : out STD_LOGIC_VECTOR(1 downto 0);
       AlUSrcOut2 : out STD_LOGIC_VECTOR(1 downto 0);
       BAWriteOut : out STD_LOGIC;
       MemDataSRCOut : out STD_LOGIC;
       MemAddressSRCOut : out STD_LOGIC;
       RegWriteOut : out STD_LOGIC;
       MemtoRegOut : out STD_LOGIC_VECTOR(1 downto 0);
       ALUOpOut : out STD_LOGIC_VECTOR(3 downto 0);
       MemCLRaddressOut : out STD_LOGIC_VECTOR(CPUSize-1 downto 0)
  );
end component;
component IF_ID_Register
  port(
       clk : in STD_LOGIC;
       Flush : in STD_LOGIC;
       IF_ID_Write : in STD_LOGIC;
       Next_PC_IN : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       Ins_In : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       Next_PC_out : out STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       Ins_out : out STD_LOGIC_VECTOR(CPUSize-1 downto 0)
  );
end component;
component IF_Unit2
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       ZandBranch : in STD_LOGIC;
       Jump : in STD_LOGIC;
       BranchingDest : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       JumpingDest : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       initInstructions : in Mem_Array;
       PC_Out : out STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       InsOut : out STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       IsFlush : out STD_LOGIC
  );
end component;
component MemoryUnit
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       MemRead : in STD_LOGIC;
       MemWrite : in STD_LOGIC;
       MemDataSRC : in STD_LOGIC;
       MemAddressSRC : in STD_LOGIC;
       RegData : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       AluOut : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       CLRaddressIn : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       MemReadData : out STD_LOGIC_VECTOR(CPUSize-1 downto 0)
  );
end component;
component Mem_WB_reg
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       MEM_WB_Write : in STD_LOGIC;
       MemToregIn : in STD_LOGIC_VECTOR(1 downto 0);
       AluOutIn : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       MemoutIn : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       WriteRegIn : in STD_LOGIC_VECTOR(3 downto 0);
       RegWriteIn : in STD_LOGIC;
       RD_Data_In : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       MemToregOut : out STD_LOGIC_VECTOR(1 downto 0);
       AluOutOut : out STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       MemoutOut : out STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       WriteRegOut : out STD_LOGIC_VECTOR(3 downto 0);
       RegWriteOut : out STD_LOGIC;
       RD_Data_Out : out STD_LOGIC_VECTOR(CPUSize-1 downto 0)
  );
end component;
component WriteBackUnit
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       MemToReg : in STD_LOGIC_VECTOR(1 downto 0);
       RD_Data : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       MemoryOut : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       AluOut : in STD_LOGIC_VECTOR(CPUSize-1 downto 0);
       DAtaToReg : out STD_LOGIC_VECTOR(CPUSize-1 downto 0)
  );
end component;

----     Constants     -----
constant DANGLING_INPUT_CONSTANT : STD_LOGIC := 'Z';

---- Signal declarations used on the diagram ----

signal NET1175 : STD_LOGIC;
signal NET1461 : STD_LOGIC;
signal NET1507 : STD_LOGIC;
signal NET1520 : STD_LOGIC;
signal NET1536 : STD_LOGIC;
signal NET1864 : STD_LOGIC;
signal NET1882 : STD_LOGIC;
signal NET1890 : STD_LOGIC;
signal NET1914 : STD_LOGIC;
signal NET1932 : STD_LOGIC;
signal NET1970 : STD_LOGIC;
signal NET1974 : STD_LOGIC;
signal NET1986 : STD_LOGIC;
signal NET2057 : STD_LOGIC;
signal NET2168 : STD_LOGIC;
signal NET2272 : STD_LOGIC;
signal NET3128 : STD_LOGIC;
signal NET624 : STD_LOGIC;
signal NET768 : STD_LOGIC;
signal NET776 : STD_LOGIC;
signal NET815 : STD_LOGIC;
signal NET827 : STD_LOGIC;
signal NET847 : STD_LOGIC;
signal NET851 : STD_LOGIC;
signal BUS1247 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS1602 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS1610 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS1618 : STD_LOGIC_VECTOR(3 downto 0);
signal BUS1630 : STD_LOGIC_VECTOR(3 downto 0);
signal BUS1642 : STD_LOGIC_VECTOR(3 downto 0);
signal BUS1662 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS1696 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS1708 : STD_LOGIC_VECTOR(1 downto 0);
signal BUS1716 : STD_LOGIC_VECTOR(1 downto 0);
signal BUS1724 : STD_LOGIC_VECTOR(3 downto 0);
signal BUS1732 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS1742 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS1750 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS1766 : STD_LOGIC_VECTOR(3 downto 0);
signal BUS1774 : STD_LOGIC_VECTOR(3 downto 0);
signal BUS1792 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS1805 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS1815 : STD_LOGIC_VECTOR(1 downto 0);
signal BUS1819 : STD_LOGIC_VECTOR(1 downto 0);
signal BUS1823 : STD_LOGIC_VECTOR(1 downto 0);
signal BUS1827 : STD_LOGIC_VECTOR(3 downto 0);
signal BUS1831 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS1874 : STD_LOGIC_VECTOR(1 downto 0);
signal BUS1902 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS1978 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS2019 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS2023 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS2037 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS2049 : STD_LOGIC_VECTOR(1 downto 0);
signal BUS2065 : STD_LOGIC_VECTOR(3 downto 0);
signal BUS2097 : STD_LOGIC_VECTOR(1 downto 0);
signal BUS2101 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS2109 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS2121 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS2148 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS2184 : STD_LOGIC_VECTOR(3 downto 0);
signal BUS637 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS649 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS676 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS689 : STD_LOGIC_VECTOR(15 downto 0);
signal NET1425 : STD_LOGIC_VECTOR(15 downto 0);
signal NET1429 : STD_LOGIC_VECTOR(15 downto 0);

---- Declaration for Dangling input ----
signal Dangling_Input_Signal : STD_LOGIC;

begin

----  Component instantiations  ----

U1 : ExecuteUnit
  port map(
       clk => clk,
       rst => Dangling_Input_Signal,
       Read1 => BUS1732,
       Read2 => NET1425,
       SigneExtendedAddress => NET1429,
       ShiftedData => BUS1696 ,
       AluSRC1 => BUS1708,
       AluSRC2 => BUS1716,
       BAWrite => NET1461,
       AluOP => BUS1724,
       AluOut => BUS1602 ,
       Reg_data => BUS1610 ,
       Oout => NET1507,
       Cout => NET1507,
       Zout => NET1536,
       Nout => NET1520
  );

U10 : IF_Unit2
  port map(
       clk => clk,
       rst => Dangling_Input_Signal,
       ZandBranch => NET3128,
       Jump => NET1175,
       BranchingDest => BUS1247 ,
       JumpingDest => BUS1247 ,
       initInstructions => initInsts,
       PC_Out => BUS649 ,
       InsOut => BUS637 ,
       IsFlush => NET624
  );

U11 : WriteBackUnit
  port map(
       clk => clk,
       rst => Dangling_Input_Signal,
       MemToReg => BUS2097,
       RD_Data => BUS2121(15 downto 0),
       MemoryOut => BUS2109(15 downto 0),
       AluOut => BUS2101(15 downto 0),
       DAtaToReg => BUS2148(15 downto 0)
  );

U12 : DecoderUnit2
  port map(
       clk => clk,
       rst => Dangling_Input_Signal,
       RegWriteIn => NET2168,
       Z => NET1536,
       N => NET1520,
       C => NET1507,
       O => NET1507,
       Instruction => BUS676(15 downto 0),
       PC_next => BUS689(15 downto 0),
       writeRegister => BUS2184,
       writeDataIN => BUS2148(15 downto 0),
       Read1 => BUS1742(15 downto 0),
       Read2 => BUS1750(15 downto 0),
       RDregister(3) => BUS1792(7),
       RDregister(2) => BUS1792(6),
       RDregister(1) => BUS1792(5),
       RDregister(0) => BUS1792(4),
       Rsregister => BUS1766,
       WriteReg => BUS1774,
       SigneExtendedAddress => BUS1805(15 downto 0),
       ShiftedData => BUS1792(15 downto 0),
       BranchDest => BUS1247(15 downto 0),
       JumpingDest => BUS1247(15 downto 0),
       JumpOut => NET1175,
       MemReadOut => NET851,
       MemWriteOut => NET847,
       AlUSrcOut1 => BUS1815,
       AlUSrcOut2 => BUS1819,
       BAWriteOut => NET768,
       MemDataSRCOut => NET776,
       MemAddressSRCOut => NET815,
       RegWriteOut => NET827,
       MemtoRegOut => BUS1823,
       ALUOpOut => BUS1827,
       Zout => Zout,
       Nout => Nout,
       Cout => Cout,
       Oout => Oout,
       MemCLRaddress => BUS1831(15 downto 0),
       ZandBranch => NET3128
  );

U3 : IF_ID_Register
  port map(
       clk => clk,
       Flush => NET624,
       IF_ID_Write => Dangling_Input_Signal,
       Next_PC_IN => BUS649(15 downto 0),
       Ins_In => BUS637(15 downto 0),
       Next_PC_out => BUS689(15 downto 0),
       Ins_out => BUS676(15 downto 0)
  );

U4 : EX_Mem_reg
  port map(
       clk => clk,
       rst => Dangling_Input_Signal,
       EX_MEM_Write => Dangling_Input_Signal,
       RDregisterIn => BUS1618,
       RsregisterIn => BUS1630,
       MemReadIn => NET1914,
       MemWriteIn => NET1932,
       MemCLRaddressIn => BUS1902(15 downto 0),
       MemDataSRCIn => NET1890,
       MemAddressSRCIn => NET1882,
       WriteRegisterIn => BUS1642,
       RegWriteIn => NET1864,
       MemtoRegIn => BUS1874,
       RD_DataIn => BUS1662(15 downto 0),
       AluOut1 => BUS1602(15 downto 0),
       Reg_DataIn => BUS1610(15 downto 0),
       MemReadOut => NET1970,
       MemWriteOut => NET1974,
       RegWriteOut => NET2057,
       MemtoRegOut => BUS2049,
       MemCLRaddressOut => BUS1978(15 downto 0),
       MemDataSRCOut => NET1986,
       MemAddressSRCOut => NET2272,
       WriteRegisterOut => BUS2065,
       RD_DataOut => BUS2121,
       Reg_DataOut => BUS2019,
       AluOut2 => BUS2023
  );

U6 : ID_EX_reg
  port map(
       clk => clk,
       rst => Dangling_Input_Signal,
       ID_EX_Write => Dangling_Input_Signal,
       ReadIn1 => BUS1742(15 downto 0),
       ReadIn2 => BUS1750(15 downto 0),
       RDregisterIn(3) => BUS1792(7),
       RDregisterIn(2) => BUS1792(6),
       RDregisterIn(1) => BUS1792(5),
       RDregisterIn(0) => BUS1792(4),
       RsregisterIn => BUS1766,
       SigneExtendedAddressIn => BUS1805(15 downto 0),
       ShiftedDataIn => BUS1792(15 downto 0),
       WriteRegisterIn => BUS1774,
       MemReadIn => NET851,
       MemWriteIn => NET847,
       AlUSrcIn1 => BUS1815,
       AlUSrcIn2 => BUS1819,
       BAWriteIn => NET768,
       MemDataSRCIn => NET776,
       MemAddressSRCIn => NET815,
       RegWriteIn => NET827,
       MemtoRegIn => BUS1823,
       ALUOpIn => BUS1827,
       MemCLRaddressIn => BUS1831(15 downto 0),
       ReadOut1 => BUS1732(15 downto 0),
       ReadOut2 => NET1425(15 downto 0),
       RDregisterOut => BUS1618,
       RsregisterOut => BUS1630,
       SigneExtendedAddressOut => NET1429(15 downto 0),
       ShiftedDataOut => BUS1696(15 downto 0),
       WriteRegisterOut => BUS1642,
       MemReadOut => NET1914,
       MemWriteOut => NET1932,
       AlUSrcOut1 => BUS1708,
       AlUSrcOut2 => BUS1716,
       BAWriteOut => NET1461,
       MemDataSRCOut => NET1890,
       MemAddressSRCOut => NET1882,
       RegWriteOut => NET1864,
       MemtoRegOut => BUS1874,
       ALUOpOut => BUS1724,
       MemCLRaddressOut => BUS1902(15 downto 0)
  );

U7 : MemoryUnit
  port map(
       clk => clk,
       rst => Dangling_Input_Signal,
       MemRead => NET1970,
       MemWrite => NET1974,
       MemDataSRC => NET1986,
       MemAddressSRC => NET2272,
       RegData => BUS2019(15 downto 0),
       AluOut => BUS2023(15 downto 0),
       CLRaddressIn => BUS1978(15 downto 0),
       MemReadData => BUS2037(15 downto 0)
  );

U9 : Mem_WB_reg
  port map(
       clk => clk,
       rst => Dangling_Input_Signal,
       MEM_WB_Write => Dangling_Input_Signal,
       MemToregIn => BUS2049,
       AluOutIn => BUS2023(15 downto 0),
       MemoutIn => BUS2037(15 downto 0),
       WriteRegIn => BUS2065,
       RegWriteIn => NET2057,
       RD_Data_In => BUS2121(15 downto 0),
       MemToregOut => BUS2097,
       AluOutOut => BUS2101(15 downto 0),
       MemoutOut => BUS2109(15 downto 0),
       WriteRegOut => BUS2184,
       RegWriteOut => NET2168,
       RD_Data_Out => BUS2121(15 downto 0)
  );


---- Dangling input signal assignment ----

Dangling_Input_Signal <= DANGLING_INPUT_CONSTANT;	

process 
	variable t1 : integer :=1;	
begin  
	 t1:=t1+1;

end process;

end insidePipeline;
