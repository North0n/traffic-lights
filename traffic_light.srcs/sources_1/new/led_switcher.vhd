library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity led_switcher is
    Port ( CLK : in STD_LOGIC;
       IS_GREEN: in STD_LOGIC;
       LD17_Red, LD16_Green: out STD_LOGIC
    );
end led_switcher;

architecture Behavioral of led_switcher is
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            LD17_Red <= not IS_GREEN;
            LD16_Green <= IS_GREEN;
        end if;
    end process;
end Behavioral;