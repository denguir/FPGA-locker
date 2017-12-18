LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY Brain IS
  PORT (
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    rotary_dir : IN STD_LOGIC;
    rotary_pulse : IN STD_LOGIC;
    btn_next : IN STD_LOGIC;
    btn_save : IN STD_LOGIC;
    btn_lock : IN STD_LOGIC;
    lock_led : OUT STD_LOGIC;
    unlock_led : OUT STD_LOGIC;
    display_led0 : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
    display_led1 : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
    display_led2 : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
    display_led3 : OUT STD_LOGIC_VECTOR (4 DOWNTO 0)
  );
END Brain;

ARCHITECTURE Logic of Brain is
  SIGNAL digit_led0 : STD_LOGIC_VECTOR (3 DOWNTO 0); -- led 0
  SIGNAL digit_led1 : STD_LOGIC_VECTOR (3 DOWNTO 0); -- led 1
  SIGNAL digit_led2 : STD_LOGIC_VECTOR (3 DOWNTO 0); -- led 2
  SIGNAL digit_led3 : STD_LOGIC_VECTOR (3 DOWNTO 0); -- led 3

  SIGNAL saved_digit0 : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL saved_digit1 : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL saved_digit2 : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL saved_digit3 : STD_LOGIC_VECTOR (3 DOWNTO 0);

  SIGNAL selected_digit : STD_LOGIC_VECTOR (1 DOWNTO 0);

  SIGNAL prev_btn_next : STD_LOGIC;
  SIGNAL prev_btn_save : STD_LOGIC;
  SIGNAL prev_btn_lock : STD_LOGIC;

  BEGIN

    update_digit : PROCESS (clk, rst)
    -- modify the value of the selected digit while turning rotary potentiometer
    BEGIN
      IF rst = '1' THEN
        display_led0 <= (3 => '1', OTHERS => '0');
        display_led1 <= (OTHERS => '0');
        display_led2 <= (OTHERS => '0');
        display_led3 <= (OTHERS => '0');

        digit_led0 <= (OTHERS => '0');
        digit_led1 <= (OTHERS => '0');
        digit_led2 <= (OTHERS => '0');
        digit_led3 <= (OTHERS => '0');

      ELSIF rising_edge(clk) THEN
        IF rotary_pulse = '1' THEN
          IF rotary_dir = '1' THEN
          -- when digit_led = "1001" + '1' -> digit_led = "0000"
            C1: CASE selected_digit IS
              WHEN "00" => IF digit_led0 < "1001" THEN digit_led0 <= digit_led0 + '1'; ELSE digit_led0 <= "0000"; END IF;
              WHEN "01" => IF digit_led1 < "1001" THEN digit_led1 <= digit_led1 + '1'; ELSE digit_led1 <= "0000"; END IF;
              WHEN "10" => IF digit_led2 < "1001" THEN digit_led2 <= digit_led2 + '1'; ELSE digit_led2 <= "0000"; END IF;
              WHEN OTHERS => IF digit_led3 < "1001" THEN digit_led3 <= digit_led3 + '1'; ELSE digit_led3 <= "0000"; END IF;
            END CASE C1;

          ELSIF rotary_dir = '0' THEN
          -- when digit_led = "0000" - '1' -> digit_led = "1001"
            C0: CASE selected_digit IS
              WHEN "00" => IF digit_led0 > "0000" THEN digit_led0 <= digit_led0 - '1'; ELSE digit_led0 <= "1001"; END IF;
              WHEN "01" => IF digit_led1 > "0000" THEN digit_led1 <= digit_led1 - '1'; ELSE digit_led1 <= "1001"; END IF;
              WHEN "10" => IF digit_led2 > "0000" THEN digit_led2 <= digit_led2 - '1'; ELSE digit_led2 <= "1001"; END IF;
              WHEN OTHERS => IF digit_led3 > "0000" THEN digit_led3 <= digit_led3 - '1'; ELSE digit_led3 <= "1001"; END IF;
            END CASE C0;
          END IF;
        END IF;
        -- update the displayed digit using the digit_led and the selected_digit signals
        CASE selected_digit IS
          WHEN "00" =>  display_led0 <= '1' & digit_led0;
                        display_led1 <= '0' & digit_led1;
                        display_led2 <= '0' & digit_led2;
                        display_led3 <= '0' & digit_led3;

          WHEN "01" =>  display_led0 <= '0' & digit_led0;
                        display_led1 <= '1' & digit_led1;
                        display_led2 <= '0' & digit_led2;
                        display_led3 <= '0' & digit_led3;

          WHEN "10" =>  display_led0 <= '0' & digit_led0;
                        display_led1 <= '0' & digit_led1;
                        display_led2 <= '1' & digit_led2;
                        display_led3 <= '0' & digit_led3;

          WHEN OTHERS =>  display_led0 <= '0' & digit_led0;
                          display_led1 <= '0' & digit_led1;
                          display_led2 <= '0' & digit_led2;
                          display_led3 <= '1' & digit_led3;
        END CASE;
      END IF;
    END PROCESS update_digit;

    select_digit : PROCESS (clk, rst)
    -- select the next digit while pressing on the "next" button
    BEGIN
      IF rst = '1' THEN
        select_digit <= (OTHERS => '0');
        prev_btn_next <= '0';

      ELSIF rising_edge(clk) THEN
        IF btn_next = '1' AND prev_btn_next = '0' THEN
          prev_btn_next <= '1';
          IF selected_digit < "11" THEN
            selected_digit <= selected_digit + '1';
          ELSE
            selected_digit <= "00";
          END IF;
        ELSIF btn_next = '0' AND prev_btn_next = '1' THEN
          prev_btn_next <= '0';
        END IF;
      END IF;
    END PROCESS select_digit;

    save_digit : PROCESS (clk, rst)
    -- save in memory the value of the 4 digits while pressing on 'save' button
    BEGIN
      IF rst = '1' THEN
        saved_digit0 <= (OTHERS => '0')
        saved_digit1 <= (OTHERS => '0')
        saved_digit2 <= (OTHERS => '0')
        saved_digit3 <= (OTHERS => '0')
        prev_btn_save <= '0';

      ELSIF rising_edge(clk) THEN
        IF btn_save = '1' AND prev_btn_save = '0' THEN
          prev_btn_save <= '1';
          saved_digit0 <= digit_led0;
          saved_digit1 <= digit_led1;
          saved_digit2 <= digit_led2;
          saved_digit3 <= digit_led3;
        ELSIF btn_save = '0' AND prev_btn_save = '1' THEN
          prev_btn_save <= '0';
        END IF;
      END IF;
    END PROCESS save_digit;

    unlock : PROCESS (clk, rst)
    BEGIN
      IF rst = '1' THEN
        prev_btn_lock <= '0';
        lock_led <= '1'; -- initially locked
        unlocked_led <= '0';

      ELSIF rising_edge(clk) THEN
        -- if password is correct and btn_lock is pressed while the state is locked then unlock
        IF (btn_lock = '1' AND prev_btn_lock = '0' AND lock_led = '1' AND unlock_led = '0' AND digit_led0 = saved_digit0
            AND digit_led1 = saved_digit1 AND digit_led2 = saved_digit2 AND digit_led3 = saved_digit3) THEN
            prev_btn_lock <= '1';
            unlock_led <= '1';
            lock_led <= '0';
            -- display set to "0000"
            digit_led0 <= (OTHERS => '0');
            digit_led1 <= (OTHERS => '0');
            digit_led2 <= (OTHERS => '0');
            digit_led3 <= (OTHERS => '0');

        -- if btn_lock is pressed while the state is unlocked then lock
        ELSIF (btn_lock = '1' AND prev_btn_lock = '0' AND lock_led = '0' AND unlock_led = '1') THEN
            prev_btn_lock <= '1';
            unlock_led <= '0';
            lock_led <= '1';
        -- when the button is unpressed
        ELSIF (btn_lock = '0' AND prev_btn_lock = '1') THEN
            prev_btn_lock <= '0';

        END IF;
      END IF;
    END PROCESS unlock;
END Logic;
