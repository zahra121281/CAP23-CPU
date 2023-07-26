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
-- type Mem_Array is array (4000 downto 0) of std_logic_vector(7 downto 0);


entity File_Reader is 
	generic (
      	FILENAME: string  := "Instructions.txt"
    );
	  port ( 
	  	--FILENAME : STRING(1 to 2000000000) ; 
	    clk      : in  std_logic;
	    rst      : in  std_logic;
	    data_out : out Mem_Array;	 
	    eof      : out std_logic
	  );
end File_Reader;

architecture Behavioral of File_Reader is
  file input_file : text open read_mode is FILENAME;
  signal data_array : Mem_array(999 downto 0) := (others => ( others => '0' )) ;	
  signal NUM_LINES : integer := 0 ;	
begin					   
	
  	process (clk, rst)   
	  variable line_counter : integer:= 0;  
	  variable input_line : line ;	
	  variable input_data : std_logic_vector(CPUSize-1 downto 0) ;
	  variable ttt : integer ;	
	  variable bitt : std_logic ; 
	  variable MYByte : std_logic_vector(7 downto 0) ;
  	begin
        if rising_edge(clk) then
		    if (not endfile(input_file) and rst = '0' and line_counter < 1000 ) then
		        readline(input_file, input_line); 
				read( input_line , input_data  ) ;  
		       	ttt := line_counter +1 ; 
 
				for j in 0 to 7 loop	 
					bitt := input_data(15-j);
					data_out(line_counter)(7-j) <= bitt ;
    			end loop;
				
				for j in 0 to 7 loop	 
					bitt := input_data(7-j);
					data_out(line_counter+1)(7-j) <= bitt ;
    			end loop;
				
				line_counter := line_counter+2; 
			  	eof <= '0'; -- Not end of file yet	
			elsif( rst = '1' ) then
		      eof <= '0'; -- Reset EOF signal
		      data_out <= (others => (others => '0')) ; -- Reset data output
		      line_counter := 0; -- Reset line counter
		      data_array <= (others => (others => '0')); -- Reset data array
	      	else
			  eof <= '1'; -- End of file reached 
			  --file_close(input_file); -- Close file on reset  
      		end if;
      end if;		 
  end process;
end architecture Behavioral;