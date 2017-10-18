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

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "07/31/2017 16:47:44"
                                                            
-- Vhdl Test Bench template for design  :  plc_design
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all; 
USE ieee.std_logic_unsigned.all; 
--USE ieee.std_logic_arith.all;                              
use ieee.numeric_std.all;
use std.textio.all;



ENTITY tb_receiver IS
END tb_receiver;
ARCHITECTURE rtl OF tb_receiver IS
                                                  

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
 
signal rst,clk:std_logic;
signal rst_delay:std_logic; 


--FILE tb_rx_data:TEXT OPEN READ_MODE IS "tb_tx_data_o.txt";
FILE tb_rx_data:TEXT OPEN READ_MODE IS "f:\lhf\hw_proj_17_syn\sim_data\rcv_sig_in.txt";
FILE tb_syn_cox_sum_mult_ab:TEXT OPEN WRITE_MODE IS "tb_syn_cox_sum_mult_ab.txt";
FILE tb_syn_cox_sum_mult_a2b2:TEXT OPEN WRITE_MODE IS "tb_syn_cox_sum_mult_a2b2.txt";
FILE tb_syn_cox_frame_syn:TEXT OPEN WRITE_MODE IS "tb_syn_cox_frame_syn.txt";
FILE tb_syn_cox_buff_sum_mult_ab:TEXT OPEN WRITE_MODE IS "tb_syn_cox_buff_sum_mult_ab.txt";
FILE tb_fft_source_real:TEXT OPEN WRITE_MODE IS "tb_fft_source_real.txt";
FILE tb_fft_source_imag:TEXT OPEN WRITE_MODE IS "tb_fft_source_imag.txt";

FILE tb_fft_sink_data:TEXT OPEN WRITE_MODE IS "tb_fft_sink_data.txt";
FILE tb_fft_sink_data_m:TEXT OPEN WRITE_MODE IS "tb_fft_sink_data_m.txt";

FILE demod_bits_v:TEXT OPEN WRITE_MODE IS "f:\lhf\hw_proj_17_syn\sim_data\demod_bits_hex_v.txt";

signal  rx_data_from_file:  STD_LOGIC_VECTOR(11 DOWNTO 0);
signal  rx_data_from_file_int_signal:  integer;

BEGIN
	i1 : receiver
	PORT MAP (
		rst =>rst,
		clk =>clk,
		rcv_en =>'1',
		--data_in => rx_data_from_file(11)&rx_data_from_file(11)&rx_data_from_file(11 downto 2)
		--data_in => rx_data_from_file(11)&rx_data_from_file(11 downto 1) 	
		data_in => rx_data_from_file
	);

init : PROCESS                                               
-- variable declarations                                     
BEGIN 
    rst<='1';
	 wait for 770 ns;                                                        
    rst<='0';
    wait;    -- code that executes only once                      
END PROCESS init;   
                                                                                               
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list  
clk <='1';
wait for 20 ns;
clk <='0';
wait for 20 ns; 
                
end process;
	
process(rst,clk) is
 	VARIABLE lo_1:LINE;
 	variable rx_data_from_file_int: integer range -1024 to 1023;
    BEGIN
      if rst='1' then
        rx_data_from_file<=(others=>'0');
      elsif rising_edge(clk) then
			  READLINE (tb_rx_data,lo_1);
			  READ (lo_1,rx_data_from_file_int);
			  rx_data_from_file_int_signal<=rx_data_from_file_int;	
		    rx_data_from_file<=std_logic_vector(to_signed(rx_data_from_file_int,12));	
		    end if;
	end process;	
	
rst_delay<=rst after 400 ns;	
process(rst,clk) is
 	VARIABLE lo_1:LINE;
  	
 	alias syn_cox_sum_mult_ab is <<signal i1.b2v_inst.dout2  : STD_LOGIC_vector>>;
    BEGIN
       
	     if rising_edge(clk) and rst_delay='0' then
			      
		            WRITE (lo_1,to_integer(signed(syn_cox_sum_mult_ab)),left,10);		        
			          WRITELINE (tb_syn_cox_sum_mult_ab,lo_1);
			  end if;
		   	end process;
		   	
		   		
process(rst,clk) is
 	VARIABLE lo_1:LINE;
  	
 	alias syn_cox_sum_mult_a2b2 is <<signal i1.b2v_inst.dout1  : STD_LOGIC_vector>>;
    BEGIN
       
	     if rising_edge(clk) and rst_delay='0' then
			      
		            WRITE (lo_1,to_integer(signed(syn_cox_sum_mult_a2b2)),left,10);		        
			          WRITELINE (tb_syn_cox_sum_mult_a2b2,lo_1);
			  end if;
		   	end process;	
		   	
