library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library work;
use work.matrixDef.all;

-- MaxPooling:
--		MaxPooling generate a MaxPoolingSingleMatrix for each input matrix

entity MaxPooling is
	generic(Nchannels:integer);
	port (
		input_channels : in in_mats(Nchannels-1 downto 0); 
		clock:   in  std_logic;
		reset:   in  std_logic;
		output_channels : out out_mats (Nchannels-1 downto 0)
	);
end MaxPooling;

architecture beh of MaxPooling is
	
	component MaxPoolingSingleMatrix
	generic (Nbit: integer);
	port(
		clock:   in  std_logic;
		reset:   in  std_logic;
		in_matrix: in t11;
		out_matrix: out t5
	);
	end component MaxPoolingSingleMatrix;

begin

	GEN: for i in 0 to Nchannels-1 generate

		MPSMi : MaxPoolingSingleMatrix 
		generic map (Nbit => 4)
		port map(clock,reset,input_channels(i),output_channels(i));

	end generate GEN;


end beh;
