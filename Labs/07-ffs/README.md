
# Cvičenie 7


## Preparation tasks
   | D | Qn | Q(n+1) | Comments |
   | :-: | :-: | :-: | :-- |
   | 0 | 0 | 0 | Zapis pri nabeznej hrane |
   | 0 | 1 | 0 | Zapis pri nabeznej hrane |
   | 1 | 0 | 1 | Zapis pri nabeznej hrane |
   | 1 | 1 | 1 | Zapis pri nabeznej hrane |

### 1.2. JK-ff

   | J | K | Qn | Q(n+1) | Comments |
   | :-: | :-: | :-: | :-: | :-- |
   | 0 | 0 | 0 | 0 | No change |
   | 0 | 0 | 1 | 1 | No change |
   | 0 | 1 | 0 | 0 | Reset |
   | 0 | 1 | 1 | 0 | Reset |
   | 1 | 0 | 0 | 1 | Set |
   | 1 | 0 | 1 | 1 | Set |
   | 1 | 1 | 0 | 1 | Invertor |
   | 1 | 1 | 1 | 0 | Invertor |

### 1.2. T-ff

   | T | Qn | Q(n+1) | Comments |
   | :-: | :-: | :-: | :-- |
   | 0 | 0 | 0 | Pamat |
   | 0 | 1 | 1 | Pamat |
   | 1 | 0 | 1 | Invertor |
   | 1 | 1 | 0 | Invertor |
   
## D latch

#### VHDL code listing of the process p_d_latch with syntax highlighting

````vhdl 
p_d_latch : process (d, arst, en)
begin
    if (arst = '1') then
        q <= '0';
        q_bar <= '1';
    elsif(en = '1') then
        q <= d;
        q_bar <= not d;
    end if;
end process p_d_latch;
````

#### Listing of VHDL reset and stimulus processes from the testbench tb_d_latch.vhd
````vhdl
 p_reset_gen : process
    begin
        s_arst <= '0';
        wait for 40 ns;
        
        s_arst <= '1';
        wait for 150 ns;

        s_arst <= '0';
        wait;
    end process p_reset_gen;
    
    ---------------------------------------------  
    
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        
        s_d <= '0';
        s_en <= '0';
        
        assert (s_q = '0')
        report "asdfadf" severity error;
        
        wait for 10 ns;
        s_d <= '1';
        wait for 10 ns;
        s_d <= '0';
        wait for 10 ns;
        s_d <= '1';
        wait for 10 ns;
        s_d <= '0';
        wait for 10 ns;
        s_d <= '1';
        wait for 10 ns;
        s_d <= '0';
        wait for 10 ns;
        s_d <= '1';
        wait for 10 ns;
        s_d <= '0';
        wait for 10 ns;
        s_d <= '1';
        
        s_en <= '1';
        
        wait for 10 ns;
        s_d <= '1';
        wait for 10 ns;
        s_d <= '0';
        wait for 10 ns;
        s_d <= '1';
        wait for 10 ns;
        s_d <= '0';
        wait for 10 ns;
        s_d <= '1';
        wait for 10 ns;
        s_d <= '0';
        wait for 10 ns;
        s_d <= '1';
        wait for 10 ns;
        s_d <= '0';
        wait for 100 ns;
        s_d <= '1';
        
        s_en <= '0';
        
        wait for 10 ns;
        s_d <= '1';
        wait for 10 ns;
        s_d <= '0';
        wait for 10 ns;
        s_d <= '1';
        wait for 10 ns;
        s_d <= '0';
        wait for 10 ns;
        s_d <= '1';
        wait for 10 ns;
        s_d <= '0';
        wait for 10 ns;
        s_d <= '1';
        wait for 10 ns;
        s_d <= '0';
        wait for 10 ns;
        s_d <= '1';
        
        report "Stimulus process finished" severity note;    
    end process p_stimulus;
````

