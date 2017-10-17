library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tranceiver is
  port(  rst: in std_logic;
         clk: in std_logic;
			m_s:in std_logic;--master='1',slave='0'
		   plc_channal_data: inout std_logic_vector(11 downto 0);
			--plc_channal_data: in std_logic_vector(11 downto 0);
		   cpu_tx_data:in std_logic_vector(31 downto 0); --415
		   cpu_tx_data_valid: in std_logic;
		   tx_data_valid:out std_logic;
		   ISL_C1:out std_logic;
		   ISL_C0:out std_logic;
		   tx_en:out std_logic;
		   rx_en:out std_logic;
		   --flag_o:out std_logic;
		   cpu_rx_data_valid:out std_logic;
		   cpu_rx_data:out std_logic_vector(31 downto 0);--415
			rcv_data_delay:out std_logic_vector(11 downto 0);
			dma_wr_en:out std_logic);
end entity tranceiver;
architecture rtl of tranceiver is


component tx IS 
	PORT
	(
		rst_syn :  IN  STD_LOGIC;
		clk_20M :  IN  STD_LOGIC;
		tx_triger: in std_logic;
		--rcv_data_valid :  IN  STD_LOGIC;
		rcv_data :  IN  STD_LOGIC_VECTOR(415 DOWNTO 0);
		ISL_C1 :  OUT  STD_LOGIC;
		ISL_C0 :  OUT  STD_LOGIC;
		tx_cnt:OUT  STD_LOGIC_VECTOR(14 DOWNTO 0);
		tx_data_valid :  OUT  STD_LOGIC;
		tx_data_o :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END component tx;

component rx IS 
	PORT
	(
		clk_20M :  IN  STD_LOGIC;
		rst_rx_syn :  IN  STD_LOGIC;
		rcv_en :  IN  STD_LOGIC;
		rx_data :  IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
		rx_cnt: out integer range 0 to 13999;
		demap_sink_sop :  OUT  STD_LOGIC;
		demap_sink_eop :  OUT  STD_LOGIC;
		demap_sink_valid :  OUT  STD_LOGIC;
		pre_cnt :  OUT  STD_LOGIC;
		rcv_data_valid :  OUT  STD_LOGIC;
		demap_dout :  OUT  STD_LOGIC_VECTOR(415 DOWNTO 0);
		rcv_data_delay:out std_logic_vector(11 downto 0);
		dma_wr_en:out std_logic
	);
END component rx;

component data_direction is
   port(rst:in std_logic;
	     clk:in std_logic;
	     tx_en: in std_logic;
	     rx_en: in std_logic;	     
	     rx_data: out std_logic_vector(11 downto 0);
		   tx_data:in std_logic_vector(11 downto 0);
		   tx_rx_data:inout std_logic_vector(11 downto 0));
end component data_direction;

signal tx_data_valid_t,tx_triger_t:std_logic;
signal tx_data_o,rx_data,rx_datain:std_logic_vector(11 downto 0);
signal rcv_en:std_logic;
signal tx_cnt:STD_LOGIC_VECTOR(14 DOWNTO 0);
signal rx_cnt:integer range 0 to 13999;
signal tx_en_t,rx_en_t:std_logic;
signal cpu_tx_data_t,cpu_rx_data_t,tx_datain:std_logic_vector(415 downto 0);
type state_t is (s_rst,s_rx,s_tx,s_delay2tx,s_delay2rx);
signal state,next_state:state_t;
--signal flag,slave_tx_data_valid:std_logic;
attribute keep:boolean;
attribute keep of rx_data:signal is true;
signal delay_cnt:integer range 0 to 127;
signal delay_cnt_en:std_logic;
begin


--cpu_tx_data_t<=((415 downto 32)=>'0')&cpu_tx_data;
cpu_tx_data_t(31 downto 0)<=cpu_tx_data;
cpu_tx_data_t(415 downto 32)<=(others=>'0');
cpu_rx_data<= cpu_rx_data_t(31 downto 0);


 process(rst,clk) is
    begin
        if rst='1' then
            state<=s_rst;
        elsif clk'event and clk='1' then
            state<=next_state;
        end if;
 end process;
 
 process(state,rst,cpu_tx_data_valid,rx_cnt,tx_cnt,delay_cnt) is
    begin
       case state is
        when s_rst =>
             if rst='1' then
                  next_state<=s_rst;
              else
                 next_state<=s_rx;
              end if;
	 
        when s_rx =>
			 if  cpu_tx_data_valid='1'   then
                next_state<=s_delay2tx;	 
          else
                next_state<=s_rx;					 
          end if;
			
			when s_delay2tx =>
          if  delay_cnt=127 then  
             next_state<=s_tx;
          else
             next_state<=s_delay2tx;
          end if; 
			  
        when s_tx =>
          if tx_cnt=19134 then --19134
             next_state<=s_delay2rx;
          else
             next_state<=s_tx;	 
          end if;
			when s_delay2rx =>
          if  delay_cnt=127 then  
             next_state<=s_rx;
          else
             next_state<=s_delay2rx;	 
          end if; 
			  
     end case;
   end process;    
 process(state) is
    begin
      case state is
         when s_rst=> 
			      rx_en_t<='0';
					tx_en_t<='0'; 
					delay_cnt_en<='0';
				   tx_triger_t<='0';
					tx_datain<=(others=>'Z');
				   rx_datain<=(others=>'Z');	
         when s_rx => 
			      rx_en_t<='1';
					tx_en_t<='0'; 
					delay_cnt_en<='0';
					tx_triger_t<='0';
					tx_datain<=(others=>'Z');
					rx_datain<=rx_data;
			when s_delay2tx => 
			      rx_en_t<='0';
					tx_en_t<='0'; 
			      delay_cnt_en<='1';
				   tx_triger_t<='0';
					tx_datain<=(others=>'Z');
				   rx_datain <=(others=>'Z');	
         when s_tx => 
			      rx_en_t<='0';
					tx_en_t<='1';
					delay_cnt_en<='0';
					tx_triger_t<=cpu_tx_data_valid;
					tx_datain<=cpu_tx_data_t;
					rx_datain <=(others=>'Z');
			when s_delay2rx => 
			      rx_en_t<='0';
					tx_en_t<='0';  
			      delay_cnt_en<='1';
				   tx_triger_t<='0';
					tx_datain<=(others=>'Z');
				   rx_datain<=(others=>'Z');	
    end case;
end process;


process(rst,clk) is
   begin
	  if rst='1' then
	      delay_cnt<=0;
	  elsif clk'event and clk='1' then
	      if delay_cnt_en='1' then
			   if delay_cnt=127 then
				    delay_cnt<=0;
				 else
				    delay_cnt<=delay_cnt+1;
				 end if;
			else
			   delay_cnt<=0; 
			end if;
	 end if;
end process;



-- flag<='1';
--rx_en_t<='1';
--tx_en_t<='0';
--ISL_C1<='1';
--ISL_C0<='1';
--rcv_en<='1';
--tx_data_valid<='0';


--  flag_o<=flag;     
                 
tx_inst: tx 
  PORT map 
	(
		rst_syn => rst,
		clk_20M => clk,
		tx_triger=>tx_triger_t,
		--rcv_data_valid =>cpu_tx_data_valid,
		rcv_data =>tx_datain,--rcv_data_t,
		ISL_C1 => ISL_C1,
		ISL_C0 => ISL_C0,
		tx_cnt => tx_cnt,
		tx_data_valid => tx_data_valid_t,
		tx_data_o =>tx_data_o
	);
	
rcv_en<=rx_en_t; 
tx_data_valid<= tx_data_valid_t;



rx_en<=rx_en_t;
tx_en<=tx_en_t;


rx_inst: rx 
	PORT map
	(
		clk_20M => clk,
		rst_rx_syn => rst,
		rcv_en => rcv_en, 
		rx_data => rx_datain,
		--rx_data => "001111111111",
		--rx_data =>plc_channal_data,
		rx_cnt => rx_cnt,
		rcv_data_valid=> cpu_rx_data_valid,
		demap_dout => cpu_rx_data_t,
		rcv_data_delay=>rcv_data_delay,
		dma_wr_en=> dma_wr_en
	);	
 
	
data_dir_inst: data_direction  
   port map
	    (rst => rst,
	     clk =>clk,
	     tx_en => tx_en_t,
	     rx_en =>rx_en_t,
	     rx_data => rx_data, 
		  tx_data => tx_data_o,
		  tx_rx_data => plc_channal_data);	
  
end architecture rtl ;	






--architecture rtl of tranceiver is
--
--
--component tx IS 
--	PORT
--	(
--		rst_syn :  IN  STD_LOGIC;
--		clk_20M :  IN  STD_LOGIC;
--		tx_triger: in std_logic;
--		--rcv_data_valid :  IN  STD_LOGIC;
--		rcv_data :  IN  STD_LOGIC_VECTOR(415 DOWNTO 0);
--		ISL_C1 :  OUT  STD_LOGIC;
--		ISL_C0 :  OUT  STD_LOGIC;
--		tx_cnt:OUT  STD_LOGIC_VECTOR(14 DOWNTO 0);
--		tx_data_valid :  OUT  STD_LOGIC;
--		tx_data_o :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0)
--	);
--END component tx;
--
--component rx IS 
--	PORT
--	(
--		clk_20M :  IN  STD_LOGIC;
--		rst_rx_syn :  IN  STD_LOGIC;
--		rcv_en :  IN  STD_LOGIC;
--		rx_data :  IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		rx_cnt: out integer range 0 to 13999;
--		demap_sink_sop :  OUT  STD_LOGIC;
--		demap_sink_eop :  OUT  STD_LOGIC;
--		demap_sink_valid :  OUT  STD_LOGIC;
--		pre_cnt :  OUT  STD_LOGIC;
--		rcv_data_valid :  OUT  STD_LOGIC;
--		demap_dout :  OUT  STD_LOGIC_VECTOR(415 DOWNTO 0);
--		rcv_data_delay:out std_logic_vector(11 downto 0);
--		dma_wr_en:out std_logic
--	);
--END component rx;
--
--component data_direction is
--   port(rst:in std_logic;
--	     clk:in std_logic;
--	     tx_en: in std_logic;
--	     rx_en: in std_logic;	     
--	     rx_data: out std_logic_vector(11 downto 0);
--		   tx_data:in std_logic_vector(11 downto 0);
--		   tx_rx_data:inout std_logic_vector(11 downto 0));
--end component data_direction;
--
--signal tx_data_valid_t:std_logic;
--signal tx_data_o,rx_data:std_logic_vector(11 downto 0);
--signal rcv_en:std_logic;
--signal tx_cnt:STD_LOGIC_VECTOR(14 DOWNTO 0);
--signal rx_cnt:integer range 0 to 13999;
--signal tx_en_t,rx_en_t:std_logic;
--signal cpu_tx_data_t,cpu_rx_data_t:std_logic_vector(415 downto 0);
--type state_t is (s_rst,s_rx,s_tx,s_delay2tx,s_delay2rx);
--signal state,next_state:state_t;
----signal flag,slave_tx_data_valid:std_logic;
--attribute keep:boolean;
--attribute keep of rx_data:signal is true;
--signal delay_cnt:integer range 0 to 127;
--signal delay_cnt_en:std_logic;
--begin
--
--
----cpu_tx_data_t<=((415 downto 32)=>'0')&cpu_tx_data;
--cpu_tx_data_t(31 downto 0)<=cpu_tx_data;
--cpu_tx_data_t(415 downto 32)<=(others=>'0');
--cpu_rx_data<= cpu_rx_data_t(31 downto 0);
--
--
---- process(rst,clk) is
----    begin
----        if rst='1' then
----            state<=s_rst;
----        elsif clk'event and clk='1' then
----            state<=next_state;
----        end if;
---- end process;
---- 
---- process(state,rst,cpu_tx_data_valid,rx_cnt,tx_cnt,delay_cnt) is
----    begin
----       case state is
----        when s_rst =>
----             if rst='1' then
----                  next_state<=s_rst;
----              else
----                 next_state<=s_rx;
----              end if;
----	 
----        when s_rx =>
----			 if  cpu_tx_data_valid='1'   then
----                next_state<=s_delay2tx;	 
----          else
----                next_state<=s_rx;					 
----          end if;
----			
----			when s_delay2tx =>
----          if  delay_cnt=1 then  
----             next_state<=s_tx;
----          else
----             next_state<=s_delay2tx;
----          end if; 
----			  
----        when s_tx =>
----          if tx_cnt=19134 then --19134
----             next_state<=s_delay2rx;
----          else
----             next_state<=s_tx;	 
----          end if;
----			when s_delay2rx =>
----          if  delay_cnt=127 then  
----             next_state<=s_rx;
----          else
----             next_state<=s_delay2rx;	 
----          end if; 
----			  
----     end case;
----   end process;    
---- process(state) is
----    begin
----      case state is
----         when s_rst=> 
----			      rx_en_t<='0';
----					tx_en_t<='0'; 
----					delay_cnt_en<='0';	
----         when s_rx => 
----			      rx_en_t<='1';
----					tx_en_t<='0'; 
----					delay_cnt_en<='0';
----			when s_delay2tx => 
----			      rx_en_t<='0';
----					tx_en_t<='0'; 
----			      delay_cnt_en<='1';	
----         when s_tx => 
----			      rx_en_t<='0';
----					tx_en_t<='1';
----					delay_cnt_en<='0';
----			when s_delay2rx => 
----			      rx_en_t<='0';
----					tx_en_t<='0';  
----			      delay_cnt_en<='1';	
----    end case;
----end process;
--
--
--process(rst,clk) is
--   begin
--	  if rst='1' then
--	      delay_cnt<=0;
--	  elsif clk'event and clk='1' then
--	      if delay_cnt_en='1' then
--			   if delay_cnt=127 then
--				    delay_cnt<=0;
--				 else
--				    delay_cnt<=delay_cnt+1;
--				 end if;
--			else
--			   delay_cnt<=0; 
--			end if;
--	 end if;
--end process;
--
--
--
---- flag<='1';
--rx_en_t<='1';
--tx_en_t<='0';
--ISL_C1<='1';
--ISL_C0<='1';
--rcv_en<='1';
--tx_data_valid<='0';
--
--
----  flag_o<=flag;     
--                 
----tx_inst: tx 
----  PORT map 
----	(
----		rst_syn => rst,
----		clk_20M => clk,
----		tx_triger=>cpu_tx_data_valid ,
----		--rcv_data_valid =>cpu_tx_data_valid,
----		rcv_data =>cpu_tx_data_t,
----		ISL_C1 => ISL_C1,
----		ISL_C0 => ISL_C0,
----		tx_cnt => tx_cnt,
----		tx_data_valid => tx_data_valid_t,
----		tx_data_o =>tx_data_o
----	);
--	
--rcv_en<=rx_en_t; 
----tx_data_valid<= tx_data_valid_t;
--
--
--
--rx_en<=rx_en_t;
--tx_en<=tx_en_t;
--
--
--rx_inst: rx 
--	PORT map
--	(
--		clk_20M => clk,
--		rst_rx_syn => rst,
--		rcv_en => rcv_en, 
--		--rx_data => rx_data,
--		--rx_data => "001111111111",
--		rx_data =>plc_channal_data,
--		rx_cnt => rx_cnt,
--		rcv_data_valid=> cpu_rx_data_valid,
--		demap_dout => cpu_rx_data_t,
--		rcv_data_delay=>rcv_data_delay,
--		dma_wr_en=> dma_wr_en
--	);	
-- 
--	
----data_dir_inst: data_direction  
----   port map
----	    (rst => rst,
----	     clk =>clk,
----	     tx_en => tx_en_t,
----	     rx_en =>rx_en_t,
----	     rx_data => rx_data, 
----		   tx_data => tx_data_o,
----		   tx_rx_data => plc_channal_data);	
--  
--end architecture rtl ;	