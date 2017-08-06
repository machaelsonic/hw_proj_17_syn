-- Copyright (C) 1991-2012 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 12.1 Build 177 11/07/2012 SJ Full Version"
-- CREATED		"Mon Jul 31 18:27:14 2017"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY plc_design IS 
	PORT
	(
		clk_tx :  IN  STD_LOGIC;
		rst_n_tx :  IN  STD_LOGIC;
		en :  IN  STD_LOGIC;
		datain :  IN  STD_LOGIC_VECTOR(35 DOWNTO 0);
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
		pre_cnt :  OUT  STD_LOGIC;
		fft_source_sop :  OUT  STD_LOGIC;
		fft_source_eop :  OUT  STD_LOGIC;
		fft_source_valid :  OUT  STD_LOGIC;
		fft_sop :  OUT  STD_LOGIC;
		fft_eop :  OUT  STD_LOGIC;
		fft_data_valid :  OUT  STD_LOGIC;
		demap_sink_sop :  OUT  STD_LOGIC;
		demap_sink_eop :  OUT  STD_LOGIC;
		demap_sink_valid :  OUT  STD_LOGIC;
		flag_o :  OUT  STD_LOGIC;
		rd_sel :  OUT  STD_LOGIC;
		rd_data_sel :  OUT  STD_LOGIC;
		wr_sel :  OUT  STD_LOGIC;
		rd_continue_o :  OUT  STD_LOGIC;
		flag_o1 :  OUT  STD_LOGIC;
		flag_eop :  OUT  STD_LOGIC;
		a_r :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		cnt :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		cnt_o :  OUT  STD_LOGIC_VECTOR(8 DOWNTO 0);
		demap_dout :  OUT  STD_LOGIC_VECTOR(35 DOWNTO 0);
		fft_source_error :  OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
		fft_source_exp :  OUT  STD_LOGIC_VECTOR(5 DOWNTO 0);
		fft_source_imag :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		fft_source_imag_delay :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		fft_source_imag_delay_1 :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		fft_source_real :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		fft_source_real_delay :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		fft_source_real_delay_1 :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		ifft_data :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		ifft_dout_imag :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		ifft_dout_real :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		ifft_source_error :  OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
		ifft_source_exp :  OUT  STD_LOGIC_VECTOR(5 DOWNTO 0);
		ifft_source_imag :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		ifft_source_real :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		max_p :  OUT  STD_LOGIC_VECTOR(8 DOWNTO 0);
		p_cnt_o :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		pre_win_data :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		ram1_d :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		ram2_d :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		ram_rd_adr :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		ram_rd_data :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		ram_wr_adr :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		rcv_data :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		rcv_data_delay :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		rd_cnt_o :  OUT  STD_LOGIC_VECTOR(8 DOWNTO 0);
		rom_rd_adr :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		rt_r :  OUT  STD_LOGIC_VECTOR(24 DOWNTO 0);
		syn_point :  OUT  STD_LOGIC_VECTOR(8 DOWNTO 0);
		tx_data_o :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		x_cor1 :  OUT  STD_LOGIC_VECTOR(20 DOWNTO 0);
		x_cor2 :  OUT  STD_LOGIC_VECTOR(20 DOWNTO 0)
	);
END plc_design;

ARCHITECTURE bdf_type OF plc_design IS 

COMPONENT receiver
	PORT(clk : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 data_in : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 pre_cnt : OUT STD_LOGIC;
		 fft_sink_ready : OUT STD_LOGIC;
		 fft_source_sop : OUT STD_LOGIC;
		 fft_source_eop : OUT STD_LOGIC;
		 fft_source_valid : OUT STD_LOGIC;
		 fft_sop : OUT STD_LOGIC;
		 fft_eop : OUT STD_LOGIC;
		 fft_data_valid : OUT STD_LOGIC;
		 demap_sink_sop : OUT STD_LOGIC;
		 demap_sink_eop : OUT STD_LOGIC;
		 demap_sink_valid : OUT STD_LOGIC;
		 a_r : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 cnt_o : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
		 demap_dout : OUT STD_LOGIC_VECTOR(35 DOWNTO 0);
		 fft_source_eeror : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 fft_source_exp : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		 fft_source_imag : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 fft_source_imag_delay : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 fft_source_imag_delay_1 : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 fft_source_real : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 fft_source_real_delay : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 fft_source_real_delay_1 : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 max_p : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
		 max_value : OUT STD_LOGIC_VECTOR(20 DOWNTO 0);
		 p_cnt_o : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 rcv_data : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 rcv_data_delay : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 rt_i : OUT STD_LOGIC_VECTOR(24 DOWNTO 0);
		 rt_r : OUT STD_LOGIC_VECTOR(24 DOWNTO 0);
		 syn_point : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
		 x_cor1 : OUT STD_LOGIC_VECTOR(20 DOWNTO 0);
		 x_cor2 : OUT STD_LOGIC_VECTOR(20 DOWNTO 0)
	);
END COMPONENT;

