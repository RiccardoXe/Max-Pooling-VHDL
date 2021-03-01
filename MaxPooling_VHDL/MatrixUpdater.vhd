library IEEE;
use IEEE.std_logic_1164.all;

use IEEE.numeric_std.all; 

library work;
use work.matrixDef.all;


-- MatrixUpdater
--	INPUTs:
--		Matrix: This Matrix is the matrix we are processing (5*5 matrix)
--		max: 	This is the max of the sub matrix 2*2 that is currently being analyzed
--		column,row: This is the column/row index of the 5*5 matrix that should be updated
-- 	OUTPUT:
--		UpMatrix: This is the Matrix given as input after being updated 

entity MatrixUpdater is
	generic(Nbit:integer);
	port(
	    Matrix:   in t5;
		max:	  in integer;
		column:   in std_logic_vector(Nbit-1 downto 0);
		row:      in std_logic_vector(Nbit-1 downto 0);
		UpMatrix: out t5
	);
end MatrixUpdater;

architecture rtl of MatrixUpdater is
begin
		
	    comp_matrixUpdater: process(max,Matrix,row,column)
		variable Mat: t5;
		begin
			Mat:=Matrix;
			Mat(to_integer(unsigned(row)),to_integer(unsigned(column))):=max;
			UpMatrix<=Mat;
		end process;
end rtl;
