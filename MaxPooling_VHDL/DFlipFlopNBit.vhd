
library IEEE;
use IEEE.std_logic_1164.all;

entity DFlipFlopNbit is
	generic(Nbit:integer);
	port(
		d: in std_logic_vector(Nbit-1 downto 0);
		clock: in std_logic;
		reset: in std_logic;
		q: out std_logic_vector(Nbit-1 downto 0)
	);
end DFlipFlopNbit;

architecture rtl of DFlipFlopNbit is
begin
	       comp_DFlipFlop: process(clock,reset)
		begin
			if reset='0' then
				q<=(others=>'0');		
			elsif rising_edge(clock) then
				q<=d;
			end if;
		end process;
end rtl;