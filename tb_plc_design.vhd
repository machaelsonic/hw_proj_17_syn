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
		datain :  IN  STD_LOGIC_VECTOR(415 DOWNTO 0);
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
		flag_o :  OUT  STD_LOGIC;
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
		c1:out std_logic
	);
END component plc_design;

signal cnt_1:integer range 0 to 25999;
signal tmp,datain,demap_dout :std_logic_vector(415 downto 0);
signal d_t:std_logic;
signal rst_n_tx,clk_tx,en:std_logic;
signal tx_data_o_t,receiver_din:std_logic_vector(11 downto 0);
signal demap_out :std_logic_vector(15 downto 0);
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

en<=d_t;
--dout<="101001011010010110100101101001011010";
datain<=tmp; 

u1: plc_design PORT map 
	(
		clk_tx =>clk_tx,
		rst_n_tx=>rst_n_tx,
		en =>en,
		datain=>datain,
		receiver_din => receiver_din,
		demap_dout =>demap_dout,
		tx_data_o =>tx_data_o_t);
		
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
		
end rtl;



