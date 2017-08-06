library ieee;
use ieee.std_logic_1164.all;

entity sop_eop_gen is
   port(rst_n: in std_logic;
	     clk: in std_logic;
		  pre_cnt: in std_logic;
		  sop:out std_logic;
		  eop:out std_logic;
		  data_valid:out std_logic);
end entity sop_eop_gen;

architecture rtl of sop_eop_gen is
  type state_t is (s_rst,s_idle,s_sop);
  signal state,next_state: state_t;
  signal cnt:integer range 0 to 565; --538
  signal cnt_en: std_logic;
  begin
  process(rst_n,clk) is
     begin
	    if rst_n='0' then
		    state<=s_rst;
	     elsif clk'event and clk='1' then
		    state<=next_state;
		  end if;
 end process;
 
 process(state,rst_n,pre_cnt,cnt) is
   begin
	   case state is
		  when s_rst =>
		    if rst_n='1' then
			   next_state<=s_idle;
			 else
			   next_state<=s_rst;
			 end if;
		   when s_idle =>
			  if pre_cnt='1' then
			     next_state<=s_sop;
			  else
			     next_state<=s_idle;
			  end if;
			when s_sop =>
			   if cnt=565 then
				   next_state<=s_idle;
			   else
				   next_state<=s_sop;
				end if;
		end case;
end process;

process(state) is
  begin
    case state is
	   when s_rst =>
		   cnt_en<='0';
		when s_idle =>
		   cnt_en<='0';
	   when s_sop =>
		   cnt_en<='1';
	 end case;
end process;

process(rst_n,clk) is
   begin
	  if rst_n='0' then
	     cnt<=0;
		 data_valid<='0';
	     sop<='1';
		 eop<='0';
	  elsif clk'event and clk='1' then
	    if cnt_en='1' then
		     if cnt=565 then
			      cnt<=0;
			  else
			     cnt<=cnt+1;
			  end if;	
			  if cnt=24  or cnt=310 then
				   sop<='1';
			  else
					sop<='0';
			  end if;
					 
			  if cnt=279 or cnt=565 then
					 eop<='1';
			  else
					 eop<='0';
			  end if;
			  
			  if (cnt>=24 and cnt<=279) or (cnt>=310 and cnt<=565)then
					 data_valid<='1';
			  else
					 data_valid<='0';
			  end if;
--          if (cnt>=409 and cnt<=4097) then
--			     data_valid<='1';
--			 else
--			     data_valid<='0';
--			 end if;
		  else
		     cnt<=0;
			  data_valid<='0';
			  sop<='0';
			  eop<='0';
		 end if;
	 end if;
end process;
end architecture rtl;

	  