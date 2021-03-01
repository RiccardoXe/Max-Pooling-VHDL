library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library work;
use work.matrixDef.all;

-- MaxPoolingSingleMatrix
--	The MaxPoolingSingleMatrix is the circuit that calcolate the max pool for a single input matrix
--	The desing is explainend on the documentation 

entity MaxPoolingSingleMatrix is
	generic(Nbit:integer);
	port(
		clock:   in  std_logic;
		reset:   in  std_logic;
		in_matrix: in t11;
		out_matrix: out t5
	);
	end MaxPoolingSingleMatrix;
	
architecture beh of MaxPoolingSingleMatrix is 
	component RowColumnIndexManager is
	generic (Nbit:integer);
	port(
		clock:   in  std_logic;
		reset:   in  std_logic;
		index_row: out std_logic_vector (Nbit-1 downto 0);
		index_column: out std_logic_vector (Nbit-1 downto 0);
		index_row_shifted: out unsigned (3 downto 0);
		index_column_shifted: out unsigned (3 downto 0)
	);
	end component;
	
	component FlipFlopMatrix is
	port(
		d: in t11;
		clock: in std_logic;
		reset: in std_logic;
		q: out t11
	);
	end component;
	
	component CellSelector is
	generic(NBit: integer);
	port(
		InMatrix:in t11;
		Row:in unsigned(Nbit-1 downto 0);
		Column: in unsigned(Nbit-1 downto 0);
		Vector: out arrayInt
	);
	end component;
	
	component Comp4elem is
	port(
		elems: in arrayInt;
		result: out integer
	);
	end component;
	
	
	component MatrixUpdater is
	generic(Nbit:integer);
	port(
	    Matrix:   in t5;
		max:	  in integer;
		column:   in std_logic_vector(Nbit-1 downto 0);
		row:      in std_logic_vector(Nbit-1 downto 0);
		UpMatrix: out t5
	);
	end component;
	
	component FlipFlopM55 is
	port(
		d: in t5;
		clock: in std_logic;
		reset: in std_logic;
		q: out t5
	);
	end component ;
	
	signal  MPindex_row: std_logic_vector (Nbit-1 downto 0);
	signal  MPindex_column: std_logic_vector (Nbit-1 downto 0);
	signal	MPindex_row_shifted:  unsigned (3 downto 0);
	signal	MPindex_column_shifted: unsigned (3 downto 0);
	signal  MPq10:  t11;
	signal  MPVector: arrayInt;
	signal  MPresult: integer;
	signal  MPUpMatrix: t5;
	signal  MPq5: t5;
	
	begin 
	
	MPRowColumnIndexManager: RowColumnIndexManager
	generic map (Nbit => 4)
	port map(
		clock => clock,
		reset =>  reset,
		index_row => MPindex_row,
		index_column => MPindex_column,
		index_row_shifted => MPindex_row_shifted,
		index_column_shifted => MPindex_column_shifted
	);
	
	MPFlipFlopMatrix: FlipFlopMatrix
	port map(
	    d     => in_matrix,
		clock => clock,
		reset => reset,
		q     => MPq10
	);
	
	MPCellSelector: CellSelector
	generic map(NBit => 4)
	port map(
		InMatrix =>MPq10,
		Row =>MPindex_row_shifted,
		Column=>MPindex_column_shifted,
		Vector=> MPVector
	);
	
	MPComp4elem:Comp4elem
	port map(
		elems=>MPVector,
		result=> MPresult
	);
	
	MPMatrixUpdater: MatrixUpdater
	generic map (Nbit => 4)
	port map(
	    Matrix => MPq5,
		max    => MPresult,
		column => MPindex_column,
		row	   => MPindex_row,
		UpMatrix => MPUpMatrix
	);
	
	MPFlipFlopM55:FlipFlopM55
	port map(
		d 	  =>  MPUpMatrix,
		clock => clock,
		reset => reset,
		q	  => MPq5
	);
	
	out_matrix<= MPq5;
	
	
	
	end beh;
