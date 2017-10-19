library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
entity fft_ctr is
  port(rst_n: in std_logic;
       clk: in std_logic;
       dout1:in std_logic_vector(31 downto 0);
       dout2:in std_logic_vector(31 downto 0);
       cnt_o:out integer range 0 to 13999;
       fft_data_valid:out std_logic;
       sink_sop:out std_logic;
       sink_eop:out std_logic;
       payload_data_valid:out std_logic;
		 reg_flush:out std_logic;
		 dma_wr_en:out std_logic);
end entity fft_ctr;

architecture rtl of fft_ctr is
    constant win_offset:integer range 0 to 127:=50;
	 constant num:integer range 0 to 1023:=1023;
	 constant num1:integer range 0 to 10:=10;
    signal s_fft_cnt,cnt:integer range 0 to 13999;--12494
	 signal s_rcv_cnt,s_idle_cnt:integer range 0 to 1023;
	 signal s_rcv_timeout_cnt:integer range 0 to 15000;
    signal s_find_cnt:integer  range 0 to 500;
    signal s_find_timeout_cnt:integer range 0 to 2000;
    signal min_frame_syn:std_logic_vector(31  downto 0);
    type state_t is (s_rst,s_idle,s_rcv,s_find,s_fft);
    signal state,next_state:state_t;
	 attribute keep:boolean;
	 attribute keep of state:signal is true;
	 attribute keep of next_state:signal is true;
	signal  dout1_reg,dout2_reg:std_logic_vector(35 downto 0); 
	constant p: std_logic_vector(3 downto 0):="0110";
 begin
   
	dout2_reg<=dout2&"0000";
	
  dout1_reg<= dout1*p ;
	
	
   cnt_o<=cnt; 
   process(rst_n,clk) is
    begin
      if rst_n='0' then
          state<=s_rst;
      elsif clk'event and clk='1' then
          state<=next_state;
      end if;
