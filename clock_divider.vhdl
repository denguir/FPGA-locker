library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity clock_divider is
  port(
    clk_50Mhz : in std_logic;
    rst : in std_logic;
    clk_4khz : out std_logic
  );
end clock_divider;


architecture behaviour of clock_divider is
  -- (50MhZ/4kHz)*0.5 = 6250 (duty cycle = 0.5)
  -- log2(6250) = 12.6 -> 13 bits
  signal prescaler : unsigned(12 downto 0);
  signal clk_4khz_flag : std_logic;

begin
  divide_clk : process(clk_50Mhz, rst)
  begin
    if rst = '1' then
      clk_4khz_flag <= '0';
      -- assign all the bits of prescaler to 0:
      prescaler <= (others => '0');

    elsif rising_edge(clk_50Mhz) then
      if prescaler = X"186A" then -- X"186A" = 6250 in hex
        prescaler <= (others => '0');
        clk_4khz_flag <= not clk_4khz_flag;
      else
        prescaler <= prescaler + "1";
      end if;
    end if;
  end process divide_clk;

  clk_4khz <= clk_4khz_flag;

end behaviour;
