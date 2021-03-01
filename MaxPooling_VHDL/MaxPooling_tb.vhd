library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.matrixDef.all;

entity MaxPooling_tb is   -- The testbench has no interface, so it is an empty entity (Be careful: the keyword "is" was missing in the code written in class).
end MaxPooling_tb;

architecture bhv of MaxPooling_tb is -- Testbench architecture declaration
    -----------------------------------------------------------------------------------
    -- Testbench constants
    -----------------------------------------------------------------------------------
	constant T_CLK   : time := 10 ns; -- Clock period
	constant T_RESET : time := 25 ns; -- Period before the reset deassertion
	constant NchannelsA : integer:= 2;
	-----------------------------------------------------------------------------------
    -- Testbench signals
    -----------------------------------------------------------------------------------
	signal clk_tb  : std_logic := '0'; -- clock signal, intialized to '0' 
	signal rst_tb  : std_logic := '0'; -- reset signal

	signal input_channels_tb: in_mats(NchannelsA-1 downto 0);
	signal output_channels_tb: out_mats(NchannelsA-1 downto 0);
	
	signal in_channels0_tb : t11;
	signal in_channels1_tb : t11;

	signal end_sim : std_logic := '1'; -- signal to use to stop the simulation when there is nothing else to test
    -----------------------------------------------------------------------------------
    -- Component to test (DUT) declaration
    -----------------------------------------------------------------------------------
	
	component MaxPooling is
	generic(Nchannels:integer);
	port (
		input_channels : in in_mats(Nchannels-1 downto 0); 
		clock:   in  std_logic;
		reset:   in  std_logic;
		output_channels : out out_mats (Nchannels-1 downto 0)
	);
	end component;
	
	
	
	begin
	
	  clk_tb <= (not(clk_tb) and end_sim) after T_CLK / 2;  -- The clock toggles after T_CLK / 2 when end_sim is high. When end_sim is forced low, the clock stops toggling and the simulation ends.
	  rst_tb <= '1' after T_RESET; -- Deasserting the reset after T_RESET nanosecods (remember: the reset is active low).
	  
	  test_maxpooling: MaxPooling
	  generic map(Nchannels => 2)
	   port map(
			clock         => clk_tb,
			reset         => rst_tb,
			input_channels     => input_channels_tb,
			output_channels    => output_channels_tb
			
	  );
	  d_process: process(clk_tb, rst_tb) -- process used to make the testbench signals change synchronously with the rising edge of the clock
		variable t : integer := 0; -- variable used to count the clock cycle after the reset
	  begin
	    if(rst_tb = '0') then
		  t:=0;
		    for i in 0 to 9 loop
				for j in 0 to 9 loop
				in_channels0_tb(i,j)<=i-j-5;
				in_channels1_tb(i,j)<=i+j;
				end loop;
			 end loop;
		    input_channels_tb(0)<=in_channels0_tb;
		    input_channels_tb(1)<=in_channels1_tb;
			
 		elsif(rising_edge(clk_tb)) then
		  case(t) is   -- specifying the input d_tb and end_sim depending on the value of t ( and so on the number of the passed clock cycles).

		   when 26 => end_sim <= '0'; -- This command stops the simulation when t = 26
            	   when others => null; -- Specifying that nothing happens in the other cases 
			
		  end case;
		  t := t + 1; -- the variable is updated exactly here (try to move this statement before the "case(t) is" one and watch the difference in the simulation)
		end if;
	  end process;
	
end bhv;
