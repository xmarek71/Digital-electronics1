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
use ieee.numeric_std. all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sound_signal is
    Port (
      clk_i   : in std_logic;   -- main clock
      dist_i  : in integer;     --distance input 
      
      buzzer  : out std_logic   --buzzer output
  );
end sound_signal;

architecture Behavioral of sound_signal is
--t_state creates new type of variable with declared values 
    type   t_state is (CM10, CM20, CM30, CM40, CM60, CM80, CM100, CM120, CM140, CM160, LOW);
    signal s_state  : t_state;  --creates signal according to t_state
    signal s_en  : std_logic;   --signal for buzzer frequency (normally frequecy should be 2,4kHz due to simulation lenght we used clock frequency)
    --signal s_reset : std_logic ;    
    
    signal s_cnt : unsigned(28 - 1 downto 0) := b"0000_0000_0000_0000_0000_0000_0000";      --buzzer counter signal
    signal s_cnt_1 : unsigned(28 - 1 downto 0) := b"0000_0000_0000_0000_0000_0000_0000";    --break counter signal
    
    --constants for time delay
    --if we change constatns value time of beep or break will be longer or shorter 
    constant c_DELAY_100ms : unsigned(28 - 1 downto 0) := b"0000_0000_0000_0000_0000_0000_0010";
    constant c_DELAY_200ms : unsigned(28 - 1 downto 0) := b"0000_0000_0000_0000_0000_0000_0100";
    constant c_DELAY_300ms : unsigned(28 - 1 downto 0) := b"0000_0000_0000_0000_0000_0000_1000";
    constant c_DELAY_400ms : unsigned(28 - 1 downto 0) := b"0000_0000_0000_0000_0000_0000_1010";
    constant c_DELAY_500ms : unsigned(28 - 1 downto 0) := b"0000_0000_0000_0000_0000_0001_0101";
    constant c_DELAY_600ms : unsigned(28 - 1 downto 0) := b"0000_0000_0000_0000_0000_0010_0110";
    constant c_DELAY_700ms : unsigned(28 - 1 downto 0) := b"0000_0000_0000_0000_0000_0011_0111";
    constant c_DELAY_800ms : unsigned(28 - 1 downto 0) := b"0000_0000_0000_0000_0000_0101_1100";
    constant c_DELAY_1s    : unsigned(28 - 1 downto 0) := b"0000_0000_0000_0000_0000_1111_0000";
    constant c_DELAY_BEEP  : unsigned(28 - 1 downto 0) := b"0000_0000_0000_0000_0000_0001_0101";
    constant c_ZERO        : unsigned(28 - 1 downto 0) := b"0000_0000_0000_0000_0000_0000_0000";

