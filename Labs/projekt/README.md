# Projekt VHDL BPC-DE1
### Name of the project:
Parking assistant with HC-SR04 ultrasonic sensor, sound signaling using PWM, signaling by LED bargraph.<br>
<i>Parkovací asistent s HC-SR04 ultrazvukovým senzorem, zvuková PWM signalizace, signalizace pomocí LED bargrafu.</i>
### Students:
Maňásek Tomáš <br>
Mareková Martina <br>
Marák Jiří <br>
Matoušek Tomáš <br>
Lukić Marko 

### Project objectives
The overall project objective is to make a Parking assitant with ultrasonic sensor, sound signaling using PWM control with an LED indicator. 

### Hardware description
Hardware list:
- Ultrasonic sensor hc-sr04
- Digilent Arty A7-35 Development board <br>
![Hardware](https://github.com/markolukicluk99/projektVHDL/blob/main/Images/hardware.PNG)

### Block scheme
![Block scheme](https://github.com/markolukicluk99/projektVHDL/blob/main/Images/block_scheme.PNG)
### VHDL Modules description and simulations
### HCSR04 
#### Listing of VHDL code of the process
```vhdl
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
```

#### Listing of VHDL testbench file
```vhdl 
    process(clk_i)
    begin
    
    if rising_edge(clk_i) then
        s_timer <= s_timer + 1;     
        
        if (s_timer < integer(ceil(C_TRIG_WIDTH * G_FREQ))) then    --pokud je s_timer mensi nez navolena sirka pulzu signalu trig_o
            trig_o <= '1';                                          --na trig_o bude '1'
            if (s_pom_cnt = '0')then                                --pro reset s_dist pri nabezne hrane signalu  trig_o 
                s_dist <= 0;
                s_pom_cnt <='1';                                    -- prepnuti s_pom_cnt na '1' aby doslo k resetu s_dist jen jednou
                s_pom_dist <='1';       --zapnuti s_dist citace
            end if;
        elsif (s_timer >= C_SENSE_PERIOD) then -- reset citacu po dosazeni delky periody trig_o
            s_timer <=0;
            s_dist  <=0;
            trig_o  <='0';
        else
            s_pom_cnt   <='0';
            trig_o      <='0';
        end if;
        
        if (s_pom_dist = '1')then               --bezi jen pokud s_pom_dist = '1'
            if (s_dist < C_SENSE_PERIOD)then    
                s_dist <= s_dist + 1;           
            else
                dist_o  <= s_dist;              --pokud s_dist dosahne hodnoty delky periody trig_o, da se na dist_o tato hodnota 
            end if;
        end if;
        
        if (echo_i = '1') then                  --detekuje echo_i
            if (s_pom_echo = '0')then           --pro provedeni jen pri nabezne hrane echo_i
                s_pom_cnt <= '0';               --reset s_pom_cnt
                s_pom_echo <='1';               
                s_pom_dist <='0';               --reset s_pom_dist
                dist_o  <= s_dist;              --vlozeni hodnoty z s_dist na dist_o 
            end if;
        else 
        s_pom_echo <='0';   
        end if;
                            
    end if;
        
    end process;
```
### Led_bar

```vhdl
architecture Behavioral of led_bar is

begin
-- process sets binary value to led_bar output if the distance in condition is verified. 
    process(clk_i)
    begin
    
        if    (dist_i <= 580)  then led_bar_o <= "1111111111";
        elsif (dist_i <= 1160) then led_bar_o <= "0111111111";
        elsif (dist_i <= 1740) then led_bar_o <= "0011111111";
        elsif (dist_i <= 2320) then led_bar_o <= "0001111111";
        elsif (dist_i <= 3480) then led_bar_o <= "0000111111";
        elsif (dist_i <= 4640) then led_bar_o <= "0000011111";
        elsif (dist_i <= 5800) then led_bar_o <= "0000001111";
        elsif (dist_i <= 6960) then led_bar_o <= "0000000111";
        elsif (dist_i <= 8120) then led_bar_o <= "0000000011";
        elsif (dist_i <= 9280) then led_bar_o <= "0000000001";
        elsif (dist_i > 9280)  then led_bar_o <= "0000000000";
        end if;
    
    end process;

end Behavioral;
```

### Sound_signal
#### Listing of VHDL code of the process sound
```vhdl 
sound : process(clk_i)
    begin
    
     if (rising_edge(clk_i)) then
            
        if    (dist_i <= 580)  then         --if the distance in condition is verified 
            if (s_state /= CM10) then       --and s_state value isn't set 
                s_state <= CM10;            --sets s_state 
                s_cnt <= c_ZERO;            --null counters
                s_cnt_1 <= c_ZERO;
            end if;
        elsif (dist_i <= 1160) then
            if (s_state /= CM20) then
                s_state <= CM20;
                s_cnt <= c_ZERO;
                s_cnt_1 <= c_ZERO;
            end if;
        elsif (dist_i <= 1740) then
            if (s_state /= CM30) then
                s_state <= CM30;
                s_cnt <= c_ZERO;
                s_cnt_1 <= c_ZERO;
            end if;
        elsif (dist_i <= 2320) then
            if (s_state /= CM40) then
                s_state <= CM40;
                s_cnt <= c_ZERO;
                s_cnt_1 <= c_ZERO;
            end if;
        elsif (dist_i <= 3480) then
            if (s_state /= CM60) then
                s_state <= CM60;
                s_cnt <= c_ZERO;
                s_cnt_1 <= c_ZERO;
            end if;
        elsif (dist_i <= 4640) then 
            if (s_state /= CM80) then
                s_state <= CM80;
                s_cnt <= c_ZERO;
                s_cnt_1 <= c_ZERO;
            end if;
        elsif (dist_i <= 5800) then
            if (s_state /= CM100) then
                s_state <= CM100;
                s_cnt <= c_ZERO;
                s_cnt_1 <= c_ZERO;
            end if;
        elsif (dist_i <= 6960) then
            if (s_state /= CM120) then
                s_state <= CM120;
                s_cnt <= c_ZERO;
                s_cnt_1 <= c_ZERO;
            end if;
        elsif (dist_i <= 8120) then
            if (s_state /= CM140) then
                s_state <= CM140;
                s_cnt <= c_ZERO;
                s_cnt_1 <= c_ZERO;
            end if;
        elsif (dist_i <= 9280) then
            if (s_state /= CM160) then
                s_state <= CM160;
                s_cnt <= c_ZERO;
                s_cnt_1 <= c_ZERO;
            end if;
        elsif (dist_i > 9280)  then
            if (s_state /= LOW) then
                s_state <= LOW;
                s_cnt <= c_ZERO;
                s_cnt_1 <= c_ZERO;
            end if;
        end if;
    end if;

        
        case s_state is
            when CM10 => 
                buzzer <= clk_i; --sets constant PWM on buzzer
                
            when CM20 =>                                                                --if s_state same as condition(CM20) 
                if (s_cnt < c_DELAY_BEEP) then                                          --if counter is smaller then beep time 
                    buzzer <= clk_i;                                                    --sets buzzer to s_en state (used clk_i instead for simulation lenght)
                    s_cnt <= s_cnt + 1;                                                 --add 1 to counter 
                    s_cnt_1 <= c_ZERO;                                                  --null counter2
                elsif (s_cnt = c_DELAY_BEEP) and (s_cnt_1 < c_DELAY_100ms) then         --if counter for beep time is in time range, counter2 starts to count
                    buzzer <= '0';                                                      --turn of buzzer
                    s_cnt_1 <= s_cnt_1 + 1;                                             --add 1 to counter2
                elsif (s_cnt_1 = c_DELAY_100ms) then                                    --if counter2 is same as delay 
                    s_cnt_1 <= c_ZERO;                                                  --null counters
                    s_cnt <= c_ZERO;
                end if;
                
            when CM30 => 
                if (s_cnt < c_DELAY_BEEP) then 
                    buzzer <= clk_i;
                    s_cnt <= s_cnt + 1;
                    s_cnt_1 <= c_ZERO;
                elsif (s_cnt = c_DELAY_BEEP) and (s_cnt_1 < c_DELAY_200ms) then
                    buzzer <= '0';
                    s_cnt_1 <= s_cnt_1 + 1;
                elsif (s_cnt_1 = c_DELAY_200ms) then
                    s_cnt_1 <= c_ZERO;
                    s_cnt <= c_ZERO;
                end if;
            
            when CM40 => 
                if (s_cnt < c_DELAY_BEEP) then 
                    buzzer <= clk_i;
                    s_cnt <= s_cnt + 1;
                    s_cnt_1 <= c_ZERO;
                elsif (s_cnt = c_DELAY_BEEP) and (s_cnt_1 < c_DELAY_300ms) then
                    buzzer <= '0';
                    s_cnt_1 <= s_cnt_1 + 1;
                elsif (s_cnt_1 = c_DELAY_300ms) then
                    s_cnt_1 <= c_ZERO;
                    s_cnt <= c_ZERO;
                end if;
                
            when CM60 => 
                if (s_cnt < c_DELAY_BEEP) then 
                    buzzer <= clk_i;
                    s_cnt <= s_cnt + 1;
                    s_cnt_1 <= c_ZERO;
                elsif (s_cnt = c_DELAY_BEEP) and (s_cnt_1 < c_DELAY_400ms) then
                    buzzer <= '0';
                    s_cnt_1 <= s_cnt_1 + 1;
                elsif (s_cnt_1 = c_DELAY_400ms) then
                    s_cnt_1 <= c_ZERO;
                    s_cnt <= c_ZERO;
                end if;
                
            when CM80 => 
                if (s_cnt < c_DELAY_BEEP) then 
                    buzzer <= clk_i;
                    s_cnt <= s_cnt + 1;
                    s_cnt_1 <= c_ZERO;
                elsif (s_cnt = c_DELAY_BEEP) and (s_cnt_1 < c_DELAY_500ms) then
                    buzzer <= '0';
                    s_cnt_1 <= s_cnt_1 + 1;
                elsif (s_cnt_1 = c_DELAY_500ms) then
                    s_cnt_1 <= c_ZERO;
                    s_cnt <= c_ZERO;
                end if;
            
            when CM100 => 
                if (s_cnt < c_DELAY_BEEP) then 
                    buzzer <= clk_i;
                    s_cnt <= s_cnt + 1;
                    s_cnt_1 <= c_ZERO;
                elsif (s_cnt = c_DELAY_BEEP) and (s_cnt_1 < c_DELAY_600ms) then
                    buzzer <= '0';
                    s_cnt_1 <= s_cnt_1 + 1;
                elsif (s_cnt_1 = c_DELAY_600ms) then
                    s_cnt_1 <= c_ZERO;
                    s_cnt <= c_ZERO;
                end if;
                
            when CM120 => 
                if (s_cnt < c_DELAY_BEEP) then 
                    buzzer <= clk_i;
                    s_cnt <= s_cnt + 1;
                    s_cnt_1 <= c_ZERO;
                elsif (s_cnt = c_DELAY_BEEP) and (s_cnt_1 < c_DELAY_700ms) then
                    buzzer <= '0';
                    s_cnt_1 <= s_cnt_1 + 1;
                elsif (s_cnt_1 = c_DELAY_700ms) then
                    s_cnt_1 <= c_ZERO;
                    s_cnt <= c_ZERO;
                end if;
                
            when CM140 => 
                if (s_cnt < c_DELAY_BEEP) then 
                    buzzer <= clk_i;
                    s_cnt <= s_cnt + 1;
                    s_cnt_1 <= c_ZERO;
                elsif (s_cnt = c_DELAY_BEEP) and (s_cnt_1 < c_DELAY_800ms) then
                    buzzer <= '0';
                    s_cnt_1 <= s_cnt_1 + 1;
                elsif (s_cnt_1 = c_DELAY_800ms) then
                    s_cnt_1 <= c_ZERO;
                    s_cnt <= c_ZERO;
                end if;
                
            when CM160 => 
                if (s_cnt < c_DELAY_BEEP) then 
                    buzzer <= clk_i;
                    s_cnt <= s_cnt + 1;
                    s_cnt_1 <= c_ZERO;
                elsif (s_cnt = c_DELAY_BEEP) and (s_cnt_1 < c_DELAY_1s) then
                    buzzer <= '0';
                    s_cnt_1 <= s_cnt_1 + 1;
                elsif (s_cnt_1 = c_DELAY_1s) then
                    s_cnt_1 <= c_ZERO;
                    s_cnt <= c_ZERO;
                end if;
                
            when LOW =>             --if the distance is too high
                buzzer <= '0';      --counter and buzzer are disabled

            when others =>
        end case;
    end process;
```
### Clock enable
#### Listing of VHDL code of the process p_clk_ena
```vhdl 
p_clk_ena : process(clk)
    begin
        if rising_edge(clk) then        -- Synchronous process

            if (reset = '1') then       -- High active reset
                s_cnt_local <= 0;       -- Clear local counter
                s_ce_o        <= '0';     -- Set output to low

            -- Test number of clock periods
            elsif (s_cnt_local >= (g_MAX - 1)) then
                s_cnt_local <= 0;       -- Clear local counter
                s_ce_o        <= not s_ce_o;     -- Generate clock enable pulse

            else
                s_cnt_local <= s_cnt_local + 1;
                --ce_o        <= '0';
            end if;
        end if;
        ce_o <= s_ce_o;
    end process p_clk_ena;
```
### TOP module description and simulations
### Top
#### top layout

![top_block_scheme](https://github.com/markolukicluk99/projektVHDL/blob/main/Images/top_block_scheme.png)

#### Listing of VHDL top layer
```vhdl 
entity top is
    Port (
        ck_io8:     out  std_logic;
        ck_io34:    out  std_logic;
        ck_io9:     out  std_logic;
        ck_io35:    out  std_logic;
        ck_io10:    out  std_logic;
        ck_io36:    out  std_logic;
        ck_io11:    out  std_logic;
        ck_io37:    out  std_logic;
        ck_io12:    out  std_logic;
        ck_io38:    out  std_logic;
        ck_io39:    out  std_logic;
        ck_io41:    out  std_logic;
        ck_io40:    in   std_logic;
        CLK100MHZ:  in   std_logic
    );
end top;

architecture Behavioral of top is
signal s_dist : integer;
begin

    hcsr04: entity work.hcsr04
    port map(
        clk_i   => CLK100MHZ,
        echo_i  => ck_io40,
        trig_o  => ck_io41,
        dist_o  => s_dist
    );
        
    sound_signal: entity work.sound_signal
    port map(
        clk_i   => CLK100MHZ,
        dist_i  => s_dist,
        buzzer  => ck_io39
    );
        
    led_bar: entity work.led_bar
    port map(
        clk_i => CLK100MHZ,
        dist_i => s_dist,
        
        led_bar_o(0)  => ck_io8,
        led_bar_o(1)  => ck_io34,
        led_bar_o(2)  => ck_io9,
        led_bar_o(3)  => ck_io35,
        led_bar_o(4)  => ck_io10,
        led_bar_o(5)  => ck_io36,
        led_bar_o(6)  => ck_io11,
        led_bar_o(7)  => ck_io37,
        led_bar_o(8)  => ck_io12,
        led_bar_o(9)  => ck_io38
    );


end Behavioral;
```
### Simulations
V simuláciách nižšie je možné vidieť testovanie pípania a led baru na základe vzdialenosti od 'prekážky'. Na prvej snímke je možné pozorovať všetky simulované vzdialenosti a taktiež na prvý pohľad vidíme ktoré ledky máme na led bare rozsvietené. V prvom zobrazenom prípade teda pri vzdialenosti 20cm je možné pozorovať, že sú rosvietené skoro všetky kdežto v stave LOW, ktorý je od prekážky príliš ďaleko nesvieti ani jedna. 

V ďalších snímkach je možné pozorovať zväčšujúcu sa vzdialenosť medzi pípnutiami bez meniacej sa frekvencie samotného pípnutia pri rôznych vzdialenostiach. 

![Overall simulation](https://github.com/markolukicluk99/projektVHDL/blob/main/Images/full.PNG)
![dist_o](https://github.com/markolukicluk99/projektVHDL/blob/main/Images/CM10-20.PNG)
![dist_o](https://github.com/markolukicluk99/projektVHDL/blob/main/Images/CM40.PNG)
![dist_o](https://github.com/markolukicluk99/projektVHDL/blob/main/Images/CM120.PNG)
![dist_o](https://github.com/markolukicluk99/projektVHDL/blob/main/Images/CM160.PNG)

### Project summary
Tento projekt sme vytvárali podľa vlastnej predstavy o funkčnosti parkovacieho senzoru v osobnom automobile. V kóde sme nastavovali hodnoty vhodné pre simuláciu, ktoré by v prípade parkovacieho senzora do budúcnosti bolo možné zmeniť poprípade zdokonaliť. V budúcnosti by bolo možné projekt rozšíriť o zobrazovanie vzdialenosti od prekážky poprípade po pridaní ďalšieho senzoru na stred auta by bolo možné zobrazovať vzdialenosť podvozku od terénu čo by v prípade terénnych áut mohlo praktické využitie. 


### Introduction video:
[Video](https://youtu.be/h4kNSY-duqI)

### Repo link: 
[Github Link](https://github.com/markolukicluk99/projektVHDL)