end process;

 process(state,rst_n,s_idle_cnt,s_rcv_timeout_cnt,s_rcv_cnt,s_find_timeout_cnt,s_find_cnt,s_fft_cnt) is
      begin
        case state is
          when s_rst =>
             if rst_n='1' then
                next_state<=s_idle;
             else
                next_state<=s_rst;
             end if;
				 
          when s_idle => 
				   if s_idle_cnt=num then 
                 next_state<=s_rcv;
               else
                 next_state<=s_idle;
               end if;
				 
          when s_rcv =>  
              if s_rcv_timeout_cnt<15000 then
                 if   s_rcv_cnt=num1  then 
                      next_state<=s_find;
                 else
                      next_state<=s_rcv;
                 end if;
              else
                  next_state<=s_idle;
              end if;     
								
           when s_find =>  
              if s_find_timeout_cnt<2000 then
                if s_find_cnt =500 then 
                   next_state<=s_fft;
                else
                   next_state<=s_find;
                end if;
              else
                 next_state<=s_idle;
              end if;
           when s_fft  =>       
              if s_fft_cnt=12544-win_offset then
                 next_state<=s_idle;
              else
                 next_state<=s_fft;
              end if;
         end case;
    end process;
  process(rst_n,clk) is
    begin
      if rst_n='0' then
         min_frame_syn<=(others=>'0');
			s_idle_cnt<=0;
         s_rcv_cnt<=0;
			s_rcv_timeout_cnt<=0;
			s_find_cnt<=0;
			s_find_timeout_cnt<=0;
			s_fft_cnt<=0;
			dma_wr_en<='0';
			reg_flush<='0';
      elsif clk'event and clk='1' then
        case state is
          when s_idle => 
                s_rcv_cnt<=0;
					 s_rcv_timeout_cnt<=0;
					 s_find_cnt<=0;
			       s_find_timeout_cnt<=0;
			       s_fft_cnt<=0;
					 reg_flush<='0';
					 if (signed(dout2_reg)> signed(dout1_reg)) then --and (dout1>=327680) then
					    if s_idle_cnt=num then
					      s_idle_cnt<=0;
						 else
						   s_idle_cnt<=s_idle_cnt+1;
						 end if;
					 else
					   s_idle_cnt<=0;
					 end if;
          when  s_rcv =>
			        s_idle_cnt<=0;
					    if s_rcv_timeout_cnt=15000 then
				          s_rcv_timeout_cnt<=0;
							 dma_wr_en<='0';
							 reg_flush<='1';
				       else
						    reg_flush<='0';
                      s_rcv_timeout_cnt<=s_rcv_timeout_cnt+1;
							 if s_rcv_timeout_cnt>=2048 and s_rcv_timeout_cnt<=3071 then
							    dma_wr_en<='1';
							 else
							    dma_wr_en<='0';
							 end if; 
						 end if;
						 
					    if signed(dout2_reg)< signed(0-dout1_reg)  then
							if s_rcv_cnt=num1 then
							   min_frame_syn<=dout2;
							   s_rcv_cnt<=0;	
							 else
							   min_frame_syn<=min_frame_syn;
								s_rcv_cnt<=s_rcv_cnt+1;
							end if;
					  else
					      s_rcv_cnt<=0;
					  end if;
          when  s_find =>
              s_rcv_cnt<=0;
				  s_rcv_timeout_cnt<=0;
				  if s_find_timeout_cnt=2000 then
				     s_find_timeout_cnt<=0;
					  reg_flush<='1';
				  else
                 s_find_timeout_cnt<=s_find_timeout_cnt+1;
					  reg_flush<='0';
				  end if;
				  
            if  signed(dout2)>signed(min_frame_syn) then
                 if s_find_cnt=500 then
                    s_find_cnt<=0;
                 else
                    s_find_cnt<=s_find_cnt+1;
                 end if;
             else
                 min_frame_syn<=dout2;
                 s_find_cnt<=0;
             end if;
          when s_fft =>
              s_find_cnt<=0;
				  s_find_timeout_cnt<=0;
				  
             if s_fft_cnt=12544-win_offset  then
                 s_fft_cnt<=0;
					  reg_flush<='1';
             else
                 s_fft_cnt<=s_fft_cnt+1;
					  reg_flush<='0';
            end if;
          when others => null; 
        end case;
      end if; 
end process;

  cnt<=s_fft_cnt;   
  
  process(rst_n,cnt) is
      begin
        if rst_n='0' then
           fft_data_valid<='0';
           sink_sop<='0';
           sink_eop<='0';
           payload_data_valid<='0';
        else
       
            if (cnt>=522-win_offset and cnt<=1545-win_offset)  or
               (cnt>=2004-win_offset and cnt<=3027-win_offset)  or
               (cnt>=3486-win_offset and cnt<=4509-win_offset) or 
               (cnt>=4968-win_offset and cnt<=5991-win_offset) or
               (cnt>=6450-win_offset and cnt<=7473-win_offset) or
               (cnt>=7932-win_offset and cnt<=8955-win_offset) or
               (cnt>=9414-win_offset and cnt<=10437-win_offset) then
                   fft_data_valid<='1';
            else
                   fft_data_valid<='0';
            end if;
            
             if cnt=522-win_offset or cnt=2004-win_offset or cnt=3486-win_offset or 
                cnt=4968-win_offset or cnt=6450-win_offset or cnt=7932-win_offset or 
                cnt=9414-win_offset  then
                sink_sop<='1';
             else
                sink_sop<='0';
             end if;
             
             if  cnt=1545-win_offset or cnt=3027-win_offset or cnt=4509-win_offset or 
                 cnt=5991-win_offset or cnt=7473-win_offset or cnt=8955-win_offset or 
                 cnt=10437-win_offset then
                sink_eop<='1';
             else
                sink_eop<='0';
             end if;
             
             if(cnt>=4111-win_offset and cnt<=5134-win_offset) or 
               (cnt>=5593-win_offset and cnt<=6616-win_offset) or
               (cnt>=7075-win_offset and cnt<=8098-win_offset) or
               (cnt>=8557-win_offset and cnt<=9580-win_offset) or
               (cnt>=10039-win_offset and cnt<=11062-win_offset) or
               (cnt>=11521-win_offset and cnt<=12544-win_offset) then
                   payload_data_valid<='1';
            else
                   payload_data_valid<='0';
            end if;
          end if;

       end process;
       
       end architecture rtl;

