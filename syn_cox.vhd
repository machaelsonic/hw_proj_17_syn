library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
entity syn_cox is
  port(rst_n: in std_logic;
       reg_flush:in std_logic;
       clk: in std_logic;
       din: in std_logic_vector(11 downto 0);
       dout1:out std_logic_vector(31 downto 0);
       dout2:out std_logic_vector(31 downto 0);
       dout:out std_logic_vector(11 downto 0));
       
       
       --frame_syn:out std_logic_vector(31 downto 0);
       --symbol_syn:out std_logic_vector(19 downto 0));

end entity syn_cox;

architecture rtl of syn_cox is

   component reg_12 is
     port(rst_n: in std_logic;
          clk: in std_logic;
          din: in std_logic_vector(11 downto 0);
          do:out std_logic_vector(11 downto 0));
    end component reg_12;
    

    
type ram is array (0 to 1023) of std_logic_vector(11 downto 0);
signal reg,reg0: ram;
signal reg_buff,reg1,reg2:ram;

 --signal dout1,dout2,dout3:std_logic_vector(31 downto 0);
 --signal dout4,max_dout4:std_logic_vector(19 downto 0);


 --signal symbol_syn_point,symbol_syn_p:integer range 0 to 511;
 --signal payload_data_valid:std_logic;

signal reg_o: std_logic_vector(11 downto 0);
type rom is array (1023 downto 0) of std_logic; --255
signal rst_n1:std_logic;                     
 begin
  rst_n1<=rst_n and (not(reg_flush));
  --reg(0)<=din(11)&din(11)&din(11 downto 2);
  reg(0)<=din;
  g1: for i in 0 to 1022 generate  
      u1: reg_12 port map(rst_n1,clk,reg(i),reg(i+1));   
  end generate;
     u2:  reg_12 port map(rst_n1,clk,reg(1023),reg0(0));
  dout<=reg0(0);
  g2: for i in 0 to 1022 generate  
      u3: reg_12 port map(rst_n1,clk,reg0(i),reg0(i+1));   
  end generate;
     u4:  reg_12 port map(rst_n1,clk,reg0(1023),reg_o); 


process(rst_n1,clk)is
     variable a:std_logic_vector(23 downto 0);
     variable s:std_logic_vector(31 downto 0);
     begin
        if rst_n1='0' then
           dout2<=(others=>'0');
           s:=(others=>'0');
        elsif clk'event and clk='1' then
           a:=std_logic_vector((signed(reg(0))-signed(reg_o))*signed(reg0(0)));
           s:=std_logic_vector(signed(s)+signed(a));    
        end if;
        --dout2<=s(27 downto 0)&"0000";
        dout2<=s;
  end process; 
 process(rst_n1,clk)is
     variable a:std_logic_vector(23 downto 0);
     variable s:std_logic_vector(31 downto 0);
     begin
        if rst_n1='0' then
           dout1<=(others=>'0');
           s:=(others=>'0');
        elsif clk'event and clk='1' then
           a:=std_logic_vector(signed(reg(0))*signed(reg(0))-signed(reg_o)*signed(reg_o));
           s:=std_logic_vector(signed(s)+signed(a));    
        end if;
        dout1<=s;
        --dout1<=s(31)&s(31 downto 1);
  end process; 
  
  
-- process(dout1,dout2) is
--    begin
--      if signed(dout1)/=0 then
--         dout3<=std_logic_vector(signed(dout2)/signed(dout1));
--      else
--         dout3<=(others=>'0');
--      end if;
--  end process;  
--frame_syn<=dout3;    
--  symbol_syn<=(others=>'0'); 

   
                       
end architecture rtl;
         

         
       


