
library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.matrixDef.all;


entity FlipFlopMatrix is
	port(
		d: in t11;
		clock: in std_logic;
		reset: in std_logic;
		q: out t11
	);
end FlipFlopMatrix;

architecture rtl of FlipFlopMatrix is
begin
	    comp_DFlipFlop: process(clock,reset)
		begin
			if reset='0' then
				q<=(others=>(others=>0));		
			elsif rising_edge(clock) then
				q<=d;
			end if;
		end process;
end rtl;