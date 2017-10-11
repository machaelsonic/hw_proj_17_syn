library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity ifft_ram_rd_ctr is
  port(rst_n: in std_logic;
       clk: in std_logic;
       state_cnt: in std_logic_vector(14 downto 0);
       rd_en:out std_logic;
       rd_adr:out std_logic_vector(9 downto 0);
       rd_sel:out std_logic;
       rd_data_sel:out std_logic;
       oe:out std_logic;
	     rd_cnt_o:OUT STD_LOGIC_VECTOR(10 DOWNTO 0));
end entity ifft_ram_rd_ctr;

architecture rtl of ifft_ram_rd_ctr is
  signal rd_sel_t:std_logic;

  signal rd_adr_cnt_en:std_logic;
  signal rd_cnt:integer range 0 to 1481;
  signal rd_en_t:std_logic;
  begin


process(state_cnt) is
  begin
     if state_cnt>=10242 and state_cnt<=19133 then --?tx_ctr?send_data_valid??2677?????
       rd_adr_cnt_en<='1';
       rd_en_t<='1';
    else
       rd_adr_cnt_en<='0';
       rd_en_t<='0';
     end if;
   end process;
	rd_en<=rd_en_t;
	 process(rst_n,clk) is
      begin
        if rst_n='0' then
            oe<='0';
        elsif clk'event and clk='1' then
            oe<=rd_en_t;  
        end if;
    end process;

    process(rst_n,clk) is
      begin
        if rst_n='0' then
            rd_cnt<=0;
				    rd_sel_t<='1';
        elsif clk'event and clk='1' then
           if rd_adr_cnt_en='1' then
               if rd_cnt=1481 then
                  rd_cnt<=0;
						      rd_sel_t<=not rd_sel_t;
               else
                  rd_cnt<=rd_cnt+1;
						      rd_sel_t<=rd_sel_t; 
               end if;
           else
              rd_cnt<=0;
           end if;
        end if;
    end process;
       
  process(rst_n,rd_cnt) is
    begin
     if rst_n='0' then
        rd_adr<=(others=>'0');
     else 
      case rd_cnt is
        when 0 to 457 => rd_adr<=CONV_STD_LOGIC_VECTOR(rd_cnt+566,10);
        when 458 to 1481 => rd_adr<=CONV_STD_LOGIC_VECTOR(rd_cnt-458,10);  
        when others =>null;
      end case;
    end if;
  end process; 

 rd_sel<=rd_sel_t;  
 process(rst_n,clk) is
      begin
        if rst_n='0' then
            rd_data_sel<='0';
        elsif clk'event and clk='1' then
            rd_data_sel<=rd_sel_t;  
        end if;
    end process;  

rd_cnt_o<=conv_std_logic_vector(rd_cnt,11);
  end architecture rtl;    