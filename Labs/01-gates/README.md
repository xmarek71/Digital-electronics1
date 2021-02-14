
# Cvičenie 1

https://www.edaplayground.com/x/8NnS

### Verification of De Morgan's laws

```vhd1
architecture dataflow of gates is
begin
    f_o <= ((NOT b_i) AND a_i) OR ((NOT c_i) AND (NOT b_i));
    fnand_o <= (a_i NAND (NOT b_i)) NAND ((NOT b_i) NAND (NOT c_i));
    fnor_o <= (a_i NOR (NOT c_i)) NOR b_i;
end architecture dataflow;
```

![De Morgan's law simulation](/Images/demorgan.PNG)


| **c** | **b** |**a** | **f(c,b,a)** | **fnand(c,b,a)** | **fnor(c,b,a)** |
| :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 1 | 1 | 1 |
| 0 | 0 | 1 | 1 | 1 | 1 |
| 0 | 1 | 0 | 0 | 0 | 0 |
| 0 | 1 | 1 | 0 | 0 | 0 |
| 1 | 0 | 0 | 0 | 0 | 0 |
| 1 | 0 | 1 | 1 | 1 | 1 |
| 1 | 1 | 0 | 0 | 0 | 0 |
| 1 | 1 | 1 | 0 | 0 | 0 |


### Verification of Distributive laws

```vhd1
architecture dataflow of gates is
begin
    f_dist1 <= (a_i AND b_i) OR (a_i AND c_i);
    f_dist11 <= a_i AND ( b_i OR c_i );
    f_dist2 <= ( a_i OR b_i ) AND ( a_i OR c_i );
    f_dist21 <= a_i OR ( b_i AND c_i );

end architecture dataflow;
```
![Distributive laws similation](/Images/disctric.PNG)

### 
| **c** | **b** |**a** | **fdist1(c,b,a)** | **fdist1.1(c,b,a)** | **fdist2(c,b,a)** | **fdist2.1(c,b,a)** |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 0 | 0 | 1 | 1 |
| 0 | 1 | 0 | 0 | 0 | 0 | 0 |
| 0 | 1 | 1 | 1 | 1 | 1 | 1 |
| 1 | 0 | 0 | 0 | 0 | 0 | 0 |
| 1 | 0 | 1 | 1 | 1 | 1 | 1 |
| 1 | 1 | 0 | 0 | 0 | 1 | 1 |
| 1 | 1 | 1 | 1 | 1 | 1 | 1 |
