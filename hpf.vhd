LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.std_logic_unsigned.all; 

entity hpf is
  port( clk_20M: in std_logic;
        rst_rx_syn:in std_logic;
		  din: in std_logic_vector(11 downto 0);
		  dout: out std_logic_vector(11 downto 0));
end entity hpf;

architecture rtl of hpf is
 signal  tmp1,tmp2,tmp3,tmp4,tmp5,tmp6:std_logic_vector(15 downto 0); 
 begin
process(rst_rx_syn,clk_20M) is
  begin
     if rst_rx_syn='1' then
          tmp3<=(others=>'0');
     elsif clk_20M'event and clk_20M='1' then
          tmp3<=tmp2;
     end if;
end process; 
process(rst_rx_syn,din,tmp5) is
  begin
    if rst_rx_syn='1' then
	     tmp1<=(others=>'0');
		  tmp2<=(others=>'0');
	 else
      tmp1<=din(11)&din(11)&din(11)&din(11)&din(11 downto 0);      
      tmp2<=(din(11)&din(11)&din(11)&din(11)&din(11 downto 0))+tmp5;
   end if;
end process;

process(rst_rx_syn,tmp3) is
  begin
    if rst_rx_syn='1' then
		 tmp4<=(others=>'0');
		 tmp5<=(others=>'0');
	 else     
     tmp4<=tmp3(15)&tmp3(15)&tmp3(15)&tmp3(15)&tmp3(15 downto 4);
     tmp5<=tmp3-(tmp3(15)&tmp3(15)&tmp3(15)&tmp3(15)&tmp3(15 downto 4));
   end if;
end process;

process(rst_rx_syn,tmp1,tmp4) is
  begin
    if rst_rx_syn='1' then
		   tmp6<=(others=>'0');
	 else     
       tmp6<=tmp1-tmp4;
   end if;
end process;
dout<=tmp6(11 downto 0);
end architecture rtl;