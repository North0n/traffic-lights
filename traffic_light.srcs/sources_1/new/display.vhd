library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real."ceil";
use IEEE.math_real."log2";

entity display is
    Generic (N: INTEGER := 8);
    Port ( 
        X : in STD_LOGIC_VECTOR(N * 4 - 1 downto 0);
        CLK : in STD_LOGIC;
        Seg : out STD_LOGIC_VECTOR(6 downto 0);
        An: out STD_LOGIC_VECTOR(N - 1 downto 0);
        Dp: out STD_LOGIC
       );
end display;

architecture Behavioral of display is
component digit_to_segments is
    Port (
        digit: in STD_LOGIC_VECTOR(3 downto 0);
        segments: out STD_LOGIC_VECTOR(6 downto 0)
    );
end component;

signal clk_div : STD_LOGIC_VECTOR(19 downto 0) := (others => '0');
signal curr_seg : STD_LOGIC_VECTOR(2 downto 0);
signal enabled_displays: STD_LOGIC_VECTOR(7 downto 0);
signal digit_to_display: STD_LOGIC_VECTOR(3 downto 0);

begin
    process(clk)
    begin
        if rising_edge(clk) then
            clk_div <= STD_LOGIC_VECTOR(TO_UNSIGNED(TO_INTEGER(UNSIGNED(clk_div)) + 1, clk_div'length));
        end if;
    end process;
    
    Dp <= '1';
    enabled_displays <= "11111111";
    curr_seg <= clk_div(integer(ceil(log2(real(N)))) + 16 downto 17);
        
    process(clk)
        variable index : integer;
        variable temp_ed: STD_LOGIC_VECTOR(7 downto 0);
    begin
        index := TO_INTEGER(UNSIGNED(curr_seg));
        temp_ed := enabled_displays;
        if rising_edge(clk) then
            digit_to_display <= X(index * 4 + 3 downto index * 4);
            temp_ed(index) := '0';
        end if;
        An <= temp_ed;
    end process;
    
    decoder: digit_to_segments PORT MAP (
        digit => digit_to_display,
        segments => Seg
    );
end Behavioral;
