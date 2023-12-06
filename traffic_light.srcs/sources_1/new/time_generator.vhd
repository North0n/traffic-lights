----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.11.2023 12:14:23
-- Design Name: 
-- Module Name: time_generator - Behavioral
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

entity time_generator is
    Generic (N: INTEGER := 8);
    Port ( CLK : in STD_LOGIC;
           INIT : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR(N * 4 - 1 downto 0);
           IS_GREEN : out STD_LOGIC);
end time_generator;

architecture Behavioral of time_generator is

component sum4m10 is
 Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
        B : in STD_LOGIC_VECTOR (3 downto 0);
        Cin : in STD_LOGIC;
        Sum : out STD_LOGIC_VECTOR (3 downto 0);
        Cout : out STD_LOGIC);
end component;

component fdce is
    Port ( D : in STD_LOGIC_VECTOR(3 downto 0);
           CE : in STD_LOGIC;
           CLK : in STD_LOGIC;
           INIT : in STD_LOGIC;
           INIT_VEC : in STD_LOGIC_VECTOR;
           Q : out STD_LOGIC_VECTOR(3 downto 0));
end component;

component fdce_1 is
    Port ( D : in STD_LOGIC;
           CE : in STD_LOGIC;
           CLK : in STD_LOGIC;
           CLR : in STD_LOGIC;
           Q : out STD_LOGIC);
end component;


type time_arr is array (0 to N - 1) of STD_LOGIC_VECTOR(3 downto 0);
signal regs_q : time_arr;
signal sums_q : time_arr;
signal couts : STD_LOGIC_VECTOR(N - 2 downto 0);
signal reset : STD_LOGIC := '0';
signal init_or_reset : STD_LOGIC;
signal init_vec : time_arr := (
    X"0",
    X"1",
    X"0",
    X"0",
    X"0",
    X"0",
    X"0",
    X"0"
  );
  
signal qis_green : std_logic;
signal nis_green: std_logic;

begin
    init_or_reset <= INIT or reset;
    nis_green <= not qis_green;

    is_red_process: process(reset)
    begin
        if (qis_green = '0') then
            init_vec <= (
                X"5",
                X"0",
                X"0",
                X"0",
                X"0",
                X"0",
                X"0",
                X"0"
              );
        else
            init_vec <= (
                X"0",
                X"1",
                X"0",
                X"0",
                X"0",
                X"0",
                X"0",
                X"0"
              ); 
        end if;    
    end process;


    IS_RED_FF: fdce_1 port map(D=>nis_green, CE=>reset, CLK=>CLK, CLR=>INIT, Q=>qis_green);

    REGS: FOR J in 0 to N - 1 GENERATE
        REG_J: FDCE port map(D=>sums_q(J), CE=>'1', CLK=>CLK, INIT=>init_or_reset, INIT_VEC=>init_vec(J), Q=>regs_q(J));
    End Generate;
    
    SUM_0: SUM4M10 port map(A=>regs_q(0), B=>"0001", Cin=>'0', Sum=>sums_q(0), Cout=>couts(0));
    SUM_N_1: SUM4M10 port map(A=>regs_q(N - 1), B=>"0000", Cin=>couts(N - 2), Sum=>sums_q(N - 1), Cout=>reset);
    
    SUMS: FOR J in 1 to N - 2 GENERATE
        SUM_J: SUM4M10 port map(A=>regs_q(J), B=>"0000", Cin=>couts(J - 1), Sum=>sums_q(J), Cout=>couts(J));
    End Generate;
    
    OUTS: FOR J in 0 to N - 1 GENERATE
        Q(J * 4 + 0) <= regs_q(J)(0);
        Q(J * 4 + 1) <= regs_q(J)(1);
        Q(J * 4 + 2) <= regs_q(J)(2);
        Q(J * 4 + 3) <= regs_q(J)(3);
    End Generate;

    IS_GREEN <= qis_green;
end Behavioral;
