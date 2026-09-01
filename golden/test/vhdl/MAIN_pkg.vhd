--- This file has been automatically generated
--- by the agwb (https://github.com/wzab/agwb).
--- Please don't edit it manually, unless you really have to do it
library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library general_cores;
use general_cores.wishbone_pkg.all;

library work;
use work.agwb_pkg.all;

package MAIN_pkg is

  constant C_MAIN_ADDR_BITS : integer := 17;

  constant c_MAIN_ver_id : std_logic_vector(31 downto 0) := x"ce69ae7e";
  constant v_MAIN_ver_id : t_ver_id_variants(1 downto 0) := (x"df01e274",x"5c20a9f5");
  constant c_CTRL_trig_clear : std_logic_vector(9 downto 0) := "0111111111";
  constant c_CTRL_size : integer := 1;
  constant c_TEST_OUT_size : integer := 3;
  constant c_TEST_IN_size : integer := 5;
  constant v_TEST_IN_size : t_reps_variants(1 downto 0 ) := (4, 5);
  constant c_EXTHUGE_size : integer := 1;
  constant v_EXTHUGE_size : t_reps_variants( 1 downto 0 ) := (0, 1);
  constant c_EXTERN_size : integer := 4;
  constant c_LINKS_size : integer := 31;
  constant v_LINKS_size : t_reps_variants( 1 downto 0 ) := (2, 31);


  constant C_CTRL_REG_ADDR: unsigned := x"00000008";
  type t_CTRL is record
    CLK_ENABLE:std_logic_vector(4 downto 0);
    CLK_FREQ:std_logic_vector(3 downto 0);
    PLL_RESET:std_logic_vector(0 downto 0);
  end record;
  
  function to_CTRL(x : std_logic_vector) return t_CTRL;
  function to_slv(x : t_CTRL) return std_logic_vector;
  constant C_TEST_OUT_REG_ADDR: unsigned := x"00000009";
  subtype t_TEST_OUT is std_logic_vector(16 downto 0);
  type ut_TEST_OUT_array is array( natural range <> ) of t_TEST_OUT;
  subtype t_TEST_OUT_array is ut_TEST_OUT_array(c_TEST_OUT_size - 1 downto 0);
  constant C_TEST_IN_REG_ADDR: unsigned := x"0000000c";
  subtype t_TEST_IN is std_logic_vector(15 downto 0);
  type ut_TEST_IN_array is array( natural range <> ) of t_TEST_IN;
  subtype t_TEST_IN_array is ut_TEST_IN_array(c_TEST_IN_size - 1 downto 0);




end MAIN_pkg;

package body MAIN_pkg is
  function to_CTRL(x : std_logic_vector) return t_CTRL is
    variable res : t_CTRL;
  begin
    res.CLK_ENABLE := std_logic_vector(x(4 downto 0));
    res.CLK_FREQ := std_logic_vector(x(8 downto 5));
    res.PLL_RESET := std_logic_vector(x(9 downto 9));
    return res;
  end function;
  
  function to_slv(x : t_CTRL) return std_logic_vector is
    variable res : std_logic_vector(9 downto 0);
  begin
    res(4 downto 0) := std_logic_vector(x.CLK_ENABLE);
    res(8 downto 5) := std_logic_vector(x.CLK_FREQ);
    res(9 downto 9) := std_logic_vector(x.PLL_RESET);
    return res;
  end function;
  

end MAIN_pkg;
