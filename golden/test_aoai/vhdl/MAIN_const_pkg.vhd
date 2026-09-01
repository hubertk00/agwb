library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
package MAIN_const_pkg is
constant C_MAIN_system_ver : std_logic_vector(31 downto 0) := x"7d821872";
constant C_NEXTERNS : integer := 4; -- 4
constant C_NSEL_BITS : integer := 5; -- 5
constant C_NSEL_MAX : integer := 31; -- (1 << NSEL_BITS)-1
end package;
