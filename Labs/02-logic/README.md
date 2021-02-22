
# Cvičenie 2

https://github.com/xmarek71/Digital-electronics1/

#### 2-bit comparator
https://www.edaplayground.com/x/k7HT

#### 2-bit comparator truth table

| **Dec. equivalent** | **B[1:0]** | **A[1:0]** | **B is greater than A** | **B equals A** | **B is less than A** |
| :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0 0 | 0 0 | 0 | 1 | 0 |
| 1 | 0 0 | 0 1 | 0 | 0 | 1 |
| 2 | 0 0 | 1 0 | 0 | 0 | 1 |
| 3 | 0 0 | 1 1 | 0 | 0 | 1 |
| 4 | 0 1 | 0 0 | 1 | 0 | 0 |
| 5 | 0 1 | 0 1 | 0 | 1 | 0 |
| 6 | 0 1 | 1 0 | 0 | 0 | 1 |
| 7 | 0 1 | 1 1 | 0 | 0 | 1 |
| 8 | 1 0 | 0 0 | 1 | 0 | 0 |
| 9 | 1 0 | 0 1 | 1 | 0 | 0 |
| 10 | 1 0 | 1 0 | 0 | 1 | 0 |
| 11 | 1 0 | 1 1 | 0 | 0 | 1 |
| 12 | 1 1 | 0 0 | 1 | 0 | 0 |
| 13 | 1 1 | 0 1 | 1 | 0 | 0 |
| 14 | 1 1 | 1 0 | 1 | 0 | 0 |
| 15 | 1 1 | 1 1 | 0 | 1 | 0 |

#### Canonical SoP (Sum of Products) and PoS (Product of Sums) forms for "equals" and "less than" functions

![equalsSOP](/Images/equalsSOP.png)
![lessPOS](/Images/lessPOS.PNG)

#### Karnaugh map for B is greater than A

![B is greater than A](/Images/greater.PNG)

#### Karnaugh map for B equals A

![B equals A](/Images/equals.PNG)

#### Karnaugh map for B is less than A

![B is less than A](/Images/less.PNG)

#### Equations of simplified SoP form of the "greater than" function and simplified PoS form of the "less than" function
![rovnice](/Images/SoPoS.gif)


## 4-bit binary comparator

#### Link
https://www.edaplayground.com/x/Zs7D

#### VHDL architecture from design file

````vhdl
entity comparator_4bit is
    port(
      	a_i           : in  std_logic_vector(4 - 1 downto 0);
      	b_i           : in  std_logic_vector(4 - 1 downto 0);
		B_greater_A_o : out std_logic;       -- B is greater than A
        B_equals_A_o  : out std_logic;       -- B equals A
        B_less_A_o    : out std_logic       -- B is less than A
    );
end entity comparator_4bit;

architecture Behavioral of comparator_4bit is
begin

    B_less_A_o   <= '1' when (b_i < a_i) else '0';
    B_greater_A_o <= '1' when (b_i > a_i) else '0';
    B_equals_A_o  <= '1' when (b_i = a_i) else '0';

end architecture Behavioral;
````
#### VHDL stimulus process from testbench file

````vhdl
p_stimulus : process
    begin
        report "Stimulus process started" severity note;

		s_b <= "0000"; s_a <= "0000"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '1') and (s_B_less_A = '0'))
		report "Test failed for input combination: 0000, 0000" severity error;

		s_b <= "0000"; s_a <= "0001"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0000, 0001" severity error;

		s_b <= "0000"; s_a <= "0010"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0000, 0010" severity error;

		s_b <= "0000"; s_a <= "0011"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0000, 0011" severity error;

		s_b <= "0000"; s_a <= "0100"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0000, 0100" severity error;

      		s_b <= "0000"; s_a <= "0101"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0000, 0101" severity error;

		s_b <= "0000"; s_a <= "0110"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0000, 0110" severity error;

		s_b <= "0000"; s_a <= "0111"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0000, 0111" severity error;

		s_b <= "0000"; s_a <= "1000"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0000, 1000" severity error;

		s_b <= "0000"; s_a <= "1001"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '1') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0000, 1001" severity error;

        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
````

#### Simulator console output

![Simulator console output](/Images/4-bit.PNG)

