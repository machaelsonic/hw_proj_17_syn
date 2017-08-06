library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity div  is
   port( rst_n: in std_logic;
	      clk: in std_logic;
	      --din1: in std_logic_vector(20 downto 0);
	      din2: in std_logic_vector(20 downto 0);
			--dout:out std_logic_vector(20 downto 0);
			pre_cnt_o:out std_logic;
			p_cnt_o:OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			cnt_o:OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
			max_p:OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
			max_value:out std_logic_vector(20 downto 0);
			syn_point:OUT STD_LOGIC_VECTOR(8 DOWNTO 0));
end entity div;


architecture rtl of div is

--signal tmp1,tmp2,tmp3,tmp6:std_logic_vector(20 downto 0);
signal p_cnt:integer range 0 to 255;
signal cnt,max_p_t,syn_point_1:integer range 0 to 511;
signal flag,pre_cnt:std_logic;
begin

			
 process(rst_n,clk) is
 variable tmp4:std_logic_vector(20 downto 0);
 variable tmp5:integer range 0 to 511;
   begin
	  if rst_n='0' then
	     p_cnt<=0;
		  cnt<=0;
		  flag<='0';
		  tmp4:=(others=>'0');
		  tmp5:=0;
		  pre_cnt<='0';
	  elsif clk'event and clk='1' then
		 if (din2>20000 and flag='0')  then 
		   if p_cnt=255 then
			   p_cnt<=0;
			else
			   p_cnt<=p_cnt+1;
			end if;
		 end if;
		 if p_cnt>=1 then
		   if cnt=511 then
			   cnt<=0;	
				flag<='0';
				p_cnt<=0;
				tmp4:=(others=>'0');
		      tmp5:=0;
			else
			   cnt<=cnt+1;
			   if cnt>255 then
			      flag<='1';	
				else
			      flag<='0';
				end if;	
			end if;
		   if (din2>tmp4 and flag='0') then
		      tmp4:=din2;
			   tmp5:=cnt; 
		   end if;
		 
			if flag='1' and cnt=tmp5+258 then -- and din2>52000 then
		      pre_cnt<='1';
		   else
		      pre_cnt<='0';
		   end if;
		end if;
	 end if;
	 max_p_t<=tmp5;
    max_value<=tmp4;
end process;

--max_p<=max_p_t;
--p_cnt_o<=p_cnt;
--cnt_o<=cnt;
pre_cnt_o<=pre_cnt;

process(rst_n,clk) is
  begin
    if rst_n='0' then
	     syn_point_1<=0;
	 elsif clk'event and clk='1' then
	     if pre_cnt='1' then
		      syn_point_1<=max_p_t;
		  end if;
	 end if;
	 end process;
	syn_point<=conv_std_logic_vector(syn_point_1,9);
    p_cnt_o<=conv_std_logic_vector(p_cnt,8);
	 max_p<=conv_std_logic_vector(max_p_t,9);
	 cnt_o<=conv_std_logic_vector(cnt,9);
	 
end architecture rtl;