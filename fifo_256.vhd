LIBRARY ieee;
USE ieee.std_logic_1164.all; 

entity fifo_256 is
 generic(N: integer:=256);
  port( rst_n: in std_logic;
         clk: in std_logic;
		 en:in std_logic;
		 din:in std_logic_vector(11 downto 0);
		 dout: out std_logic_vector(11 downto 0));
end entity fifo_256;

architecture rtl of fifo_256 is
 
component reg_12_en is
   port(rst_n: in std_logic;
        clk: in std_logic;
		en: in std_logic;
        din: in std_logic_vector(11 downto 0);
        do:out std_logic_vector(11 downto 0));
end component reg_12_en;

type ram is array (0 to 256) of std_logic_vector(11 downto 0);--255
signal reg: ram;

begin
 
reg(0)<=din;
  g1: for i in 0 to N-1 generate --254
      u1: reg_12_en port map(rst_n,clk,en,reg(i),reg(i+1));   
  end generate;
 dout<=reg(N);
 
end rtl;