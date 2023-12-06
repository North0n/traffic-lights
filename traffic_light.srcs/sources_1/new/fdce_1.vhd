----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.11.2023 12:00:23
-- Design Name: 
-- Module Name: fdce - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fdce_1 is
    Port ( D : in STD_LOGIC;
           CE : in STD_LOGIC;
           CLK : in STD_LOGIC;
           CLR : in STD_LOGIC;
           Q : out STD_LOGIC);
end fdce_1;

architecture Behavioral of fdce_1 is
begin
    main: process(D, CE, CLK, CLR)
    begin
        if CE = '1' then
            if rising_edge(CLK) then
                if CLR = '1' then
                    Q <= '0';
                else
                    Q <= D;
                end if;
            end if;
        end if;
    end process;
end Behavioral;
