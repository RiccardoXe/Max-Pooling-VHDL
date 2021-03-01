library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

package matrixDef is

type t11 is array (0 to 9, 0 to 9) of integer range -2147483648 to 50;
type t5  is array (0 to 4, 0 to 4) of integer range -2147483648 to 50;
type arrayInt is array (0 to 3) of integer range    -2147483648 to 50;
type in_mats is array (integer range <>) of t11;
type out_mats is array (integer range <>) of t5;

end matrixDef;