library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY test_timer IS 
END ENTITY test_timer;

ARCHITECTURE arch OF test_timer IS

signal t_Enable, t_Clock, t_Direction, t_Reset, t_Step : STD_LOGIC;
signal t_Output : STD_Logic_vector(11 downto 0);

Component Timer IS
PORT (	    
				Clock 		 								: 		in 	std_logic;
				Load											: 		in 	std_logic;
				Start											: 		in 	std_logic;
				Data_In										: 		in 	std_logic_vector(15 downto 0);
				Time_Out				 						: 		out 	std_logic;
				LCD_Out_seconds, 							--Cont...
				LCD_Out_seconds_tens, 					--Cont...
				LCD_Out_minutes, 							--Cont...
				LCD_OUT_minutes_tens						:		out   std_logic_vector(7 downto 0)
		);
END COMPONENT Timer;
BEGIN

END arch;