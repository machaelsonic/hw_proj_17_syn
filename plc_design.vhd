

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.std_logic_unsigned.all; 
LIBRARY work;

ENTITY plc_design IS 
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
		rx_ram_rd_triger:out std_logic;
		reg_tx_end_time:out std_logic_vector(31 downto 0);
		reg_syn_start_time:out std_logic_vector(31 downto 0);
		reg_syn_err_time:out std_logic_vector(31 downto 0);
		reg_syn_true_time:out std_logic_vector(31 downto 0);
	   reg_demap_end_time:out std_logic_vector(31 downto 0)
	);
END plc_design;

ARCHITECTURE bdf_type OF plc_design IS 

COMPONENT receiver
	PORT
	(
		rst :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		rcv_en: in std_logic;
		data_in :  IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
		fft_sink_ready :  OUT  STD_LOGIC;
		fft_source_sop :  OUT  STD_LOGIC;
		fft_source_eop :  OUT  STD_LOGIC;
		fft_source_valid :  OUT  STD_LOGIC;
		demap_sink_sop :  OUT  STD_LOGIC;
		demap_sink_eop :  OUT  STD_LOGIC;
		demap_sink_valid :  OUT  STD_LOGIC;
		fft_sop :  OUT  STD_LOGIC;
		fft_eop :  OUT  STD_LOGIC;
		fft_data_valid :  OUT  STD_LOGIC;
		cnt_o:out integer range 0 to 13999;
		demap_dout :  OUT  STD_LOGIC_VECTOR(415 DOWNTO 0);
		fft_source_error :  OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
		fft_source_exp :  OUT  STD_LOGIC_VECTOR(5 DOWNTO 0);
		fft_source_imag :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		fft_source_imag_delay :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		fft_source_real :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		fft_source_real_delay :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		rcv_data :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		rt_i :  OUT  STD_LOGIC_VECTOR(24 DOWNTO 0);
		rt_r :  OUT  STD_LOGIC_VECTOR(24 DOWNTO 0);
		syn_point :  OUT  STD_LOGIC_VECTOR(8 DOWNTO 0);
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
END COMPONENT;

COMPONENT transfer
	PORT
	(
      rst :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		en :  IN  STD_LOGIC;
		xmt_ram_rd_data:in STD_LOGIC_VECTOR(31 DOWNTO 0);
		xmt_ram_rd_en:out std_logic;
		xmt_ram_rd_adr:out STD_LOGIC_VECTOR(6 DOWNTO 0);
		ram_rd_en :  OUT  STD_LOGIC;
		ram_wr_en :  OUT  STD_LOGIC;
		tx_data_valid :  OUT  STD_LOGIC;
		ifft_data_valid :  OUT  STD_LOGIC;
		ifft_sop :  OUT  STD_LOGIC;
		ifft_eop :  OUT  STD_LOGIC;
		ifft_sink_ready :  OUT  STD_LOGIC;
		ifft_source_sop :  OUT  STD_LOGIC;
		ifft_source_eop :  OUT  STD_LOGIC;
		rom_rd_en :  OUT  STD_LOGIC;
		send_data_valid :  OUT  STD_LOGIC;
		pre_win_data_valid :  OUT  STD_LOGIC;
		ram_data_valid :  OUT  STD_LOGIC;
		rd_sel :  OUT  STD_LOGIC;
		rd_data_sel :  OUT  STD_LOGIC;
		wr_sel :  OUT  STD_LOGIC;
		cnt :  OUT  STD_LOGIC_VECTOR(14 DOWNTO 0);
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
		rd_cnt_o :  OUT  STD_LOGIC_VECTOR(10 DOWNTO 0);
		rom_rd_adr :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		tx_data_o :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		c0:out std_logic;
		c1:out std_logic
	);
END COMPONENT;

component timer_32 is
   port( rst: in std_logic;
         clk: in std_logic;
			dout:out std_logic_vector(31 downto 0));
end component timer_32;

SIGNAL	rst_n_tx_syn :  STD_LOGIC;
SIGNAL	rst_rx_syn :  STD_LOGIC;
SIGNAL	rst_tx :  STD_LOGIC;
--SIGNAL	tx_data_o,receiver_din:  STD_LOGIC_VECTOR(11 DOWNTO 0);
--signal demap_dout:std_logic_vector(415 downto 0);
signal datain_t:std_logic_vector(415 downto 0);

signal timer_cnt: std_logic_vector(31 downto 0);
signal rcv_isr_syn_start,rcv_isr_syn_err,rcv_isr_syn_true,rcv_isr_demap_end:std_logic;
signal tx_cnt_t:STD_LOGIC_VECTOR(14 DOWNTO 0);
BEGIN 


--datain_t(31 downto 0)<=datain;
--datain_t(415 downto 32)<=(others=>'0');
--demap_out<=demap_dout(15 downto 0);

b2v_inst : receiver
PORT MAP(clk => clk_tx,
		 rst => rst_rx_syn,
		 rcv_en =>'1',
		 data_in => receiver_din,
		 fft_sink_ready => fft_sink_ready,
		 fft_source_sop => fft_source_sop,
		 fft_source_eop => fft_source_eop,
		 fft_source_valid => fft_source_valid,
		 fft_sop => fft_sop,
		 fft_eop => fft_eop,
		 fft_data_valid => fft_data_valid,
		 demap_sink_sop => demap_sink_sop,
		 demap_sink_eop => demap_sink_eop,
		 demap_sink_valid => demap_sink_valid,
		 demap_dout => demap_dout,
		 cnt_o =>rx_cnt,
		 fft_source_error => fft_source_error,
		 fft_source_exp => fft_source_exp,
		 fft_source_imag => fft_source_imag,
		 fft_source_imag_delay => fft_source_imag_delay,
		 fft_source_real => fft_source_real,
		 fft_source_real_delay => fft_source_real_delay,
		 rcv_data => rcv_data,
		 rt_r => rt_r,
		 rt_i => rt_i,
		 syn_point => syn_point,
		 dma_wr_en=> dma_wr_en,
		 rcv_isr_syn_start=>rcv_isr_syn_start,
		 rcv_isr_syn_err=>rcv_isr_syn_err,
		 rcv_isr_syn_true=>rcv_isr_syn_true,
		 rcv_isr_demap_end=>rcv_isr_demap_end,
		 rx_ram_wr_data=>rx_ram_wr_data,
		 rx_ram_wr_en=>rx_ram_wr_en,
		 rx_ram_wr_clk=>rx_ram_wr_clk,
		 rx_ram_wr_adr=>rx_ram_wr_adr,
		 rx_ram_rd_triger=>rx_ram_rd_triger);


b2v_inst1 : transfer
PORT MAP(rst => rst_rx_syn,
		 clk => clk_tx,
		 en => en,
		 xmt_ram_rd_en=>xmt_ram_rd_en,
		 xmt_ram_rd_adr=>xmt_ram_rd_adr,	
		 xmt_ram_rd_data=>xmt_ram_rd_data,
		 ram_rd_en => ram_rd_en,
		 ram_wr_en => ram_wr_en,
		 tx_data_valid => tx_data_valid,
		 ifft_data_valid => ifft_data_valid,
		 ifft_sop => ifft_sop,
		 ifft_eop => ifft_eop,
		 ifft_sink_ready => ifft_sink_ready,
		 ifft_source_sop => ifft_source_sop,
		 ifft_source_eop => ifft_source_eop,
		 rom_rd_en => rom_rd_en,		 
		 send_data_valid => send_data_valid,
		 pre_win_data_valid => pre_win_data_valid,
		 ram_data_valid => ram_data_valid,
		 rd_sel => rd_sel,
		 rd_data_sel => rd_data_sel,
		 wr_sel => wr_sel,
		 cnt => tx_cnt_t,
		 ifft_data => ifft_data,
		 ifft_dout_imag => ifft_dout_imag,
		 ifft_dout_real => ifft_dout_real,
		 ifft_source_error => ifft_source_error,
		 ifft_source_exp => ifft_source_exp,
		 ifft_source_imag => ifft_source_imag,
		 ifft_source_real => ifft_source_real,
		 ifft_source_valid =>ifft_source_valid,
		 pre_win_data => pre_win_data,
		 pre_inverse=>pre_inverse,
		 ram1_d => ram1_d,
		 ram2_d => ram2_d,
		 ram_rd_adr => ram_rd_adr,
		 ram_rd_data => ram_rd_data,
		 ram_wr_adr => ram_wr_adr,
		 rd_cnt_o => rd_cnt_o,
		 rom_rd_adr => rom_rd_adr,
		 tx_data_o => tx_data_o,
		 c0 =>c0,
		 c1 =>c1);
		 
timer_32_inst:timer_32 
     port map ( rst=> rst_tx,
                clk=>clk_tx,
			       dout=>timer_cnt);	 
		 
		 
	process(rst_tx,clk_tx) is
     begin
	    if rst_tx='1' then
		     reg_tx_end_time<=(others=>'0');
			  reg_syn_start_time<=(others=>'0');
			  reg_syn_err_time<=(others=>'0');
		     reg_syn_true_time<=(others=>'0');
	        reg_demap_end_time<=(others=>'0');
		 elsif clk_tx'event and clk_tx='1' then
	      if tx_cnt_t=19134 then
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


PROCESS(clk_tx)
BEGIN
IF (RISING_EDGE(clk_tx)) THEN
	rst_n_tx_syn <= rst_n_tx;
END IF;
END PROCESS;


PROCESS(clk_tx)
BEGIN
IF (RISING_EDGE(clk_tx)) THEN
	rst_rx_syn <= rst_tx;
END IF;
END PROCESS;


rst_tx <= NOT(rst_n_tx);

tx_cnt<=tx_cnt_t;

END bdf_type;



--LIBRARY ieee;
--USE ieee.std_logic_1164.all; 
--
--LIBRARY work;
--
--ENTITY plc_design IS 
--	PORT
--	(
--		clk_tx :  IN  STD_LOGIC;
--		rst_n_tx :  IN  STD_LOGIC;
--		en :  IN  STD_LOGIC;
--		datain :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
--		receiver_din: IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		ifft_sink_ready :  OUT  STD_LOGIC;
--		ifft_source_sop :  OUT  STD_LOGIC;
--		ifft_source_eop :  OUT  STD_LOGIC;
--		ifft_data_valid :  OUT  STD_LOGIC;
--		ifft_sop :  OUT  STD_LOGIC;
--		ifft_eop :  OUT  STD_LOGIC;
--		rom_rd_en :  OUT  STD_LOGIC;
--		send_data_valid :  OUT  STD_LOGIC;
--		pre_win_data_valid :  OUT  STD_LOGIC;
--		ram_rd_en :  OUT  STD_LOGIC;
--		ram_wr_en :  OUT  STD_LOGIC;
--		ram_data_valid :  OUT  STD_LOGIC;
--		tx_data_valid :  OUT  STD_LOGIC;
--		fft_sink_ready :  OUT  STD_LOGIC;
--		fft_source_sop :  OUT  STD_LOGIC;
--		fft_source_eop :  OUT  STD_LOGIC;
--		fft_source_valid :  OUT  STD_LOGIC;
--		fft_sop :  OUT  STD_LOGIC;
--		fft_eop :  OUT  STD_LOGIC;
--		fft_data_valid :  OUT  STD_LOGIC;
--		demap_sink_sop :  OUT  STD_LOGIC;
--		demap_sink_eop :  OUT  STD_LOGIC;
--		demap_sink_valid :  OUT  STD_LOGIC;
--		flag_o :  OUT  STD_LOGIC;
--		rd_sel :  OUT  STD_LOGIC;
--		rd_data_sel :  OUT  STD_LOGIC;
--		wr_sel :  OUT  STD_LOGIC;
--		flag_o1 :  OUT  STD_LOGIC;
--		flag_eop :  OUT  STD_LOGIC;
--		tx_cnt :  OUT  STD_LOGIC_VECTOR(14 DOWNTO 0);
--		rx_cnt:out integer range 0 to 13999;
--		--demap_dout :  OUT  STD_LOGIC_VECTOR(415 DOWNTO 0);
--		--demap_out :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
--		fft_source_error :  OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
--		fft_source_exp :  OUT  STD_LOGIC_VECTOR(5 DOWNTO 0);
--		fft_source_imag :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		fft_source_imag_delay :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		fft_source_real :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		fft_source_real_delay :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		ifft_data :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
--		ifft_dout_imag :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		ifft_dout_real :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		ifft_source_error :  OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
--		ifft_source_exp :  OUT  STD_LOGIC_VECTOR(5 DOWNTO 0);
--		ifft_source_imag :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		ifft_source_real :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		ifft_source_valid: out std_logic;
--		pre_win_data :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		pre_inverse:out std_logic;
--		ram1_d :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
--		ram2_d :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
--		ram_rd_adr :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
--		ram_rd_data :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
--		ram_wr_adr :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
--		rcv_data :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		rcv_data_delay :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		rd_cnt_o :  OUT  STD_LOGIC_VECTOR(10 DOWNTO 0);
--		rom_rd_adr :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
--		rt_r :  OUT  STD_LOGIC_VECTOR(24 DOWNTO 0);
--		rt_i: out STD_LOGIC_VECTOR(24 DOWNTO 0);
--		syn_point :  OUT  STD_LOGIC_VECTOR(8 DOWNTO 0);
--		tx_data_o :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		c0:out std_logic;
--		c1:out std_logic
--	);
--END plc_design;
--
--ARCHITECTURE bdf_type OF plc_design IS 
--
--COMPONENT receiver
--	PORT
--	(
--		rst :  IN  STD_LOGIC;
--		clk :  IN  STD_LOGIC;
--		rcv_en: in std_logic;
--		data_in :  IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		fft_sink_ready :  OUT  STD_LOGIC;
--		fft_source_sop :  OUT  STD_LOGIC;
--		fft_source_eop :  OUT  STD_LOGIC;
--		fft_source_valid :  OUT  STD_LOGIC;
--		demap_sink_sop :  OUT  STD_LOGIC;
--		demap_sink_eop :  OUT  STD_LOGIC;
--		demap_sink_valid :  OUT  STD_LOGIC;
--		fft_sop :  OUT  STD_LOGIC;
--		fft_eop :  OUT  STD_LOGIC;
--		fft_data_valid :  OUT  STD_LOGIC;
--		cnt_o:out integer range 0 to 13999;
--		demap_dout :  OUT  STD_LOGIC_VECTOR(415 DOWNTO 0);
--		fft_source_error :  OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
--		fft_source_exp :  OUT  STD_LOGIC_VECTOR(5 DOWNTO 0);
--		fft_source_imag :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		fft_source_imag_delay :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		fft_source_real :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		fft_source_real_delay :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		rcv_data :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		rt_i :  OUT  STD_LOGIC_VECTOR(24 DOWNTO 0);
--		rt_r :  OUT  STD_LOGIC_VECTOR(24 DOWNTO 0);
--		syn_point :  OUT  STD_LOGIC_VECTOR(8 DOWNTO 0)
--	);
--END COMPONENT;
--
--COMPONENT transfer
--	PORT
--	(
--		rst_n :  IN  STD_LOGIC;
--		clk :  IN  STD_LOGIC;
--		en :  IN  STD_LOGIC;
--		din :  IN  STD_LOGIC_VECTOR(415 DOWNTO 0);
--		ram_rd_en :  OUT  STD_LOGIC;
--		ram_wr_en :  OUT  STD_LOGIC;
--		tx_data_valid :  OUT  STD_LOGIC;
--		ifft_data_valid :  OUT  STD_LOGIC;
--		ifft_sop :  OUT  STD_LOGIC;
--		ifft_eop :  OUT  STD_LOGIC;
--		ifft_sink_ready :  OUT  STD_LOGIC;
--		ifft_source_sop :  OUT  STD_LOGIC;
--		ifft_source_eop :  OUT  STD_LOGIC;
--		rom_rd_en :  OUT  STD_LOGIC;
--		send_data_valid :  OUT  STD_LOGIC;
--		pre_win_data_valid :  OUT  STD_LOGIC;
--		ram_data_valid :  OUT  STD_LOGIC;
--		flag_o :  OUT  STD_LOGIC;
--		rd_sel :  OUT  STD_LOGIC;
--		rd_data_sel :  OUT  STD_LOGIC;
--		wr_sel :  OUT  STD_LOGIC;
--		cnt :  OUT  STD_LOGIC_VECTOR(14 DOWNTO 0);
--		ifft_data :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
--		ifft_dout_imag :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		ifft_dout_real :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		ifft_source_error :  OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
--		ifft_source_exp :  OUT  STD_LOGIC_VECTOR(5 DOWNTO 0);
--		ifft_source_imag :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		ifft_source_real :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		ifft_source_valid: out std_logic;
--		pre_win_data :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		pre_inverse:out std_logic;
--		ram1_d :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
--		ram2_d :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
--		ram_rd_adr :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
--		ram_rd_data :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
--		ram_wr_adr :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
--		rd_cnt_o :  OUT  STD_LOGIC_VECTOR(10 DOWNTO 0);
--		rom_rd_adr :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
--		tx_data_o :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
--		c0:out std_logic;
--		c1:out std_logic
--	);
--END COMPONENT;
--
--SIGNAL	rst_n_tx_syn :  STD_LOGIC;
--SIGNAL	rst_rx_syn :  STD_LOGIC;
--SIGNAL	rst_tx :  STD_LOGIC;
----SIGNAL	tx_data_o,receiver_din:  STD_LOGIC_VECTOR(11 DOWNTO 0);
--signal demap_dout:std_logic_vector(415 downto 0);
--signal datain_t:std_logic_vector(415 downto 0);
--BEGIN 
--
--
--datain_t(31 downto 0)<=datain;
--datain_t(415 downto 32)<=(others=>'0');
--demap_out<=demap_dout(15 downto 0);
--
--b2v_inst : receiver
--PORT MAP(clk => clk_tx,
--		 rst => rst_rx_syn,
--		 rcv_en =>'1',
--		 data_in => receiver_din,
--		 fft_sink_ready => fft_sink_ready,
--		 fft_source_sop => fft_source_sop,
--		 fft_source_eop => fft_source_eop,
--		 fft_source_valid => fft_source_valid,
--		 fft_sop => fft_sop,
--		 fft_eop => fft_eop,
--		 fft_data_valid => fft_data_valid,
--		 demap_sink_sop => demap_sink_sop,
--		 demap_sink_eop => demap_sink_eop,
--		 demap_sink_valid => demap_sink_valid,
--		 demap_dout => demap_dout,
--		 cnt_o =>rx_cnt,
--		 fft_source_error => fft_source_error,
--		 fft_source_exp => fft_source_exp,
--		 fft_source_imag => fft_source_imag,
--		 fft_source_imag_delay => fft_source_imag_delay,
--		 fft_source_real => fft_source_real,
--		 fft_source_real_delay => fft_source_real_delay,
--		 rcv_data => rcv_data,
--		 rt_r => rt_r,
--		 rt_i => rt_i,
--		 syn_point => syn_point);
--
--
--b2v_inst1 : transfer
--PORT MAP(rst_n => rst_n_tx_syn,
--		 clk => clk_tx,
--		 en => en,
--		 din => datain_t,
--		 ram_rd_en => ram_rd_en,
--		 ram_wr_en => ram_wr_en,
--		 tx_data_valid => tx_data_valid,
--		 ifft_data_valid => ifft_data_valid,
--		 ifft_sop => ifft_sop,
--		 ifft_eop => ifft_eop,
--		 ifft_sink_ready => ifft_sink_ready,
--		 ifft_source_sop => ifft_source_sop,
--		 ifft_source_eop => ifft_source_eop,
--		 rom_rd_en => rom_rd_en,		 
--		 send_data_valid => send_data_valid,
--		 pre_win_data_valid => pre_win_data_valid,
--		 ram_data_valid => ram_data_valid,
--		 flag_o => flag_o,
--		 rd_sel => rd_sel,
--		 rd_data_sel => rd_data_sel,
--		 wr_sel => wr_sel,
--		 cnt => tx_cnt,
--		 ifft_data => ifft_data,
--		 ifft_dout_imag => ifft_dout_imag,
--		 ifft_dout_real => ifft_dout_real,
--		 ifft_source_error => ifft_source_error,
--		 ifft_source_exp => ifft_source_exp,
--		 ifft_source_imag => ifft_source_imag,
--		 ifft_source_real => ifft_source_real,
--		 ifft_source_valid =>ifft_source_valid,
--		 pre_win_data => pre_win_data,
--		 pre_inverse=>pre_inverse,
--		 ram1_d => ram1_d,
--		 ram2_d => ram2_d,
--		 ram_rd_adr => ram_rd_adr,
--		 ram_rd_data => ram_rd_data,
--		 ram_wr_adr => ram_wr_adr,
--		 rd_cnt_o => rd_cnt_o,
--		 rom_rd_adr => rom_rd_adr,
--		 tx_data_o => tx_data_o,
--		 c0 =>c0,
--		 c1 =>c1);
--		 
--		 
--		 
--		 
--		 
--
--
--PROCESS(clk_tx)
--BEGIN
--IF (RISING_EDGE(clk_tx)) THEN
--	rst_n_tx_syn <= rst_n_tx;
--END IF;
--END PROCESS;
--
--
--PROCESS(clk_tx)
--BEGIN
--IF (RISING_EDGE(clk_tx)) THEN
--	rst_rx_syn <= rst_tx;
--END IF;
--END PROCESS;
--
--
--rst_tx <= NOT(rst_n_tx);
--
--
--
--END bdf_type;
