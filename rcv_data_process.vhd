library ieee;
 use ieee.std_logic_1164.all;
 
 entity rcv_data_process is
    port(rst_n: in std_logic;
	      clk: in std_logic;
			rcv_data_rd_over:in std_logic;
			din: in std_logic_vector(35 downto 0);
			dout:out std_logic_vector(35 downto 0));
end entity rcv_data_process;

architecture rtl of rcv_data_process is
  begin
  
    process( rst_n,clk) is
	    begin
		   if rst_n='0' then
			  dout<=(others=>'0');
			elsif clk'event and clk='1' then
		      if	rcv_data_rd_over='1' then
			       dout<=(others=>'0');
			   else
			       dout<=din;
			   end if;
		   end if;
	end process;
end architecture rtl;