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
-- CREATED		"Mon Jul 31 18:42:07 2017"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY cp_insert IS 
	PORT
	(
		rst_n :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		eop :  IN  STD_LOGIC;
		sop :  IN  STD_LOGIC;
		din :  IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
		rd_en :  OUT  STD_LOGIC;
		rd_sel :  OUT  STD_LOGIC;
		wr_en :  OUT  STD_LOGIC;
		wr_sel :  OUT  STD_LOGIC;
		rd_data_sel :  OUT  STD_LOGIC;
		ram_data_oe :  OUT  STD_LOGIC;
		rd_continue_o :  OUT  STD_LOGIC;
		flag_o1 :  OUT  STD_LOGIC;
		flag_eop :  OUT  STD_LOGIC;
		dout :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		ram1_d :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		ram2_d :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		rd_adr :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		rd_cnt_o :  OUT  STD_LOGIC_VECTOR(8 DOWNTO 0);
		rt :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		wr_adr :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END cp_insert;

ARCHITECTURE bdf_type OF cp_insert IS 

COMPONENT ifft_ram_rd_ctr
	PORT(rst_n : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 sop : IN STD_LOGIC;
		 eop : IN STD_LOGIC;
		 rd_en : OUT STD_LOGIC;
		 rd_sel : OUT STD_LOGIC;
		 rd_data_sel : OUT STD_LOGIC;
		 oe : OUT STD_LOGIC;
		 rd_continue_o : OUT STD_LOGIC;
		 flag_o1 : OUT STD_LOGIC;
		 flag_eop : OUT STD_LOGIC;
		 rd_adr : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 rd_cnt_o : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
		 ram_aclr:out std_logic
	);
END COMPONENT;

COMPONENT ifft_ram_wr_ctr
	PORT(rst_n : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 sop : IN STD_LOGIC;
		 din : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 wr_en : OUT STD_LOGIC;
		 wr_sel : OUT STD_LOGIC;
		 dout : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 wr_adr : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT d_sel
	PORT(sel : IN STD_LOGIC;
		 oe : IN STD_LOGIC;
		 a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 b : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 c : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ifft_ram
  port
	(
		aclr		: IN STD_LOGIC  := '0';
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		rdaddress		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		rden		: IN STD_LOGIC  := '1';
		wraddress		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren		: IN STD_LOGIC  := '0';
		q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	dout_t :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	ram_data_oe_t:  STD_LOGIC;
SIGNAL	rd_adr_t :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	rd_data_sel_t :  STD_LOGIC;
SIGNAL	rd_en_t:  STD_LOGIC;
SIGNAL	rd_en_1 :  STD_LOGIC;
SIGNAL	rd_en_2 :  STD_LOGIC;
SIGNAL	rd_sel_t :  STD_LOGIC;
SIGNAL	rd_sel_n :  STD_LOGIC;
SIGNAL	wr_adr_t :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	wr_en_t:  STD_LOGIC;
SIGNAL	wr_en_1 :  STD_LOGIC;
SIGNAL	wr_en_2 :  STD_LOGIC;
SIGNAL	wr_sel_t :  STD_LOGIC;
SIGNAL	wr_sel_n :  STD_LOGIC;
SIGNAL	ram1_d_t :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	ram2_d_t :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	ram_aclr:  STD_LOGIC;

BEGIN 
dout <=dout_t;
ram_data_oe <=ram_data_oe_t;
rd_adr <=rd_adr_t;
rd_data_sel<=rd_data_sel_t;
rd_en<=rd_en_t;
rd_sel <=rd_sel_t;
wr_adr <=wr_adr_t;
wr_en <= wr_en_t;
wr_sel <=wr_sel_t;
ram1_d <=ram1_d_t;
ram2_d <=ram2_d_t;

b2v_inst : ifft_ram_rd_ctr
PORT MAP(rst_n => rst_n,
		 clk => clk,
		 sop => sop,
		 eop => eop,
		 rd_en => rd_en_t,
		 rd_sel => rd_sel_t,
		 rd_data_sel => rd_data_sel_t,
		 oe => ram_data_oe_t,
		 rd_continue_o => rd_continue_o,
		 flag_o1 => flag_o1,
		 flag_eop => flag_eop,
		 rd_adr => rd_adr_t,
		 rd_cnt_o => rd_cnt_o,
		 ram_aclr =>ram_aclr);


b2v_inst1 : ifft_ram_wr_ctr
PORT MAP(rst_n => rst_n,
		 clk => clk,
		 sop => sop,
		 din => din,
		 wr_en => wr_en_t,
		 wr_sel => wr_sel_t,
		 dout => dout_t,
		 wr_adr => wr_adr_t);


wr_en_1 <= wr_en_t AND wr_sel_t;


wr_en_2 <= wr_en_t AND wr_sel_n;


rd_en_1 <= rd_en_t AND rd_sel_t;


rd_en_2 <= rd_en_t AND rd_sel_n;


b2v_inst15 : d_sel
PORT MAP(sel => rd_data_sel_t,
		 oe => ram_data_oe_t,
		 a => ram1_d_t,
		 b => ram2_d_t,
		 c => rt);


b2v_inst6 : ifft_ram
PORT MAP(aclr =>ram_aclr,
         wren => wr_en_1,
		 rden => rd_en_1,
		 clock => clk,
		 data => dout_t,
		 rdaddress => rd_adr_t,
		 wraddress => wr_adr_t,
		 q => ram1_d_t);


b2v_inst7 : ifft_ram
PORT MAP(aclr =>ram_aclr,
         wren => wr_en_2,
		 rden => rd_en_2,
		 clock => clk,
		 data => dout_t,
		 rdaddress => rd_adr_t,
		 wraddress => wr_adr_t,
		 q => ram2_d_t);


rd_sel_n <= NOT(rd_sel_t);



wr_sel_n <= NOT(wr_sel_t);


END bdf_type;