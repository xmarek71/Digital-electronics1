----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.04.2021 20:27:03
-- Design Name: 
-- Module Name: tb_hcsr04 - Behavioral
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

entity tb_hcsr04 is
--  Port ( );
end tb_hcsr04;

architecture Behavioral of tb_hcsr04 is
constant c_CLK_1MHZ_PERIOD : time    := 1 us;
signal s_CLK_1MHZ: std_logic;
signal s_echo: std_logic;
signal s_dist : natural;
begin

p_clk_gen : process
    begin
        while now < 1000 ms loop         -- 75 periods of 100MHz clock
            s_clk_1MHz <= '0';
            wait for c_CLK_1MHZ_PERIOD / 2;
            s_clk_1MHz <= '1';
            wait for c_CLK_1MHZ_PERIOD / 2;
        end loop;
        wait;                           -- Process is suspended forever
    end process p_clk_gen;

hcsr04: entity work.hcsr04
    port map(
            clk_i   => s_CLK_1MHZ,
            echo_i  => s_echo,
            dist_o => s_dist
        );
        
sound_signal: entity work.sound_signal
port map(
          clk_i => s_CLK_1MHZ,
          dist_i => s_dist
        );
        
led_bar: entity work.led_bar
port map(
          clk_i => s_CLK_1MHZ,
          dist_i => s_dist
        );
        
p_stimulus : process
begin
while now < 1000 ms loop
s_echo <= '0';
wait for 1 ms;
s_echo <= '1';
wait for 20 us;
s_echo <= '0';
wait for 100 ms;

end loop;
wait;
end process p_stimulus;


end Behavioral;
