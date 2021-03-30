
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

#### Screenshot with simulated time waveforms
![Waveform](/Images/lab7/dlatch.PNG)

## Flip-flops

#### Process d_ff_arst
````vhdl
 p_d_latch : process (clk, arst)
    begin
        if (arst = '1') then
            q <= '0';
            q_bar <= '1';

        elsif rising_edge(clk) then
            q <= d;
            q_bar <= not(d);
        end if;
    end process p_d_latch;
````
#### Process d_ff_rst
````vhdl
d_ff_rst : process (clk)
    begin
        if rising_edge(clk) then
            if (rst = '1')then
                q <= '0';
            else
                q <= d;
                q_bar <= not(d);                  
            end if;           
        end if;
    end process d_ff_rst;
````

#### Process jk_ff_rst
````vhdl
p_d_latch : process (clk)
begin
  if rising_edge(clk) then
    if(rst = '1') then
        s_q <= '0';
    else 
        if(j = '0' and k = '0') then
            s_q <= s_q;
            
        elsif(j = '0' and k = '1') then
            s_q <= '0';
            
        elsif(j = '1' and k = '0') then
            s_q <= '1';
            
        elsif(j = '1' and k = '1') then
            s_q <= not s_q;
        end if;
    end if;
  end if;
end process p_d_latch;
````

#### Process t_ff_rst
````vhdl 
t_ff_rst : process (clk)
    begin
        if rising_edge(clk) then
            if (rst = '1')then
                s_q <= '0';
            else
                if(t = '0')then
                    s_q <= s_q;
                elsif(t = '1')then
                    s_q <= not s_q;
                end if;
            end if;        
        end if;
    end process t_ff_rst;
````


#### Testbench d_ff_arst

````vhdl 
 p_clk_gen : process
    begin
        while now < 750 ns loop 
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
        
    p_reset_gen : process
    begin
        s_arst <= '0';
        wait for 28 ns;
        
        s_arst <= '1';
        wait for 53 ns;

        s_arst <= '0';
        wait for 660 ns;
        
        s_arst <= '1';
        wait;
    end process p_reset_gen;
    
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        
        s_d <= '0';
        
        wait for 14 ns;
        s_d <= '1';
        wait for 25 ns;
        s_d <= '0';
        
        wait for 6 ns;
        --assert ()
        --report "";
        
        wait for 4 ns;
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
#### Testbench d_ff_rst
````vhdl
p_clk_gen : process
    begin
        while now < 750 ns loop
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;

p_reset : process
    begin
        s_rst <= '0';
        wait for 20 ns;
        s_rst <= '1';
        wait for 55 ns;  
        s_rst <= '0';
        wait for 660 ns;
        s_rst <= '1';
        wait;
    end process p_reset;
    
     p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        
        s_d <= '0';
        
        wait for 14 ns;
        s_d <= '1';
        wait for 25 ns;
        s_d <= '0';
        
        wait for 6 ns;
        --assert ()
        --report "";
        
        wait for 4 ns;
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
        wait;
    end process p_stimulus;
````
#### Testbench jk_ff_rst
````vhdl
p_clk_gen : process
    begin
        while now < 750 ns loop  
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
        
    p_reset_gen : process
    begin
        s_rst <= '0';
        wait for 28 ns;

        s_rst <= '1';
        wait for 13 ns;

        s_rst <= '0';
        wait for 17 ns;
        
        s_rst <= '1';
        wait for 33 ns;
        
        s_rst <= '0';
        wait for 53 ns;
        
        s_rst <= '1';

        wait;
    end process p_reset_gen;
    
    ---------------------------------------------  

    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        
        s_j <= '0';
        s_k <= '0';
        
        wait for 40 ns;
        s_j <= '0';
        s_k <= '0';
        
        wait for 7 ns;
        s_j <= '0';
        s_k <= '1';
        
        wait for 7 ns;
        s_j <= '1';
        s_k <= '0';
        wait for 7 ns;
        s_j <= '1';
        s_k <= '1';
        
        
        wait for 7 ns;
        s_j <= '0';
        s_k <= '0';
        
        wait for 7 ns;
        s_j <= '0';
        s_k <= '1';
        
        wait for 7 ns;
        s_j <= '1';
        s_k <= '0';
        wait for 7 ns;
        s_j <= '1';
        s_k <= '1';
        
        report "Stimulus process finished" severity note;    
    end process p_stimulus;
````
#### Testbench t_ff_rst
````vhdl
p_clk_gen : process
    begin
        while now < 750 ns loop 
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;

p_reset : process
    begin
        s_rst <= '0';
        wait for 15 ns;
        s_rst <= '1';
        wait for 15 ns;  
        -- Reset activated
        s_rst <= '0';
        wait for 20 ns;
        s_rst <= '1';
        wait for 60 ns;
        s_rst <= '0';
        wait for 660 ns;
        s_rst <= '1';
 
    end process p_reset;
    
     p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        
        s_t <= '0';
        
        wait for 14 ns;
        s_t <= '1';
        wait for 10 ns;
        s_t <= '0';
        
        wait for 6 ns;
        --assert ()
        --report "";
        
        wait for 4 ns;
        s_t <= '1';
        wait for 10 ns;
        s_t <= '0';
        wait for 10 ns;
        s_t <= '1';
        wait for 10 ns;
        s_t <= '0';
        wait for 10 ns;
        s_t <= '1';
        wait for 10 ns;
        s_t <= '0';
        wait for 10 ns;
        s_t <= '1';
            
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
````

#### Screenshot with simulated time waveforms of tb_d_ff_arst
![Waveform](/Images/lab7/dffarst.PNG)

#### Screenshot with simulated time waveforms of tb_d_ff_rst
![Waveform](/Images/lab7/dffrst.PNG)

#### Screenshot with simulated time waveforms of tb_jk_ff_rst
![Waveform](/Images/lab7/jkffrst.PNG)

#### Screenshot with simulated time waveforms of tb_t_ff_rst
![Waveform](/Images/lab7/tffrst.PNG)

## Shift register
![Schema](/Images/lab7/schema.PNG)
