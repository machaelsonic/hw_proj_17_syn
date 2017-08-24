library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity ifft_ram_wr_ctr is
  port(rst_n: in std_logic;
       clk: in std_logic;
       din: in std_logic_vector(11 downto 0);
       sop: in std_logic;
       state_cnt: in std_logic_vector(12 downto 0);
       dout:out std_logic_vector(15 downto 0);
       wr_en:out std_logic;
       wr_adr:out std_logic_vector(7 downto 0);
       wr_sel:out std_logic);
end entity ifft_ram_wr_ctr;

architecture rtl of ifft_ram_wr_ctr is
  signal wr_sel_t:std_logic;
  signal tmp1:std_logic_vector(7 downto 0);
  signal wr_data:std_logic_vector(15 downto 0);
  type state_t is (s_rst,s_idle,s_wr);
  signal state,next_state:state_t;
  signal wr_adr_cnt_en:std_logic;
  signal wr_cnt:integer range 0 to 255;
  --signal ram_sel_t:std_logic;
  begin
    process(rst_n,clk) is
      begin
        if rst_n='0' then
            state<=s_rst;
        elsif clk'event and clk='1' then
            state<=next_state;
        end if;
    end process;
    
    process(state,rst_n,state_cnt,wr_cnt) is
      begin
         case state is
            when s_rst =>
              if rst_n='1' then
                 next_state<=s_idle;
              else
                 next_state<=s_rst;
              end if;
            when s_idle =>
              if state_cnt=2306 then
                 next_state<=s_wr;
              else
                 next_state<=s_idle;
              end if;
            when s_wr =>
              if state_cnt=3842 then
                  next_state<=s_idle;
              else
                 next_state<=s_wr;
              end if;
          end case;  
    end process;
    process(state) is
      begin
         case state is
            when s_rst =>
              wr_en<='0';
              wr_adr_cnt_en<='0';
            when s_idle =>
              wr_en<='0';
              wr_adr_cnt_en<='0';
            when s_wr =>
              wr_en<='1';
              wr_adr_cnt_en<='1';
          end case;  
    end process; 
  
    process(rst_n,clk) is
      begin
        if rst_n='0' then
            wr_data<=(others=>'0');
        elsif clk'event and clk='1' then
            wr_data<="0000"&din;
        end if;
    end process;

    process(rst_n,clk) is
      begin
        if rst_n='0' then
            wr_cnt<=0;
        elsif clk'event and clk='1' then
           if wr_adr_cnt_en='1' then
               if wr_cnt=255 then
                  wr_cnt<=0;
               else
                  wr_cnt<=wr_cnt+1;
               end if;
           else
              wr_cnt<=0;
           end if;
        end if;
    end process;
    
  wr_adr<=CONV_STD_LOGIC_VECTOR(wr_cnt,8);
  dout<=wr_data; 
  
  process(rst_n,clk) is
      begin
        if rst_n='0' then
            wr_sel_t<='0';
        elsif clk'event and clk='1' then
           if sop='1' then
              wr_sel_t<= not wr_sel_t;  
           end if;
        end if;
    end process; 
  wr_sel<=wr_sel_t; 
  end architecture rtl;    