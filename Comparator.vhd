LIBRARY ieee;
USE ieee.std_logic_1164.all;



ENTITY Comparator IS
PORT
(
	P_Data 													:	IN		STD_LOGIC_VECTOR(15 downto 0);
	Count_one,Count_two, Count_three, Count_four : 	IN 	STD_LOGIC_VECTOR(3 downto 0);
	timer_out												:	OUT	STD_LOGIC
);

END Comparator;


ARCHITECTURE Comparator_architecture OF Comparator IS


BEGIN

timer_out <= '1' WHEN P_Data = Count_four & Count_three & Count_two & Count_one;

END Comparator_architecture;
