-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : Pipeline
-- Author      : ASUS
-- Company     : za33
--
-------------------------------------------------------------------------------
--
-- File        : F:\uni\CA\project\CPU (3)\CPU\Pipeline\compile\ID_EX_reg.vhd
-- Generated   : Sun Jul  9 21:00:41 2023
-- From        : F:\uni\CA\project\CPU (3)\CPU\Pipeline\src\ID_EX_reg.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library pipeline;
use pipeline.p_avg.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.MATH_REAL.UNIFORM;

entity ID_EX_reg is
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       ID_EX_Write : in STD_LOGIC;
       ReadIn1 : in STD_LOGIC_VECTOR(CPUSize - 1 downto 0);
       ReadIn2 : in STD_LOGIC_VECTOR(CPUSize - 1 downto 0);
       RDregisterIn : in STD_LOGIC_VECTOR(3 downto 0);
       RsregisterIn : in STD_LOGIC_VECTOR(3 downto 0);
       SigneExtendedAddressIn : in STD_LOGIC_VECTOR(CPUSize - 1 downto 0);
       ShiftedDataIn : in STD_LOGIC_VECTOR(CPUSize - 1 downto 0);
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
       MemCLRaddressIn : in STD_LOGIC_VECTOR(CPUSize - 1 downto 0);
       ReadOut1 : out STD_LOGIC_VECTOR(CPUSize - 1 downto 0);
       ReadOut2 : out STD_LOGIC_VECTOR(CPUSize - 1 downto 0);
       RDregisterOut : out STD_LOGIC_VECTOR(3 downto 0);
       RsregisterOut : out STD_LOGIC_VECTOR(3 downto 0);
       SigneExtendedAddressOut : out STD_LOGIC_VECTOR(CPUSize - 1 downto 0);
       ShiftedDataOut : out STD_LOGIC_VECTOR(CPUSize - 1 downto 0);
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
       MemCLRaddressOut : out STD_LOGIC_VECTOR(CPUSize - 1 downto 0)
  );
end ID_EX_reg;

architecture ID_EX_ARC of ID_EX_reg is

begin

---- Processes ----

process (clk,rst)
                       begin
                         if (rst = '1') then
                            ReadOut1 <= (others => '0');
                            ReadOut2 <= (others => '0');
                            RDregisterOut <= (others => '0');
                            RsregisterOut <= (others => '0');
                            SigneExtendedAddressOut <= (others => '0');
                            ShiftedDataOut <= (others => '0');
                            WriteRegisterOut <= (others => '0');
                            MemReadOut <= '0';
                            MemWriteOut <= '0';
                            AlUSrcOut1 <= (others => '0');
                            AlUSrcOut2 <= (others => '0');
                            BAWriteOut <= '0';
                            MemDataSRCOut <= '0';
                            MemAddressSRCOut <= '0';
                            RegWriteOut <= '0';
                            MemtoRegOut <= (others => '0');
                            ALUOpOut <= (others => '0');
                            MemCLRaddressOut <= (others => '0');
                         else 
                            if (rising_edge(clk) and ID_EX_Write = '1') then
                               ReadOut1 <= ReadIn1;
                               ReadOut2 <= ReadIn2;
                               RDregisterOut <= RDregisterIn;
                               RsregisterOut <= RsregisterIn;
                               SigneExtendedAddressOut <= SigneExtendedAddressIn;
                               ShiftedDataOut <= ShiftedDataIn;
                               WriteRegisterOut <= WriteRegisterIn;
                               MemReadOut <= MemReadIn;
                               MemWriteOut <= MemWriteIn;
                               AlUSrcOut1 <= AlUSrcIn1;
                               AlUSrcOut2 <= AlUSrcIn2;
                               BAWriteOut <= BAWriteIn;
                               MemDataSRCOut <= MemDataSRCIn;
                               MemAddressSRCOut <= MemAddressSRCIn;
                               RegWriteOut <= RegWriteIn;
                               MemtoRegOut <= MemtoRegIn;
                               ALUOpOut <= ALUOpIn;
                               MemCLRaddressOut <= MemCLRaddressIn;
                            end if;
                         end if;
                       end process;
                      

end ID_EX_ARC;
