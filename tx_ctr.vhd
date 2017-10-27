library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity tx_ctr is
  port(rst_n: in std_logic;
       clk: in std_logic;
       en: in std_logic;
		 xmt_ram_rd_data:in STD_LOGIC_VECTOR(31 DOWNTO 0);
		 xmt_ram_rd_en:out std_logic;
		 xmt_ram_rd_adr:out STD_LOGIC_VECTOR(6 DOWNTO 0);
       rom_rd_en:out std_logic;
       rom_adr:out std_logic_vector(9 downto 0);
	    cnt_o:OUT STD_LOGIC_VECTOR(14 DOWNTO 0);
	    frame_flag:out std_logic;
	    send_data_valid:out std_logic;
       ram_data_valid: out std_logic;
	    send_data_o:out std_logic_vector(415 downto 0);
	    pre_inverse:out std_logic
		 );
end entity tx_ctr;

architecture rtl of tx_ctr is

signal cnt_en1,cnt_en2,rom_rd_en_t:std_logic;
signal tmp:std_logic_vector(9 downto 0);

signal cnt:integer range 0 to 19134;
type state_t is (s_rst,s_idle,s_tx);
signal state,next_state: state_t;

type state_t1 is (s_rst,s_idle,s_rd);
signal sta,next_sta: state_t1;

signal tmp_cnt:integer range 0 to 10;
-----------------------------------------------
signal  xmt_rd_en,xmt_rd_en_t:std_logic;
signal  xmt_ram_rd_cnt:std_logic_vector(6 downto 0);
signal  send_data_t,send_data:std_logic_vector(415 downto 0);


begin


process(rst_n,clk) is
     begin
       if rst_n='0' then
         state<=s_rst;
       elsif clk'event and clk='1' then
         state<=next_state;
       end if;
 end process;


  process(state,rst_n,en,cnt) is
    begin
      case state is
        when s_rst =>
          if rst_n<='1' then
             next_state<=s_idle;
          else
             next_state<=s_rst;
          end if;
        when s_idle =>
          if en='1' then
             next_state<=s_tx;
          else
             next_state<=s_idle;
          end if; 
        when s_tx => 
	       if cnt=19134 then
              next_state<=s_idle;
			   else
				      next_state<=s_tx;
			   end if; 
        
      end case;
  end process;

  process(state) is
       begin
         case state is
           when s_rst =>
                  cnt_en1<='0';
           when s_idle =>
                  cnt_en1<='0';   
			     when s_tx =>
                  cnt_en1<='1';               
         end case;
  end process;
  
  
  process(rst_n,clk) is
     begin
	    if rst_n='0' then
        cnt<=0;
      elsif clk'event and clk='1' then
         if cnt_en1='1' then
			  if cnt=19134 then
			     cnt<=0;
           else
            cnt<=cnt+1;
           end if;
         else
           cnt<=0;
        end if;
      end if; 
  end process;
  
  process(cnt) is
     begin
       if (cnt>=7565 and cnt<=8588) or (cnt>=9047 and cnt<=10070) or 
          (cnt>=10529 and cnt<=11552) or (cnt>=12011 and cnt<=13034) or
          (cnt>=13493 and cnt<=14516) or (cnt>=14975 and cnt<=15998) then
				    send_data_valid<='1'; 
			 else
				    send_data_valid<='0';
			 end if; 
	 end process;
	 
	process(cnt) is
     begin
       if (cnt>=7565 and cnt<=15998) then
				    frame_flag<='1'; 
			 else
				    frame_flag<='0';
			 end if; 
	 end process ;
				       
  process(rst_n,clk) is
     begin
       if rst_n='0' then
         sta<=s_rst;
       elsif clk'event and clk='1' then
         sta<=next_sta;
       end if;
 end process;