begin

    clk_en0 : entity work.clock_enable  --instance copy of clock_enable entity 
        generic map(
            g_MAX => 100
        )
        port map(
            clk    => clk_i,
            reset  => '0',
            ce_o   => s_en
        );
    
    --following the distance sets time of PWM and break on buzzer output  
    sound : process(clk_i)
    begin
    
     if (rising_edge(clk_i)) then
            
        if    (dist_i <= 580)  then         --if the distance in condition is verified 
            if (s_state /= CM10) then       --and s_state value isn't set 
                s_state <= CM10;            --sets s_state 
                s_cnt <= c_ZERO;            --null counters
                s_cnt_1 <= c_ZERO;
            end if;
        elsif (dist_i <= 1160) then
            if (s_state /= CM20) then
                s_state <= CM20;
                s_cnt <= c_ZERO;
                s_cnt_1 <= c_ZERO;
            end if;
        elsif (dist_i <= 1740) then
            if (s_state /= CM30) then
                s_state <= CM30;
                s_cnt <= c_ZERO;
                s_cnt_1 <= c_ZERO;
            end if;
        elsif (dist_i <= 2320) then
            if (s_state /= CM40) then
                s_state <= CM40;
                s_cnt <= c_ZERO;
                s_cnt_1 <= c_ZERO;
            end if;
        elsif (dist_i <= 3480) then
            if (s_state /= CM60) then
                s_state <= CM60;
                s_cnt <= c_ZERO;
                s_cnt_1 <= c_ZERO;
            end if;
        elsif (dist_i <= 4640) then 
            if (s_state /= CM80) then
                s_state <= CM80;
                s_cnt <= c_ZERO;
                s_cnt_1 <= c_ZERO;
            end if;
        elsif (dist_i <= 5800) then
            if (s_state /= CM100) then
                s_state <= CM100;
                s_cnt <= c_ZERO;
                s_cnt_1 <= c_ZERO;
            end if;
        elsif (dist_i <= 6960) then
            if (s_state /= CM120) then
                s_state <= CM120;
                s_cnt <= c_ZERO;
                s_cnt_1 <= c_ZERO;
            end if;
        elsif (dist_i <= 8120) then
            if (s_state /= CM140) then
                s_state <= CM140;
                s_cnt <= c_ZERO;
                s_cnt_1 <= c_ZERO;
            end if;
        elsif (dist_i <= 9280) then
            if (s_state /= CM160) then
                s_state <= CM160;
                s_cnt <= c_ZERO;
                s_cnt_1 <= c_ZERO;
            end if;
        elsif (dist_i > 9280)  then
            if (s_state /= LOW) then
                s_state <= LOW;
                s_cnt <= c_ZERO;
                s_cnt_1 <= c_ZERO;
            end if;
        end if;
    end if;

        
        case s_state is
            when CM10 => 
                buzzer <= clk_i; --sets constant PWM on buzzer
                
            when CM20 =>                                                                --if s_state same as condition(CM20) 
                if (s_cnt < c_DELAY_BEEP) then                                          --if counter is smaller then beep time 
                    buzzer <= clk_i;                                                    --sets buzzer to s_en state (used clk_i instead for simulation lenght)
                    s_cnt <= s_cnt + 1;                                                 --add 1 to counter 
                    s_cnt_1 <= c_ZERO;                                                  --null counter2
                elsif (s_cnt = c_DELAY_BEEP) and (s_cnt_1 < c_DELAY_100ms) then         --if counter for beep time is in time range, counter2 starts to count
                    buzzer <= '0';                                                      --turn of buzzer
                    s_cnt_1 <= s_cnt_1 + 1;                                             --add 1 to counter2
                elsif (s_cnt_1 = c_DELAY_100ms) then                                    --if counter2 is same as delay 
                    s_cnt_1 <= c_ZERO;                                                  --null counters
                    s_cnt <= c_ZERO;
                end if;
                
            when CM30 => 
                if (s_cnt < c_DELAY_BEEP) then 
                    buzzer <= clk_i;
                    s_cnt <= s_cnt + 1;
                    s_cnt_1 <= c_ZERO;
                elsif (s_cnt = c_DELAY_BEEP) and (s_cnt_1 < c_DELAY_200ms) then
                    buzzer <= '0';
                    s_cnt_1 <= s_cnt_1 + 1;
                elsif (s_cnt_1 = c_DELAY_200ms) then
                    s_cnt_1 <= c_ZERO;
                    s_cnt <= c_ZERO;
                end if;
            
            when CM40 => 
                if (s_cnt < c_DELAY_BEEP) then 
                    buzzer <= clk_i;
                    s_cnt <= s_cnt + 1;
                    s_cnt_1 <= c_ZERO;
                elsif (s_cnt = c_DELAY_BEEP) and (s_cnt_1 < c_DELAY_300ms) then
                    buzzer <= '0';
                    s_cnt_1 <= s_cnt_1 + 1;
                elsif (s_cnt_1 = c_DELAY_300ms) then
                    s_cnt_1 <= c_ZERO;
                    s_cnt <= c_ZERO;
                end if;
                
            when CM60 => 
                if (s_cnt < c_DELAY_BEEP) then 
                    buzzer <= clk_i;
                    s_cnt <= s_cnt + 1;
                    s_cnt_1 <= c_ZERO;
                elsif (s_cnt = c_DELAY_BEEP) and (s_cnt_1 < c_DELAY_400ms) then
                    buzzer <= '0';
                    s_cnt_1 <= s_cnt_1 + 1;
                elsif (s_cnt_1 = c_DELAY_400ms) then
                    s_cnt_1 <= c_ZERO;
                    s_cnt <= c_ZERO;
                end if;
                
            when CM80 => 
                if (s_cnt < c_DELAY_BEEP) then 
                    buzzer <= clk_i;
                    s_cnt <= s_cnt + 1;
                    s_cnt_1 <= c_ZERO;
                elsif (s_cnt = c_DELAY_BEEP) and (s_cnt_1 < c_DELAY_500ms) then
                    buzzer <= '0';
                    s_cnt_1 <= s_cnt_1 + 1;
                elsif (s_cnt_1 = c_DELAY_500ms) then
                    s_cnt_1 <= c_ZERO;
                    s_cnt <= c_ZERO;
                end if;
            
            when CM100 => 
                if (s_cnt < c_DELAY_BEEP) then 
                    buzzer <= clk_i;
                    s_cnt <= s_cnt + 1;
                    s_cnt_1 <= c_ZERO;
                elsif (s_cnt = c_DELAY_BEEP) and (s_cnt_1 < c_DELAY_600ms) then
                    buzzer <= '0';
                    s_cnt_1 <= s_cnt_1 + 1;
                elsif (s_cnt_1 = c_DELAY_600ms) then
                    s_cnt_1 <= c_ZERO;
                    s_cnt <= c_ZERO;
                end if;
                
            when CM120 => 
                if (s_cnt < c_DELAY_BEEP) then 
                    buzzer <= clk_i;
                    s_cnt <= s_cnt + 1;
                    s_cnt_1 <= c_ZERO;
                elsif (s_cnt = c_DELAY_BEEP) and (s_cnt_1 < c_DELAY_700ms) then
                    buzzer <= '0';
                    s_cnt_1 <= s_cnt_1 + 1;
                elsif (s_cnt_1 = c_DELAY_700ms) then
                    s_cnt_1 <= c_ZERO;
                    s_cnt <= c_ZERO;
                end if;
                
            when CM140 => 
                if (s_cnt < c_DELAY_BEEP) then 
                    buzzer <= clk_i;
                    s_cnt <= s_cnt + 1;
                    s_cnt_1 <= c_ZERO;
                elsif (s_cnt = c_DELAY_BEEP) and (s_cnt_1 < c_DELAY_800ms) then
                    buzzer <= '0';
                    s_cnt_1 <= s_cnt_1 + 1;
                elsif (s_cnt_1 = c_DELAY_800ms) then
                    s_cnt_1 <= c_ZERO;
                    s_cnt <= c_ZERO;
                end if;
                
            when CM160 => 
                if (s_cnt < c_DELAY_BEEP) then 
                    buzzer <= clk_i;
                    s_cnt <= s_cnt + 1;
                    s_cnt_1 <= c_ZERO;
                elsif (s_cnt = c_DELAY_BEEP) and (s_cnt_1 < c_DELAY_1s) then
                    buzzer <= '0';
                    s_cnt_1 <= s_cnt_1 + 1;
                elsif (s_cnt_1 = c_DELAY_1s) then
                    s_cnt_1 <= c_ZERO;
                    s_cnt <= c_ZERO;
                end if;
                
            when LOW =>             --if the distance is too high
                buzzer <= '0';      --counter and buzzer are disabled

            when others =>
        end case;
    end process;

end Behavioral;
