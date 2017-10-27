LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.std_logic_unsigned.all;
LIBRARY work;

ENTITY tb_plc_design IS 
end entity tb_plc_design;

architecture rtl of tb_plc_design is 

component plc_design 
  PORT
	(
		clk_tx :  IN  STD_LOGIC;
		rst_n_tx :  IN  STD_LOGIC;
		en :  IN  STD_LOGIC;
		xmt_ram_rd_data:in STD_LOGIC_VECTOR(31 DOWNTO 0);
		xmt_ram_rd_en:out std_logic;
		xmt_ram_rd_adr:out STD_LOGIC_VECTOR(6 DOWNTO 0);
		receiver_din: IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
		ifft_sink_ready :  OUT  STD_LOGIC;
		ifft_source_sop :  OUT  STD_LOGIC;
		ifft_source_eop :  OUT  STD_LOGIC;
		ifft_data_valid :  OUT  STD_LOGIC;
		ifft_sop :  OUT  STD_LOGIC;
		ifft_eop :  OUT  STD_LOGIC;
		rom_rd_en :  OUT  STD_LOGIC;
		send_data_valid :  OUT  STD_LOGIC;
		pre_win_data_valid :  OUT  STD_LOGIC;
		ram_rd_en :  OUT  STD_LOGIC;
		ram_wr_en :  OUT  STD_LOGIC;
		ram_data_valid :  OUT  STD_LOGIC;
		tx_data_valid :  OUT  STD_LOGIC;
		fft_sink_ready :  OUT  STD_LOGIC;
		fft_source_sop :  OUT  STD_LOGIC;
		fft_source_eop :  OUT  STD_LOGIC;
		fft_source_valid :  OUT  STD_LOGIC;
		fft_sop :  OUT  STD_LOGIC;
		fft_eop :  OUT  STD_LOGIC;
		fft_data_valid :  OUT  STD_LOGIC;
		demap_sink_sop :  OUT  STD_LOGIC;
		demap_sink_eop :  OUT  STD_LOGIC;
		demap_sink_valid :  OUT  STD_LOGIC;
		rd_sel :  OUT  STD_LOGIC;
		rd_data_sel :  OUT  STD_LOGIC;
		wr_sel :  OUT  STD_LOGIC;
		flag_o1 :  OUT  STD_LOGIC;
		flag_eop :  OUT  STD_LOGIC;
		tx_cnt :  OUT  STD_LOGIC_VECTOR(14 DOWNTO 0);
		rx_cnt:out integer range 0 to 13999;
		demap_dout :  OUT  STD_LOGIC_VECTOR(415 DOWNTO 0);
		--demap_out :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		fft_source_error :  OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
		fft_source_exp :  OUT  STD_LOGIC_VECTOR(5 DOWNTO 0);
		fft_source_imag :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		fft_source_imag_delay :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		fft_source_real :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		fft_source_real_delay :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		ifft_data :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		ifft_dout_imag :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		ifft_dout_real :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		ifft_source_error :  OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
		ifft_source_exp :  OUT  STD_LOGIC_VECTOR(5 DOWNTO 0);
		ifft_source_imag :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		ifft_source_real :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		ifft_source_valid: out std_logic;
		pre_win_data :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		pre_inverse:out std_logic;
		ram1_d :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		ram2_d :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		ram_rd_adr :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		ram_rd_data :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		ram_wr_adr :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		rcv_data :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		rcv_data_delay :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		rd_cnt_o :  OUT  STD_LOGIC_VECTOR(10 DOWNTO 0);
		rom_rd_adr :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		rt_r :  OUT  STD_LOGIC_VECTOR(24 DOWNTO 0);
		rt_i: out STD_LOGIC_VECTOR(24 DOWNTO 0);
		syn_point :  OUT  STD_LOGIC_VECTOR(8 DOWNTO 0);
		tx_data_o :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		c0:out std_logic;
		c1:out std_logic;
		dma_wr_en:out std_logic;
		rx_ram_wr_data:out std_logic_vector(31 downto 0);
		rx_ram_wr_en:out std_logic;
		rx_ram_wr_clk:out std_logic;
		rx_ram_wr_adr:out std_logic_vector(6 downto 0);
		rx_ram_rd_triger:out std_logic
	);
END component plc_design;

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

signal cnt_1:integer range 0 to 25999;
signal tmp,datain,demap_dout :std_logic_vector(415 downto 0);
signal d_t:std_logic;
signal rst_n_tx,clk_tx,en:std_logic;
signal tx_data_o_t,receiver_din:std_logic_vector(11 downto 0);
signal demap_out :std_logic_vector(15 downto 0);
signal xmt_ram_rd_en:std_logic;
signal xmt_ram_rd_adr:std_logic_vector(6 downto 0);
signal xmt_ram_wr_data: std_logic_vector(31 downto 0);
signal xmt_ram_wr_en,xmt_ram_wr_clk: std_logic;
signal  xmt_ram_wr_cnt,xmt_ram_wr_adr:std_logic_vector(6 downto 0);
signal xmt_ram_rd_data: STD_LOGIC_VECTOR(31 DOWNTO 0);

signal rx_ram_rd_en,rx_ram_rd_triger:std_logic;
signal rx_ram_rd_adr:std_logic_vector(6 downto 0);
signal rx_ram_wr_data: std_logic_vector(31 downto 0);
signal rx_ram_wr_en,rx_ram_wr_clk: std_logic;
signal rx_ram_wr_adr:std_logic_vector(6 downto 0);
signal rx_ram_rd_data: STD_LOGIC_VECTOR(31 DOWNTO 0);
begin




