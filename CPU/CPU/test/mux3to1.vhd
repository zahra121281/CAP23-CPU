library IEEE;
use IEEE.std_logic_1164.all;

entity mux3to1 is
port(
  a1      : in  std_logic_vector(15 downto 0);
  a2      : in  std_logic_vector(15 downto 0);
  a3      : in  std_logic_vector(15 downto 0);
  sel    : in  std_logic_vector(1 downto 0);
  b       :out std_logic_vector(15 downto 0));
end mux3to1;

architecture rtl of mux3to1 is
  -- declarative part: empty
begin

  b <= a1 when (sel = "00") else
       a2 when (sel = "01") else
       a3 ;

end rtl;