LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.STD_LOGIC_UNSIGNED.all;

ENTITY i_digit IS
  PORT(
    i_clk : IN  STD_LOGIC;
    i_rst : IN  STD_LOGIC;

    i_digit1 : IN  STD_LOGIC_vector(4 downto 0);
    i_digit2 : IN  STD_LOGIC_vector(4 downto 0);
    i_digit3 : IN  STD_LOGIC_vector(4 downto 0);
    i_digit4 : IN  STD_LOGIC_vector(4 downto 0);

    o_selected_digit : OUT  STD_LOGIC_vector(3 downto 0);
    o_i_digit_digit   : OUT  STD_LOGIC_vector(7 downto 0)
  );
END i_digit ;


ARCHITECTURE arch OF Diplay IS
  signal Counter : STD_LOGIC_vector(1 downto 0);
  signal Led1 :  STD_LOGIC_vector(7 downto 0);
  signal Led2 :  STD_LOGIC_vector(7 downto 0);
  signal Led3 :  STD_LOGIC_vector(7 downto 0);
  signal Led4 :  STD_LOGIC_vector(7 downto 0);

BEGIN
  i_digit_digits : Process(i_clk, i_rst)
  begin
  if i_rst = '1' then
    Counter <= "00";
    Led1 <= (others =>'0');
    Led2 <= (others =>'0');
    Led3 <= (others =>'0');
    Led4 <= (others =>'0');
    o_selected_digit <= "1111";
    o_i_digit_digit <= "11111111";

  elsif rising_edge(i_clk) then
    Counter <= Counter + 1;

    case i_digit1(3 downto 0) is
      when "0000"   => Led1(7 downto 1) <=   "0000001"; --0
      when "0001"   => Led1(7 downto 1) <=   "1001111"; --1
      when "0010"   => Led1(7 downto 1) <=   "0010010"; --2
      when "0011"   => Led1(7 downto 1) <=   "0000110"; --3
      when "0100"   => Led1(7 downto 1) <=   "1001100"; --4
      when "0101"   => Led1(7 downto 1) <=   "0100100"; --5
      when "0110"   => Led1(7 downto 1) <=   "0100000"; --6
      when "0111"   => Led1(7 downto 1) <=   "0001111"; --7
      when "1000"   => Led1(7 downto 1) <=   "0000000"; --8
      when "1001"   => Led1(7 downto 1) <=   "0000100"; --9
      when "1010"   => Led1(7 downto 1) <=   "0001000"; --A
      when "1011"   => Led1(7 downto 1) <=   "1100000"; --B
      when "1100"   => Led1(7 downto 1) <=   "0110001"; --C
      when "1101"   => Led1(7 downto 1) <=   "1000010"; --D
      when "1110"   => Led1(7 downto 1) <=   "0110000"; --E
      when others   => Led1(7 downto 1) <=   "0111000"; --F
    end case;

    case i_digit1(4) is
      when '0'      => Led1(0)          <=   '1'
      when others   => Led1(0)          <=   '0'
    end case;


    case i_digit2(3 downto 0) is
      when "0000"   => Led2(7 downto 1) <=   "0000001"; --0
      when "0001"   => Led2(7 downto 1) <=   "1001111"; --1
      when "0010"   => Led2(7 downto 1) <=   "0010010"; --2
      when "0011"   => Led2(7 downto 1) <=   "0000110"; --3
      when "0100"   => Led2(7 downto 1) <=   "1001100"; --4
      when "0101"   => Led2(7 downto 1) <=   "0100100"; --5
      when "0110"   => Led2(7 downto 1) <=   "0100000"; --6
      when "0111"   => Led2(7 downto 1) <=   "0001111"; --7
      when "1000"   => Led2(7 downto 1) <=   "0000000"; --8
      when "1001"   => Led2(7 downto 1) <=   "0000100"; --9
      when "1010"   => Led2(7 downto 1) <=   "0001000"; --A
      when "1011"   => Led2(7 downto 1) <=   "1100000"; --B
      when "1100"   => Led2(7 downto 1) <=   "0110001"; --C
      when "1101"   => Led2(7 downto 1) <=   "1000010"; --D
      when "1110"   => Led2(7 downto 1) <=   "0110000"; --E
      when others   => Led2(7 downto 1) <=   "0111000"; --F
    end case;

    case i_digit2(4) is
      when '0'      => Led2(0)          <=   '1'
      when others   => Led2(0)          <=   '0'
    end case;


    case i_digit3(3 downto 0) is
      when "0000"   => Led3(7 downto 1) <=   "0000001"; --0
      when "0001"   => Led3(7 downto 1) <=   "1001111"; --1
      when "0010"   => Led3(7 downto 1) <=   "0010010"; --2
      when "0011"   => Led3(7 downto 1) <=   "0000110"; --3
      when "0100"   => Led3(7 downto 1) <=   "1001100"; --4
      when "0101"   => Led3(7 downto 1) <=   "0100100"; --5
      when "0110"   => Led3(7 downto 1) <=   "0100000"; --6
      when "0111"   => Led3(7 downto 1) <=   "0001111"; --7
      when "1000"   => Led3(7 downto 1) <=   "0000000"; --8
      when "1001"   => Led3(7 downto 1) <=   "0000100"; --9
      when "1010"   => Led3(7 downto 1) <=   "0001000"; --A
      when "1011"   => Led3(7 downto 1) <=   "1100000"; --B
      when "1100"   => Led3(7 downto 1) <=   "0110001"; --C
      when "1101"   => Led3(7 downto 1) <=   "1000010"; --D
      when "1110"   => Led3(7 downto 1) <=   "0110000"; --E
      when others   => Led3(7 downto 1) <=   "0111000"; --F
    end case;

    case i_digit3(4) is
      when '0'      => Led3(0)          <=   '1'
      when others   => Led3(0)          <=   '0'
    end case;


    case i_digit4(3 downto 0) is
      when "0000"   => Led4(7 downto 1) <=   "0000001"; --0
      when "0001"   => Led4(7 downto 1) <=   "1001111"; --1
      when "0010"   => Led4(7 downto 1) <=   "0010010"; --2
      when "0011"   => Led4(7 downto 1) <=   "0000110"; --3
      when "0100"   => Led4(7 downto 1) <=   "1001100"; --4
      when "0101"   => Led4(7 downto 1) <=   "0100100"; --5
      when "0110"   => Led4(7 downto 1) <=   "0100000"; --6
      when "0111"   => Led4(7 downto 1) <=   "0001111"; --7
      when "1000"   => Led4(7 downto 1) <=   "0000000"; --8
      when "1001"   => Led4(7 downto 1) <=   "0000100"; --9
      when "1010"   => Led4(7 downto 1) <=   "0001000"; --A
      when "1011"   => Led4(7 downto 1) <=   "1100000"; --B
      when "1100"   => Led4(7 downto 1) <=   "0110001"; --C
      when "1101"   => Led4(7 downto 1) <=   "1000010"; --D
      when "1110"   => Led4(7 downto 1) <=   "0110000"; --E
      when others   => Led4(7 downto 1) <=   "0111000"; --F
    end case;

    case i_digit4(4) is
      when '0'      => Led4(0)          <=   '1'
      when others   => Led4(0)          <=   '0'
    end case;


    case Counter is
      when "00"   => o_selected_digit <= "0111"; -- i_digit left left
      when "01"   => o_selected_digit <= "1011"; -- i_digit left
      when "10"   => o_selected_digit <= "1101"; -- i_digit right
      when others => o_selected_digit <= "1110"; -- i_digit right right
    end case;

    case Counter is
      when "00"   => o_i_digit_digit <= Led1;
      when "01"   => o_i_digit_digit <= Led2;
      when "10"   => o_i_digit_digit <= Led3;
      when others => o_i_digit_digit <= Led4;
    end case;

  end if;

end process;

END ARCHITECTURE arch;
