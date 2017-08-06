library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
entity ifft_ram_ctr is
  port(rst_n: in std_logic;
       clk: in std_logic;
       sop: in std_logic;
       eop: in std_logic;
		 din:in std_logic_vector(11 downto 0);
       rd_en:out std_logic;
       rd_adr:out std_logic_vector(7 downto 0);
       wr_en:out std_logic;
       wr_adr:out std_logic_vector(7 downto 0);
		 dout: out std_logic_vector(15 downto 0);
		 data_valid:out std_logic);
end entity ifft_ram_ctr;

architecture rtl of ifft_ram_ctr is
  type state_t is (s_rst,s_idle,s_wr,s_wr_rd,s_rd);
  signal state,next_state:state_t;
  signal cnt:integer range 0 to 512;
  signal cnt_en,wr_en_t,rd_en_t,v_t,v_t1:std_logic;
  begin
    process(rst_n,clk) is
      begin
        if rst_n='0' then
            state<=s_rst;
        elsif clk'event and clk='1' then
            state<=next_state;
        end if;
    end process;
     
    process(state) is
      begin
         case state is
            when s_rst =>
              if rst_n='1' then
                 next_state<=s_idle;
              else
                 next_state<=s_rst;
              end if; 
              
            when s_idle =>
              if sop='1' then
                 next_state<=s_wr;
              else
                 next_state<=s_idle;
              end if;
				 when s_wr =>
              if cnt=225 then
                 next_state<=s_wr_rd;
              else
                 next_state<=s_wr;
              end if;  
				  
            when s_wr_rd =>
                 if cnt=255 then
                    next_state<=s_rd;  
                 else
                    next_state<=s_wr_rd; 
                 end if;
				when s_rd =>
	              if cnt=512 then
			          next_state<=s_idle;  
                 else
                    next_state<=s_rd; 
                 end if;		 		  
          end case;  
    end process;
    process(state) is
      begin
         case state is
            when s_rst =>
              rd_en_t<='0';
				  wr_en_t<='0';
              cnt_en<='0';
				  v_t<='0';
            when s_idle =>
              rd_en_t<='0';
				  wr_en_t<='0';
              cnt_en<='0';
				 v_t<='0'; 
            when s_wr =>
              rd_en_t<='0';
				  wr_en_t<='1';
              cnt_en<='1';
				  v_t<='0';
				when s_wr_rd =>
              rd_en_t<='1';
				  wr_en_t<='1';
              cnt_en<='1';
				  v_t<='1';
				when s_rd =>
              rd_en_t<='1';
				  wr_en_t<='0';
              cnt_en<='1'; 
				  v_t<='1'; 
          end case;  
    end process; 
	 
  
 wr_en<=wr_en_t;
 
--   process(rst_n,clk) is
--      begin
--        if rst_n='0' then
--             rd_en_t1<='0';
--        elsif clk'event and clk='1' then
--              rd_en_t1<=rd_en_t;  
--        end if;
--    end process;
--	 
--	rd_en<=rd_en_t1;-- or rd_en_t;
	
   process(rst_n,clk) is
      begin
        if rst_n='0' then
            cnt<=0;
        elsif clk'event and clk='1' then
           if cnt_en='1' then
               if cnt=512 then
                  cnt<=0;
               else
                  cnt<=cnt+1;
               end if;
           else
              cnt<=0;
           end if;
        end if;
    end process; 
    
  process(rst_n,wr_en_t,cnt) is
    begin
     if rst_n='0' then
        wr_adr<=(others=>'0');
     elsif wr_en_t='1' then  
        wr_adr<=CONV_STD_LOGIC_VECTOR(cnt,8);
	  else
	     wr_adr<=(others=>'0');
	  end if;
 end process;
   process(rst_n,rd_en_t,cnt) is
    begin
     if rst_n='0' then
        rd_adr<=(others=>'0');
     elsif rd_en_t='1' then
	     if cnt<257 then  
           rd_adr<=CONV_STD_LOGIC_VECTOR(cnt-1,8);
	     else
		     rd_adr<=CONV_STD_LOGIC_VECTOR(cnt-257,8);
		  end if;
		else
	     rd_adr<=(others=>'0');
	  end if;
 end process;
  process(rst_n,clk) is
    begin
     if rst_n='0' then
         dout<=(others=>'0');
			rd_en<='0';
			data_valid<='0';
     elsif clk'event and clk='1' then  
         dout<="0000"&din;
			rd_en<=rd_en_t;
			v_t1<=v_t;
			data_valid<=v_t1;
	  end if;
 end process;
    
  end architecture rtl;    