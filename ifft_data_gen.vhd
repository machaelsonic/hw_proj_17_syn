library ieee;
use ieee.std_logic_1164.all;

entity ifft_data_gen is
  generic(N: integer range 0 to 127:=33);
  port(rst_n: in std_logic;
       clk: in std_logic;
       din: in std_logic_vector(35 downto 0);
       source_data_valid:in std_logic;
	   ifft_sink_ready: in std_logic;
       sink_data_valid:out std_logic;
       sop:out std_logic;
       eop:out std_logic;
       dout_real:out std_logic_vector(11 downto 0);
       dout_imag:out std_logic_vector(11 downto 0));
end entity ifft_data_gen ;

architecture rtl of ifft_data_gen is
 signal cnt,cnt1: integer range 0 to 255;
 begin
 --sink_data_valid<='1';
  process(rst_n,clk) is
    begin
      if rst_n='0' then
         cnt<=0; 
         sop<='0'; 
         eop<='0';        
         --sink_data_valid<='0';
      elsif clk'event and clk='1' then
        sink_data_valid<=source_data_valid;
         if source_data_valid='1' then
           if cnt=255 then
              cnt<=0;
           else
              cnt<=cnt+1;
           end if;
		 case cnt is
           when 255 =>
            sop<='0'; 
            eop<='1';
           when 0 =>
            sop<='1'; 
            eop<='0';
           when others =>
            sop<='0'; 
            eop<='0';
         end case;
		else 
		 cnt<=0;
		 sop<='0'; 
         eop<='0'; 
		 end if;
      end if;
	  
  end process;


 process(rst_n,clk) is
    begin
    if rst_n<='0' then
       dout_real<=(others=>'0');
       dout_imag<=(others=>'0');
    elsif clk'event and clk='1' then
      case cnt is
           when N=> 
               if din(35)='0' then --0
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
				   end if;
       when N+1=>
              if din(34)='0' then --0
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
					end if;	
       when N+2=>
              if din(33)='0' then --0
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
				  end if;
       when N+3=>
              if din(32)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
					end if;	
       when N+4=>
              if din(31)='0' then --7/4
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
					end if;
       when N+5=>
              if din(30)='0' then --3/2
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
              end if;
       when N+6=>
              if din(29)='0' then --5/4
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000"; 
              end if;
       when N+7=>
              if din(28)='0' then --7/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000"; 
              end if;
       when N+8=>
              if din(27)='0' then --3/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000"; 
					end if;	
       when N+9=>
              if din(26)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;
       when N+10=>
              if din(25)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;
		 when N+11=>
              if din(24)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;
		 when N+12=>
              if din(23)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;
		 when N+13=>
              if din(22)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;	
		 when N+14=>
              if din(21)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;	
		 when N+15=>
              if din(20)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;	
		 when N+16=>
              if din(19)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;	 
		when N+17=>
              if din(18)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;
		when N+18=>
              if din(17)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;
		when N+19=>
              if din(16)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;
		when N+20=>
              if din(15)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;
	   when N+21=>
              if din(14)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;
		when N+22=>
              if din(13)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;
		when N+23=>
              if din(12)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;
		when N+24=>
              if din(11)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;
		when N+25=>
              if din(10)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;
		when N+26=>
              if din(9)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;
		when N+27=>
              if din(8)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;
		when N+28=>
              if din(7)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;
		when N+29=>
              if din(6)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;
		when N+30=>
              if din(5)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;
		when N+31=>
              if din(4)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;
		when N+32=>
              if din(3)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;
		when N+33=>
              if din(2)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;
		when N+34=>
              if din(1)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;
		when N+35=>
              if din(0)='0' then --15/8
                  dout_real<="001111111111";
                  dout_imag<="000000000000";
               else   --1
                  dout_real<="110000000000";
                  dout_imag<="000000000000";
             end if;
      
        when others => 
                   dout_real<=(others=>'0');
                   dout_imag<=(others=>'0');
      end case;
    end if;
   end process;  
  end architecture rtl;


