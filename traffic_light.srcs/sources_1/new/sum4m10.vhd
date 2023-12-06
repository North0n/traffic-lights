----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.11.2023 15:19:49
-- Design Name: 
-- Module Name: sum4m10 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sum4m10 is
 Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
        B : in STD_LOGIC_VECTOR (3 downto 0);
        Cin : in STD_LOGIC;
        Sum : out STD_LOGIC_VECTOR (3 downto 0);
        Cout : out STD_LOGIC);
end sum4m10;

architecture Behavioral of sum4m10 is

begin
    process(A, B, Cin)
        variable temp_sum : INTEGER;
    begin
        temp_sum := TO_INTEGER(UNSIGNED(A)) - TO_INTEGER(UNSIGNED(B)) - TO_INTEGER(unsigned'("" & Cin));
        
        if temp_sum >= 0 then
            Sum <= STD_LOGIC_VECTOR(TO_UNSIGNED(temp_sum, 4));
            Cout <= '0';
        else
            Sum <= STD_LOGIC_VECTOR(TO_UNSIGNED(temp_sum + 10, 4));
            Cout <= '1';
        end if;
    end process;
end Behavioral;
