library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library work;
use work.matrixDef.all;

entity LogicShift is
	generic(Nbit:integer);
	port(
		index: in std_logic_vector (Nbit-1 downto 0);
		shifted: out unsigned (Nbit-1 downto 0)
	);
end LogicShift;

architecture rtl of LogicShift is
begin
	logic_shift: process(index)

		begin
			shifted <= shift_left(unsigned(index), 1);
		end process;

end rtl; 
