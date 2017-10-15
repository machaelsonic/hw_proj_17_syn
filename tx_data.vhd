library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tx_data is 
   port(rst_n: in std_logic;
        clk: in std_logic;
        d1: in std_logic_vector(11 downto 0);
        d2: in std_logic_vector(15 downto 0);
        valid1: in std_logic;
        valid2:in std_logic;
        state_cnt: in std_logic_vector(14 downto 0);
        do:out std_logic_vector(11 downto 0);
        data_valid: out std_logic;
		    c0:out std_logic;
		    c1:out std_logic);
end entity tx_data;
architecture rtl of tx_data is
signal do_t:  std_logic_vector(11 downto 0);
signal valid_t,valid1_t,valid_t1:std_logic;
  begin
  
     
    process(rst_n,state_cnt,d1,d2) is
       begin
         if rst_n='0' then
            do<=(others=>'0');
         else
            if state_cnt>=3 and state_cnt<=10242 then
                 do<=d1;
					  --do<=d1(11)&d1(11 downto 1); 
            elsif state_cnt>=10243 and state_cnt<=19134 then
               --do<=d2(11 downto 0);
               do<=d2(9 downto 0)&"00";
            else
               do<=(others=>'0');
            end if;
          end if;
     end process;
    
    process(rst_n,state_cnt) is
       begin
         if rst_n='0' then
            data_valid<='0';
         else
            if state_cnt>=3 and state_cnt<=19134 then
               data_valid<='1';
            else
               data_valid<='0';
            end if;
          end if;
     end process;
  
  process(rst_n,state_cnt) is
       begin
         if rst_n='0' then
             c0<='1';
			       c1<='1'; 
         else
            if state_cnt>=2 and state_cnt<=19135 then
               c0<='0';
			         c1<='0';
            else
               c0<='1';
			         c1<='1'; 
            end if;
          end if;
     end process;
  
  
end architecture rtl;


