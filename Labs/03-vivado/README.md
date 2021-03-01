# Cvičenie 2

https://github.com/xmarek71/Digital-electronics1/

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
