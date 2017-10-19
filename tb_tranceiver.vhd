LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.std_logic_unsigned.all;
LIBRARY work;
use ieee.numeric_std.all;
use std.textio.all;


ENTITY tb_tranceiver IS 
end entity tb_tranceiver;

architecture rtl of tb_tranceiver is 

component tranceiver is 
	port(rst: in std_logic;
       clk: in std_logic;
       m_s:in std_logic;--master='1',slave='0'
		   plc_channal_data: inout std_logic_vector(11 downto 0);
		   cpu_tx_data:in std_logic_vector(31 downto 0);
		   cpu_tx_data_valid: in std_logic;
		   tx_data_valid:out std_logic;
		   ISL_C1:out std_logic;
		   ISL_C0:out std_logic;
		   tx_en:out std_logic;
		   rx_en:out std_logic;
		   --flag_o:out std_logic;
		   cpu_rx_data_valid:out std_logic;
		   cpu_rx_data:out std_logic_vector(31 downto 0);
		   dma_wr_en:out std_logic);
END component tranceiver;

--FILE tb_tx_data_tranceiver:TEXT OPEN WRITE_MODE IS "tb_tx_data_tranceiver.txt";
FILE tb_rx_data_tranceiver:TEXT OPEN READ_MODE IS "tb_tx_data_tranceiver2.txt";
--FILE tb_rx_data_tranceiver:TEXT OPEN READ_MODE IS "rcv_data3.txt";
signal cnt_1:integer range 0 to 49999;
signal tmp,cpu_tx_data,cpu_rx_data :std_logic_vector(31 downto 0);
signal d_t:std_logic;
signal rst_n,clk:std_logic;
signal plc_channal_data:std_logic_vector(11 downto 0);
signal  cpu_tx_data_valid,tx_data_valid,ISL_C1,ISL_C0,tx_en,rx_en,cpu_rx_data_valid:std_logic;
signal  rx_data_from_file:  STD_LOGIC_VECTOR(11 DOWNTO 0);
signal  rx_data_from_file_int_signal:  integer;
signal rx_en_t:std_logic;
--signal flag_o: std_logic;
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
			    cnt_1<=49900;
				 d_t<='0';
				 tmp<=(others=>'0');
			 elsif clk'event and clk='1' then
			    if cnt_1=49999 then
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

--cpu_tx_data_valid<=d_t;
cpu_tx_data_valid<='0';
--dout<="101001011010010110100101101001011010";
cpu_tx_data<=tmp; 
--process
--  begin   
--     cpu_tx_data_valid<='0';
--     wait for 1000 ns;
--     cpu_tx_data_valid<='1';
--     wait for 40 ns;
--     cpu_tx_data_valid<='0';
--     wait;
--  end process;
   
u1: tranceiver PORT map 
	  (
		   clk =>clk,
		   rst=> not(rst_n),
		   m_s=>'1',
		   plc_channal_data => plc_channal_data,
		   cpu_tx_data => cpu_tx_data,
		   cpu_tx_data_valid =>cpu_tx_data_valid,
		   tx_data_valid =>tx_data_valid,
		   ISL_C1 =>ISL_C1,
		   ISL_C0 =>ISL_C0,
		   tx_en => tx_en,
		   rx_en => rx_en,
		   --flag_o =>flag_o,
		   cpu_rx_data_valid =>cpu_rx_data_valid,
		   cpu_rx_data=> cpu_rx_data);
		
		
--process(clk) is
-- 	VARIABLE lo_1:LINE;
-- 	--alias tx_data_o is <<signal u1.tx_inst.tx_data_o  : STD_LOGIC_vector>>;
--
--    BEGIN
--	     if rising_edge(clk) then
--				 if tx_data_valid='1' then
--					--WRITE (lo_1,to_integer(signed(tx_data_o)),left,10);
--					WRITE (lo_1,to_integer(signed(plc_channal_data)),left,10);
--					WRITELINE (tb_tx_data_tranceiver,lo_1);
--				 end if;
--		 end if;
--end process; 
process(rst_n,clk) is
 	VARIABLE lo_1:LINE;
 	--variable rx_data_from_file_int: integer range -1024 to 1023;
 	  variable rx_data_from_file_int: integer;
    BEGIN
      if rst_n='0' then
        rx_data_from_file<=(others=>'0');
      elsif rising_edge(clk) then
         --if rx_en='1' and flag_o='1' then
         --if rx_en='1'  then
           if not(endfile(tb_rx_data_tranceiver)) then
			        READLINE (tb_rx_data_tranceiver,lo_1);
			        READ (lo_1,rx_data_from_file_int);
			        rx_data_from_file_int_signal<=rx_data_from_file_int;	
		          rx_data_from_file<=std_logic_vector(to_signed(rx_data_from_file_int,12));	
		       end if;
		     --end if;
		   end if;
	end process;	
	
	process(rx_en,rx_data_from_file) is
    BEGIN
	     	if rx_en='1' then
	     	    plc_channal_data<=rx_data_from_file;
		     else
		       plc_channal_data<=(others=>'Z');
		    end if;
end process;
	
			
end rtl;




