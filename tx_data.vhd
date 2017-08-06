library ieee;
use ieee.std_logic_1164.all;

entity tx_data is 
   port(rst_n: in std_logic;
        clk: in std_logic;
        d1: in std_logic_vector(11 downto 0);
        d2: in std_logic_vector(15 downto 0);
        valid1: in std_logic;
        valid2:in std_logic;
        do:out std_logic_vector(11 downto 0);
        data_valid: out std_logic;
		  c0:out std_logic;
		  c1:out std_logic);
end entity tx_data;

architecture rtl of tx_data is
signal do_t:  std_logic_vector(11 downto 0);
signal valid_t,valid1_t,valid_t1:std_logic;
  begin
  
     
    process(rst_n,clk) is
       begin
         if rst_n='0' then
            do_t<=(others=>'0');
            valid1_t<='0';
         elsif clk'event and clk='1' then
            valid1_t<=valid1;
            if valid1='1' then
               --do_t<=d1;
					do_t<=d1(7 downto 0)&"0000";
            else
               if valid2='1' then
                  do_t<=d2(11 downto 0);
						--do_t<=d2(9 downto 0)&"00";
               else
                  do_t<=(others=>'0');
               end if;
            end if;
          end if;
     end process;
     
     valid_t<=valid1_t or valid2;
     valid_t1<=valid1 or valid2;
 process(valid_t, do_t) is
       begin
        if valid_t='1' then
           --do<=do_t(9 downto 0)&"00";
			  do<=do_t;
        else
           do<=(others=>'0');
        end if;   
     end process;
  data_valid<=valid_t;
  
  
    process(valid_t1) is
       begin
        if valid_t1='1' then
          c0<='0';
			 c1<='0';
        else
          c0<='1';
			 c1<='1'; 
        end if;   
     end process;  
  
end architecture rtl;
