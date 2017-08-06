library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity de_map is
generic(N: integer range 0 to 127:=33);
   port( rst_n: in std_logic;
         clk: in std_logic;
         din_real: in std_logic_vector(11 downto 0);
         din_imag: in std_logic_vector(11 downto 0);
         source_valid: in std_logic;
			din_real_clc: in std_logic_vector(24 downto 0);
         din_imag_clc: in std_logic_vector(24 downto 0);
			
         source_sop: in std_logic;
         --source_eop: in std_logic;
         sink_sop: out std_logic;
         sink_eop: out std_logic;
         sink_valid: out std_logic;
         dout:out std_logic_vector(35 downto 0);
			dout_real:out std_logic_vector(11 downto 0);
			dout_imag:out std_logic_vector(11 downto 0));
			--cnt_o:out integer range 0 to 63);
end entity de_map;

architecture rtl of de_map is
  signal cnt: integer range 0 to 255;
  signal tmp_real,tmp_imag,tmp_real1,tmp_imag1: std_logic_vector(11 downto 0);
  signal tmp1,source_valid_t,source_valid_t1,source_valid_t2: std_logic;
  signal tmp2:std_logic_vector(35 downto 0);
  signal sink_sop_t,sink_eop_t,sink_valid_t,sink_eop_t1: std_logic;
  signal tmp_real_delay,tmp_real_delay_neg,tmp_imag_delay,tmp_imag_delay_neg:std_logic_vector(11 downto 0);
  type state_t is (s_rst,s_idle,s1,s2,s3);
  signal state,next_state:state_t;
  signal flag: std_logic;
  begin
   process(rst_n,clk) is
     begin
       if rst_n='0' then
          state<=s_rst;
       elsif clk'event and clk='1' then
          state<=next_state;		
       end if;
  end process;
   process(state,source_sop) is
	  begin
	     case state is
		     when s_rst =>
			    if rst_n='1' then
				   next_state<=s_idle;
				 else
				   next_state<=s_rst;
				 end if;
			   when s_idle =>
			    if source_sop='1' then
				   next_state<=s1;
				 else
				   next_state<=s_idle;
				 end if;
           when s1 =>
			     if source_sop='1' then
				   next_state<=s2;
				 else
				   next_state<=s1;
				 end if;
			  when s2 =>
				  if source_sop='1' then
				   next_state<=s3;
				 else
				   next_state<=s2; 
				 end if;
          when s3 =>
             	next_state<=s3;		 
		  end case;
	end process;
	

  
 	process(clk) is
	  begin
	   if clk'event and clk='1' then
	     case state is
		     when s_rst =>
              --tmp_real<=(others=>'0');
				  flag<='0';
			   when s_idle =>
			     flag<='0';
           when s1 =>
			     flag<='0';
			  when s2 =>
			     flag<='0';
			  when s3 =>
			     flag<='1';
		 end case;
	 end if;
	end process;

-- process( flag,source_valid,source_valid_t1) is
--   begin 
--	   if flag='0' then
--			 source_valid_t<=source_valid_t1;
--		else
--			 source_valid_t<=source_valid;
--	  end if; 
--end process;

	 -- tmp_real<=tmp_real1;
	 -- tmp_imag<=tmp_imag1;
    -- source_valid_t<=source_valid_t2;	 
     tmp_real<=din_real;
	 tmp_imag<=din_imag;
     source_valid_t<=source_valid;			 
   process(rst_n,clk) is
     begin
       if rst_n='0' then
		    tmp_real1<=(others=>'0');
            tmp_imag1<=(others=>'0');
			 source_valid_t1<='0';
			 source_valid_t2<='0';
       elsif clk'event and clk='1' then
            tmp_real1<=din_real;
            tmp_imag1<=din_imag;				
				source_valid_t1<=source_valid;
				source_valid_t2<=source_valid_t1;
       end if;
  end process;
  
    process(rst_n,clk) is
     begin
       if rst_n='0' then
          cnt<=0;
       elsif clk'event and clk='1' then
         if source_valid_t='1' then
             if cnt=255 then
                cnt<=0;
             else
                cnt<=cnt+1;
             end if;
         end if;
      end if;
  end process;

  process(din_real_clc,din_imag_clc,cnt) is
    begin
      case cnt is
        when N to N+35 => 
           if din_real_clc(24)='0'  then
                tmp1<='0';
           else
                tmp1<='1';
           end if;
   
		  when others =>
           tmp1<='0';
   end case;
end process;


process(rst_n,clk) is
    begin
     if rst_n='0' then
        sink_sop_t<='0';
        sink_eop_t<='0';
     elsif clk'event and clk='1' then   
      case cnt is
        when N =>
           sink_sop_t<='1';
           sink_eop_t<='0'; 
        when N+35 =>
           sink_sop_t<='0';
           sink_eop_t<='1'; 
        when others =>
           sink_sop_t<='0';
           sink_eop_t<='0';  
      end case;
     end if;
 end process;
 sink_sop<=sink_sop_t;
 sink_eop<=sink_eop_t; 
 process(rst_n,clk) is
    begin
    if rst_n='0' then
       sink_valid_t<='0';
    elsif clk'event and clk='1' then
      case cnt is
        when N to N+35 =>
          sink_valid_t<='1';
          tmp2(0)<=tmp1;
          for i in 0 to 34 loop
             tmp2(i+1)<=tmp2(i);
          end loop; 
        when others =>
          sink_valid_t<='0';   
      end case;
    end if;
 end process; 
 
 

  --sink_valid<=sink_valid_t;  
  
 process(rst_n,clk) is
      begin
       if rst_n='0' then
          dout<=(others=>'0');
            sink_valid<='0';
       elsif clk'event and clk='1' then
          if sink_valid_t='1' and sink_eop_t='1' then
              dout<=tmp2;
          end if;
          sink_eop_t1<=sink_eop_t;
          sink_valid<=sink_eop_t1;
       end if;
  end process;          

dout_real<=tmp_real;
dout_imag<=tmp_imag;

  
  end architecture rtl;   
     
     
                 
          