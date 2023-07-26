library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

	 
entity mux2to1 is
  port (w0, w1, s : in std_logic;
     f : out std_logic); 
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