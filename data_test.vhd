library ieee;
use ieee.std_logic_1164.all;

entity data_test is
   port(datain:in std_logic_vector(11 downto 0);
		  dataout:out std_logic_vector(35 downto 0));
end entity data_test;

architecture  rtl of data_test is
   begin
   dataout<="111111111111111111111111"&datain;
end architecture rtl;