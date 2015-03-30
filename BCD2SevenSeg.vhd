library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY BCD2SevenSeg is
PORT(
		digit 	:	IN		STD_LOGIC_VECTOR(3 downto 0);
		all_off	:	IN		STD_LOGIC;
		LED_out	:	OUT	STD_LOGIC_VECTOR(7 downto 0)
);
END ENTITY BCD2SevenSeg;

ARCHITECTURE arc2 OF BCD2SevenSeg is
BEGIN
	PROCESS(digit,all_off)
		BEGIN	
			IF(all_off = '1') THEN
				LED_out <= "11111111";
			ELSE
				CASE digit IS
					WHEN "0000" => Led_out <= "00000011"; --0
					WHEN "0001" => Led_out <= "10011111"; --1
					WHEN "0010" => Led_out <= "00100101"; --2
					WHEN "0011" => Led_out <= "00001101"; --3
					WHEN "0100" => Led_out <= "10011001"; --4
					WHEN "0101" => Led_out <= "01001001"; --5
					WHEN "0110" => Led_out <= "01000001"; --6
					WHEN "0111" => Led_out <= "00011111"; --7
					WHEN "1000" => Led_out <= "00000001"; --8
					WHEN "1001" => Led_out <= "00001001"; --9
					WHEN OTHERS => Led_out <= "11111111"; -- ERR
				END CASE;
			END IF;
		--End
	END PROCESS;
END ARCHITECTURE arc2;
	
					