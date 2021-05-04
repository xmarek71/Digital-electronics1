----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/21/2021 07:27:29 PM
-- Design Name: 
-- Module Name: led_bar - Behavioral
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

entity led_bar is
    Port (
      clk_i   : in std_logic; -- main clock
      dist_i  : in integer; -- distance input 
      
      led_bar_o : out std_logic_vector (10 - 1 downto 0)    -- Output for 10 leds
  );
end led_bar;

architecture Behavioral of led_bar is

begin
-- process sets binary value to led_bar output if the distance in condition is verified. 
    process(clk_i)
    begin
    
        if    (dist_i <= 580)  then led_bar_o <= "1111111111";
        elsif (dist_i <= 1160) then led_bar_o <= "0111111111";
        elsif (dist_i <= 1740) then led_bar_o <= "0011111111";
        elsif (dist_i <= 2320) then led_bar_o <= "0001111111";
        elsif (dist_i <= 3480) then led_bar_o <= "0000111111";
        elsif (dist_i <= 4640) then led_bar_o <= "0000011111";
        elsif (dist_i <= 5800) then led_bar_o <= "0000001111";
        elsif (dist_i <= 6960) then led_bar_o <= "0000000111";
        elsif (dist_i <= 8120) then led_bar_o <= "0000000011";
        elsif (dist_i <= 9280) then led_bar_o <= "0000000001";
        elsif (dist_i > 9280)  then led_bar_o <= "0000000000";
        end if;
    
    end process;

end Behavioral;
