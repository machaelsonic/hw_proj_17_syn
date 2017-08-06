library ieee;
use ieee.std_logic_1164.all;

entity led is
  port(rst_n: in std_logic;
       clk: in std_logic;
		 d:out std_logic);
end entity led;

architecture rtl of led is
signal cnt:integer range 0 to 52428799;
   begin 
	   process(rst_n,clk) is
		  begin
		    if rst_n='0' then
			    cnt<=0;
			 elsif clk'event and clk='1' then
			    if cnt=52428799 then
				    cnt<=0;
				 else
				    cnt<=cnt+1;
				end if;
				
				 if cnt<26214399 then
				    d<='0';
				 else
				    d<='1';
				 end if;
		    end if;
			 
		end process;
end architecture rtl;
