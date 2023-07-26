library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL ; 	
use ieee.math_real.uniform;
use work.p_avg.All ;

 
entity mux2to1 is
  port ( 
  w0      : in  std_logic_vector(15 downto 0);
  w1      : in  std_logic_vector(15 downto 0);
  s    : in  std_logic;
  f       :out std_logic_vector(15 downto 0)); 
end mux2to1;

architecture behaviour of mux2to1 is 
begin
  process (w0, w1, s)
  begin
    if s = '0' then
      f <= w0;
    else
      f <= w1;
    end if;
  end process;
end behaviour;