process(sta,rst_n,cnt,tmp_cnt) is
      begin 
		  case sta is
		     when s_rst =>
			       if rst_n='1' then
               next_sta<=s_idle;
             else
               next_sta<=s_rst;
             end if;
         when s_idle =>
		          if  cnt=1 then
                next_sta<=s_rd;
              else
                next_sta<=s_idle;
              end if;  
		     when s_rd =>
			        if tmp_cnt=10 then
			           next_sta<=s_idle;
			        else
			           next_sta<=s_rd;
			        end if;
        end case;
   end process;	
   
   
     process(sta) is
       begin
         case sta is
           when s_rst =>
              rom_rd_en_t<='0';
				  cnt_en2<='0';
           when s_idle =>
              rom_rd_en_t<='0';
				  cnt_en2<='0';
           when s_rd =>
              rom_rd_en_t<='1';
				  cnt_en2<='1';
         end case;
     end process;

	  
   process(rst_n,clk) is
     begin
      if rst_n='0' then
         tmp<=(others=>'0');
			   tmp_cnt<=0;
      elsif clk'event and clk='1' then
         if cnt_en2='1' then
           if tmp=1023 then 
			        tmp<=(others=>'0');
				     tmp_cnt<=tmp_cnt+1;
           else
                  tmp<=tmp+1;
				      tmp_cnt<=tmp_cnt;
           end if;
         else
              tmp<=(others=>'0');
				  tmp_cnt<=0;
        end if;
        

      end if;
		
      if rom_rd_en_t='1' then
          rom_adr<=tmp;
	    else
          rom_adr<=(others=>'0');
		  end if;	
		  

  end process;
  
  process(rst_n,cnt) is
   begin
     if rst_n='0' then
        pre_inverse<='0';
     else
       if cnt>=8195 and cnt<=10242 then
         pre_inverse<='1';	
       else
         pre_inverse<='0';	
       end if;
     end if;
  end process;
  

 process(rst_n,cnt) is
   begin
     if rst_n='0' then
        ram_data_valid<='0';	
     else
       if cnt>=3 and cnt<=10242 then
         ram_data_valid<='1';	
       else
         ram_data_valid<='0';	
       end if;
     end if;
  end process;

 rom_rd_en<=rom_rd_en_t;

cnt_o<=conv_std_logic_vector(cnt,15);

 process(cnt) is
     begin
	     if (cnt>= 7551 and cnt<=7563) or (cnt>= 9033 and cnt<=9045)  or
		     (cnt>= 10515 and cnt<=10527) or(cnt>= 11997 and cnt<=12009)  or 
			  (cnt>= 13479 and cnt<=13491)  or  (cnt>= 14961 and cnt<=14973) then
		        xmt_rd_en<='1';
		  else
		        xmt_rd_en<='0';
		  end if;
  end process;

process(rst_n,clk) is
     
     begin
	    if rst_n='0' then
		     xmt_ram_rd_cnt<=(others=>'0');
		 elsif clk'event and clk='1' then
		    if xmt_rd_en='1' then
			   if xmt_ram_rd_cnt=77 then
				  xmt_ram_rd_cnt<=(others=>'0');
				else
				  xmt_ram_rd_cnt<=xmt_ram_rd_cnt+1;
				end if;
			  end if;
		 end if;
		 
  end process;
 xmt_ram_rd_adr<=xmt_ram_rd_cnt; 
 xmt_ram_rd_en<=xmt_rd_en;

-- process(rst_n,xmt_ram_wr_clk) is
--     begin
--	    if rst_n='0' then
--         xmt_ram_wr_cnt<=(others=>'0');
--      elsif xmt_ram_wr_clk'event and xmt_ram_wr_clk='1' then
--         if xmt_ram_wr_en='1' then
--			     if xmt_ram_wr_cnt=77 then
--			         xmt_ram_wr_cnt<=(others=>'0');        
--           else
--                 xmt_ram_wr_cnt<=xmt_ram_wr_cnt+1;
--           end if;
--         else
--           xmt_ram_wr_cnt<=(others=>'0');
--        end if;
--      end if; 
--  end process;
--  
--  
-- xmt_ram_wr_adr<=xmt_ram_wr_cnt;
 --xmt_ram_wr_data(31 downto 7)<=(others=>'0');
 --xmt_ram_wr_data(6 downto 0)<=xmt_ram_wr_cnt;
 	 



 process(rst_n,clk) is
   begin
    if rst_n='0' then
         send_data_t<=(others=>'0');
         xmt_rd_en_t<='0';
    elsif clk'event and clk='1' then
        xmt_rd_en_t<=xmt_rd_en;
      if xmt_rd_en_t='1' then
         send_data_t(31 downto 0)<=xmt_ram_rd_data;
         for i in 1 to 12 loop
           send_data_t(32*(i+1)-1 downto 32*i)<=send_data_t(32*i-1 downto 32*(i-1));
         end loop;   
     end if;
  end if;
end process; 

process(cnt,send_data_t) is
   begin
      case  cnt is
       when 7565|9047|10529|12011|13493|14975 => send_data<=send_data_t;
       when others => send_data<=send_data;
    end case;
end process;
process(rst_n,send_data) is
  begin
   if rst_n='0' then
	   send_data_o<=(others=>'0');
	else
      send_data_o<=send_data;
   end if;
end process;


end architecture rtl;