PROCESS                                               
-- variable declarations                                     
BEGIN 
    rst_n_tx<='0';
	 wait for 770 ns;                                                        
    rst_n_tx<='1';
    wait;    -- code that executes only once                      
END PROCESS ;   
                                                                                               
 

 PROCESS                                                                         
   BEGIN                                                         

      clk_tx<='1';
    wait for 20 ns;
      clk_tx<='0';
    wait for 20 ns; 
   end process;

process
  begin
    wait for 800 ns;
    xmt_ram_wr_en<='1';
    wait for 3120 ns;
    xmt_ram_wr_en<='0';
    wait;
  end process;
  xmt_ram_wr_clk<=clk_tx;
  

 process(rst_n_tx,clk_tx) is
		  begin
		    if rst_n_tx='0' then
			    cnt_1<=25900;
				 d_t<='0';
				 tmp<=(others=>'0');
			 elsif clk_tx'event and clk_tx='1' then
			    if cnt_1=25999 then
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

--en<='1';
--dout<="101001011010010110100101101001011010";
--datain<=tmp; 

u1: plc_design PORT map 
	(
		clk_tx =>clk_tx,
		rst_n_tx=>rst_n_tx,
		en =>en,
		xmt_ram_rd_en=>xmt_ram_rd_en,
		xmt_ram_rd_adr=>xmt_ram_rd_adr,	
		xmt_ram_rd_data=>xmt_ram_rd_data,
		receiver_din => receiver_din,
		demap_dout =>demap_dout,
		tx_data_o =>tx_data_o_t,
		rx_ram_wr_data=>rx_ram_wr_data,
		 rx_ram_wr_en=>rx_ram_wr_en,
		 rx_ram_wr_clk=>rx_ram_wr_clk,
		 rx_ram_wr_adr=>rx_ram_wr_adr,
	   rx_ram_rd_triger=>rx_ram_rd_triger
		);
		
		receiver_din<=tx_data_o_t;
		
		
		-- ram_rd_en,
		-- ram_wr_en,
		-- tx_data_valid,
		-- ifft_data_valid,
		-- ifft_sop,
		-- ifft_eop,
		-- ifft_sink_ready,
		-- ifft_source_sop,
		-- ifft_source_eop,
		-- rom_rd_en,
		-- send_data_valid,
		-- pre_win_data_valid,
		-- ram_data_valid,
		-- flag_o,
		-- rd_sel,
		-- rd_data_sel,
		-- wr_sel,
		-- rd_continue_o ,
		-- flag_o1,
		-- flag_eop,
		-- cnt,
		-- ifft_data,
		-- ifft_dout_imag,
		-- ifft_dout_real,
		-- ifft_source_error,
		-- ifft_source_exp,
		-- ifft_source_imag,
		-- ifft_source_real,
		-- pre_win_data,
		-- ram1_d,
		-- ram2_d,
		-- ram_rd_adr,
		-- ram_rd_data,
		-- ram_wr_adr,
		-- rd_cnt_o,
		-- rom_rd_adr,
		-- tx_data_o);
		
		
		xmt_rcv_ram_inst:xmt_rcv_ram   
  GENERIC map(N=>7,W=>32)
  PORT map( rst=>not(rst_n_tx),
          rd_clk=>clk_tx,
		      wr_clk=>xmt_ram_wr_clk,
          wr_en=>xmt_ram_wr_en,
		      rd_en=>xmt_ram_rd_en,
          wr_adr=>xmt_ram_wr_adr,
		      rd_adr=>xmt_ram_rd_adr,
          wr_data=>xmt_ram_wr_data,
          rd_data=>xmt_ram_rd_data);
          		
process(rst_n_tx,xmt_ram_wr_clk) is
     begin
	    if rst_n_tx='0' then
         xmt_ram_wr_cnt<=(others=>'0');
      elsif xmt_ram_wr_clk'event and xmt_ram_wr_clk='1' then
         if xmt_ram_wr_en='1' then
			     if xmt_ram_wr_cnt=77 then
			         xmt_ram_wr_cnt<=(others=>'0'); 
			         en<='1';       
           else
                 xmt_ram_wr_cnt<=xmt_ram_wr_cnt+1;
                 en<='0';
           end if;
         else
           xmt_ram_wr_cnt<=(others=>'0');
        end if;
      end if; 
  end process;
  
 xmt_ram_wr_data(31 downto 7)<=(others=>'0');
 xmt_ram_wr_data(6 downto 0)<=xmt_ram_wr_cnt;	
 xmt_ram_wr_adr<=xmt_ram_wr_cnt;

rx_rcv_ram_inst:xmt_rcv_ram   
  GENERIC map(N=>7,W=>32)
  PORT map( rst=>not(rst_n_tx),
          rd_clk=>clk_tx,
		      wr_clk=>rx_ram_wr_clk,
          wr_en=>rx_ram_wr_en,
		      rd_en=>rx_ram_rd_en,
          wr_adr=>rx_ram_wr_adr,
		      rd_adr=>rx_ram_rd_adr,
          wr_data=>rx_ram_wr_data,
          rd_data=>rx_ram_rd_data);	
                  




		
end rtl;



