----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2023 00:04:00
-- Design Name: 
-- Module Name: main - Behavioral
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

entity main is
     Port (
        CLK : in STD_LOGIC;
        INIT : in STD_LOGIC;
        Seg: out STD_LOGIC_VECTOR(6 downto 0);
        An: out STD_LOGIC_VECTOR(7 downto 0);
        Dp: out STD_LOGIC
     );
end main;

architecture Behavioral of main is

component freq_divider is
    Generic(
        N: INTEGER := 100000000
    );
    Port ( CLK : in STD_LOGIC;
           Q_CLK : out STD_LOGIC);
end component;

component display is
    Generic (N: INTEGER := 8);
    Port ( 
        X : in STD_LOGIC_VECTOR(N * 4 - 1 downto 0);
        CLK : in STD_LOGIC;
        Seg : out STD_LOGIC_VECTOR(6 downto 0);
        An: out STD_LOGIC_VECTOR(N - 1 downto 0);
        Dp: out STD_LOGIC
    );
end component;

component time_generator is
    Generic (N: INTEGER := 8);
    Port ( CLK : in STD_LOGIC;
           INIT : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR(N * 4 - 1 downto 0);
           IS_GREEN : out STD_LOGIC);
end component;

signal generated_values: STD_LOGIC_VECTOR(31 downto 0);
signal time_clk: STD_LOGIC;
signal is_green: STD_LOGIC;

begin
    divider: freq_divider PORT MAP (
        CLK => CLK,
        Q_CLK => time_clk
    );

    gen: time_generator PORT MAP (
        CLK => time_clk,
        INIT => INIT,
        Q => generated_values,
        IS_GREEN=>is_green
    );
    
    dis: display port MAP (
        CLK => CLK,
        X => generated_values,
        Seg => Seg,
        An => An,
        Dp => Dp
    );
end Behavioral;
