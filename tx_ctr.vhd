library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity tx_ctr is
  port(rst_n: in std_logic;
       clk: in std_logic;
       en: in std_logic;
       din:in std_logic_vector(415 downto 0);
	     ifft_eop:in std_logic;		 
       rd_en:out std_logic;
       adr:out std_logic_vector(9 downto 0);
	     cnt_o:OUT STD_LOGIC_VECTOR(14 DOWNTO 0);
	     frame_flag:out std_logic;
	     send_data_valid:out std_logic;
       ram_data_valid: out std_logic;
	     flag_o:out std_logic;
	     dout:out std_logic_vector(415 downto 0);
	     pre_inverse:out std_logic);
end entity tx_ctr;

architecture rtl of tx_ctr is

signal cnt_en1,cnt_en2,rd_en_t,rd_en_t1:std_logic;
signal tmp:std_logic_vector(9 downto 0);
signal cnt:integer range 0 to 19134;
type state_t is (s_rst,s_idle,s_tx);
signal state,next_state: state_t;

type state_t1 is (s_rst,s_idle,s_rd);
signal sta,next_sta: state_t1;


signal flag:std_logic;
signal tmp_cnt:integer range 0 to 10;
begin

flag_o<=flag;
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

  process(state,cnt) is
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
              rd_en_t<='0';
				      cnt_en2<='0';
           when s_idle =>
              rd_en_t<='0';
				      cnt_en2<='0';
           when s_rd =>
              rd_en_t<='1';
				      cnt_en2<='1';
         end case;
     end process;
	  
   process(clk) is
       begin
		  if clk'event and clk='1' then
         case sta is
           when s_rst =>
				  flag<='0'; 
           when s_idle =>
				  flag<=flag; 
           when s_rd =>
				  flag<='1'; 
         end case;
			end if;
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
		
      if rd_en_t='1' then
          adr<=tmp;
	    else
          adr<=(others=>'0');
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
  
  --ram_data_valid<=rd_en_t;
 rd_en<=rd_en_t;

--cnt_o<=cnt;
cnt_o<=conv_std_logic_vector(cnt,15);


		dout<=din; 
end architecture rtl;