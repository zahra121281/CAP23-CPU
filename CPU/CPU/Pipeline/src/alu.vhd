library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity ALU is
  Port (
    A        : in  STD_LOGIC_VECTOR(15 downto 0);
    B        : in  STD_LOGIC_VECTOR(15 downto 0);
    ALU_Sel  : in  STD_LOGIC_VECTOR(3 downto 0);
    ALU_Out  : out STD_LOGIC_VECTOR(15 downto 0);
    Carryout : out std_logic;
    Overflow : out std_logic;
    Z        : out std_logic;
    N        : out std_logic
  );
end ALU; 

architecture Behavioral of ALU is

  signal ALU_Result : std_logic_vector (15 downto 0);
  signal tmp        : std_logic_vector (16 downto 0);

begin
  process(A,B,ALU_Sel)
    variable ALU_Result_signed : signed(15 downto 0);
    variable A_signed          : signed(15 downto 0);
    variable B_signed          : signed(15 downto 0);
  begin
    A_signed := signed(A);
    B_signed := signed(B);
    
    case ALU_Sel is
      when "0000" => -- Addition
        ALU_Result_signed := A_signed + B_signed;
        ALU_Result        <= std_logic_vector(ALU_Result_signed);
        
        if A_signed > 0 and B_signed > 0 and ALU_Result_signed < 0 then
          Overflow <= '1';
        elsif A_signed < 0 and B_signed < 0 and ALU_Result_signed > 0 then
          Overflow <= '1';
        else
          Overflow <= '0';
        end if;
        
      when "0001" => -- Addition with a number
	  ALU_Result <= A + B; 
	  
	  if A_signed > 0 and B_signed > 0 and ALU_Result < 0 then
          Overflow <= '1';
        elsif A_signed < 0 and B_signed < 0 and ALU_Result > 0 then
          Overflow <= '1';
        else
          Overflow <= '0';
        end if;
      
      when "0011" => -- Add immediate
	  ALU_Result <= A + B;
	  if A_signed > 0 and B_signed > 0 and ALU_Result < 0 then
          Overflow <= '1';
        elsif A_signed < 0 and B_signed < 0 and ALU_Result > 0 then
          Overflow <= '1';
        else
          Overflow <= '0';
        end if;
      
      when "0010" => -- Subtraction
        ALU_Result_signed := A_signed - B_signed;
        ALU_Result        <= std_logic_vector(ALU_Result_signed);
        
        if A_signed > 0 and B_signed < 0 and ALU_Result_signed < 0 then
          Overflow <= '1';
        elsif A_signed < 0 and B_signed > 0 and ALU_Result_signed > 0 then
          Overflow <= '1';
        else
          Overflow <= '0';
        end if;
                                                                                                     
      when "0110" => -- Logical shift left
        ALU_Result <= std_logic_vector(shift_left(unsigned(A), to_integer(unsigned(B))));
      
      when "0101" => -- Logical and 
        ALU_Result <= A and B;
      
      when others => 
        ALU_Result <= A + B;
    end case;	 
	
	 -- Set the Z and N output signals based on the ALU_Result
  		
  end process;
  
  ALU_Out <= ALU_Result;
  tmp     <= ('0' & A) + ('0' & B);
  Carryout <= tmp(16);	
  Z <= '1' when ALU_Result = X"0000" else '0';
  		N <= ALU_Result(15);
  
end Behavioral;
