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
-- CREATED		"Tue Aug 08 15:18:40 2017"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY tx IS 
	PORT
	(
		rst_syn :  IN  STD_LOGIC;
		clk_20M :  IN  STD_LOGIC;
		tx_triger: in std_logic;
		xmt_ram_wr_data: in std_logic_vector(31 downto 0);
		ISL_C1 :  OUT  STD_LOGIC;
		ISL_C0 :  OUT  STD_LOGIC;
		tx_cnt:OUT  STD_LOGIC_VECTOR(14 DOWNTO 0);
		tx_data_valid :  OUT  STD_LOGIC;
		tx_data_o :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		xmt_ram_wr_en:out std_logic
	);
END tx;

ARCHITECTURE bdf_type OF tx IS 

COMPONENT transfer
	PORT
	(
		rst :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		en :  IN  STD_LOGIC;
		xmt_ram_wr_data: in std_logic_vector(31 downto 0);
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
		c1:out std_logic;
		xmt_ram_wr_en:out std_logic
	);
END COMPONENT;

COMPONENT rx_to_tx
	PORT(rst_n : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 rcv_data_valid : IN STD_LOGIC;
		 en : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	c0 :  STD_LOGIC;
SIGNAL	c1 :  STD_LOGIC;
SIGNAL	data_gen :  STD_LOGIC_VECTOR(415 DOWNTO 0);
SIGNAL	rst_n_tx_syn :  STD_LOGIC;
signal en: std_logic;

BEGIN 



rst_n_tx_syn <= NOT(rst_syn);



b2v_inst1 : transfer
PORT MAP(rst => rst_syn,
		 clk => clk_20M,
		 en => en,
		 xmt_ram_wr_data=>xmt_ram_wr_data,
		 tx_data_valid => tx_data_valid,
		 c0 => c0,
		 c1 => c1,
		 cnt =>tx_cnt,
		 tx_data_o => tx_data_o,
		 xmt_ram_wr_en=>xmt_ram_wr_en);


b2v_inst2 : rx_to_tx
PORT MAP(rst_n => rst_n_tx_syn,
		 clk => clk_20M,
		 rcv_data_valid => tx_triger,
		 en => en);

ISL_C1 <= c1;
ISL_C0 <= c0;

END bdf_type;