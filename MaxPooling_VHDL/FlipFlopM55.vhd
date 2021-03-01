library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.matrixDef.all;


entity FlipFlopM55 is
	port(
		d: in t5;
		clock: in std_logic;
		reset: in std_logic;
		q: out t5
	);
end FlipFlopM55 ;

architecture rtl of FlipFlopM55  is
begin
	    comp_DFlipFlop: process(clock,reset)
		begin
			if reset='0' then
				q<=(others=>(others=>1));		
			elsif rising_edge(clock) then
				q<=d;
			end if;
		end process;
end rtl;
