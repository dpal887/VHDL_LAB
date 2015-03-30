library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
entity BCD_Counter is
   port( Enable: in std_logic;
 	 Clock: in std_logic;
	 Direction: in std_logic;
 	 Reset: in std_logic;
 	 Output: out std_logic_vector(0 to 3));
end BCD_Counter;
 
architecture arch of BCD_Counter is
signal temp: std_logic_vector(0 to 3) := "0000";
begin   
process(Clock)
   begin
      if(Clock'event and Clock='1') then
        if (Reset='1') then
			     if (Direction = '1') then
				      temp <= "0000";
			     else
				      temp <= "1001";
			     end if;
			  
			   elsif Enable ='1' then
				    if(Direction = '1') then
					     if temp="1001" then
						      temp<="0000";
					     else
						      temp <= temp + 1;
					     end if;
				    else
					     if temp="0000" then
						      temp<="1001";
					     else
						      temp <= temp - 1;
					     end if;
				    end if;
			 end if;
		end if;
   end process;
   Output <= temp;
end arch;