
library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.matrixDef.all;

entity Comp4elem is
	port(
		elems: in arrayInt;
		result: out integer
	);
end Comp4elem;

architecture rtl of Comp4elem is
begin
	comp_4elem: process(elems)
		variable c: integer;
		begin
			c := elems(0);
			for i in 1 to 3 loop
				if(elems(i) > c) then
					c:=elems(i);
				end if;
			end loop; 
			result <= c;
		end process;

end rtl; 
 

