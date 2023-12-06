----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2023 23:50:04
-- Design Name: 
-- Module Name: freq_divider - Behavioral
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

entity freq_divider is
    Generic(
        N: INTEGER := 100000000
    );
    Port ( CLK : in STD_LOGIC;
           Q_CLK : out STD_LOGIC);
end freq_divider;

architecture Behavioral of freq_divider is
    signal q_t : STD_LOGIC := '0';
    signal nq_t: STD_LOGIC;
    signal counter: integer := 0;
begin
    nq_t <= not q_t;
    Divider: process(CLK)
    begin
        if rising_edge(CLK) then
            if counter = (N - 2) / 2 then
                q_t <= nq_t;
                counter <= 0;  
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    Q_CLK <= q_t;
end Behavioral;
