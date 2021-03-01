# Cvičenie 3

https://github.com/xmarek71/Digital-electronics1/

### Table with connection of 16 slide switches and 16 LEDs on Nexys A7 board

| **Name** | **Port** |**Function** |
| :-: | :-: | :-: | 
| J15 | a_i[0] | SW0 | 
| L16 | a_i[1] | SW1 |
| M13 | b_i[0] | SW2 |
| R15 | b_i[1] | SW3 |
| R17 | c_i[0] | SW4 |
| T18 | c_i[1] | SW5 |
| U18 | d_i[0] | SW6 |
| R13 | d_i[1] | SW7 |
| U11 | sel_i[0] | SW7 |
| V10 | sel_i[1] | SW7 |
| H17 | f_o[0] | LD0 |
| K15 | f_o[1] | LD1 |

### Two-bit wide 4-to-1 multiplexer

#### VHDL architecture syntax

````vhdl 
architecture Behavioral of mux_2bit_4to1 is
begin

    f_o <= a_i when (sel_i = "00") else
           b_i when (sel_i = "01") else
           c_i when (sel_i = "10") else
           d_i;

end architecture Behavioral;
````

#### VHDL stimulus process testbench syntax

```vhdl 
p_stimulus : process
    begin
        report "Stimulus process started" severity note;

         s_d <= "00"; s_c <= "00"; s_b <= "00"; s_a <= "00";
         s_sel <= "00"; wait for 100 ns;
        
         s_a <= "01"; wait for 100 ns;
         s_b <= "01"; wait for 100 ns;
        
         s_sel <= "01"; wait for 100 ns;
         s_c <= "00"; wait for 100 ns;
         s_b <= "11"; wait for 100 ns;
        
         s_d <= "10"; s_c <= "11"; s_b <= "01"; s_a <= "00";
         s_sel <= "10"; wait for 100 ns;
        
         s_d <= "00"; s_c <= "00"; s_b <= "00"; s_a <= "01";
         s_sel <= "10"; wait for 100 ns;
        
         s_d <= "10"; s_c <= "11"; s_b <= "01"; s_a <= "00";
         s_sel <= "11"; wait for 100 ns;

        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
````

#### Simulated time waveforms

![Waveforms](/Images/lab3/waveform.PNG)

### Vivado tutorial

### Project creation tutorial

![create](/Images/lab3/create.png)
![name](/Images/lab3/name.PNG)
![type](/Images/lab3/type.PNG)
![sources](/Images/lab3/sources.png)
![boards](/Images/lab3/boards.png)
![module](/Images/lab3/module.png)



### Adding of testbench file

##### Use File > Add Sources Alt+A > Add or create simulation sources and create a new VHDL file with same name and prefix "tb_"

![TB](/Images/lab3/testbench.png)
![TB](/Images/lab3/testsources.png)
![TB](/Images/lab3/testsim.png)


### Adding of XDC constraints file

![XDC](/Images/lab3/XDC1.png)
![XDC](/Images/lab3/XDC2.PNG)
![XDC](/Images/lab3/XDC3.PNG)

### Running simulation

![Simulation](/Images/lab3/simulation.png)
