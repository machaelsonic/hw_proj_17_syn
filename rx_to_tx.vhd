library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity rx_to_tx is
  port(rst_n: in std_logic;
       clk: in std_logic;
		 rcv_data:in std_logic_vector(35 downto 0);
		 rcv_data_valid:in std_logic;
       en:out std_logic;
       dout:out std_logic_vector(35 downto 0));
end entity rx_to_tx;
  
architecture rtl of rx_to_tx is

	signal tmp:std_logic_vector(35 downto 0);


   begin
     
     process(rst_n,clk) is
	     begin
		    if rst_n='0'  then
			     tmp<=(others=>'0');
			 elsif clk'event and clk='1' then
			    if rcv_data_valid='1' then
				     tmp<=rcv_data;
				 end if;
				 if rcv_data_valid='1' then
				    en<='1';
				 else
				    en<='0';
				 end if;
			 end if;
	   end process;
	dout<=tmp;	
    end architecture rtl;   

