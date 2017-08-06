library ieee;
use ieee.std_logic_1164.all;

entity data_cut is 
   port(rst_n,clk: in std_logic;
        din: in std_logic_vector(23 downto 0);
        do:out std_logic_vector(23 downto 0));
end entity data_cut;

architecture rtl of data_cut is
  begin
  process(rst_n,clk) is
    begin
	   if rst_n='0' then
		    do<=(others=>'0');
	    elsif clk'event and clk='1' then
     --do<=din(11)&din(11)&din(11 downto 2);
	      do<=din;
	    end if;
	end process;
end architecture rtl;