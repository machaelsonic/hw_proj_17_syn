library ieee;
use ieee.std_logic_1164.all;

entity data_direction is
   port(rst:in std_logic;
	     clk:in std_logic;
	     tx_en: in std_logic;
	     rx_en:in std_logic;
	     rx_data: out std_logic_vector(11 downto 0);
		  tx_data:in std_logic_vector(11 downto 0);
		  tx_rx_data:inout std_logic_vector(11 downto 0));
end entity data_direction;



--architecture  rtl of data_direction is 
--   signal tmp:std_logic_vector(11 downto 0);
--   begin
--	   process(rst,clk) is
--		  begin
--		   if rst='1' then
--			   rx_data<=(others=>'0');
--			   tmp<=(others=>'Z');
--		   elsif clk'event and clk='1' then	
--		    if rx_en='1' then
--			     rx_data<=tx_rx_data;
--			     tmp<=(others=>'Z');
--			 else
--			     tmp<=tx_data;
--			     rx_data<=(others=>'Z');
--			 end if;
--			end if;
--		end process;
--		
--          tx_rx_data<=tmp;
--end architecture rtl;

architecture  rtl of data_direction is 
   signal tmp:std_logic_vector(11 downto 0);
   begin
	   process(rst,rx_en,tx_rx_data,tx_data) is
		  begin
		   if rst='1' then
			   rx_data<=(others=>'0');
			   tmp<=(others=>'Z');
		   else
		    if rx_en='1' then
			     rx_data<=tx_rx_data;
			     tmp<=(others=>'Z');
			 else
			      tmp<=tx_data;
			      rx_data<=(others=>'0');	
			    end if;
			  end if;
		end process;
		tx_rx_data<=tmp;
          
end architecture rtl;

