library ieee;
use ieee.std_logic_1164.all;

entity data_out is
   port( rst_n: in std_logic;
         clk: in std_logic;
         sink_eop: in std_logic;
         sink_valid: in std_logic;
			din:in std_logic_vector(35 downto 0);
         dout:out std_logic_vector(35 downto 0);
			data_valid:out std_logic);
end entity data_out;

architecture rtl of data_out is
  type state_t is (s_rst,s_idle,s1,s2);
  signal state,next_state:state_t;
  signal tmp:std_logic_vector(35 downto 0);
  
  begin
   process(rst_n,clk) is
     begin
       if rst_n='0' then
          state<=s_rst;
       elsif clk'event and clk='1' then
          state<=next_state;
       end if;
  end process;
  
    process(state,sink_eop) is
     begin
        case state is
		     when s_rst =>
			    if rst_n='1' then
				    next_state<=s_idle;
				 else
				    next_state<=s_rst;
				 end if;
			 when s_idle =>
			    if sink_eop='1' then
				     next_state<=s1;
				 else
				     next_state<=s_idle;
				 end if;
			 when s1 =>
		       if sink_eop='1' then
			        next_state<=s2;
				 else
			     	  next_state<=s1;
				 end if;
			 when s2 =>
			    if sink_eop='1' then
				     next_state<=s1;
				 else
				     next_state<=s2;
				 end if;
			end case;
				 
  end process;
  
 process(clk) is
     begin
	   if clk'event and clk='1' then
        case state is
		    when s_rst =>
              tmp<=(others=>'0');
				  data_valid<='0';  
			 when s_idle =>
			     tmp<=(others=>'0');
				  data_valid<='0'; 
			 when s2 =>
		        tmp<=tmp;
				  data_valid<='0'; 
--				  tmp<=din;
--				  data_valid<=sink_valid; 
			 when s1 =>
			     tmp<=din;
				  data_valid<=sink_valid; 
			end case;
		end if;		 
  end process;
   dout<=tmp;
     
  end architecture rtl;   
     
     
                 
          