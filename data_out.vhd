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
  signal tmp1:std_logic_vector(31 downto 0);
  attribute keep: boolean;
  attribute keep of state:signal is true;
  attribute keep of next_state:signal is true;
  signal sink_valid_t:std_logic;
  begin
   process(rst_n,clk) is
     begin
       if rst_n='0' then
          state<=s_rst;
       elsif clk'event and clk='1' then
          state<=next_state;
       end if;
  end process;
  
    process(state) is
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
				  sink_valid_t<='0';  
			 when s_idle =>
				  sink_valid_t<='0'; 
			 when s1 =>
				  sink_valid_t<='0'; 
			 when s2 =>
				  sink_valid_t<=sink_valid;
			end case;
		end if;		 
  end process;
	
	process(rst_n,clk) is
	   begin
		  if rst_n='0' then
		     dout<=(others=>'0');
           data_valid<='0';
		  elsif clk'event and clk='1' then
		      if sink_valid_t='1' then
               dout<=din;
			  end if;
			  data_valid<=sink_valid_t;
		  end if;
	end process;  
				    
  end architecture rtl;   
     
     
                 
          