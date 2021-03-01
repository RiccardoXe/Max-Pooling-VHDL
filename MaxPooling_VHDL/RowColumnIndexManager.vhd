library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 


-- RowColumnIndexManager Notes:
--			In the RowColumnIndexManager we have two IndexManager
--			the first for the column index the second for the row index
--	Components:
--		+ColumnIndexManager:
--			The column index manger has to increment of '1' each time there is a
--			raising edge of the clock and when the index exceed 4 has to go back to 0 and 
--			notify to the RowIndexManger to incrase it's stored number
--		+RowIndexManager:
--			The row index manger column has to increment of '1' each time the column index exceeded 
--			4 and when the index exceed 4 has to go back to 0 
--		This condition is achieved by attaching the ComparatorOut of the ColumnIndexManger to the
--		carry_input of the RowIndexManager 
 
entity RowColumnIndexManager is
	generic (Nbit:integer);
	port(
		clock:   in  std_logic;
		reset:   in  std_logic;
		index_row: out std_logic_vector (Nbit-1 downto 0);
		index_column: out std_logic_vector (Nbit-1 downto 0);
		index_row_shifted: out unsigned (3 downto 0);
		index_column_shifted: out unsigned (3 downto 0)
	);
	end RowColumnIndexManager;

architecture beh of RowColumnIndexManager is 
	
	component IndexManager is
	generic (Nbit: integer);
	port (
	
		clock:   in  std_logic;
		reset:   in  std_logic;
		carry_input: in std_logic;
		FlipFlopOut: out std_logic_vector(Nbit-1 downto 0);
		ShiftOut:	 out unsigned (3 downto 0);
		ComparatorOut: out std_logic
	);
	end component;
	
	signal index_row_out: std_logic_vector (Nbit-1 downto 0);
	signal index_column_out: std_logic_vector (Nbit-1 downto 0);
	signal index_row_shifted_out: unsigned (3 downto 0);
	signal index_column_shifted_out: unsigned (3 downto 0);
	signal comparator_out_column : std_logic;
	signal comparator_out_row : std_logic;

	begin
		IndexManagerColumn:IndexManager
		generic map (Nbit => 4)
		port map (
			clock => clock,
			reset => reset,
			carry_input => '1',
			FlipFlopOut => index_column_out,
			ShiftOut => index_column_shifted_out,
			ComparatorOut => comparator_out_column
		);

		IndexManagerRow:IndexManager
		generic map (Nbit => 4)
		port map (
			clock => clock,
			reset => reset,
			carry_input => comparator_out_column,
			FlipFlopOut => index_row_out,
			ShiftOut => index_row_shifted_out,
			ComparatorOut => comparator_out_row
		);
		
		index_row <= index_row_out;
		index_column <= index_column_out;
		index_row_shifted <= index_row_shifted_out;
		index_column_shifted <= index_column_shifted_out;


end beh;
