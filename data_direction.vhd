library ieee;
use ieee.std_logic_1164.all;

entity data_direction is
   port(rst:in std_logic;
	     clk:in std_logic;
	     tx_data_valid: in std_logic;
	     rx_data: out std_logic_vector(11 downto 0);
		  tx_data:in std_logic_vector(11 downto 0);
		  tx_rx_data:inout std_logic_vector(11 downto 0));
end entity data_direction;



--architecture  rtl of data_direction is
--  signal tmp:std_logic_vector(11 downto 0);
--   begin
--	   process(tx_data_valid,tx_rx_data,tx_data) is
--		  begin
--		    if tx_data_valid='0' then
--			     rx_data<=tx_rx_data;
--			     tmp<=(others=>'Z');
--				  --tmp<=tx_rx_data;
--			 else
--			     tmp<=tx_data;
--			     rx_data<=(others=>'Z');
--				  
--			 end if;
--		end process;
--		tx_rx_data<=tmp;
--end architecture rtl;

--architecture  rtl of data_direction is
--  signal tmp:std_logic_vector(11 downto 0);
--   begin
--    rx_data<=tx_rx_data;
--end architecture rtl;
--
architecture  rtl of data_direction is 
   signal tmp:std_logic_vector(11 downto 0);
   begin
	   process(rst,clk) is
		  begin
		   if rst='1' then
			   rx_data<=(others=>'0');
			   tmp<=(others=>'Z');
		   elsif clk'event and clk='1' then	
		    if tx_data_valid='0' then
			     rx_data<=tx_rx_data;
			     tmp<=(others=>'Z');
			 else
			     tmp<=tx_data;
			     rx_data<=(others=>'Z');
			 end if;
			end if;
		end process;
		
          tx_rx_data<=tmp;
end architecture rtl;


--architecture  rtl of data_direction is 
--   signal tmp:std_logic_vector(11 downto 0);
--	signal tx_data_valid_delay,clr:std_logic;
--   begin
--	   process(rst,clk) is
--		  begin
--		   if rst='1' then
--			   rx_data<=(others=>'0');
--			   tmp<=(others=>'Z');
--		   elsif clk'event and clk='1' then	
--		    if tx_data_valid='1' then
--			     tmp<=tx_data;
--			     rx_data<=(others=>'Z');
--			 else
--			    if tx_data_valid_delay='0' then
--			     rx_data<=tx_rx_data;
--				 end if;
--			     tmp<=(others=>'Z');			     
--			 end if;
--			 tx_data_valid_delay<=tx_data_valid;
--			end if;
--		end process;
--		
--		process(tx_data_valid,tx_data_valid_delay) is
--		   begin
--			    if tx_data_valid='0' and tx_data_valid_delay='1' then
--				    clr<='1';
--				 else
--				    clr<='0';
--				 end if;
--		end process;
--		process(clr) is
--		   begin
--			  if clr='1' then
--			     tx_rx_data<=(others=>'0');
--			  else
--              tx_rx_data<=tmp;
--			  end if;
--		 end process;
--	 rcv_data_valid<=not(tx_data_valid or tx_data_valid_delay);	 
--end architecture rtl;