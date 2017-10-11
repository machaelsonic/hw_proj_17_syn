library ieee;
use ieee.std_logic_1164.all;

entity d_sel is
  port(a: in std_logic_vector(15 downto 0);
       b: in std_logic_vector(15 downto 0);
       sel: in std_logic;
       oe:in std_logic;
       c:out std_logic_vector(15 downto 0));
end entity d_sel;

architecture rtl of d_sel is
   begin
     process(a,b,sel) is
       begin
        if oe='1' then
         if sel='1' then
           c<=a;
         else
           c<=b;
         end if;
        else
         c<=(others=>'0');
       end if;
     end process;
end architecture rtl;