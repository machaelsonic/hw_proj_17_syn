LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.std_logic_unsigned.all; 
LIBRARY work;
use ieee.numeric_std.all;
use std.textio.all;

entity tb_hpf is
end entity tb_hpf;

architecture rtl of tb_hpf is

component hpf is
  port( clk_20M: in std_logic;
        rst_rx_syn:in std_logic;
		  din: in std_logic_vector(11 downto 0);
		  dout: out std_logic_vector(11 downto 0));
end component hpf;

FILE tb_rx_data_tranceiver:TEXT OPEN READ_MODE IS "tb_tx_data_tranceiver3.txt";
FILE tb_hpf_dout:TEXT OPEN WRITE_MODE IS "tb_hpf_dout.txt";

signal  clk_20M:  std_logic;
signal  rst_rx_syn: std_logic;
signal  din:   std_logic_vector(11 downto 0);
signal  dout:std_logic_vector(11 downto 0);
signal  rx_data_from_file_int_signal:  integer;
begin




PROCESS                                               
-- variable declarations                                     
BEGIN 
    rst_rx_syn<='1';
	 wait for 770 ns;                                                        
    rst_rx_syn<='0';
    wait;    -- code that executes only once                      
END PROCESS ;   
                                                                                               
 

 PROCESS                                                                         
   BEGIN                                                         

      clk_20M<='1';
    wait for 20 ns;
      clk_20M<='0';
    wait for 20 ns; 
   end process;
	
	process(rst_rx_syn,clk_20M) is
 	VARIABLE lo_1:LINE;
 	  variable rx_data_from_file_int: integer;
    BEGIN
      if rst_rx_syn='1' then
          din<=(others=>'0');
      elsif rising_edge(clk_20M) then
           if not(endfile(tb_rx_data_tranceiver)) then
			        READLINE (tb_rx_data_tranceiver,lo_1);
			        READ (lo_1,rx_data_from_file_int);
			          rx_data_from_file_int_signal<=rx_data_from_file_int;	
		             din<=std_logic_vector(to_signed(rx_data_from_file_int,12));	
		       end if;
		   end if;
	end process;
	
process(clk_20M) is
 	VARIABLE lo_1:LINE;
 	
    BEGIN
	     if rising_edge(clk_20M) then
					WRITE (lo_1,to_integer(signed(dout)),left,10);
					WRITELINE (tb_hpf_dout,lo_1);
				 end if;
end process;

u1: hpf port map(
        clk_20M=> clk_20M,
        rst_rx_syn=>rst_rx_syn,
		  din=> din,
		  dout=>dout);
 

end architecture rtl;