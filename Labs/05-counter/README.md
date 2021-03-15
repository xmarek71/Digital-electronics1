
# Cvičenie 5

#### Truth table for common anode 7-segment display

| **Name** | **Port** |**Function** |
| :-: | :-: | :-: | 
| J15 | SW | L=0V, H=3,3V | 
| P17 | RESET | L=0V, H=3,3V |
| T10 | CA | A | 
| R10 | CB | B |
| K16 | CC | C |
| K13 | CD | D |
| P15 | CE | E |
| T11 | CF | F |
| L18 | CG | G |
| J17 | AN[0] | KAT 1 |
| J18 | AN[1] | KAT 2 |
| T9 | AN[2] | KAT 3 |
| J14 | AN[3] | KAT 4 |
| P14 | AN[4] | KAT 5 |
| T14 | AN[5] | KAT 6 |
| K2 | AN[6] | KAT 7 |
| U13 | AN[7] | KAT 8 |

#### Table with calculated values

| **Time interval** | **Number of clk periods** | **Number of clk periods in hex** | **Number of clk periods in binary** |
   | :-: | :-: | :-: | :-: |
   | 2&nbsp;ms | 200 000 | `x"3_0d40"` | `b"0011_0000_1101_0100_0000"` |
   | 4&nbsp;ms | 400 000 | `x"6_1a80"` | `b"0110_0001_1010_1000_0000"` |
   | 10&nbsp;ms | 1 000 000 | `x"f_4240"` | `b"1111_0100_0010_0100_0000"` |
   | 250&nbsp;ms | 25 000 000 | `x"17d_7840"` | `b"0001_0111_1101_0111_1000_0100_0000"` |
   | 500&nbsp;ms | 50 000 000 | `x"2fa_f080"` | `b"0010_1111_1010_1111_0000_1000_0000"` |
   | 1&nbsp;sec | 100 000 000 | `x"5f5_e100"` | `b"0101_1111_0101_1110_0001_0000_0000"` |
   
   ### Bidirectional counter
   
   #### Listing of VHDL code of the process p_cnt_up_down
   
   ````vhdl 
       p_cnt_up_down : process(clk)
    begin
        if rising_edge(clk) then
        
            if (reset = '1') then 
                s_cnt_local <= (others => '0'); 

            elsif (en_i = '1') then    

            if (cnt_up_i = '1') then
                s_cnt_local <= s_cnt_local + 1;
                    
            elsif (cnt_up_i = '0') then
                s_cnt_local <= s_cnt_local - 1;
                
             end if;
            end if;
        end if;
    end process p_cnt_up_down;
   ````
   #### Listing of VHDL reset and stimulus processes from testbench file
   ````vhdl
   p_reset_gen : process
    begin
        s_reset <= '0';
        wait for 12 ns;
        
        -- Reset activated
        s_reset <= '1';
        wait for 73 ns;

        s_reset <= '0';
        wait;
    end process p_reset_gen;

    p_stimulus : process
    begin
        report "Stimulus process started" severity note;

        -- Enable counting
        s_en     <= '1';
        
        -- Change counter direction
        s_cnt_up <= '1';
        wait for 380 ns;
        s_cnt_up <= '0';
        wait for 220 ns;

        -- Disable counting
        s_en     <= '0';

        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
   ````
