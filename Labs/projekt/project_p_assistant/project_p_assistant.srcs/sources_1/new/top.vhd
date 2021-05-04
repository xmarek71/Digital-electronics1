----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.04.2021 17:45:51
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
    Port (
        ck_io8: out  std_logic;
        ck_io34: out  std_logic;
        ck_io9: out  std_logic;
        ck_io35: out  std_logic;
        ck_io10: out  std_logic;
        ck_io36: out  std_logic;
        ck_io11: out  std_logic;
        ck_io37: out  std_logic;
        ck_io12: out  std_logic;
        ck_io38: out  std_logic;
       -- P17: out  std_logic;
        ck_io39: out  std_logic;
        ck_io41: out  std_logic;
        ck_io40: in   std_logic;
        CLK100MHZ:  in   std_logic
    );
end top;

architecture Behavioral of top is
signal s_dist : integer;
begin

    hcsr04: entity work.hcsr04
    port map(
        clk_i   => CLK100MHZ,
        echo_i  => ck_io40,
        trig_o  => ck_io41,
        dist_o  => s_dist
    );
        
    sound_signal: entity work.sound_signal
    port map(
        clk_i   => CLK100MHZ,
        dist_i  => s_dist,
        buzzer  => ck_io39
    );
        
    led_bar: entity work.led_bar
    port map(
        clk_i => CLK100MHZ,
        dist_i => s_dist,
        
        led_bar_o(0)  => ck_io8,
        led_bar_o(1)  => ck_io34,
        led_bar_o(2)  => ck_io9,
        led_bar_o(3)  => ck_io35,
        led_bar_o(4)  => ck_io10,
        led_bar_o(5)  => ck_io36,
        led_bar_o(6)  => ck_io11,
        led_bar_o(7)  => ck_io37,
        led_bar_o(8)  => ck_io12,
        led_bar_o(9)  => ck_io38
    );


end Behavioral;
