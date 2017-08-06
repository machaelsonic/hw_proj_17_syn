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
-- CREATED		"Tue Aug 01 15:33:07 2017"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY receiver IS 
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
		pre_cnt :  OUT  STD_LOGIC;
		fft_sop :  OUT  STD_LOGIC;
		fft_eop :  OUT  STD_LOGIC;
		fft_data_valid :  OUT  STD_LOGIC;
		a_r :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		cnt_o :  OUT  STD_LOGIC_VECTOR(8 DOWNTO 0);
		demap_dout :  OUT  STD_LOGIC_VECTOR(35 DOWNTO 0);
		fft_source_eeror :  OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
		fft_source_exp :  OUT  STD_LOGIC_VECTOR(5 DOWNTO 0);
		fft_source_imag :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		fft_source_imag_delay :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		fft_source_imag_delay_1 :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		fft_source_real :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		fft_source_real_delay :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		fft_source_real_delay_1 :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		max_p :  OUT  STD_LOGIC_VECTOR(8 DOWNTO 0);
		max_value :  OUT  STD_LOGIC_VECTOR(20 DOWNTO 0);
		p_cnt_o :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		rcv_data :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		rcv_data_delay :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		rt_i :  OUT  STD_LOGIC_VECTOR(24 DOWNTO 0);
		rt_r :  OUT  STD_LOGIC_VECTOR(24 DOWNTO 0);
		syn_point :  OUT  STD_LOGIC_VECTOR(8 DOWNTO 0);
		x_cor1 :  OUT  STD_LOGIC_VECTOR(20 DOWNTO 0);
		x_cor2 :  OUT  STD_LOGIC_VECTOR(20 DOWNTO 0)
	);
END receiver;

ARCHITECTURE bdf_type OF receiver IS 

COMPONENT x_cor
	PORT(rst_n : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 din : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 dout1 : OUT STD_LOGIC_VECTOR(20 DOWNTO 0);
		 dout2 : OUT STD_LOGIC_VECTOR(20 DOWNTO 0)
	);
END COMPONENT;

COMPONENT div
	PORT(rst_n : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 din2 : IN STD_LOGIC_VECTOR(20 DOWNTO 0);
		 pre_cnt_o : OUT STD_LOGIC;
		 cnt_o : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
		 max_p : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
		 max_value : OUT STD_LOGIC_VECTOR(20 DOWNTO 0);
		 p_cnt_o : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 syn_point : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
	);
END COMPONENT;

