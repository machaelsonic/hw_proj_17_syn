library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity en_gen is
  port(rst_n: in std_logic;
       clk: in std_logic;
		 ifft_eop:in std_logic;
		 d:out std_logic;
		 dout:out std_logic_vector(35 downto 0));
end entity en_gen;

architecture rtl of en_gen is
signal cnt:integer range 0 to 2299;
signal tmp:std_logic_vector(35 downto 0);
signal d_t:std_logic;
--type state_t is (s_rst,s_idle,s1,s2);
--signal state,next_state: state_t;
   begin 
	   process(rst_n,clk) is
		  begin
		    if rst_n='0' then
			    cnt<=2100;
				 d_t<='0';
				 tmp<=(others=>'0');
			 elsif clk'event and clk='1' then
			    if cnt=2299 then
				    cnt<=0;
					 d_t<='1';
					 tmp<=tmp+1;
				 else
				    cnt<=cnt+1;
					 d_t<='0';
					 tmp<=tmp;
				end if;
		    end if;
			 
		end process;
--	 process(rst_n,clk) is
--		  begin
--		    if rst_n='0' then
--			    state<=s_rst;
--			 elsif clk'event and clk='1' then
--             state<=next_state;
--		    end if;	 
--		end process;	
--	process(state) is
--     begin
--	    case state is
--		   when s_rst =>
--		      if rst_n='1' then
--			      next_state<=s_idle;
--				else
--			      next_state<=s_rst;
--				end if;
--			when s_idle=>
--		       if d_t='1' then
--				   next_state<=s1;
--				 else
--				   next_state<=s_idle;
--				 end if;
--			when s1 =>
--		      if ifft_eop='1' then
--			      next_state<=s2;
--				else
--			      next_state<=s1;
--				end if;
--			when s2 =>
--		      if d_t='1' then
--			      next_state<=s1;
--				else
--			      next_state<=s2;
--				end if;
--			end case;
--		end process;
--	
--   process(state) is
--     begin
--	    case state is
--		   when s_rst =>
--		        dout<=(others=>'0');
--			when s_idle=>
--		        dout<=(others=>'0');
--			when s1 =>
--		       dout<=(others=>'0');
--			when s2 =>
--		       dout<=tmp;
--		 end case;
--		end process;
--	
--
d<=d_t;
--dout<=tmp;
dout<="101001011010010110100101101001011010";
end architecture rtl;
