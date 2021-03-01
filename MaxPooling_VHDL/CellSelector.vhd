library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library work;
use work.matrixDef.all;

-- CellSelector:
--	INPUT:
--		InMatrix:	matrix that has to be computed 
--		Row, Column: indexes obtained by the Logicshift
--  OUTPUT:
--		Vector: This vector contains the 4 values stored in the 2*2 sub-matrix 
--	Notes:
--	This a very simple implementation (It works only for 2*2 sub-Matrixes)
--  This solution has been chosen according to the requirements of this specific Project

entity CellSelector is
	generic(NBit: integer);
	port(
		InMatrix:in t11;
		Row:in unsigned(Nbit-1 downto 0);
		Column: in unsigned(Nbit-1 downto 0);
		Vector: out arrayInt
	);
end CellSelector;

architecture rtl of CellSelector is
begin 
			Vector(0)<= InMatrix(to_integer(Row),to_integer(Column));
			Vector(1)<= InMatrix(to_integer(Row),to_integer(Column)+1);
			Vector(2)<= InMatrix(to_integer(Row)+1,to_integer(Column));
			Vector(3)<= InMatrix(to_integer(Row)+1,to_integer(Column)+1);
end rtl;
