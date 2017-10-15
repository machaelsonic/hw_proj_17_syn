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
-- CREATED		"Tue Aug 08 15:15:58 2017"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY rx IS 
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
		dma_wr_en:out std_logic
	);
END rx;

ARCHITECTURE bdf_type OF rx IS 

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
		dma_wr_en:out std_logic
	);
END COMPONENT;

signal tmp:std_logic_vector(7 downto 0);
signal demap_sink_valid_t:std_logic;
BEGIN 



b2v_inst : receiver
PORT MAP(rst => rst_rx_syn,
		 clk => clk_20M,
		 rcv_en => rcv_en,
		 data_in => rx_data,
		 cnt_o =>rx_cnt,
		 demap_sink_sop => demap_sink_sop,
		 demap_sink_eop => demap_sink_eop,
		 demap_sink_valid => demap_sink_valid_t,
		 demap_dout => demap_dout,
		 dma_wr_en=> dma_wr_en);

rcv_data_valid<=demap_sink_valid_t;
END bdf_type;