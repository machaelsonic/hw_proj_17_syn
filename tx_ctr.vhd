library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity tx_ctr is
  port(rst_n: in std_logic;
       clk: in std_logic;
       en: in std_logic;
       din:in std_logic_vector(35 downto 0);
		 ifft_eop:in std_logic;		 
       rd_en:out std_logic;
       adr:out std_logic_vector(7 downto 0);
		 cnt_o:OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 send_data_valid:out std_logic;
       ram_data_valid: out std_logic;
		 flag_o:out std_logic;
		 dout:out std_logic_vector(35 downto 0));
end entity tx_ctr;

architecture rtl of tx_ctr is

signal cnt_en1,cnt_en2,rd_en_t,rd_en_t1:std_logic;
signal tmp:std_logic_vector(7 downto 0);
signal cnt:integer range 0 to 767;
type state_t is (s_rst,s_idle,s_send,s_idle1);
signal state,next_state: state_t;

type state_t1 is (s_rst,s_idle,s_rd);
signal sta,next_sta: state_t1;

type state_t2 is (s_rst,s_idle,s1,s2);
signal sta1,next_sta1: state_t2;

signal flag:std_logic;
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
             next_state<=s_send;
          else
             next_state<=s_idle;
          end if;
        when s_send => 
	       if cnt=511 then
              next_state<=s_idle1;
			 else
				  next_state<=s_send;
			 end if; 
        when s_idle1 => 
	       if cnt=767 then
              next_state<=s_idle;
			 else
				  next_state<=s_idle1;
			 end if; 
      end case;
  end process;

  process(state) is
       begin
         case state is
           when s_rst =>
                  cnt_en1<='0';
				  send_data_valid<='0';
           when s_idle =>
                  cnt_en1<='0';
				  send_data_valid<='0';
			  when s_send =>
                  cnt_en1<='1';
				  send_data_valid<='1'; 
			  when s_idle1 =>
                  cnt_en1<='1';
				  send_data_valid<='0';  
         end case;
  end process;

  
  process(rst_n,clk) is
     begin
       if rst_n='0' then
         sta<=s_rst;
       elsif clk'event and clk='1' then
         sta<=next_sta;
       end if;
 end process;
  process(sta,rst_n,flag,cnt,tmp) is
      begin 
		  case sta is
		     when s_rst =>
			    if rst_n='1' then
               next_sta<=s_idle;
             else
               next_sta<=s_rst;
             end if;
           when s_idle =>
		       if flag='0' then
			      if  cnt=535 then
			         next_sta<=s_rd;
				   else
				      next_sta<=s_idle; 
				   end if;
			   else
		        if  cnt=534 then
                next_sta<=s_rd;
              else
                next_sta<=s_idle;
              end if;
			   end if;   
		  when s_rd =>
		     if tmp=255 then
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
      elsif clk'event and clk='1' then
         if cnt_en2='1' then
           if tmp=255 then 
			     tmp<=(others=>'0');
           else
            tmp<=tmp+1;
           end if;
         else
           tmp<=(others=>'0');
        end if;
      end if; 
      if rd_en_t='1' then
          adr<=tmp;
	   else
          adr<=(others=>'0');
		end if;	 
  end process;
  
  process(rst_n,clk) is
     begin
	    if rst_n='0' then
        cnt<=0;
      elsif clk'event and clk='1' then
         if cnt_en1='1' then
           --if cnt=511 then 
			  if cnt=767 then
			     cnt<=0;
           else
            cnt<=cnt+1;
           end if;
         else
           cnt<=0;
        end if;
      end if; 
  end process;
  
  process(rst_n,clk) is
     begin
       if rst_n='0' then
         ram_data_valid<='0';	
       elsif clk'event and clk='1' then
         ram_data_valid<=rd_en_t;
       end if;
 end process;
 rd_en<=rd_en_t;

--cnt_o<=cnt;
cnt_o<=conv_std_logic_vector(cnt,10);

  process(rst_n,clk) is
		  begin
		    if rst_n='0' then
			    sta1<=s_rst;
			 elsif clk'event and clk='1' then
             sta1<=next_sta1;
		    end if;	 
		end process;	
	-- process(sta1,rst_n,en,ifft_eop) is
     -- begin
	    -- case sta1 is
		   -- when s_rst =>
		      -- if rst_n='1' then
			      -- next_sta1<=s_idle;
				-- else
			      -- next_sta1<=s_rst;
				-- end if;
			-- when s_idle=>
		       -- if en='1' then
				   -- next_sta1<=s1;
				 -- else
				   -- next_sta1<=s_idle;
				 -- end if;
			-- when s1 =>
		      -- if ifft_eop='1' then
			      -- next_sta1<=s2;
				-- else
			      -- next_sta1<=s1;
				-- end if;
			-- when s2 =>
		      -- if en='1' then
			      -- next_sta1<=s1;
				-- else
			      -- next_sta1<=s2;
				-- end if;
			-- end case;
		-- end process;
	process(sta1,rst_n,en,ifft_eop) is
     begin
	    case sta1 is
		   when s_rst =>
		      if rst_n='1' then
			      next_sta1<=s_idle;
				else
			      next_sta1<=s_rst;
				end if;
			when s_idle=>
		       if en='1' then
				   next_sta1<=s1;
				 else
				   next_sta1<=s_idle;
				 end if;
			when s1 =>
		      if ifft_eop='1' then
			      next_sta1<=s2;
				else
			      next_sta1<=s1;
				end if;
			when s2 =>
			    if ifft_eop='1' then
			      next_sta1<=s_idle;
				else
			      next_sta1<=s2;
				end if;
			end case;
		end process;	
   process(sta1,din) is
     begin
	    case sta1 is
		   when s_rst =>
		        dout<=(others=>'0');
			when s_idle=>
		        dout<=(others=>'0');
			when s1 =>
		       dout<=(others=>'0');
			when s2 =>
		       dout<=din;
		 end case;
		end process; 
end architecture rtl;