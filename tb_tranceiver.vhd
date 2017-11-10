LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.std_logic_unsigned.all;
LIBRARY work;
use ieee.numeric_std.all;
use std.textio.all;


ENTITY tb_tranceiver IS 
end entity tb_tranceiver;

architecture rtl of tb_tranceiver is 

component tranceiver is 
	   port(  rst: in std_logic;
            clk: in std_logic;
			      m_s:in std_logic;--master='1',slave='0'
			      cpu_rd_ram:in std_logic;--cpu read xmt ram data when cpu_rd_ram='1',when '0' hard logic read xmt ram data 
		        plc_channal_data: inout std_logic_vector(11 downto 0);
			
			      cpu_tx_triger: in std_logic;
            cpu_xmt_ram_wr_clk: in std_logic;
			      cpu_xmt_ram_wr_en:in std_logic;
            cpu_xmt_ram_wr_adr:in  std_logic_vector(6 downto 0);		   
		        cpu_xmt_ram_wr_data: in std_logic_vector(31 downto 0);
            cpu_xmt_ram_rd_clk: in std_logic;
			      cpu_xmt_ram_rd_en:in std_logic;
            cpu_xmt_ram_rd_adr:in  std_logic_vector(6 downto 0);		   
		        cpu_xmt_ram_rd_data: out std_logic_vector(31 downto 0);		   
			
			      cpu_rx_ram_rd_clk: in std_logic;
			      cpu_rx_ram_rd_en: in std_logic;
            cpu_rx_ram_rd_adr:in std_logic_vector(6 downto 0);
			      cpu_rx_ram_rd_data:out std_logic_vector(31 downto 0);
		        cpu_rx_ram_rd_triger:out std_logic;
		        cpu_rd_end:in std_logic;
		        tx_data_valid:out std_logic;
		        ISL_C1:out std_logic;
		        ISL_C0:out std_logic;
		        tx_en:out std_logic;
		        rx_en:out std_logic;
		        
			      rcv_data_delay:out std_logic_vector(11 downto 0);
			      dma_wr_en:out std_logic;
			      reg_tx_end_time:out std_logic_vector(31 downto 0);
			      reg_syn_start_time:out std_logic_vector(31 downto 0);
			      reg_syn_err_time:out std_logic_vector(31 downto 0);
		        reg_syn_true_time:out std_logic_vector(31 downto 0);
	          reg_demap_end_time:out std_logic_vector(31 downto 0)
			 );
END component tranceiver;


--FILE tb_tx_data_tranceiver:TEXT OPEN WRITE_MODE IS "tb_tx_data_tranceiver.txt";
FILE tb_rx_data_tranceiver:TEXT OPEN READ_MODE IS "tb_tx_data_tranceiver3.txt";
--FILE tb_rx_data_tranceiver:TEXT OPEN READ_MODE IS "rcv_data3.txt";
signal cnt_1:integer range 0 to 49999;
signal tmp :std_logic_vector(31 downto 0);
signal d_t:std_logic;
signal rst_n,clk:std_logic;
signal plc_channal_data:std_logic_vector(11 downto 0);
signal  cpu_tx_triger,cpu_tx_triger1,tx_data_valid,ISL_C1,ISL_C0,tx_en,rx_en,rx_ram_rd_triger:std_logic;
signal  rx_data_from_file:  STD_LOGIC_VECTOR(11 DOWNTO 0);
signal  rx_data_from_file_int_signal:  integer;
signal  rx_en_t:std_logic;

signal cpu_xmt_ram_wr_data: std_logic_vector(31 downto 0);
signal cpu_xmt_ram_wr_en,cpu_xmt_ram_wr_clk: std_logic;
signal  cpu_xmt_ram_wr_cnt,cpu_xmt_ram_wr_adr:std_logic_vector(6 downto 0);
signal cpu_xmt_ram_rd_data:std_logic_vector(31 downto 0);
signal  cpu_xmt_ram_rd_cnt,cpu_xmt_ram_rd_adr:std_logic_vector(6 downto 0);
signal cpu_xmt_ram_rd_clk,cpu_xmt_ram_rd_en:std_logic;
signal cpu_rx_ram_rd_data: std_logic_vector(31 downto 0);
signal cpu_rx_ram_rd_en,cpu_rx_ram_rd_clk: std_logic;
signal cpu_rx_ram_rd_adr,cpu_rx_ram_rd_cnt:std_logic_vector(6 downto 0);
signal m_s,cpu_rd_ram,cpu_rd_en,cpu_wr_en:std_logic;
signal cpu_rx_ram_rd_triger,cpu_rd_end:std_logic;

