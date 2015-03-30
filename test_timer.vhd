library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY test_timer IS 
END ENTITY test_timer;

ARCHITECTURE arch OF test_timer IS

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

signal t_Clock, t_Load, t_Start, t_Time_Out 																:		STD_LOGIC;
signal t_LCD_Out_Seconds, LCD_Out_seconds_tens, LCD_Out_minutes, LCD_OUT_minutes_tens 		:		STD_LOGIC_VECTOR(7 downto 0);
signal t_Data_In																									:		STD_LOGIC_VECTOR(15 downto 0);

BEGIN
 my_design: Timer port map (t_Clock, t_Load, t_Start, t_Data_In, t_Time_Out, t_LCD_Out_Seconds, LCD_Out_seconds_tens, LCD_Out_minutes,LCD_OUT_minutes_tens);
 Clock_init: process
 begin
	wait for 10 ns;
	t_Clock <= '1';
	wait for 10 ns;
	t_Clock <= '0';
 end process Clock_init;
 
 Start_init: process
 begin
	t_Start <= '0', '1' after 100 us;
 wait;
 End process Start_init;
 
 Load_init: process
 begin
	t_Load <= '0', '1' after 20 ns;
 wait;
 End process Load_init;

 t_Data_In <= "0001010000100110";
 
END arch;