library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity ifft_ram_wr_ctr is
  port(rst_n: in std_logic;
       clk: in std_logic;
       din: in std_logic_vector(11 downto 0);
       sop: in std_logic;
       ifft_source_valid: in std_logic;
       dout:out std_logic_vector(15 downto 0);
       wr_en:out std_logic;
       wr_adr:out std_logic_vector(9 downto 0);
       wr_sel:out std_logic);
end entity ifft_ram_wr_ctr;

architecture rtl of ifft_ram_wr_ctr is
  signal wr_sel_t,wr_en_t:std_logic;
  signal wr_data:std_logic_vector(15 downto 0);
  signal wr_cnt:integer range 0 to 1023;

  begin

    process(rst_n,clk) is
      begin
        if rst_n='0' then
            wr_data<=(others=>'0');
            wr_en_t<='0';
        elsif clk'event and clk='1' then
            wr_data<="0000"&din;
            wr_en_t<=ifft_source_valid;
        end if;
    end process;
  
    process(rst_n,clk) is
      begin
        if rst_n='0' then
            wr_cnt<=0;
        elsif clk'event and clk='1' then
           if wr_en_t='1' then
               if wr_cnt=1023 then
                  wr_cnt<=0;
               else
                  wr_cnt<=wr_cnt+1;
               end if;
           else
              wr_cnt<=0;
           end if;
        end if;
    end process;
  wr_en<=wr_en_t;  
  wr_adr<=CONV_STD_LOGIC_VECTOR(wr_cnt,10);
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