--process(rst,clk) is
-- 	VARIABLE lo_1:LINE;
--  	
-- 	alias syn_cox_frame_syn is <<signal i1.b2v_inst.dout3  : STD_LOGIC_vector>>;
--    BEGIN
--       
--	     if rising_edge(clk) and rst_delay='0' then
--			      
--		            WRITE (lo_1,to_integer(signed(syn_cox_frame_syn)),left,10);		        
--			          WRITELINE (tb_syn_cox_frame_syn,lo_1);
--			  end if;
--		   	end process;
--		   	
--		   			   	
--process(rst,clk) is
-- 	VARIABLE lo_1:LINE;
--  	
-- 	alias syn_cox_buff_sum_mult_ab is <<signal i1.b2v_inst.dout4  : STD_LOGIC_vector>>;
--    BEGIN
--       
--	     if rising_edge(clk) and rst_delay='0' then
--			      
--		            WRITE (lo_1,to_integer(signed(syn_cox_buff_sum_mult_ab)),left,10);		        
--			          WRITELINE (tb_syn_cox_buff_sum_mult_ab,lo_1);
--			  end if;
--		   	end process;
		   				 
process(rst,clk) is
 	VARIABLE lo_1:LINE;
  	
 	alias fft_data_valid is <<signal i1.b2v_fft_ctr.fft_data_valid  : STD_LOGIC>>;
 	alias din is <<signal i1.b2v_inst.dout  : STD_LOGIC_vector>>;
 	alias cnt is <<signal i1.b2v_fft_ctr.cnt  : integer range 0 to 13999>>;
    BEGIN
       
	     if rising_edge(clk) and rst_delay='0' then
			        if fft_data_valid='1' and cnt>2000 then 
		            WRITE (lo_1,to_integer(signed(din)),left,10);		        
			          WRITELINE (tb_fft_sink_data,lo_1);
			         end if;
			  end if;
		   	end process;	
		   	
	process(rst,clk) is
 	VARIABLE lo_1:LINE;
  	
 	alias fft_data_valid is <<signal i1.b2v_fft_ctr.fft_data_valid  : STD_LOGIC>>;
 	alias din is <<signal i1.b2v_inst.dout  : STD_LOGIC_vector>>;
    BEGIN
       
	     if rising_edge(clk) and rst_delay='0' then
			        if fft_data_valid='1' then 
		            WRITE (lo_1,to_integer(signed(din)),left,10);		        
			          WRITELINE (tb_fft_sink_data_m,lo_1);
			         end if;
			  end if;
		   	end process;		   			   	

process(rst,clk) is
 	VARIABLE lo_1:LINE;
  	
 	alias payload_data_valid is <<signal i1.b2v_fft_ctr.payload_data_valid  : STD_LOGIC>>;
 	alias fft_source_real is <<signal i1.b2v_inst3.source_real  : STD_LOGIC_vector>>;
    BEGIN
       
	     if rising_edge(clk) and rst_delay='0' then
			        if payload_data_valid='1' then
		            WRITE (lo_1,to_integer(signed(fft_source_real)),left,10);		        
			          WRITELINE (tb_fft_source_real,lo_1);
			         end if;
			  end if;
		   	end process;		

process(rst,clk) is
 	VARIABLE lo_1:LINE;
  	
 	alias payload_data_valid is <<signal i1.b2v_fft_ctr.payload_data_valid  : STD_LOGIC>>;
 	alias fft_source_imag is <<signal i1.b2v_inst3.source_imag  : STD_LOGIC_vector>>;
    BEGIN
       
	     if rising_edge(clk) and rst_delay='0' then
			        if payload_data_valid='1' then
		            WRITE (lo_1,to_integer(signed(fft_source_imag)),left,10);		        
			          WRITELINE (tb_fft_source_imag,lo_1);
			         end if;
			  end if;
		   	end process;	
			
		
process(rst,clk) is
    VARIABLE lo_1:LINE;
	alias demap_sink_v is <<signal i1.demap_sink_v : STD_LOGIC>>; 
	alias demap_dout is <<signal i1.demap_dout : STD_LOGIC_vector>>;
	-- alias demap_sink_v is <<signal i1.dma_wr_en  : STD_LOGIC>>; 
	-- alias demap_dout is <<signal i1.demap_dout : STD_LOGIC_vector>>;
    begin 
		if rising_edge(clk) then 
			if demap_sink_v='1' then
				HWRITE (lo_1,demap_dout,left,120);
				WRITELINE (demod_bits_v,lo_1);
			end if;
		end if;
	end process;		   
		   	  	                                                                     
END rtl;
