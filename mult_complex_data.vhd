library ieee;
use ieee.std_logic_1164.all;
entity mult_complex_data is
   port( rst_n: in std_logic;
         clk: in std_logic;
			din_real_clc: in std_logic_vector(24 downto 0);
         din_imag_clc: in std_logic_vector(24 downto 0);
			source_valid: in std_logic;
         source_sop: in std_logic;
         source_eop: in std_logic;
         sink_sop: out std_logic;
         sink_eop: out std_logic;
         sink_valid: out std_logic;
			dout_real_clc:out std_logic_vector(24 downto 0);
			dout_imag_clc:out std_logic_vector(24 downto 0));
end entity mult_complex_data;

architecture rtl of mult_complex_data is
begin
process(rst_n,clk) is
  begin
     if rst_n='0' then
	      sink_sop<='0';
         sink_eop<='0';
         sink_valid<='0';
			dout_real_clc<=(others=>'0');
			dout_imag_clc<=(others=>'0');
	  elsif clk'event and clk='1' then
	      sink_sop<=source_sop;
         sink_eop<=source_eop;
         sink_valid<=source_valid;
			dout_real_clc<=din_real_clc;
			dout_imag_clc<=din_imag_clc;
		end if;
end process;

end architecture rtl;