type state_t is (s_rst,s_idle,s_wr,s_rd1,s_tx,s_rd2);
signal state,next_state:state_t;
signal reg_syn_start_time,reg_syn_err_time,reg_syn_true_time,reg_demap_end_time: std_logic_vector(31 downto 0);	
begin




PROCESS                                               
-- variable declarations                                     
BEGIN 
    rst_n<='0';
	 wait for 770 ns;                                                        
    rst_n<='1';
    wait;    -- code that executes only once                      
END PROCESS ;   
                                                                                               
 

 PROCESS                                                                         
   BEGIN                                                         

      clk<='1';
    wait for 20 ns;
      clk<='0';
    wait for 20 ns; 
   end process;
   
   
process
  begin
    wait for 800 ns;
    cpu_wr_en<='1';
    wait for 40 ns;
    cpu_wr_en<='0';
    wait;
  end process;
 process
    begin
       cpu_rd_end<='0';
     wait for 3000000 ns; 
        cpu_rd_end<='1';
     wait for 40 ns;
        cpu_rd_end<='0';
end process; 
  
 

 process(rst_n,clk) is
		  begin
		    if rst_n='0' then
			    cnt_1<=49900;
				 d_t<='0';
				 tmp<=(others=>'0');
			 elsif clk'event and clk='1' then
			    if cnt_1=49999 then
				    cnt_1<=0;
					 d_t<='1';
					 tmp<=tmp+1;
				 else
				    cnt_1<=cnt_1+1;
					 d_t<='0';
					 tmp<=tmp;
				end if;
		    end if;
			 
		end process;