-- process(state,rst_n,dout1,dout2,cnt) is
--      begin
--        case state is
--          when s_rst =>
--             if rst_n='1' then
--                next_state<=s_idle;
--             else
--                next_state<=s_rst;
--             end if;
--          when s_idle => --????????????????
--             
--				 if (signed(dout2)>signed(dout1(29 downto 0)&"00")) and (signed(dout1)>5000000) then--first time
--                 next_state<=s0;
--              else
--                 next_state<=s_idle;
--              end if;
--          when s0 =>
--              if (signed(dout2)>signed(dout1(29 downto 0)&"00")) and (signed(dout1)>5000000)  then--second time
--                 next_state<=s1;
--              else
--                 next_state<=s_idle;
--              end if;  
--          when s1 =>
--              if (signed(dout2)>signed(dout1(29 downto 0)&"00")) and (signed(dout1)>5000000)  then --third time
--                 next_state<=s2;
--              else
--                 next_state<=s_idle;
--              end if;   
--          when s2 =>  --?????????????M????
--              if s2_cnt<15000 then
--                 if  (signed(dout2)<signed(dout1(29 downto 0)&"00"))  then--first time
--                      next_state<=s3;
--                 else
--                      next_state<=s2;
--                 end if;
--              else
--                  next_state<=s_idle;
--              end if;
--               
--          when s3 =>
--              if  (signed(dout2)<signed(dout1(29 downto 0)&"00")) then--second time
--                  next_state<=s4;
--              else
--                  next_state<=s2;
--              end if; 
--           when s4 =>
--              if (signed(dout2)<signed(dout1(29 downto 0)&"00")) then--third time
--                  next_state<=s5;
--              else
--                  next_state<=s2;
--              end if;
--			   when s5 =>
--              if (signed(dout2)<signed(dout1(29 downto 0)&"00")) then--third time
--                  next_state<=s6;
--              else
--                  next_state<=s2;
--              end if;
--			   when s6 =>
--              if (signed(dout2)<signed(dout1(29 downto 0)&"00")) then--third time
--                  next_state<=s7;
--              else
--                  next_state<=s2;
--              end if;
--				
--				
--           when s5 => --????????????
--              if s5_cnt<2000 then
--                if cnt1=500 then 
--                   next_state<=s6;
--                else
--                   next_state<=s5;
--                end if;
--              else
--                 next_state<=s_idle;
--              end if;
--           when s6  => --?????????????       
--              if cnt=12544-win_offset then
--                 next_state<=s_idle;
--              else
--                 next_state<=s6;
--              end if;
--         end case;
--    end process;
--  process(rst_n,clk) is
--    begin
--      if rst_n='0' then
--         min_frame_syn<=(others=>'0');
--         cnt1<=0;
--         cnt<=0;
--         s2_cnt<=0;
--         s5_cnt<=0;
--      elsif clk'event and clk='1' then
--        case state is
--          when s_idle => 
--                s2_cnt<=0;
--                s5_cnt<=0;
--          when  s2 =>
--                 s2_cnt<=s2_cnt+1;
--          when s4 =>
--                min_frame_syn<=dout2;
--          when  s5 =>
--              s2_cnt<=0;
--              s5_cnt<=s5_cnt+1;
--            if  signed(dout2)>signed(min_frame_syn) then
--                 if cnt1=500 then
--                    cnt1<=0;
--                 else
--                    cnt1<=cnt1+1;
--                 end if;
--             else
--                 min_frame_syn<=dout2;
--                 cnt1<=0;
--             end if;
--          when s6 =>
--              s5_cnt<=0;
--             if cnt=12544-win_offset  then
--                 cnt<=0;
--             else
--                 cnt<=cnt+1;
--            end if;
--          when others => null; 
--        end case;
--      end if; 
--end process;