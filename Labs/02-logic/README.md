
# Cvičenie 2

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

#### Karnaug map for B is greater than A

![B is greater than A](/Images/greater.PNG)

#### Karnaug map for B equals A

![B equals A](/Images/equals.PNG)

#### Karnaug map for B is less than A

![B is less than A](/Images/less.PNG)

## 4-bit binary comparator

#### Link
https://www.edaplayground.com/x/Zs7D

![Simulator console output](/Images/4-bit.PNG)

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