COMPONENT transfer
	PORT(rst_n : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 en : IN STD_LOGIC;
		 din : IN STD_LOGIC_VECTOR(35 DOWNTO 0);
		 ifft_sink_ready : OUT STD_LOGIC;
		 ifft_source_sop : OUT STD_LOGIC;
		 ifft_source_eop : OUT STD_LOGIC;
		 ifft_data_valid : OUT STD_LOGIC;
		 ifft_sop : OUT STD_LOGIC;
		 ifft_eop : OUT STD_LOGIC;
		 rom_rd_en : OUT STD_LOGIC;
		 send_data_valid : OUT STD_LOGIC;
		 pre_win_data_valid : OUT STD_LOGIC;
		 ram_rd_en : OUT STD_LOGIC;
		 flag_o : OUT STD_LOGIC;
		 rd_sel : OUT STD_LOGIC;
		 rd_data_sel : OUT STD_LOGIC;
		 ram_data_valid : OUT STD_LOGIC;
		 rd_continue_o : OUT STD_LOGIC;
		 flag_o1 : OUT STD_LOGIC;
		 flag_eop : OUT STD_LOGIC;
		 ram_wr_en : OUT STD_LOGIC;
		 wr_sel : OUT STD_LOGIC;
		 tx_data_valid : OUT STD_LOGIC;
		 cnt : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 ifft_data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 ifft_dout_imag : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 ifft_dout_real : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 ifft_source_error : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 ifft_source_exp : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		 ifft_source_imag : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 ifft_source_real : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 pre_win_data : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 ram1_d : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 ram2_d : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 ram_rd_adr : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 ram_rd_data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 ram_wr_adr : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 rd_cnt_o : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
		 rom_rd_adr : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 tx_data_o : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	rst_n_tx_syn :  STD_LOGIC;
SIGNAL	rst_rx_syn :  STD_LOGIC;
SIGNAL	rst_tx :  STD_LOGIC;
--SIGNAL	tx_data_o,receiver_din:  STD_LOGIC_VECTOR(11 DOWNTO 0);


BEGIN 



b2v_inst : receiver
PORT MAP(clk => clk_tx,
		 rst => rst_rx_syn,
		 data_in => receiver_din,
		 pre_cnt => pre_cnt,
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
		 a_r => a_r,
		 cnt_o => cnt_o,
		 demap_dout => demap_dout,
		 fft_source_eeror => fft_source_error,
		 fft_source_exp => fft_source_exp,
		 fft_source_imag => fft_source_imag,
		 fft_source_imag_delay => fft_source_imag_delay,
		 fft_source_imag_delay_1 => fft_source_imag_delay_1,
		 fft_source_real => fft_source_real,
		 fft_source_real_delay => fft_source_real_delay,
		 fft_source_real_delay_1 => fft_source_real_delay_1,
		 max_p => max_p,
		 p_cnt_o => p_cnt_o,
		 rcv_data => rcv_data,
		 rcv_data_delay => rcv_data_delay,
		 rt_r => rt_r,
		 syn_point => syn_point,
		 x_cor1 => x_cor1,
		 x_cor2 => x_cor2);


b2v_inst1 : transfer
PORT MAP(rst_n => rst_n_tx_syn,
		 clk => clk_tx,
		 en => en,
		 din => datain,
		 ifft_sink_ready => ifft_sink_ready,
		 ifft_source_sop => ifft_source_sop,
		 ifft_source_eop => ifft_source_eop,
		 ifft_data_valid => ifft_data_valid,
		 ifft_sop => ifft_sop,
		 ifft_eop => ifft_eop,
		 rom_rd_en => rom_rd_en,
		 send_data_valid => send_data_valid,
		 pre_win_data_valid => pre_win_data_valid,
		 ram_rd_en => ram_rd_en,
		 flag_o => flag_o,
		 rd_sel => rd_sel,
		 rd_data_sel => rd_data_sel,
		 ram_data_valid => ram_data_valid,
		 rd_continue_o => rd_continue_o,
		 flag_o1 => flag_o1,
		 flag_eop => flag_eop,
		 ram_wr_en => ram_wr_en,
		 wr_sel => wr_sel,
		 tx_data_valid => tx_data_valid,
		 cnt => cnt,
		 ifft_data => ifft_data,
		 ifft_dout_imag => ifft_dout_imag,
		 ifft_dout_real => ifft_dout_real,
		 ifft_source_error => ifft_source_error,
		 ifft_source_exp => ifft_source_exp,
		 ifft_source_imag => ifft_source_imag,
		 ifft_source_real => ifft_source_real,
		 pre_win_data => pre_win_data,
		 ram1_d => ram1_d,
		 ram2_d => ram2_d,
		 ram_rd_adr => ram_rd_adr,
		 ram_rd_data => ram_rd_data,
		 ram_wr_adr => ram_wr_adr,
		 rd_cnt_o => rd_cnt_o,
		 rom_rd_adr => rom_rd_adr,
		 tx_data_o => tx_data_o);


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



END bdf_type;