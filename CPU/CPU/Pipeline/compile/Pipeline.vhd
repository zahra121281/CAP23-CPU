-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : Pipeline
-- Author      : ASUS
-- Company     : za33
--
-------------------------------------------------------------------------------
--
-- File        : F:\uni\CA\project\CPU (3)\CPU\Pipeline\compile\Pipeline.vhd
-- Generated   : Sun Jul  9 21:00:43 2023
-- From        : F:\uni\CA\project\CPU (3)\CPU\Pipeline\src\Pipeline.bde
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
use std.TEXTIO.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.MATH_REAL.UNIFORM;
use ieee.STD_LOGIC_TEXTIO.all;

entity Pipeline is
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       initInsts : in Mem_Array;
       Oout : out STD_LOGIC;
       Cout : out STD_LOGIC;
       Zout : out STD_LOGIC;
       Nout : out STD_LOGIC
  );
end Pipeline;

architecture Pipeline_Arc of Pipeline is

begin

end Pipeline_Arc;
