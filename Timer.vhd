library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Timer is
port (	    
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
end entity Timer;

ARCHITECTURE ARCH OF Timer IS

-------------------------------------------------------------------------------------------------------
--	BCD COUNTER  [Component 1]
--							 ______________
--		ENABLE	 	->	|		BCD		|
--		CLOCK		  	->	|	 COUNTER		|
--		DIRECTION  	->	|		0-9		|=> OUTPUT[3..0]
--		RESET		  	->	|______________|
--							
--		Output +-= 1 until Output = "0000" or "1001"
--
--	USAGE -- 3 Times
--------------------------------------------------------------------------------------------------------
COMPONENT BCD_Counter is
PORT (
	 Enable													: in 	std_logic;
 	 Clock													: in 	std_logic;
	 Direction												: in 	std_logic;
 	 Reset													: in 	std_logic;
 	 Output													: out std_logic_vector(3 downto 0)
	 );
END COMPONENT;

-------------------------------------------------------------------------------------------------------
--	Comparator 
--									 ______________
--		P_Data	 			->	|					|
--		1.1,1.2,1.3,1.4	=>	|	COMPARATOR	|
--		Time_Out  			->	|					|-> OUTPUT
--					  				|______________|
--							
--		Output +-= 1 until Output = "0000" or "1001"
--
--	USAGE -- 3 Times
--------------------------------------------------------------------------------------------------------

COMPONENT Comparator is
PORT (
	P_Data 																						:	IN		STD_LOGIC_VECTOR(15 downto 0);
	Count_one,Count_two, Count_three, Count_four 									: 	IN 	STD_LOGIC_VECTOR(3 downto 0);
	timer_out																					:	OUT	STD_LOGIC
	);
END COMPONENT;

COMPONENT STOREREG is
PORT (
	New_Data																						:	IN		STD_LOGIC_VECTOR(15 downto 0);
	Load																							:	IN		STD_LOGIC;
	clk																							:	IN 	STD_LOGIC;
	Passed_Data																					:	OUT 	STD_LOGIC_VECTOR(15 downto 0)
	);
END COMPONENT;

COMPONENT BCD2SevenSeg is
PORT(
	digit 																						:	IN		STD_LOGIC_VECTOR(3 downto 0);
	all_off																						:	IN		STD_LOGIC;
	LED_out																						:	OUT	STD_LOGIC_VECTOR(7 downto 0)
);
END COMPONENT;

signal e1,e2,e3,e4 																			: STD_LOGIC := '0';
signal Q_out_seconds,Q_out_seconds_tens, Q_out_minutes, Q_out_Minutes_tens : STD_LOGIC_VECTOR(3 downto 0 ) := "0000";
signal r, count 																				: STD_LOGIC := '0';
signal loaded_value 																			: STD_LOGIC_VECTOR(15 downto 0);

	BEGIN
--------------------------------------------------------------------------------------------
--Enables linked via signal
--Clock linked to all inputs
--Direction is set to always up
--Resets are linked
--Outputs are linked to Comparator and decoders
--------------------------------------------------------------------------------------------
	C1 : BCD_Counter 	PORT MAP (e1, Clock, '1', r, Q_out_Seconds);
	C2 : BCD_Counter 	PORT MAP (e2, Clock, '1', r, Q_out_Seconds_tens);
	C3 : BCD_Counter 	PORT MAP (e3, Clock, '1', r, Q_out_Minutes);
	C4 : BCD_Counter 	PORT MAP (e4, Clock, '1', r, Q_out_Minutes_tens);
--------------------------------------------------------------------------------------------
--TODO: Change the '0''s to their expected values
--------------------------------------------------------------------------------------------	
	D1 : BCD2SevenSeg PORT MAP (Q_out_Seconds, 		'0', 	LCD_Out_seconds);
	D2 : BCD2SevenSeg PORT MAP (Q_out_Seconds_tens,	'0',	LCD_Out_seconds_tens);
	D3 : BCD2SevenSeg PORT MAP (Q_out_Minutes, 		'0',	LCD_Out_minutes);
	D4 : BCD2SevenSeg PORT MAP (Q_out_Minutes_tens,	'0',	LCD_OUT_minutes_tens);
	
--------------------------------------------------------------------------------------------
	S 	: STOREREG		PORT MAP	(Data_In,Load,Clock,Loaded_value);
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------	
--
--
--
--------------------------------------------------------------------------------------------	
	Comp : Comparator PORT MAP	(Loaded_value,Q_Out_Seconds,Q_Out_Seconds_tens,Q_out_Minutes,Q_out_Minutes_tens,Time_Out);
--------------------------------------------------------------------------------------------
-- Count is enabled when start becomes 1. First counter begins counting...	
--------------------------------------------------------------------------------------------
	count <= '1' when Start = '1';
--------------------------------------------------------------------------------------------
--			C1	when Start 	= 1
--			C2 when C1 		= 1001 -- 9
--			C3 when C2		= 0101 -- 5
--			C4 when C3		= 1001 -- 9
--------------------------------------------------------------------------------------------	
	e1 <= '1' 	when (count 					= '1'		) 	else '0';
	e2 <= e1 	when (Q_out_Seconds 			= "1001"	) 	else '0';
	e3 <= e2 	when (Q_out_Seconds_tens 	= "0101"	) 	else '0';
	e4 <= e3 	when (Q_out_Minutes			= "1001"	) 	else '0';
--------------------------------------------------------------------------------------------	
	

END ARCHITECTURE ARCH;