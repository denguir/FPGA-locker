--
-- VHDL Architecture VHDL_PROJECT_lib.Rotary.encoder
--
-- Created:
--          by - Labo.UNKNOWN (PC-000)
--          at - 15:16:39 29/11/2017
--
-- using Mentor Graphics HDL Designer(TM) 2013.1b (Build 2)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Rotary IS
   PORT( 
      A   : IN     STD_LOGIC;
      B   : IN     STD_LOGIC;
      clk : IN     STD_LOGIC;
      rst : IN     STD_LOGIC;
      P   : OUT    STD_LOGIC;
      DIR : OUT    STD_LOGIC
   );

-- Declarations

END Rotary ;

--
ARCHITECTURE encoder OF Rotary IS
  signal Ar,Br : STD_LOGIC_VECTOR(1 downto 0); -- Ar(0) = present, Ar(1) = past
BEGIN
  PROCESS (clk, rst)
  BEGIN
    if rst = '1' then
      P <= '0';
      DIR <= '0';
      Ar <= "00"; 
      Br <= "00";
    elsif rising_edge(clk) then
      Ar <= Ar(0)&A; -- & = union
      Br <= Br(0)&B;
      if (Ar = "01") then
        P <= '1';
        if (B = '0') then
          DIR <= '1'; -- A leads B
        else 
          DIR <= '0';
        end if;
        
      elsif (Ar = "10") then
        P <= '1';
        if (B = '1') then
          DIR <= '1'; -- A leads B
        else 
          DIR <= '0';
        end if;
      
      elsif (Br = "01") then
        P <= '1';
        if (A = '1') then
          DIR <= '1'; -- A leads B
        else 
          DIR <= '0';
        end if;
      
      elsif (Br = "10") then
        P <= '1';
        if (A = '0') then
          DIR <= '1'; -- A leads B
        else 
          DIR <= '0';
        end if;
      
      else
        P <= '0';
      end if;
    end if;
  END PROCESS;
END ARCHITECTURE encoder;

