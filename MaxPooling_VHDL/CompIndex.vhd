 
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library work;
use work.matrixDef.all;

entity CompIndex is
	generic(Nbit:integer);
	port(
		reset:  in std_logic;
		a: 	    in std_logic_vector (Nbit-1 downto 0);
		column: out std_logic_vector(Nbit-1 downto 0);
		row:    out std_logic
	);
end CompIndex;

architecture rtl of CompIndex is
begin
	comp_index: process(a,reset)
		variable c: integer;
		begin
		if reset='0' then 
			column<=(others=>'0');
			row<='0';
		else		
			c:=to_integer(unsigned(a));
			if (c<5) then
				column <= a;
				row<='0';
			else
				column <= (others=>'0');
				row<='1';
			end if;
		end if;

		end process;

end rtl; 
 

