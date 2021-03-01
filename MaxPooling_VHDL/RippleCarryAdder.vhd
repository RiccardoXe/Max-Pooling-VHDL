-- Il Ripple CarryAdder non sono altro che dei FullAdder messi in cascata 
library IEEE;
use IEEE.std_logic_1164.all;

entity RippleCarryAdder is
	generic (Nbit: integer); -- Non sappiamo a quanti bit sono gli ingressi per addessp
	port(
		a:   in  std_logic_vector(Nbit-1 downto 0);
		b:   in  std_logic_vector(Nbit-1 downto 0);
		cin: in  std_logic;
		s:   out std_logic_vector(Nbit-1 downto 0);
		cout:out std_logic 
	);
end RippleCarryAdder;

architecture beh of RippleCarryAdder is
begin 
	combinational_p: process(a,b,cin) -- when one of this changes this process is activateted
	-- We use a variable to take trace of the change of the cout in real time
	-- N.B evrithing else despite the variables are update at the end of the process
	-- we need the carry out of each FullAdder immediatly after the sum of the previous elements 
	variable c: std_logic;
	begin
		c:=cin;
		for i in 0 to Nbit-1 loop
			s(i) <= a(i) xor b(i) xor c;
			c := (a(i) and b(i)) or (a(i) and c) or (b(i) and c);
		end loop;
		cout<=c; -- this is the carry out of the last FullAdder
	end process combinational_p;
end beh;
