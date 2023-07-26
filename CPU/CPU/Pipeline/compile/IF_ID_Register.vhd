-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : Pipeline
-- Author      : ASUS
-- Company     : za33
--
-------------------------------------------------------------------------------
--
-- File        : F:\uni\CA\project\CPU (3)\CPU\Pipeline\compile\IF_ID_Register.vhd
-- Generated   : Sun Jul  9 21:00:42 2023
-- From        : F:\uni\CA\project\CPU (3)\CPU\Pipeline\src\IF_ID_Register.bde
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

entity IF_ID_Register is
  port(
       clk : in STD_LOGIC;
       Flush : in STD_LOGIC;
       IF_ID_Write : in STD_LOGIC;
       Next_PC_IN : in STD_LOGIC_VECTOR(CPUSize - 1 downto 0);
       Ins_In : in STD_LOGIC_VECTOR(CPUSize - 1 downto 0);
       Next_PC_out : out STD_LOGIC_VECTOR(CPUSize - 1 downto 0);
       Ins_out : out STD_LOGIC_VECTOR(CPUSize - 1 downto 0)
  );
end IF_ID_Register;

architecture IF_ID_ARC of IF_ID_Register is

begin

---- Processes ----

process (clk,Flush)
                       begin
                         if (Flush = '1') then
                            Next_Pc_out <= (others => '0');
                            Ins_out <= (others => '0');
                         else 
                            if (rising_edge(clk) and IF_ID_Write = '1') then
                               Next_PC_out <= Next_PC_IN;
                               Ins_out <= Ins_In;
                            end if;
                         end if;
                       end process;
                      

end IF_ID_ARC;
