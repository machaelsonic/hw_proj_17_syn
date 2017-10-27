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
		rx_ram_wr_data:out std_logic_vector(31 downto 0);
		rx_ram_wr_en:out std_logic;
		rx_ram_wr_clk:out std_logic;
		rx_ram_wr_adr:out std_logic_vector(6 downto 0);
		rx_ram_rd_triger:out std_logic
	);
END receiver;

ARCHITECTURE bdf_type OF receiver IS 

COMPONENT syn_cox is
   port(rst_n: in std_logic;
	    reg_flush:in std_logic;
       clk: in std_logic;
       din: in std_logic_vector(11 downto 0);
       dout1:out std_logic_vector(31 downto 0);
       dout2:out std_logic_vector(31 downto 0);
       dout:out std_logic_vector(11 downto 0));
end COMPONENT syn_cox;

COMPONENT fft_ctr is
  port(rst_n: in std_logic;
       clk: in std_logic;
       dout1:in std_logic_vector(31 downto 0);
       dout2:in std_logic_vector(31 downto 0);
       cnt_o:out integer range 0 to 13999;
       fft_data_valid:out std_logic;
       sink_sop:out std_logic;
       sink_eop:out std_logic;
       payload_data_valid:out std_logic;
		 reg_flush:out std_logic;
		 dma_wr_en:out std_logic);
end COMPONENT fft_ctr;

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

COMPONENT fifo_1024
 generic(N: integer );
    port( rst_n: in std_logic;
          clk: in std_logic;
		      en:in std_logic;
		      din:in std_logic_vector(11 downto 0);
		      dout: out std_logic_vector(11 downto 0));
END COMPONENT fifo_1024;

COMPONENT fifo_8
 generic(N: integer );
    port( rst_n: in std_logic;
          clk: in std_logic;
		      en:in std_logic;
		      din:in std_logic_vector(11 downto 0);
		      dout: out std_logic_vector(11 downto 0));
END COMPONENT fifo_8;


COMPONENT de_map
GENERIC (N : INTEGER);
	port( rst_n: in std_logic;
         clk: in std_logic;
         source_valid: in std_logic;
			   din_real_clc: in std_logic_vector(24 downto 0);
         sink_sop: out std_logic;
         sink_eop: out std_logic;
         sink_valid: out std_logic;
         dout:out std_logic_vector(415 downto 0));
END COMPONENT;


component rx_ram_ctr is
  port(rst_n: in std_logic;
       clk: in std_logic;
	    din:in std_logic_vector(415 downto 0);
		 din_valid: in std_logic;
	    rx_ram_wr_data:out std_logic_vector(31 downto 0);
		 rx_ram_wr_en:out std_logic;
		 rx_ram_wr_clk:out std_logic;
		 rx_ram_wr_adr:out std_logic_vector(6 downto 0);
		 rx_ram_rd_triger:out std_logic
		 );
end component rx_ram_ctr;

--
SIGNAL	fft_source_imag_t:  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	fft_source_real_t:  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	fft_source_sop_t:  STD_LOGIC;
SIGNAL	fft_source_valid_t:  STD_LOGIC;

SIGNAL	rcv_data_t:  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	rcv_data_delay_t:  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	rst_n:  STD_LOGIC;
SIGNAL	rt_i_t:  STD_LOGIC_VECTOR(24 DOWNTO 0);
SIGNAL	rt_r_t :  STD_LOGIC_VECTOR(24 DOWNTO 0);
signal   fft_source_imag_delay_t:std_logic_vector(11 downto 0);
signal   fft_source_imag_delay_n:std_logic_vector(11 downto 0);

signal   fft_source_real_delay_t:std_logic_vector(11 downto 0);
signal   demap_sink_v:std_logic;
signal   demap_d:std_logic_vector(415 downto 0);


signal dout1,dout2:std_logic_vector(31 downto 0);
signal symbol_syn:std_logic_vector(19 downto 0);
signal fft_data_valid_t,sink_sop_t,sink_eop_t:std_logic;
signal payload_data_valid:std_logic;
signal reg_flush:std_logic;
BEGIN 


b2v_inst : syn_cox
PORT MAP(rst_n => rst_n,
         reg_flush=>reg_flush,
		 clk => clk,
		 din => rcv_data_t,
		 dout1 => dout1,
		 dout2 => dout2,
		 dout =>rcv_data_delay_t);
		 
		 
