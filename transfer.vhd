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
-- CREATED		"Tue Aug 01 15:32:58 2017"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all; 
LIBRARY work;

ENTITY transfer IS 
	PORT
	(
		rst_n :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		en :  IN  STD_LOGIC;
		din :  IN  STD_LOGIC_VECTOR(415 DOWNTO 0);
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
		flag_o :  OUT  STD_LOGIC;
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
END transfer;

ARCHITECTURE bdf_type OF transfer IS 

COMPONENT rom_ip
	PORT(rden : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 address : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END COMPONENT;

COMPONENT fft_ip
	PORT(clk : IN STD_LOGIC;
		 reset_n : IN STD_LOGIC;
		 clk_ena : IN STD_LOGIC;
		 inverse : IN STD_LOGIC;
		 sink_valid : IN STD_LOGIC;
		 sink_sop : IN STD_LOGIC;
		 sink_eop : IN STD_LOGIC;
		 source_ready : IN STD_LOGIC;
		 sink_error : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 sink_imag : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 sink_real : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 sink_ready : OUT STD_LOGIC;
		 source_sop : OUT STD_LOGIC;
		 source_eop : OUT STD_LOGIC;
		 source_valid : OUT STD_LOGIC;
		 source_error : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 source_exp : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		 source_imag : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 source_real : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ifft_data_gen
GENERIC (N : INTEGER	);
	port(rst_n: in std_logic;
       clk: in std_logic;
       din: in std_logic_vector(415 downto 0);
       frame_flag:in std_logic;
       source_data_valid:in std_logic;
       sink_data_valid:out std_logic;
       sop:out std_logic;
       eop:out std_logic;
       dout_real:out std_logic_vector(11 downto 0);
       dout_imag:out std_logic_vector(11 downto 0)
	);
END COMPONENT;

COMPONENT cp_insert
  port	(
		rst_n :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		eop :  IN  STD_LOGIC;
		sop :  IN  STD_LOGIC;
		din :  IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
		state_cnt: in std_logic_vector(14 downto 0);
		ifft_source_valid: in std_logic;
		rd_en :  OUT  STD_LOGIC;
		rd_sel :  OUT  STD_LOGIC;
		wr_en :  OUT  STD_LOGIC;
		wr_sel :  OUT  STD_LOGIC;
		rd_data_sel :  OUT  STD_LOGIC;
		ram_data_oe :  OUT  STD_LOGIC;
		dout :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		ram1_d :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		ram2_d :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		rd_adr :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		rd_cnt_o :  OUT  STD_LOGIC_VECTOR(10 DOWNTO 0);
		rt :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		wr_adr :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END COMPONENT;

COMPONENT tx_data
	PORT(rst_n : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 valid1 : IN STD_LOGIC;
		 valid2 : IN STD_LOGIC;
		 d1 : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 d2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 state_cnt: in std_logic_vector(14 downto 0);
		 data_valid : OUT STD_LOGIC;
		 do : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 c0:out std_logic;
		 c1:out std_logic 
	);
END COMPONENT;

COMPONENT tx_ctr
	PORT(rst_n : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 en : IN STD_LOGIC;
		 ifft_eop : IN STD_LOGIC;
		 din : IN STD_LOGIC_VECTOR(415 DOWNTO 0);
		 rd_en : OUT STD_LOGIC;
		 frame_flag:out std_logic;
		 send_data_valid : OUT STD_LOGIC;
		 ram_data_valid : OUT STD_LOGIC;
		 flag_o : OUT STD_LOGIC;
		 adr : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 cnt_o : OUT STD_LOGIC_VECTOR(14 DOWNTO 0);
		 dout : OUT STD_LOGIC_VECTOR(415 DOWNTO 0);
		 pre_inverse:out std_logic
	);
END COMPONENT;

SIGNAL	ifft_data_valid_t:  STD_LOGIC;
SIGNAL	ifft_dout_imag_t :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	ifft_dout_real_t :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	ifft_eop_t :  STD_LOGIC;
SIGNAL	ifft_sop_t :  STD_LOGIC;
SIGNAL	ifft_source_ready_t :  STD_LOGIC;
SIGNAL	ifft_source_real_t:  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	ifft_source_sop_t:  STD_LOGIC;
SIGNAL	ifft_source_eop_t :  STD_LOGIC;
SIGNAL	pre_win_data_t,pre_win_data_t1:  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	pre_win_data_valid_t:  STD_LOGIC;
SIGNAL	ram_data_valid_t:  STD_LOGIC;
SIGNAL	ram_rd_data_t:  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	rom_rd_adr_t:  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	rom_rd_en_t:  STD_LOGIC;
SIGNAL	send_data_valid_t:  STD_LOGIC;
SIGNAL	tx_ctr_do_t :  STD_LOGIC_VECTOR(415 DOWNTO 0);
SIGNAL	 ifft_sink_ready_t: std_logic;



--signal cnt_t: integer range 0 to 1023;
--signal a: std_logic_vector(11 downto 0);
signal en_d,fft_rst_n,en_delay_8:std_logic;
signal tmp: std_logic_vector(9 downto 0);
signal pre_inverse_t:std_logic;
signal state_cnt:std_logic_vector(14 downto 0);
signal frame_flag,ifft_source_valid_t:std_logic;
-----------------------------
--signal din:std_logic_vector(415 downto 0);

BEGIN 
ifft_data_valid <=ifft_data_valid_t;
ifft_dout_imag  <=ifft_dout_imag_t;
ifft_dout_real  <=ifft_dout_real_t;
ifft_eop <=ifft_eop_t;
ifft_sop <=ifft_sop_t;
ifft_source_eop <=ifft_source_eop_t;
ifft_source_sop <=ifft_source_sop_t;
--ifft_source_ready <= ifft_source_ready_t;
ifft_source_real <=ifft_source_real_t;

pre_win_data_valid <=pre_win_data_valid_t;

ram_data_valid<=ram_data_valid_t;
ram_rd_data <=ram_rd_data_t;
rom_rd_adr <=rom_rd_adr_t;
rom_rd_en <=rom_rd_en_t;
send_data_valid <=send_data_valid_t;
--tx_ctr_do <=tx_ctr_do_t;
 ifft_sink_ready <= ifft_sink_ready_t;
 
 pre_inverse<= pre_inverse_t;
 cnt<=state_cnt;
 
 ifft_source_valid<=ifft_source_valid_t;
 
--------------------------------------------------
-- process(rst_n,clk) is
--   variable tmp:std_logic_vector(415 downto 0);
--	variable cnt_1:integer range 0 to 25999;
--		  begin
--		    if rst_n='0' then
--			    cnt_1:=25900;
--				 tmp:=(others=>'0');
--			 elsif clk'event and clk='1' then
--			    if cnt_1=25999 then
--				    cnt_1:=0;
--					 tmp:=tmp+1;
--				 else
--				    cnt_1:=cnt_1+1;
--					 tmp:=tmp;
--				end if;
--		    end if;
--		din<=tmp;	 
--		end process; 
		
----------------------------------------- 
 
 
b2v_inst : rom_ip
PORT MAP(rden => rom_rd_en_t,
		 clock => clk,
		 address => rom_rd_adr_t,
		 q => pre_win_data_t);
		 
   pre_win_data_t1 <=pre_win_data_t when pre_inverse_t='0' else
                  0-pre_win_data_t;
   pre_win_data <=pre_win_data_t1;
    
 process(rst_n,clk) is   
   begin 
      if rst_n='0' then 
	     en_d<='0';
	  elsif clk'event and clk='1' then
	     en_d<=en;
	  end if;
	  
	  fft_rst_n<=rst_n and (not(en_d) or en);
 end process;
 
 process(rst_n,clk) is   
   begin 
      if rst_n='0' then 
	     tmp<=(others=>'0');
	  elsif clk'event and clk='1' then
	     tmp(0)<=en;
	     for i in 0 to 6 loop
		   tmp(i+1)<=tmp(i);
		   end loop;
		  en_delay_8<=tmp(7);
	  end if;
 end process;
 
b2v_inst1 : fft_ip
PORT MAP(clk => clk,
		 --reset_n => rst_n ,
		 reset_n =>fft_rst_n,
		 clk_ena => '1',
		 inverse => '1',
		 sink_valid => ifft_data_valid_t,
		 --sink_valid => '1',
		 sink_sop => ifft_sop_t,
		 sink_eop => ifft_eop_t,
		 --source_ready => ifft_source_ready_t,
		 source_ready => '1',
		 sink_error => "00",
		 sink_imag => ifft_dout_imag_t,
		 sink_real => ifft_dout_real_t,
		 sink_ready => ifft_sink_ready_t,
		 source_sop => ifft_source_sop_t,
		 source_eop => ifft_source_eop_t,
		 source_valid => ifft_source_valid_t,
		 source_error => ifft_source_error,
		 source_exp => ifft_source_exp,
		 source_imag => ifft_source_imag,
		 source_real => ifft_source_real_t);



b2v_inst2 : ifft_data_gen
GENERIC MAP(N => 80
			)
PORT MAP(rst_n => rst_n,
		 clk => clk,
		 source_data_valid => send_data_valid_t,
		 din => tx_ctr_do_t,
		 frame_flag =>frame_flag,
		 sink_data_valid => ifft_data_valid_t,
		 sop => ifft_sop_t,
		 eop => ifft_eop_t,
		 dout_imag => ifft_dout_imag_t,
		 dout_real => ifft_dout_real_t);


b2v_inst3 : cp_insert
PORT MAP(rst_n => rst_n,
		 clk => clk,
		 eop => ifft_source_eop_t,
		 sop => ifft_source_sop_t,
		 din => ifft_source_real_t,
		 state_cnt =>state_cnt,
		 ifft_source_valid=>ifft_source_valid_t,
		 rd_en => ram_rd_en,
		 rd_sel => rd_sel,
		 rd_data_sel => rd_data_sel,
		 ram_data_oe => ram_data_valid_t,
		 wr_en => ram_wr_en,
		 wr_sel => wr_sel,
		 dout => ifft_data,
		 ram1_d => ram1_d,
		 ram2_d => ram2_d,
		 rd_adr => ram_rd_adr,
		 rd_cnt_o => rd_cnt_o,
		 rt => ram_rd_data_t,
		 wr_adr => ram_wr_adr);


b2v_inst4 : tx_data
PORT MAP(rst_n => rst_n,
		 clk => clk,
		 valid1 => pre_win_data_valid_t,
		 valid2 => ram_data_valid_t,
		 d1 => pre_win_data_t1,
		 d2 => ram_rd_data_t,
		 state_cnt=>state_cnt,
		 data_valid => tx_data_valid,
		 do => tx_data_o,
		 c0 =>c0,
		 c1 =>c1);


b2v_inst5 : tx_ctr
PORT MAP(rst_n => rst_n,
		 clk => clk,
		 --en => en,
		 en => en_delay_8,
		 ifft_eop => ifft_eop_t,
		 din => din,
		 rd_en => rom_rd_en_t,
		 frame_flag =>frame_flag,
		 send_data_valid => send_data_valid_t,
		 ram_data_valid => pre_win_data_valid_t,
		 flag_o => flag_o,
		 adr => rom_rd_adr_t,
		 cnt_o => state_cnt,
		 dout => tx_ctr_do_t,
		 pre_inverse =>pre_inverse_t);

-- ifft_dout_imag_t<=(others=>'0');
-- ifft_dout_real_t<=conv_std_logic_vector(cnt_t,12);
--a<=conv_std_logic_vector(cnt_t,12);
 
END bdf_type;