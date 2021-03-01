library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

-- IndexManger Notes:
-- 		Components: 
-- 		+ RippleCarryAdder:
--			The RippleCarryAdder has as input the carry_input and the value 
--			sotred in the FlipFlop and give as output the sum of the two values
--		+ Comparator:
--			The Comparator has to check if the out of The ripple CarryAdder exceed 4
--			In that case ComporatorOut will be set to '1'
--		+ FlipFlopNbit:
--			The FlipFlop need to store the exit ot the comparator


entity IndexManager is
	generic (Nbit:integer);
	port(
		clock:   in  std_logic;
		reset:   in  std_logic;
		carry_input: in std_logic;
		FlipFlopOut: out std_logic_vector(Nbit-1 downto 0);
		ShiftOut:	 out unsigned (Nbit-1 downto 0);
		ComparatorOut: out std_logic
	);
	end IndexManager;
	
architecture beh of IndexManager is 
	component RippleCarryAdder is
	generic (Nbit: integer); -- Non sappiamo a quanti bit sono gli ingressi per addessp
	port(
		a:   in  std_logic_vector(Nbit-1 downto 0);
		b:   in  std_logic_vector(Nbit-1 downto 0);
		cin: in  std_logic;
		s:   out std_logic_vector(Nbit-1 downto 0);
		cout:out std_logic 
	);
	end component;

	component CompIndex is
	generic(Nbit:integer);
	port(
		reset:  in std_logic;
		a: 	    in std_logic_vector (Nbit-1 downto 0);
		column: out std_logic_vector(Nbit-1 downto 0);
		row:    out std_logic
	);
	end component;
	
	
	
	component DFlipFlopNbit is
	generic(Nbit:integer);
	port(
		d: in std_logic_vector(Nbit-1 downto 0);
		clock: in std_logic;
		reset: in std_logic;
		q: out std_logic_vector(Nbit-1 downto 0)
	);
	end component;
	
	component LogicShift is
	generic(Nbit:integer);
	port(
		index: in std_logic_vector (Nbit-1 downto 0);
		shifted: out unsigned (Nbit-1 downto 0)
	);
	end component;
	
	signal outRCA: std_logic_vector(Nbit-1 downto 0);
	signal outCompIndexCol: std_logic_vector(3 downto 0);
	signal outCompIndexRow: std_logic;
	signal outDFlipFlopQ:	std_logic_vector(Nbit-1 downto 0);
	signal outLogicShiftS: 	unsigned (3 downto 0);
	signal inA: std_logic_vector(3 downto 0); 

	begin
	
	
	--inA<=(0=>carry_input,others=>'0');
	
		comp_IndexManager: process(carry_input)
		begin
			inA<=(0=>carry_input,others=>'0');
		end process;
		
	Adder:RippleCarryAdder
	generic map(Nbit=>4)
	port map(
		a=>inA,
		b=>outDFlipFlopQ,
		cin=>'0',
		s => outRCA,
		cout=> open
	);
	
	Comparator:CompIndex
	generic map(Nbit=>4)
	port map(
		reset  => reset,
		a	   => outRCA,
		column => outCompIndexCol,
		row	   => outCompIndexRow
	);
	
	FlipFlop: DFlipFlopNbit
	generic map(Nbit => 4)
	port map(
		d=> outCompIndexCol,
		clock => clock,
		reset => reset,
		q =>  outDFlipFlopQ
	);
	
	LogicS:LogicShift
	generic map(Nbit => 4)
	port map(
		index => outDFlipFlopQ,
		shifted=>outLogicShiftS
	);
	
	FlipFlopOut	 <= outDFlipFlopQ;
	ShiftOut	 <= outLogicShiftS;
	ComparatorOut<= outCompIndexRow;
	
	
end beh;