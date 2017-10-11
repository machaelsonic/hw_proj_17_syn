library ieee;
use ieee.std_logic_1164.all;

entity reg_12_en is
   port(rst_n: in std_logic;
        clk: in std_logic;
		  en: in std_logic;
        din: in std_logic_vector(11 downto 0);
        do:out std_logic_vector(11 downto 0));
end entity reg_12_en;

architecture rtl of reg_12_en is
  begin
    process(rst_n,clk) is
      begin
        if rst_n='0' then
           do<=(others=>'0');
        elsif clk'event and clk='1' then
		     if en='1' then 
              do<=din;
		     end if;
        end if;
    end process;
end architecture rtl;