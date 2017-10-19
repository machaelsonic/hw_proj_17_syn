library ieee;
use ieee.std_logic_1164.all;

entity spi_ctr is
   port(rst_n: in std_logic;
        clk: in std_logic; --40M
        start:out std_logic;
        dout:out std_logic_vector(15 downto 0);
		  ad_rst:out std_logic);
end entity spi_ctr;

architecture rtl of spi_ctr is
   type state_t is (s_rst,s_idle,s_rst_for_9866,s0,s1);
   signal state,next_state:state_t;

   signal cnt:integer range 0 to 172; 
   signal cnt_en:std_logic;
	signal cnt1:integer range 0 to 1023; 
   signal cnt_en1:std_logic;
   begin
    
   
   process(rst_n,clk) is
      begin
         if rst_n='0' then
            cnt<=0;
         elsif clk'event and clk='1' then
           if cnt_en='1' then
            if cnt=172 then
               cnt<=0;
             else
               cnt<=cnt+1;
             end if;
				else
				 cnt<=0;
           end if;
         end if; 
   end process;
	
   process(rst_n,clk) is
      begin
         if rst_n='0' then
            cnt1<=0;
         elsif clk'event and clk='1' then
           if cnt_en1='1' then
            if cnt1=1023 then
               cnt1<=0;
             else
               cnt1<=cnt1+1;
             end if;
				else
				  cnt1<=0;
           end if;
         end if; 
   end process;
   process(rst_n,clk) is
    begin
      if rst_n='0' then
        state<=s_rst;
      elsif clk'event and clk='1' then
        state<=next_state;
      end if;
   end process;
   
   
   process(rst_n,state,cnt) is

    begin
     case state is
       when s_rst =>
         if rst_n='0' then
            next_state<=s_rst;
         else
            next_state<=s_idle;
         end if; 
      when s_idle =>
           next_state<=s_rst_for_9866;    
		when s_rst_for_9866 =>
           if cnt1=1023 then
			    next_state<=s0;
		     else
			    next_state<=s_rst_for_9866;
			  end if;	 
      when s0 =>
            if cnt=172 then
               next_state<=s1; 
            else
               next_state<=s0;
            end if;
      when s1 =>
           next_state<=s1;       
     end case;           
   end process; 
    
    process(state,cnt) is
      begin
        case state is
          when s_rst =>
             cnt_en<='0';
				 cnt_en1<='0';
             start<='0';
             dout<=(others=>'0');
				 ad_rst<='0';
          when s_idle =>
             cnt_en<='0';
				 cnt_en1<='0';
             start<='0';
             dout<=(others=>'0'); 
				 ad_rst<='0'; 
			when s_rst_for_9866 =>
             cnt_en<='0';
				 cnt_en1<='1';
             start<='0';
             dout<=(others=>'0'); 	 
				 ad_rst<='0';
          when s0 =>
            start<='1';
            cnt_en<='1';
				cnt_en1<='0';
				ad_rst<='1';
            if cnt<18 then
					  dout<="0000100101101010";--R09--010101 -- rx gain --001111
					  
            elsif cnt<37 then
					dout<="0000011100000000";--R07
            elsif cnt<56 then
					dout<="0000110100000001";--R0D
            elsif cnt<75 then
					dout<="0000010100000000";--R05
			   elsif cnt<94 then
					--dout<="0000010000110010";--R04,(B1=1,B0=0)->M=2(F=4);
					   dout<="0000010000000010";
					--dout<="0000010000110000";--R04,(B1=0,B0=0)->M=0 ;
				elsif cnt<113 then
               dout<="0000011001001000";--R06
					
					--dout<="0000011000010001";--R06 clkout1 and clkout2 is disabled
            elsif cnt<132 then
                 dout<="0000110000000001";--R0C--  (B7,B6)10<->F=1,00<->F=4,01<->F=2
					  
                 --dout<="0000110010000001";--R0C--  
            elsif cnt<151 then
               dout<="0000111000000001"; --R0E
            else
					dout<="0000101001001111";--R0A --tx gain
				
				   --dout<="0000010000000010";--R04 --(B1,B0)00<->M=0(F=1);01<->M=1(F=2);10<->M=2(F=4)
            end if;
          when s1 =>
             cnt_en<='0';
				 cnt_en1<='0';
             start<='0';
             dout<=(others=>'0');
				 ad_rst<='1';
        end case;
     end process;
 end architecture rtl;    


--library ieee;
--use ieee.std_logic_1164.all;
--
--entity spi_ctr is
--   port(rst_n: in std_logic;
--        clk: in std_logic; --40M
--        start:out std_logic;
--        dout:out std_logic_vector(15 downto 0));
--end entity spi_ctr;
--
--architecture rtl of spi_ctr is
--   type state_t is (s_rst,s_idle,s0,s1);
--   signal state,next_state:state_t;
--
--   signal cnt:integer range 0 to 83; 
--   signal cnt_en:std_logic;
--   begin
--    
--   
--   process(rst_n,clk) is
--      begin
--         if rst_n='0' then
--            cnt<=0;
--         elsif clk'event and clk='1' then
--           if cnt_en='1' then
--            if cnt=83 then
--               cnt<=0;
--             else
--               cnt<=cnt+1;
--             end if;
--           end if;
--         end if; 
--   end process;
--   
--   process(rst_n,clk) is
--    begin
--      if rst_n='0' then
--        state<=s_rst;
--      elsif clk'event and clk='1' then
--        state<=next_state;
--      end if;
--   end process;
--   
--   
--   process(rst_n,state,cnt) is
--
--    begin
--     case state is
--       when s_rst =>
--         if rst_n='0' then
--            next_state<=s_rst;
--         else
--            next_state<=s_idle;
--         end if; 
--      when s_idle =>
--           next_state<=s0;      
--      when s0 =>
--            if cnt=83 then
--               next_state<=s1; 
--            else
--               next_state<=s0;
--            end if;
--      when s1 =>
--           next_state<=s1;       
--     end case;           
--   end process; 
--    
--    process(state,cnt) is
--      begin
--        case state is
--          when s_rst =>
--             cnt_en<='0';
--             start<='0';
--             dout<=(others=>'0');
--          when s_idle =>
--             cnt_en<='0';
--             start<='0';
--             dout<=(others=>'0');  
--          when s0 =>
--            start<='1';
--            cnt_en<='1';
--            if cnt<18 then
--               --dout<="0000011001000100";
--					--dout<="0000100101011000";--R09--001100 --jieshouzengyi=011000(valudable)
--					dout<="0000100101010100";--R09--010100 --
--					--dout<="0000100101011010";--R09--011010 --
--					--dout<="0000100101010011";
--					
--            elsif cnt<37 then
--               --dout<="0000110001000001";
--					dout<="0000011100000000";--R07
--            elsif cnt<56 then
--               --dout<="0000111000000001"; 
--					dout<="0000110100000001";--R0D
--            elsif cnt<75 then
--               --dout<="0000101001111111";
--					dout<="0000010100000000";--R05
--			   else
--				   dout<="0000010000110000";--R04
--            end if;
--           --dout<="0000011001001000";
--          when s1 =>
--             cnt_en<='0';
--             start<='0';
--             dout<=(others=>'0');
--        end case;
--     end process;
-- end architecture rtl;    
              
              