COMPONENT sop_eop_gen
	PORT(rst_n : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 pre_cnt : IN STD_LOGIC;
		 sop : OUT STD_LOGIC;
		 eop : OUT STD_LOGIC;
		 data_valid : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT mult_complex_ip
	PORT(dataa_imag : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 dataa_real : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 datab_imag : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 datab_real : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 result_imag : OUT STD_LOGIC_VECTOR(24 DOWNTO 0);
		 result_real : OUT STD_LOGIC_VECTOR(24 DOWNTO 0)
	);
END COMPONENT;

COMPONENT add_ip
	PORT(datab : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
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

COMPONENT fifo_256
 generic(N: integer );
    port( rst_n: in std_logic;
         clk: in std_logic;
		 en:in std_logic;
		 din:in std_logic_vector(11 downto 0);
		 dout: out std_logic_vector(11 downto 0));
END COMPONENT fifo_256;

COMPONENT data_out
	PORT(rst_n : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 sink_eop : IN STD_LOGIC;
		 sink_valid : IN STD_LOGIC;
		 din : IN STD_LOGIC_VECTOR(35 DOWNTO 0);
		 data_valid : OUT STD_LOGIC;
		 dout : OUT STD_LOGIC_VECTOR(35 DOWNTO 0)
	);
END COMPONENT;

COMPONENT fifo_ip_8
	PORT(wrreq : IN STD_LOGIC;
		 rdreq : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 aclr : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END COMPONENT;

COMPONENT de_map
GENERIC (N : INTEGER
			);
	PORT(rst_n : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 source_valid : IN STD_LOGIC;
		 source_sop : IN STD_LOGIC;
		 din_imag : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 din_imag_clc : IN STD_LOGIC_VECTOR(24 DOWNTO 0);
		 din_real : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 din_real_clc : IN STD_LOGIC_VECTOR(24 DOWNTO 0);
		 sink_sop : OUT STD_LOGIC;
		 sink_eop : OUT STD_LOGIC;
		 sink_valid : OUT STD_LOGIC;
		 dout : OUT STD_LOGIC_VECTOR(35 DOWNTO 0);
		 dout_imag : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 dout_real : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	a_i :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	a_r_t :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	fft_data_valid_t :  STD_LOGIC;
SIGNAL	fft_eop_t:  STD_LOGIC;
SIGNAL	fft_sop_t:  STD_LOGIC;
SIGNAL	fft_source_imag_t:  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	fft_source_real_t:  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	fft_source_sop_t:  STD_LOGIC;
SIGNAL	fft_source_valid_t:  STD_LOGIC;
SIGNAL	pre_cnt_t :  STD_LOGIC;
SIGNAL	rcv_data_t:  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	rcv_data_delay_t:  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	rst_n:  STD_LOGIC;
SIGNAL	rt_i_t:  STD_LOGIC_VECTOR(24 DOWNTO 0);
SIGNAL	rt_r_t :  STD_LOGIC_VECTOR(24 DOWNTO 0);
SIGNAL	x_cor2_t :  STD_LOGIC_VECTOR(20 DOWNTO 0);
signal   fft_source_imag_delay_1_t:std_logic_vector(11 downto 0);
signal   fft_source_imag_delay_t:std_logic_vector(11 downto 0);
signal   fft_source_imag_delay_n:std_logic_vector(11 downto 0);
signal   fft_source_real_delay_1_t:std_logic_vector(11 downto 0);
signal   fft_source_real_delay_t:std_logic_vector(11 downto 0);
signal   demap_sink_v:std_logic;
signal   demap_d:std_logic_vector(35 downto 0);
signal   demap_sink_eop_t:std_logic;

BEGIN 


b2v_inst : x_cor
PORT MAP(rst_n => rst_n,
		 clk => clk,
		 din => rcv_data_t,
		 dout1 => x_cor1,
		 dout2 => x_cor2_t);


b2v_inst1 : div
PORT MAP(rst_n => rst_n,
		 clk => clk,
		 din2 => x_cor2_t,
		 pre_cnt_o => pre_cnt_t,
		 cnt_o => cnt_o,
		 max_p => max_p,
		 max_value => max_value,
		 p_cnt_o => p_cnt_o,
		 syn_point => syn_point);

x_cor2<=x_cor2_t;


b2v_inst2 : sop_eop_gen
PORT MAP(rst_n => rst_n,
		 clk => clk,
		 pre_cnt => pre_cnt_t,
		 sop => fft_sop_t,
		 eop => fft_eop_t,
		 data_valid => fft_data_valid_t);
pre_cnt<=pre_cnt_t;
fft_sop<=fft_sop_t;
fft_eop<=fft_eop_t;
fft_data_valid<=fft_data_valid_t;



b2v_inst28 : mult_complex_ip
PORT MAP(dataa_imag => a_i,
		 dataa_real => a_r_t,
		 datab_imag => fft_source_imag_delay_n,
		 --datab_real => fft_source_real_delay_t,
		 datab_real => fft_source_real_delay_1_t,
		 result_imag => rt_i_t,
		 result_real => rt_r_t);

rt_i<=rt_i_t;
rt_r<=rt_r_t;

b2v_inst29 : add_ip
PORT MAP(--datab => fft_source_imag_delay_t,
         
         datab => fft_source_imag_delay_1_t,
         result =>fft_source_imag_delay_n);


b2v_inst3 : fft_ip
PORT MAP(clk => clk,
		 reset_n => rst_n,
		 clk_ena => '1',
		 inverse => '0',
		 sink_valid => fft_data_valid_t,
		 sink_sop => fft_sop_t,
		 sink_eop => fft_eop_t,
		 source_ready => fft_source_valid_t,
		 sink_error =>"00",
		 sink_imag => (others=>'0'),
		 sink_real => rcv_data_delay_t,
		 sink_ready => fft_sink_ready,
		 source_sop => fft_source_sop_t,
		 source_eop => fft_source_eop,
		 source_valid => fft_source_valid_t,
		 source_error => fft_source_eeror,
		 source_exp => fft_source_exp,
		 source_imag => fft_source_imag_t,
		 source_real => fft_source_real_t);

     rcv_data_delay<=rcv_data_delay_t;
     fft_source_valid<=fft_source_valid_t;
	  fft_source_sop<=fft_source_sop_t;
	  fft_source_imag<=fft_source_imag_t;
	  fft_source_real<=fft_source_real_t;
	  fft_source_imag_delay_1<=fft_source_imag_delay_1_t;
	  fft_source_real_delay_1<=fft_source_real_delay_1_t;
	  fft_source_real_delay<=fft_source_real_delay_t;
	  fft_source_imag_delay<=fft_source_imag_delay_t;
	  
	  
b2v_inst32 : fifo_256
   generic MAP (N=>256) 
    port MAP (rst_n => rst_n,
              clk =>clk,
			   en =>'1',
		       din => rcv_data_t,
               dout =>rcv_data_delay_t);
			
			
 -- PORT MAP(wrreq => '1',
		 -- rdreq => '1',
		 -- clock => clk,
		 -- aclr => rst,
		 -- data => rcv_data_t,
		 -- q => rcv_data_delay_t);

b2v_inst33 : fifo_256
  generic MAP (N=>256) 
    port MAP (rst_n =>rst_n,
            clk =>clk,
			en => fft_source_valid_t,
		    din => fft_source_real_t,
            dout =>fft_source_real_delay_1_t);

-- PORT MAP(wrreq => fft_source_valid_t,
		 -- rdreq => fft_source_valid_t,
		 -- clock => clk,
		 -- aclr => rst,
		 -- data => fft_source_real_t,
		 -- q => fft_source_real_delay_1_t);


b2v_inst34 : fifo_256
  generic MAP (N=>256) 
     port MAP (rst_n =>rst_n,
            clk =>clk,
			en => fft_source_valid_t,
		    din => fft_source_imag_t,
            dout =>fft_source_imag_delay_1_t);



-- PORT MAP(wrreq => fft_source_valid_t,
		 -- rdreq => fft_source_valid_t,
		 -- clock => clk,
		 -- aclr => rst,
		 -- data => fft_source_imag_t,
		 -- q => fft_source_imag_delay_1_t);


b2v_inst35 : fifo_256
 generic MAP (N=>256) 
   port MAP (rst_n =>rst_n,
            clk =>clk,
			en => fft_source_valid_t,
		    din => fft_source_real_delay_1_t,
            dout =>fft_source_real_delay_t);
			
			
-- PORT MAP(wrreq => fft_source_valid_t,
		 -- rdreq => fft_source_valid_t,
		 -- clock => clk,
		 -- aclr => rst,
		 -- data => fft_source_real_delay_1_t,
		 -- q => fft_source_real_delay_t);


b2v_inst36 : fifo_256
  generic MAP (N=>256) 
    port MAP (rst_n =>rst_n,
            clk =>clk,
			en => fft_source_valid_t,
		    din => fft_source_imag_delay_1_t,
            dout =>fft_source_imag_delay_t);



-- PORT MAP(wrreq => fft_source_valid_t,
		 -- rdreq => fft_source_valid_t,
		 -- clock => clk,
		 -- aclr => rst,
		 -- data => fft_source_imag_delay_1_t,
		 -- q => fft_source_imag_delay_t);

		 
		 

rst_n <= NOT(rst);



b2v_inst5 : data_out
PORT MAP(rst_n => rst_n,
		 clk => clk,
		 sink_eop => demap_sink_eop_t,
		 sink_valid => demap_sink_v,
		 din => demap_d,
		 data_valid => demap_sink_valid,
		 dout => demap_dout);

demap_sink_eop<=demap_sink_eop_t;


b2v_inst8 : fifo_256
  generic MAP (N=>8) 
  port MAP (rst_n =>rst_n,
            clk =>clk,
			  en => rcv_en,
		     din => data_in,
            dout =>rcv_data_t);
 
  
 -- PORT MAP(wrreq => '1',
		 -- rdreq => '1',
		 -- clock => clk,
		 -- aclr => rst,
		 -- data => data_in,
		 -- q => rcv_data_t);
		 
		 rcv_data<=rcv_data_t;



b2v_inst_17 : de_map
GENERIC MAP(N => 33
			)
PORT MAP(rst_n => rst_n,
		 clk => clk,
		 source_valid => fft_source_valid_t,
		 source_sop => fft_source_sop_t,
		 --din_imag => fft_source_imag_delay_1_t,
		 din_imag => fft_source_imag_t,
		 din_imag_clc => rt_i_t,
		 --din_real => fft_source_real_delay_1_t,
		 din_real => fft_source_real_t,
		 din_real_clc => rt_r_t,
		 sink_sop => demap_sink_sop,
		 sink_eop => demap_sink_eop_t,
		 sink_valid => demap_sink_v,
		 dout => demap_d,
		 dout_imag => a_i,
		 dout_real => a_r_t);
		 
  a_r<=a_r_t;

END bdf_type;