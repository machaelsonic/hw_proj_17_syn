library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity rcv_ram_ctr is
   port(rst: in std_logic;
	     clk: in std_logic;
		  din: in std_logic_vector(11 downto 0);
		  wr_en:in std_logic;
		  wr_adr:out std_logic_vector(9 downto 0);
		  dout:out std_logic_vector(15 downto 0);
		  wr_end:out std_logic);
		end entity rcv_ram_ctr;

architecture rtl of rcv_ram_ctr is
    signal cnt: std_logic_vector(9 downto 0);
   begin
     process(rst,clk) is
	    begin
		   if rst='1' then
		      cnt<=(others=>'0');
				wr_end<='0';
		   elsif clk'event and clk='1' then
		      if wr_en='1' then
				    if cnt=1023 then
					    cnt<=(others=>'0');
						 wr_end<='1';
				    else
			          cnt<=cnt+1;
						 wr_end<='0';
					 end if;
			   end if;
		   end if;
		end process;
	  wr_adr<=cnt;
	  dout<="0000"&din;
--	process(rst,clk) is
--	    begin
--		   if rst='1' then
--		      tmp<=(others=>'0');
--		   elsif clk'event and clk='1' then
--		      if wr_en='1' then
--			       tmp<=tmp+1;
--				else
--				    tmp<=(others=>'0');
--			   end if;
--		   end if;
--		end process;  
--	  
--	 dout<="0000"&tmp;
	 
	 
	end architecture rtl; 