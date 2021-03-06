LIBRARY ieee;
USE ieee.std_logic_1164.all;
 USE ieee.std_logic_unsigned.all;
entity tb_transfer is
end entity tb_transfer;

architecture rtl of tb_transfer is 
 component transfer IS 
	PORT
	(
		rst_n :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		en :  IN  STD_LOGIC;
		din :  IN  STD_LOGIC_VECTOR(35 DOWNTO 0);
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
		rd_continue_o :  OUT  STD_LOGIC;
		flag_o1 :  OUT  STD_LOGIC;
		flag_eop :  OUT  STD_LOGIC;
		cnt :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		ifft_data :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		ifft_dout_imag :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		ifft_dout_real :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		ifft_source_error :  OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
		ifft_source_exp :  OUT  STD_LOGIC_VECTOR(5 DOWNTO 0);
		ifft_source_imag :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		ifft_source_real :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		pre_win_data :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		ram1_d :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		ram2_d :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		ram_rd_adr :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		ram_rd_data :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		ram_wr_adr :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		rd_cnt_o :  OUT  STD_LOGIC_VECTOR(8 DOWNTO 0);
		rom_rd_adr :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		tx_data_o :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END component transfer;


signal cnt_1:integer range 0 to 2299;
signal tmp,din :std_logic_vector(35 downto 0);
signal d_t:std_logic;
signal rst_n,clk,en:std_logic;

begin




PROCESS                                               
-- variable declarations                                     
BEGIN 
    rst_n<='0';
	 wait for 770 ns;                                                        
    rst_n<='1';
    wait;    -- code that executes only once                      
END PROCESS ;   
                                                                                               
 

 PROCESS                                                                         
   BEGIN                                                         

       clk<='1';
    wait for 20 ns;
      clk<='0';
    wait for 20 ns; 
   end process;



 process(rst_n,clk) is
		  begin
		    if rst_n='0' then
			    cnt_1<=2100;
				 d_t<='0';
				 tmp<=(others=>'0');
			 elsif clk'event and clk='1' then
			    if cnt_1=2299 then
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
din<=tmp; 

u1: transfer PORT map 
	(
		rst_n,
		clk,
		en,
		din);
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