--cpu_tx_triger<=d_t;
--cpu_tx_data_valid<='0';
--dout<="101001011010010110100101101001011010";
--cpu_tx_data<=tmp; 
 
   
u1: tranceiver PORT map 
	  (
		   clk =>clk,
		   rst=> not(rst_n),
		   m_s=>m_s,
		   cpu_rd_ram=>cpu_rd_ram,
		   cpu_tx_triger =>cpu_tx_triger or cpu_tx_triger1,
		   plc_channal_data => plc_channal_data,
		   cpu_xmt_ram_wr_en=>cpu_xmt_ram_wr_en,
		   cpu_xmt_ram_wr_clk=>cpu_xmt_ram_wr_clk,
		   cpu_xmt_ram_wr_data=>cpu_xmt_ram_wr_data,
		   cpu_xmt_ram_wr_adr=>cpu_xmt_ram_wr_adr,
		   cpu_xmt_ram_rd_clk=>cpu_xmt_ram_rd_clk,
			 cpu_xmt_ram_rd_en=>cpu_xmt_ram_rd_en,
       cpu_xmt_ram_rd_adr=>cpu_xmt_ram_rd_adr,	   
		   cpu_xmt_ram_rd_data=>cpu_xmt_ram_rd_data,
		   
		   cpu_rx_ram_rd_clk=>cpu_rx_ram_rd_clk,
		   cpu_rx_ram_rd_en=>cpu_rx_ram_rd_en,
		   cpu_rx_ram_rd_adr=>cpu_rx_ram_rd_adr,
       cpu_rx_ram_rd_data=>cpu_rx_ram_rd_data,
		   cpu_rx_ram_rd_triger=>cpu_rx_ram_rd_triger,
		   
		   cpu_rd_end=>cpu_rd_end,
		   tx_data_valid =>tx_data_valid,
		   ISL_C1 =>ISL_C1,
		   ISL_C0 =>ISL_C0,
		   tx_en => tx_en,
		   rx_en => rx_en,
		   reg_syn_start_time=>reg_syn_start_time,
	     reg_syn_err_time=>reg_syn_err_time,
	     reg_syn_true_time=>reg_syn_true_time,
	     reg_demap_end_time=>reg_demap_end_time	);
		
	 process(rst_n,cpu_xmt_ram_wr_clk) is
     begin
	    if rst_n='0' then
           cpu_xmt_ram_wr_cnt<=(others=>'0');
      elsif cpu_xmt_ram_wr_clk'event and cpu_xmt_ram_wr_clk='1' then
         if cpu_xmt_ram_wr_en='1' then
			      if cpu_xmt_ram_wr_cnt=77 then
			          cpu_xmt_ram_wr_cnt<=(others=>'0'); 
			          cpu_rd_en<='0';      
           else
                 cpu_xmt_ram_wr_cnt<=cpu_xmt_ram_wr_cnt+1;
                 if cpu_xmt_ram_wr_cnt=76 then
                     cpu_rd_en<='1';
                 else
                    cpu_rd_en<='0';
                 end if;
           end if;
         else
           cpu_xmt_ram_wr_cnt<=(others=>'0');
           cpu_rd_en<='0';
        end if;
      end if; 
  end process;
  
 process(rst_n,cpu_xmt_ram_rd_clk) is
     begin
	    if rst_n='0' then
           cpu_xmt_ram_rd_cnt<=(others=>'0');
      elsif cpu_xmt_ram_rd_clk'event and cpu_xmt_ram_rd_clk='1' then
         if cpu_xmt_ram_rd_en='1' then
			      if cpu_xmt_ram_rd_cnt=77 then
			         cpu_xmt_ram_rd_cnt<=(others=>'0'); 
			         cpu_tx_triger<='0';       
           else
                 cpu_xmt_ram_rd_cnt<=cpu_xmt_ram_rd_cnt+1;
                 if cpu_xmt_ram_rd_cnt=76 then
                     cpu_tx_triger<='1';
                 else
                     cpu_tx_triger<='0';
                 end if;
           end if;
         else
           cpu_xmt_ram_rd_cnt<=(others=>'0');
           cpu_tx_triger<='0';
        end if;
      end if; 
  end process;
  
  process(rst_n,cpu_rx_ram_rd_clk) is
     begin
	    if rst_n='0' then
           cpu_rx_ram_rd_cnt<=(others=>'0');
      elsif cpu_rx_ram_rd_clk'event and cpu_rx_ram_rd_clk='1' then
         if cpu_rx_ram_rd_en='1' then
			      if cpu_rx_ram_rd_cnt=77 then
			         cpu_rx_ram_rd_cnt<=(others=>'0'); 
			         cpu_tx_triger1<='0';       
           else
                 cpu_rx_ram_rd_cnt<=cpu_rx_ram_rd_cnt+1;
                 if cpu_rx_ram_rd_cnt=76 then
                    cpu_tx_triger1<='1';
                 else
                    cpu_tx_triger1<='0';
                 end if;
           end if;
         else
           cpu_rx_ram_rd_cnt<=(others=>'0');
           cpu_tx_triger1<='0';
        end if;
      end if; 
  end process; 
  

 
 cpu_xmt_ram_wr_clk<=clk;
 cpu_xmt_ram_wr_adr<=cpu_xmt_ram_wr_cnt;
 cpu_xmt_ram_wr_data(31 downto 7)<=(others=>'0');
 cpu_xmt_ram_wr_data(6 downto 0)<=cpu_xmt_ram_wr_cnt(5 downto 0)&'0' ;
 
 cpu_xmt_ram_rd_clk<=clk;
 cpu_xmt_ram_rd_adr<=cpu_xmt_ram_rd_cnt;
 
 cpu_rx_ram_rd_clk<=clk;
 cpu_rx_ram_rd_adr<=cpu_rx_ram_rd_cnt;
 
 process(rst_n,clk) is
    begin
        if rst_n='0' then
            state<=s_rst;
        elsif clk'event and clk='1' then
            state<=next_state;
        end if;
 end process;
 
 process(state,rst_n,cpu_rx_ram_rd_triger,cpu_wr_en,cpu_rd_en,cpu_tx_triger,cpu_tx_triger1) is
    begin
       case state is
        when s_rst =>
             if rst_n='0' then
                  next_state<=s_rst;
              else
                 next_state<=s_idle;
              end if;
	      when s_idle =>
			    if  cpu_wr_en='1'   then
                next_state<=s_wr;	 
          else
                next_state<=s_idle;					 
          end if;
        when s_wr =>
			    if  cpu_rd_en='1'   then
                next_state<=s_rd1;	 
          else
                next_state<=s_wr;					 
          end if;  
        when s_rd1 =>
			    if  cpu_tx_triger='1'   then
                next_state<=s_tx;	 
          else
                next_state<=s_rd1;					 
          end if;    
        when s_tx =>
			    if  cpu_rx_ram_rd_triger='1'   then
                next_state<=s_rd2;	 
          else
                next_state<=s_tx;					 
          end if;
			  when s_rd2 =>
			    if  cpu_tx_triger1='1'   then
                next_state<=s_tx;	 
          else
                next_state<=s_rd2;					 
          end if; 
     end case;
   end process;
    
   m_s<='1'; 
      
 process(state) is
    begin
      case state is
         when s_rst=> 
			      cpu_xmt_ram_wr_en<='0';
			      cpu_xmt_ram_rd_en<='0';
			      cpu_rx_ram_rd_en<='0'; 
			      cpu_rd_ram<='0';
         when s_idle => 
			      cpu_xmt_ram_wr_en<='0';
			      cpu_xmt_ram_rd_en<='0';
			      cpu_rx_ram_rd_en<='0';
			      cpu_rd_ram<='0'; 
			   when s_wr => 
			      cpu_xmt_ram_wr_en<='1';
			      cpu_xmt_ram_rd_en<='0';
			      cpu_rx_ram_rd_en<='0';
			      cpu_rd_ram<='0';
			   when s_rd1 =>
			      cpu_xmt_ram_wr_en<='0';
			      cpu_xmt_ram_rd_en<='1';
			      cpu_rx_ram_rd_en<='0';
			      cpu_rd_ram<='1';    
			   when s_tx => 
			      cpu_xmt_ram_wr_en<='0';
			      cpu_xmt_ram_rd_en<='0';
			      cpu_rx_ram_rd_en<='0'; 
			      cpu_rd_ram<='0';
			   when s_rd2 => 
			      cpu_xmt_ram_wr_en<='0';
			      cpu_xmt_ram_rd_en<='0';
			      cpu_rx_ram_rd_en<='1'; 
			      cpu_rd_ram<='1'; 
			           
       end case;