b2v_fft_ctr: fft_ctr
  port map(	rst_n => rst_n,
		 clk => clk,
		 dout1 => dout1,
		 dout2 => dout2,
		 cnt_o=>cnt_o,
		 fft_data_valid =>fft_data_valid_t,
		 sink_sop => sink_sop_t,
     sink_eop =>sink_eop_t,
     payload_data_valid =>payload_data_valid,
	  reg_flush=>reg_flush,
	  dma_wr_en=> dma_wr_en);



b2v_inst28 : mult_complex_ip
PORT MAP(dataa_imag =>fft_source_imag_t ,
		     dataa_real =>fft_source_real_t,
		     datab_imag => fft_source_imag_delay_n,
		     datab_real => fft_source_real_delay_t,
		     result_imag => rt_i_t,
		     result_real => rt_r_t);

rt_i<=rt_i_t;
rt_r<=rt_r_t;

b2v_inst29 : add_ip
PORT MAP(datab => fft_source_imag_delay_t,
         result =>fft_source_imag_delay_n);


b2v_inst3 : fft_ip
PORT MAP(clk => clk,
		 reset_n => rst_n,
		 clk_ena => '1',
		 inverse => '0',
		 sink_valid => fft_data_valid_t,
		 sink_sop => sink_sop_t,
		 sink_eop => sink_eop_t,
		 --source_ready => fft_source_valid_t,
		 source_ready =>'1',
		 sink_error =>"00",
		 sink_imag => (others=>'0'),
		 sink_real => rcv_data_delay_t,
		 sink_ready => fft_sink_ready,
		 source_sop => fft_source_sop_t,
		 source_eop => fft_source_eop,
		 source_valid => fft_source_valid_t,
		 source_error => fft_source_error,
		 source_exp => fft_source_exp,
		 source_imag => fft_source_imag_t,
		 source_real => fft_source_real_t);

     fft_sop<=sink_sop_t;
     fft_eop<=sink_eop_t;
     fft_data_valid<=fft_data_valid_t; 
     
     fft_source_valid<=fft_source_valid_t;
	  fft_source_sop<=fft_source_sop_t;
	  fft_source_imag<=fft_source_imag_t;
	  fft_source_real<=fft_source_real_t;
	  fft_source_real_delay<=fft_source_real_delay_t;
	  fft_source_imag_delay<=fft_source_imag_delay_t;
	  
	  
b2v_inst33 : fifo_1024
  generic MAP (N=>1024) 
    port MAP (rst_n =>rst_n,
              clk =>clk,
			        en => fft_source_valid_t,
		          din => fft_source_real_t,
              dout =>fft_source_real_delay_t);


b2v_inst34 : fifo_1024
  generic MAP (N=>1024) 
     port MAP (rst_n =>rst_n,
               clk =>clk,
			         en => fft_source_valid_t,
		           din => fft_source_imag_t,
               dout =>fft_source_imag_delay_t);
		 

rst_n <= NOT(rst or not(rcv_en));


b2v_inst8 : fifo_8
  generic MAP (N=>8) 
  port MAP (rst_n =>rst_n,
            clk =>clk,
			      en => rcv_en,
		        din => data_in,
            dout =>rcv_data_t);
 
 
		 
		 rcv_data<=rcv_data_t;



b2v_inst_17 : de_map
GENERIC MAP(N => 80 )
PORT MAP(rst_n => rst_n,
		     clk => clk,
		     source_valid => payload_data_valid,
		     din_real_clc => rt_r_t,
		     sink_sop => demap_sink_sop,
		     sink_eop => demap_sink_eop,
		     sink_valid => demap_sink_v,
		     dout => demap_d);
		     
   demap_sink_valid<=demap_sink_v;
   demap_dout<=demap_d;
   
rx_ram_ctr_inst: rx_ram_ctr 
  port map (rst_n=>rst_n,
            clk =>clk,
	         din=>demap_d,
		      din_valid=>demap_sink_v,
	         rx_ram_wr_data=>rx_ram_wr_data,
		      rx_ram_wr_en=>rx_ram_wr_en,
		      rx_ram_wr_clk=>rx_ram_wr_clk,
		      rx_ram_wr_adr=>rx_ram_wr_adr,
				rx_ram_rd_triger=>rx_ram_rd_triger
		 );
	
	
END bdf_type;