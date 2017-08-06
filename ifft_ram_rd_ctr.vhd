library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
entity ifft_ram_rd_ctr is
  port(rst_n: in std_logic;
       clk: in std_logic;
       sop: in std_logic;
       eop: in std_logic;
       rd_en:out std_logic;
       rd_adr:out std_logic_vector(7 downto 0);
       rd_sel:out std_logic;
       rd_data_sel:out std_logic;
       oe:out std_logic;
	   rd_cnt_o:OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
	   rd_continue_o:out std_logic;
	   flag_o1:out std_logic;
	   flag_eop:out std_logic;
	   ram_aclr:out std_logic );
end entity ifft_ram_rd_ctr;

architecture rtl of ifft_ram_rd_ctr is
  signal eop_t,eop_t1,rd_sel_t,rd_sel_t1:std_logic;
  type state_t is (s_rst,s_idle,s_rd,s_rd1,s_rd2);
  signal state,next_state:state_t;
  signal rd_adr_cnt_en:std_logic;
  signal rd_cnt:integer range 0 to 285;
  signal rd_en_t,oe_t,oe_t1,rd_en_t1:std_logic;
  signal flag:std_logic;
  signal rd_continue:std_logic;
--  type state_t1 is (s0,s1,s2,s3);
--  signal sta,next_sta:state_t1;
  begin
    process(rst_n,clk) is
      begin
        if rst_n='0' then
            state<=s_rst;
        elsif clk'event and clk='1' then
            state<=next_state;
        end if;
    end process;
    
    process(state,rst_n,eop_t,rd_cnt) is
      begin
         case state is
            when s_rst =>
              if rst_n='1' then
                 next_state<=s_idle;
              else
                 next_state<=s_rst;
              end if; 
              
            when s_idle =>
              if eop_t='1' then
                 next_state<=s_rd;
              else
                 next_state<=s_idle;
              end if;
            when s_rd =>
	            if rd_cnt=255  then
				      if eop_t='1'  then
		                next_state<=s_rd1;
			         else
		               next_state<=s_rd2;
						end if;
					else
					   next_state<=s_rd;
			      end if;
		      when s_rd1 =>					
               if rd_cnt=285 then
                    next_state<=s_rd;  
               else
                    next_state<=s_rd1; 
               end if;
				when s_rd2 =>					
               if rd_cnt=285 then
                    next_state<=s_idle;  
               else
                    next_state<=s_rd2; 
               end if;	
		
          end case;  
    end process;
	
	process(rst_n,clk) is
	  begin  
	    if rst_n='0' then 
		   ram_aclr<='1';
		 elsif clk'event and clk='1' then 
		   if next_state=s_idle and state/=s_idle then
		     ram_aclr<='1';
			else 
			 ram_aclr<='0';
		   end if;
		 end if;
	end process;
    process(state) is
      begin
         case state is
            when s_rst =>
              rd_en_t<='0';
              rd_adr_cnt_en<='0';
			  rd_continue<='0';
			  
            when s_idle =>
              rd_en_t<='0';
              rd_adr_cnt_en<='0';
			  rd_continue<='0';
			 
			when s_rd =>
              rd_en_t<='1';
              rd_adr_cnt_en<='1';
			  rd_continue<='0'; 
            			  
            when s_rd1 =>
              rd_en_t<='1';
              rd_adr_cnt_en<='1';
			  rd_continue<='1';
			
			when s_rd2 =>
              rd_en_t<='1';
              rd_adr_cnt_en<='1';
			  rd_continue<='0';
			
          end case;  
    end process; 

 --rd_en<=rd_en_t; 
   process(rst_n,clk) is
      begin
        if rst_n='0' then
             rd_en_t1<='0';
        elsif clk'event and clk='1' then
              rd_en_t1<=rd_en_t;  
        end if;
    end process;
	 
	rd_en<=rd_en_t1;-- or rd_en_t;
	
   process(rst_n,clk) is
      begin
        if rst_n='0' then
            rd_cnt<=0;
				rd_sel_t<='1';
        elsif clk'event and clk='1' then
           if rd_adr_cnt_en='1' then
               if rd_cnt=285 then
                  rd_cnt<=0;
						rd_sel_t<= not rd_sel_t; 
               else
                  rd_cnt<=rd_cnt+1;
						rd_sel_t<=rd_sel_t; 
               end if;
           else
              rd_cnt<=0;
           end if;
        end if;
    end process; 
    
  process(rst_n,clk) is
    begin
     if rst_n='0' then
        rd_adr<=(others=>'0');
     elsif clk'event and clk='1' then  
      case rd_cnt is
        when 0 to 29 => rd_adr<=CONV_STD_LOGIC_VECTOR(rd_cnt+226,8);
        when 30 to 285 => rd_adr<=CONV_STD_LOGIC_VECTOR(rd_cnt-30,8);  
        when others =>null;
      end case;
    end if;
  end process; 
  
  process(rst_n,clk) is
      begin
        if rst_n='0' then
             eop_t1<='0';
        elsif clk'event and clk='1' then
              eop_t1<= eop;   
        end if;
    end process;
	 
  process(eop_t1,eop,flag) is
      begin
        if flag='0' then
          eop_t<=eop;
        else
          eop_t<=eop_t1;
        end if;
  end process;  
  
  

 process(rst_n,clk) is
      begin
        if rst_n='0' then
            rd_sel<='0';
        elsif clk'event and clk='1' then
            rd_sel<=rd_sel_t;  
        end if;
    end process; 
    
 process(rst_n,clk) is
      begin
        if rst_n='0' then
            rd_data_sel<='0';
			rd_sel_t1<='0';
        elsif clk'event and clk='1' then
            rd_sel_t1<=rd_sel_t;  
            rd_data_sel<=rd_sel_t1;  
        end if;
    end process;  
       
process(rst_n,clk) is
      begin
        if rst_n='0' then
            oe_t1<='0';
			oe_t<='0';
        elsif clk'event and clk='1' then
            oe_t<=rd_en_t1;  
            oe_t1<=oe_t;  
        end if;
    end process; 
	
    oe<=oe_t1 or oe_t;
	--oe<='0';
	 
process(clk) is
       begin
		  if clk'event and clk='1' then
         case state is
           when s_rst =>
				  flag<='0'; 
           when s_idle =>
				  flag<='0'; 
           when s_rd =>
				  flag<='0'; 
			  when s_rd1 =>
				  flag<='1';
			  when s_rd2 =>
				  flag<='1';
         end case;
			end if;
     end process;	 
	 
 

rd_continue_o<=rd_continue;  
--rd_cnt_o<=rd_cnt; 
flag_o1<=flag; 
flag_eop<=eop_t;
rd_cnt_o<=conv_std_logic_vector(rd_cnt,9);
  end architecture rtl;    