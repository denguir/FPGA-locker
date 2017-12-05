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

  SIGNAL selected_led : STD_LOGIC_VECTOR (1 DOWNTO 0); -- 4 leds

  BEGIN
    update_digit : PROCESS (clk, rst)
    -- modify the value of the selected digit while turning rotary potentiometer
    BEGIN
      IF rst = '1' THEN
        digit_led0 <= (others => '0');
        digit_led1 <= (others => '0');
        digit_led2 <= (others => '0');
        digit_led3 <= (others => '0');

        saved_digit0 <= (others => '0');
        saved_digit1 <= (others => '0');
        saved_digit2 <= (others => '0');
        saved_digit3 <= (others => '0');

        selected_led <= (others => '0');
        unlock_led <= '0';
        lock_led <= '1';

      ELSIF rising_edge(clk) THEN
        IF rotary_pulse = '1' THEN
          IF rotary_dir = '1' THEN
          -- when digit_led = "1111" + '1' -> digit_led = "0000"
            C1: CASE selected_led IS
              WHEN "00" => IF digit_led0 NOT "1111" THEN (digit_led0 <= digit_led0 + '1') ELSE (digit_led0 <= "0000") END IF;
              WHEN "01" => IF digit_led1 NOT "1111" THEN (digit_led1 <= digit_led1 + '1') ELSE (digit_led1 <= "0000") END IF;
              WHEN "10" => IF digit_led2 NOT "1111" THEN (digit_led2 <= digit_led2 + '1') ELSE (digit_led2 <= "0000") END IF;
              WHEN "11" => IF digit_led3 NOT "1111" THEN (digit_led3 <= digit_led3 + '1') ELSE (digit_led3 <= "0000") END IF;
            END CASE C1;

          ELSIF rotary_dir = '0' THEN
          -- when digit_led = "0000" - '1' -> digit_led = "1111"
            C0: CASE selected_led IS
              WHEN "00" => IF digit_led0 NOT "0000" THEN (digit_led0 <= digit_led0 - '1') ELSE (digit_led0 <= "1111") END IF;
              WHEN "01" => IF digit_led1 NOT "0000" THEN (digit_led1 <= digit_led1 - '1') ELSE (digit_led1 <= "1111") END IF;
              WHEN "10" => IF digit_led2 NOT "0000" THEN (digit_led2 <= digit_led2 - '1') ELSE (digit_led2 <= "1111") END IF;
              WHEN "11" => IF digit_led3 NOT "0000" THEN (digit_led3 <= digit_led3 - '1') ELSE (digit_led3 <= "1111") END IF;
            END CASE C0;
          END IF;
        END IF;
      END IF;
    END PROCESS update_digit;

    select_digit : PROCESS (clk, rst)
    -- select the next digit while pressing on the "next" button
    BEGIN
      IF rst = '1' THEN
        digit_led0 <= (others => '0');
        digit_led1 <= (others => '0');
        digit_led2 <= (others => '0');
        digit_led3 <= (others => '0');

        saved_digit0 <= (others => '0');
        saved_digit1 <= (others => '0');
        saved_digit2 <= (others => '0');
        saved_digit3 <= (others => '0');

        selected_led <= (others => '0');
        unlock_led <= '0';
        lock_led <= '1';

      ELSIF rising_edge(clk) THEN
        IF btn_next = '1' THEN
          IF selected_led = "11" THEN
            selected_led <= "00";
          ELSE
            selected_led <= selected_led + '1';
          END IF;
        END IF;
      END IF;
    END PROCESS select_digit;

    save_digit : PROCESS (clk, rst)
    -- save in memory the value of the selected digit while pressing on 'save' button
    BEGIN
      IF rst = '1' THEN
        digit_led0 <= (others => '0');
        digit_led1 <= (others => '0');
        digit_led2 <= (others => '0');
        digit_led3 <= (others => '0');

        saved_digit0 <= (others => '0');
        saved_digit1 <= (others => '0');
        saved_digit2 <= (others => '0');
        saved_digit3 <= (others => '0');

        selected_led <= (others => '0');
        unlock_led <= '0';
        lock_led <= '1';

      ELSIF rising_edge(clk) THEN
        IF btn_save = '1' THEN
          C1: CASE selected_led IS
            WHEN "00" => (saved_digit0 <= digit_led0);
            WHEN "01" => (saved_digit1 <= digit_led1);
            WHEN "10" => (saved_digit2 <= digit_led2);
            WHEN "11" => (saved_digit3 <= digit_led3);
          END CASE C1;
        END IF;
      END IF;
    END PROCESS save_digit;

    unlock : PROCESS (clk, rst)
    BEGIN
      IF rst = '1' THEN
        digit_led0 <= (others => '0');
        digit_led1 <= (others => '0');
        digit_led2 <= (others => '0');
        digit_led3 <= (others => '0');

        saved_digit0 <= (others => '0');
        saved_digit1 <= (others => '0');
        saved_digit2 <= (others => '0');
        saved_digit3 <= (others => '0');

        selected_led <= (others => '0');
        unlock_led <= '0';
        lock_led <= '1';

      ELSIF rising_edge(clk) THEN
        -- if password is correct and button unlock is pressed
        IF (btn_unlock = '1' AND digit_led0 = saved_digit0 AND digit_led1 = saved_digit1
          AND digit_led2 = saved_digit2 AND digit_led3 = saved_digit3) THEN
            unlock_led <= '1';
            lock_led <= NOT lock_led;
        ELSE
          unlock_led <= '0';
          lock_led <= NOT lock_led;
        END IF;
      END IF;
    END PROCESS unlock;

-- put an additionnal bit to digit_led :
-- its value is 1 if it is the selected digit (switch on the point led)
display_led0 <= (selected_led="00") & digit_led0;
display_led1 <= (selected_led="01") & digit_led1;
display_led2 <= (selected_led="10") & digit_led2;
display_led3 <= (selected_led="11") & digit_led3;
END Logic;