end process;
 
 
 
 
--process(clk) is
-- 	VARIABLE lo_1:LINE;
-- 	--alias tx_data_o is <<signal u1.tx_inst.tx_data_o  : STD_LOGIC_vector>>;
--
--    BEGIN
--	     if rising_edge(clk) then
--				 if tx_data_valid='1' then
--					--WRITE (lo_1,to_integer(signed(tx_data_o)),left,10);
--					WRITE (lo_1,to_integer(signed(plc_channal_data)),left,10);
--					WRITELINE (tb_tx_data_tranceiver,lo_1);
--				 end if;
--		 end if;
--end process; 
process(rst_n,clk) is
 	VARIABLE lo_1:LINE;
 	--variable rx_data_from_file_int: integer range -1024 to 1023;
 	  variable rx_data_from_file_int: integer;
    BEGIN
      if rst_n='0' then
        rx_data_from_file<=(others=>'0');
      elsif rising_edge(clk) then
         --if rx_en='1' and flag_o='1' then
         --if rx_en='1'  then
           if not(endfile(tb_rx_data_tranceiver)) then
			        READLINE (tb_rx_data_tranceiver,lo_1);
			        READ (lo_1,rx_data_from_file_int);
			        rx_data_from_file_int_signal<=rx_data_from_file_int;	
		          rx_data_from_file<=std_logic_vector(to_signed(rx_data_from_file_int,12));	
		       end if;
		     --end if;
		   end if;
	end process;	
	
	process(rx_en,rx_data_from_file) is
    BEGIN
	     	if rx_en='1' then
	     	    plc_channal_data<=rx_data_from_file;
		     else
		       plc_channal_data<=(others=>'Z');
		    end if;
end process;
	
			
end rtl;




