library ieee;
use ieee.std_logic_1164.all;

entity mcp_spi is
   port(rst_n: in std_logic;
        clk_20M: in std_logic; --20M
        start:in std_logic;
        din:in std_logic_vector(15 downto 0);
        cs:out std_logic;
        sclk:out std_logic;
        ldac_n:out std_logic;
        do:out std_logic);
end entity mcp_spi;

architecture rtl of mcp_spi is
   signal tmp:std_logic_vector(15 downto 0);
   signal ls,oe:std_logic;
   type state_t is (s_rst,s_idle,s0,s1,s2 );
   signal state,next_state:state_t;
 
   signal cnt:integer range 0 to 15; 
   signal cnt_en:std_logic;
   signal clk:std_logic; --2M
   begin
   
--  process(rst_n,clk_20M) is
--     variable div:integer range 0 to 9;
--    begin
--      if rst_n='0' then
--         div:=0;
--      elsif clk_20M'event and clk_20M='1' then
--         if div=9 then
--            div:=0;
--         else
--            div:=div+1;
--         end if;  
--      if div<5 then
--         clk<='0';
--      else
--         clk<='1';
--      end if;
--    end if;
--    end process;  
clk<=clk_20M; 
   process(rst_n,clk,ls,din,tmp,oe) is 
    begin
      if rst_n='0' then
         tmp<=(others=>'0');
      elsif ls='1' then
           tmp<=din;
      elsif clk'event and clk='1' then
        
           for i in 14 downto 0 loop
              tmp(i+1)<=tmp(i);
           end loop;
        --do_tmp<=tmp(15); 

       end if;
       if oe='1' then
          do<=tmp(15);
         else
          do<='Z';
         end if;
   end process;
   
   process(rst_n,clk) is
      begin
         if rst_n='0' then
            cnt<=0;
         elsif clk'event and clk='1' then
           if cnt_en='1' then
            if cnt=15 then
               cnt<=0;
             else
               cnt<=cnt+1;
             end if;
           end if;
         end if; 
   end process;
   
   process(rst_n,clk) is
    begin
      if rst_n='0' then
        state<=s_rst;
      elsif clk'event and clk='1' then
        state<=next_state;
      end if;
   end process;
   
   
   process(rst_n,start,state,cnt) is

    begin
     case state is
       when s_rst =>
         if rst_n='0' then
            next_state<=s_rst;
         else
            next_state<=s_idle;
         end if;
      when s_idle =>
         if start='1' then
            next_state<=s0;
         else
            next_state<=s_idle;
         end if;     
      when s0 =>
            if cnt=15 then
               next_state<=s1; 
            else
               next_state<=s0;
            end if;
 
      when s1 =>
           next_state<=s2;     
      when s2 =>
           next_state<=s_idle;  
     end case;           
   end process; 
    
    process(state,clk) is
      begin
        case state is
          when s_rst =>
             cs<='1';
             sclk<='0';
             ldac_n<='1';
             ls<='0';
             oe<='0';
             cnt_en<='0';
          when s_idle =>
             cs<='1';
             sclk<='0';
             ldac_n<='1';
             ls<='1';
             oe<='0';
             cnt_en<='0';
          when s0 =>
             cs<='0';
             sclk<=not clk;
             ldac_n<='1';
             ls<='0';
             oe<='1';
             cnt_en<='1';
          when s1 =>
             cs<='1';
             sclk<='0';
             ldac_n<='1';
             ls<='0';
             oe<='0';
             cnt_en<='0';
          when s2 =>
             cs<='1';
             sclk<='0';
             ldac_n<='0';
             ls<='0';
             oe<='0';
             cnt_en<='0';
        end case;
     end process;
 end architecture rtl;    
              