library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tranceiver is
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
end entity tranceiver;
architecture rtl of tranceiver is


component tx IS 
	PORT
	(
		rst_syn :  IN  STD_LOGIC;
		clk_20M :  IN  STD_LOGIC;
		tx_en: in std_logic;
		xmt_ram_rd_data:in STD_LOGIC_VECTOR(31 DOWNTO 0);
		xmt_ram_rd_en:out std_logic;
		xmt_ram_rd_adr:out STD_LOGIC_VECTOR(6 DOWNTO 0);
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
		dma_wr_en:out std_logic;
		rcv_isr_syn_start:out std_logic;
		rcv_isr_syn_err:out std_logic;
		rcv_isr_syn_true:out std_logic;
		rcv_isr_demap_end:out std_logic;
		rx_ram_wr_data:out std_logic_vector(31 downto 0);
		rx_ram_wr_en:out std_logic;
		rx_ram_wr_clk:out std_logic;
		rx_ram_wr_adr:out std_logic_vector(6 downto 0);
		rx_ram_rd_triger:out std_logic
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

component xmt_rcv_ram IS 
  GENERIC(N: INTEGER:=7;
          W: INTEGER:=32);
  PORT( rst: IN STD_LOGIC;
        rd_clk: IN STD_LOGIC;
		  wr_clk: in std_logic;
        wr_en:IN STD_LOGIC;
		  rd_en: in std_logic;
        wr_adr:IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		  rd_adr:IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        wr_data:IN STD_LOGIC_VECTOR(W-1 DOWNTO 0);
        rd_data:OUT STD_LOGIC_VECTOR(W-1 DOWNTO 0));
END component xmt_rcv_ram;

component timer_32 is
   port( rst: in std_logic;
         clk: in std_logic;
			dout:out std_logic_vector(31 downto 0));
end component timer_32;


signal tx_data_valid_t:std_logic;
signal tx_data_o,rx_datain:std_logic_vector(11 downto 0);
signal rcv_en:std_logic;
signal tx_cnt:STD_LOGIC_VECTOR(14 DOWNTO 0);
signal rx_cnt:integer range 0 to 13999;
signal tx_en_t,rx_en_t:std_logic;
signal cpu_tx_data_t,cpu_rx_data_t:std_logic_vector(415 downto 0);
type state_t is (s_rst,s_rx,s_tx,s_delay2tx,s_delay2rx);
signal state,next_state:state_t;
--signal flag,slave_tx_data_valid:std_logic;
attribute keep:boolean;
attribute keep of rx_datain:signal is true;
signal delay_cnt:integer range 0 to 127;
signal delay_cnt_en:std_logic;
signal xmt_ram_rd_clk:std_logic;
signal xmt_ram_rd_en:std_logic;
signal xmt_ram_rd_adr:std_logic_vector(6 downto 0);
signal xmt_ram_rd_data: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal xmt_ram_wr_clk:std_logic;
signal xmt_ram_wr_en:std_logic;
signal xmt_ram_wr_adr:std_logic_vector(6 downto 0);
signal xmt_ram_wr_data: STD_LOGIC_VECTOR(31 DOWNTO 0);

signal rx_ram_rd_clk: std_logic;
signal rx_ram_rd_en: std_logic;
signal rx_ram_rd_adr:std_logic_vector(6 downto 0);
signal rx_ram_rd_data: std_logic_vector(31 downto 0);
signal rx_ram_wr_clk: std_logic;
signal rx_ram_wr_en: std_logic;
signal rx_ram_wr_adr:std_logic_vector(6 downto 0);
signal rx_ram_wr_data: std_logic_vector(31 downto 0);

signal ram_rd_en: std_logic;
signal ram_rd_adr:std_logic_vector(6 downto 0);
signal ram_rd_data: std_logic_vector(31 downto 0);
signal rx_ram_rd_triger:std_logic;

signal cpu_rx_data_valid:std_logic;
signal timer_cnt: std_logic_vector(31 downto 0);
signal rcv_isr_syn_start,rcv_isr_syn_err,rcv_isr_syn_true,rcv_isr_demap_end:std_logic;

begin


 process(rst,clk) is
    begin
        if rst='1' then
            state<=s_rst;
        elsif clk'event and clk='1' then
            state<=next_state;
        end if;
 end process;
 
 process(state,rst,cpu_tx_triger,tx_cnt,delay_cnt) is
    begin
       case state is
        when s_rst =>
             if rst='1' then
                  next_state<=s_rst;
              else
                 next_state<=s_rx;
              end if;
	 
        when s_rx =>
			 if  cpu_tx_triger='1'   then
                next_state<=s_delay2tx;	 
          else
                next_state<=s_rx;					 
          end if;
			
			when s_delay2tx =>
          if  delay_cnt=2 then  
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
          if  delay_cnt=2 then  
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
         when s_rx => 
			      rx_en_t<='1';
					tx_en_t<='0'; 
					delay_cnt_en<='0';
			when s_delay2tx => 
			      rx_en_t<='0';
					tx_en_t<='0'; 
			      delay_cnt_en<='1';
         when s_tx => 
			      rx_en_t<='0';
					tx_en_t<='1';
					delay_cnt_en<='0';
			when s_delay2rx => 
			      rx_en_t<='0';
					tx_en_t<='0';  
			      delay_cnt_en<='1';

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
 
                 
tx_inst: tx 
  PORT map 
	(
		rst_syn => rst,
		clk_20M => clk,
		tx_en=>tx_en_t,
		xmt_ram_rd_en=>ram_rd_en,
		xmt_ram_rd_adr=>ram_rd_adr,	
		xmt_ram_rd_data=>ram_rd_data,	 
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
		rx_cnt => rx_cnt,
		rcv_data_valid=> cpu_rx_data_valid,
		demap_dout => cpu_rx_data_t,
		rcv_data_delay=>rcv_data_delay,
		dma_wr_en=> dma_wr_en,
		rcv_isr_syn_start=>rcv_isr_syn_start,
		rcv_isr_syn_err=>rcv_isr_syn_err,
		rcv_isr_syn_true=>rcv_isr_syn_true,
		rcv_isr_demap_end=>rcv_isr_demap_end,
		rx_ram_wr_data=>rx_ram_wr_data,
		rx_ram_wr_en=>rx_ram_wr_en,
		rx_ram_wr_clk=>rx_ram_wr_clk,
		rx_ram_wr_adr=>rx_ram_wr_adr,
		rx_ram_rd_triger=>rx_ram_rd_triger
	);	
 
	
data_dir_inst: data_direction  
   port map
	    (rst => rst,
	     clk =>clk,
	     tx_en => tx_en_t,
	     rx_en =>rx_en_t,
	     rx_data => rx_datain, 
		  tx_data => tx_data_o,
		  tx_rx_data => plc_channal_data);	
		  
		  
xmt_rcv_ram_inst:xmt_rcv_ram   
  GENERIC map(N=>7,W=>32)
  PORT map( rst=>rst,
          rd_clk=>xmt_ram_rd_clk,
		    wr_clk=>xmt_ram_wr_clk,
          wr_en=>xmt_ram_wr_en,
		    rd_en=>xmt_ram_rd_en,
          wr_adr=>xmt_ram_wr_adr,
		    rd_adr=>xmt_ram_rd_adr,
          wr_data=>xmt_ram_wr_data,
          rd_data=>xmt_ram_rd_data);	  
		  
 
rx_rcv_ram_inst:xmt_rcv_ram   
  GENERIC map(N=>7,W=>32)
  PORT map( rst=>rst,
            rd_clk=>rx_ram_rd_clk,
		      wr_clk=>rx_ram_wr_clk,
            wr_en=>rx_ram_wr_en,
		      rd_en=>rx_ram_rd_en,
            wr_adr=>rx_ram_wr_adr,
		      rd_adr=>rx_ram_rd_adr,
            wr_data=>rx_ram_wr_data,
            rd_data=>rx_ram_rd_data);

process(rst,m_s,clk,ram_rd_en,ram_rd_adr,xmt_ram_rd_data,cpu_rd_ram,cpu_xmt_ram_rd_clk,
        cpu_xmt_ram_rd_en,cpu_xmt_ram_rd_adr,cpu_rx_ram_rd_clk,cpu_rx_ram_rd_en,cpu_rx_ram_rd_adr,rx_ram_rd_triger) is
  begin
    if rst='1' then
	    xmt_ram_rd_clk<='0';
		 xmt_ram_rd_en<='0';
		 xmt_ram_rd_adr<=(others=>'0');
		 rx_ram_rd_clk<='0';
		 rx_ram_rd_en<='0';
		 rx_ram_rd_adr<=(others=>'0');
		 ram_rd_data<=(others=>'0');
		 cpu_xmt_ram_rd_data<=(others=>'0');
		 cpu_rx_ram_rd_data<=(others=>'0');
		 cpu_rx_ram_rd_triger<='0';
	 else
	   cpu_rx_ram_rd_triger<=rx_ram_rd_triger;
	   if cpu_rd_ram='0' then --hard logic  read data from ram
         if m_s='1' then --master, read send data from xmt_rcv_ram_inst
	         xmt_ram_rd_clk<=clk;
		      xmt_ram_rd_en<=ram_rd_en;
		      xmt_ram_rd_adr<=ram_rd_adr;
	         rx_ram_rd_clk<='0';
		      rx_ram_rd_en<='0';
		      rx_ram_rd_adr<=(others=>'0');
		      ram_rd_data<=xmt_ram_rd_data;
         else
		      xmt_ram_rd_clk<='0';
		      xmt_ram_rd_en<='0';
		      xmt_ram_rd_adr<=(others=>'0');
            rx_ram_rd_clk<=clk;
		      rx_ram_rd_en<=ram_rd_en;
		      rx_ram_rd_adr<=ram_rd_adr;
		      ram_rd_data<=rx_ram_rd_data;
		   end if;
			cpu_xmt_ram_rd_data<=(others=>'0');
			cpu_rx_ram_rd_data<=(others=>'0');
		 else  --cpu read data from ram
		      xmt_ram_rd_clk<=cpu_xmt_ram_rd_clk;
		      xmt_ram_rd_en<=cpu_xmt_ram_rd_en;
		      xmt_ram_rd_adr<=cpu_xmt_ram_rd_adr;
				cpu_xmt_ram_rd_data<=xmt_ram_rd_data;
				
				rx_ram_rd_clk<=cpu_rx_ram_rd_clk;
            rx_ram_rd_en<=cpu_rx_ram_rd_en;
            rx_ram_rd_adr<=cpu_rx_ram_rd_adr;
            cpu_rx_ram_rd_data<=rx_ram_rd_data;
				ram_rd_data<=(others=>'0');
	    end if;
	 end if;
  end process;
  
  xmt_ram_wr_clk<=cpu_xmt_ram_wr_clk;
  xmt_ram_wr_en<=cpu_xmt_ram_wr_en;
  xmt_ram_wr_adr<=cpu_xmt_ram_wr_adr;
  xmt_ram_wr_data<=cpu_xmt_ram_wr_data;
  
  timer_32_inst:timer_32 
     port map ( rst=> rst,
                clk=>clk,
			       dout=>timer_cnt);
					
				
	process(rst,clk,cpu_tx_triger) is
     begin
	    if rst='1' or cpu_tx_triger='1' then
		     reg_tx_end_time<=(others=>'0');
			  reg_syn_start_time<=(others=>'0');
			  reg_syn_err_time<=(others=>'0');
		     reg_syn_true_time<=(others=>'0');
	        reg_demap_end_time<=(others=>'0');
		 elsif clk'event and clk='1' then
	      if tx_cnt=19134 then
	         	reg_tx_end_time<=timer_cnt;
			end if;
		   if rcv_isr_syn_start='1' then
		         reg_syn_start_time<=timer_cnt;
			end if;
			if rcv_isr_syn_err='1' then
		         reg_syn_err_time<=timer_cnt;
			end if;
	      if rcv_isr_syn_true='1' then
		         reg_syn_true_time<=timer_cnt;
			end if;
         if rcv_isr_demap_end='1' then
		         reg_demap_end_time<=timer_cnt;
			end if;
		end if;
   end process;
end architecture rtl ;	



