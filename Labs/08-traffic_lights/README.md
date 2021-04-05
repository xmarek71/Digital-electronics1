# Cvičenie 8

## Preparation tasks

#### Table with the state names and output values accoding to the given inputs

| **Input P** | `0` | `0` | `1` | `1` | `0` | `1` | `0` | `1` | `1` | `1` | `1` | `0` | `0` | `1` | `1` | `1` |
| :-- | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| **Clock** | ![rising](/Images/lab8/eq_uparrow.png) | ![rising](/Images/lab8/eq_uparrow.png) | ![rising](/Images/lab8/eq_uparrow.png) | ![rising](/Images/lab8/eq_uparrow.png) | ![rising](/Images/lab8/eq_uparrow.png) | ![rising](/Images/lab8/eq_uparrow.png) | ![rising](/Images/lab8/eq_uparrow.png) | ![rising](/Images/lab8/eq_uparrow.png) | ![rising](/Images/lab8/eq_uparrow.png) | ![rising](/Images/lab8/eq_uparrow.png) | ![rising](/Images/lab8/eq_uparrow.png) | ![rising](/Images/lab8/eq_uparrow.png) | ![rising](/Images/lab8/eq_uparrow.png) | ![rising](/Images/lab8/eq_uparrow.png) | ![rising](/Images/lab8/eq_uparrow.png) | ![rising](/Images/lab8/eq_uparrow.png) |
| **State** | A | A | B | C | C | D | A | B | C | D | B | B | B | C | D | B |
| **Output R** | `0` | `0` | `0` | `0` | `0` | `1` | `0` | `0` | `0` | `1` | `0` | `0` | `0` | `0` | `1` | `0` |

#### Figure with connection of RGB LEDs on Nexys A7 board

| **RGB LED** | **Artix-7 pin names** | **Red** | **Yellow** | **Green** |
| :-: | :-: | :-: | :-: | :-: |
| LD16 | N15, M16, R12 | `1,0,0` | `1,1,0` | `0,1,0` |
| LD17 | N16, R11, G14 | `1,0,0` | `1,1,0` | `0,1,0` |

## Traffic light controller

#### State diagram

#### Listing of VHDL code of sequential process p_traffic_fsm

#### Listing of VHDL code of combinatorial process p_output_fsm

#### Screenshot(s) of the simulation

## Smart controller

#### State table

#### State diagram

#### Listing of VHDL code of sequential process p_smart_traffic_fsm
