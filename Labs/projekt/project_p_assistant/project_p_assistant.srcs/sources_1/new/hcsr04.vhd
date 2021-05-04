----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.04.2021 18:39:28
-- Design Name: 
-- Module Name: hcsr04 - Behavioral
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
use IEEE.MATH_REAL.ALL;
use IEEE.numeric_std.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity hcsr04 is
  generic (
    G_FREQ       : real := 1.0;         -- Operating frequency in MHz.
    G_SENSE_FREQ : real := 20.0         -- Number of times distance is sensed per second.
    );
  Port ( 
      clk_i   : in  std_logic;          -- Input clock.
      trig_o  : out std_logic;          -- hcsr04 trigger
      echo_i  : in  std_logic;          -- echo signal from hcsr04
      dist_o  : out integer             -- measured delay output
      
  );
end hcsr04;




architecture Behavioral of hcsr04 is


constant C_TRIG_WIDTH   : real      := 20.0;  -- Trigger width (us).
constant C_SENSE_PERIOD : integer   := integer(ceil(G_FREQ * 1.0E6 / G_SENSE_FREQ));--period length of trig_o
signal s_trig_timer, s_dist_timer   : integer range 0 to C_SENSE_PERIOD;            --s_trig_timer: counter for generating signal on trig_o, s_dist_timer: counter for measuring dealy between trig_o and echo_i
signal rs_trig                      : std_logic :='0';                              --RS memory for trig detection
signal rs_echo                      : std_logic :='0';                              --RS memory for echo detection
signal dist_timer_trig              : std_logic :='0';                              --when this signal equals '1' s_dist_timer is running

begin
process(clk_i)
begin

if rising_edge(clk_i) then                                         
    s_trig_timer <= s_trig_timer + 1;                               --incrementing of s_trig_timer
    
    if (s_trig_timer < integer(ceil(C_TRIG_WIDTH * G_FREQ))) then   --if s_trig_timer is lower then set trigger width
        trig_o <= '1';                                              --the output of trig_o = '1'
        if (rs_trig = '0')then      --rs circuit for triggering statements below only on rising edge of trig_o
            s_dist_timer <= 0;      --s_dist_timer reset
            rs_trig <='1';          
            dist_timer_trig <='1';  --switching on s_trig_timer
        end if;
    elsif (s_trig_timer >= C_SENSE_PERIOD) then -- reset of both timers on reaching C_SENSE_PERIOD
        s_trig_timer    <=0;
        s_dist_timer    <=0;
        trig_o          <='0';                  -- trig_o switches back to '0'
        rs_trig         <='0';
    else
        rs_trig         <='0';
        trig_o          <='0';
    end if;
    
    if (dist_timer_trig = '1')then              --s_dist_timer is on only when dist_timer_trig = '1'
        if (s_dist_timer < C_SENSE_PERIOD)then  --and only if it's lower then C_SENSE_PERIOD 
            s_dist_timer <= s_dist_timer + 1;           
        else
            dist_o  <= s_dist_timer;            --if s_dist_timer reaches C_SENSE_PERIOD, it outputs its value to dist_o 
        end if;
    end if;
    
    if (echo_i = '1') then          --detects echo_i
        if (rs_echo = '0')then      --rs circuit for triggering statements below only on rising edge of echo_o
            rs_trig <= '0';         
            rs_echo <='1';               
            dist_timer_trig <='0';  --dist_timer_trig reset
            dist_o  <= s_dist_timer;--output of the measured delay between trig_o and echo_i from s_dist_timer to dist_o
        end if;
    else 
    rs_echo <='0';   
    end if;
    
                       
end if;
    
end process;

end Behavioral;
