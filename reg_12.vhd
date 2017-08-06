library ieee;
use ieee.std_logic_1164.all;

entity reg_12 is
   port(rst_n: in std_logic;
        clk: in std_logic;
        din: in std_logic_vector(11 downto 0);
        do:out std_logic_vector(11 downto 0));
end entity reg_12;

architecture rtl of reg_12 is
  begin
    process(rst_n,clk) is
      begin
        if rst_n='0' then
           do<=(others=>'0');
        elsif clk'event and clk='1' then
           do<=din;
        end if;
    end process;
end architecture rtl;