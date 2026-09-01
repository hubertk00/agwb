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

package SYS1_pkg is

  constant C_SYS1_ADDR_BITS : integer := 4;

  constant c_SYS1_ver_id : std_logic_vector(31 downto 0) := x"9f5e3c34";
  constant v_SYS1_ver_id : t_ver_id_variants(1 downto 0) := (x"038dc299",x"43fbfb77");
  constant c_CTRL_trig_clear : std_logic_vector(5 downto 0) := "111100";
  constant c_CTRL_size : integer := 1;
  constant v_CTRL_size : t_reps_variants(1 downto 0 ) := (0, 1);
  constant c_X2_trig_clear : std_logic_vector(2 downto 0) := "010";
  constant c_X2_size : integer := 1;
  constant c_ENABLEs_size : integer := 10;
  constant v_ENABLEs_size : t_reps_variants(1 downto 0 ) := (10, 9);
  constant c_STATUS_size : integer := 1;


  constant C_CTRL_REG_ADDR: unsigned := x"00000002";
  type t_CTRL is record
    START:std_logic_vector(0 downto 0);
    STOP:std_logic_vector(0 downto 0);
    SPEED:signed(3 downto 0);
  end record;
  
  function to_CTRL(x : std_logic_vector) return t_CTRL;
  function to_slv(x : t_CTRL) return std_logic_vector;
  constant C_X2_REG_ADDR: unsigned := x"00000003";
  type t_X2 is record
    B1:std_logic_vector(0 downto 0);
    B2:std_logic_vector(0 downto 0);
    B3:std_logic_vector(0 downto 0);
  end record;
  
  function to_X2(x : std_logic_vector) return t_X2;
  function to_slv(x : t_X2) return std_logic_vector;
  type ut_X2_array is array( natural range <> ) of t_X2;
  subtype t_X2_array is ut_X2_array(c_X2_size - 1 downto 0);
  constant C_ENABLEs_REG_ADDR: unsigned := x"00000004";
  subtype t_ENABLEs is std_logic_vector(31 downto 0);
  type ut_ENABLEs_array is array( natural range <> ) of t_ENABLEs;
  subtype t_ENABLEs_array is ut_ENABLEs_array(c_ENABLEs_size - 1 downto 0);
  constant C_STATUS_REG_ADDR: unsigned := x"0000000e";
  subtype t_STATUS is std_logic_vector(31 downto 0);




end SYS1_pkg;

package body SYS1_pkg is
  function to_CTRL(x : std_logic_vector) return t_CTRL is
    variable res : t_CTRL;
  begin
    res.START := std_logic_vector(x(0 downto 0));
    res.STOP := std_logic_vector(x(1 downto 1));
    res.SPEED := signed(x(5 downto 2));
    return res;
  end function;
  
  function to_slv(x : t_CTRL) return std_logic_vector is
    variable res : std_logic_vector(5 downto 0);
  begin
    res(0 downto 0) := std_logic_vector(x.START);
    res(1 downto 1) := std_logic_vector(x.STOP);
    res(5 downto 2) := std_logic_vector(x.SPEED);
    return res;
  end function;
  
  function to_X2(x : std_logic_vector) return t_X2 is
    variable res : t_X2;
  begin
    res.B1 := std_logic_vector(x(0 downto 0));
    res.B2 := std_logic_vector(x(1 downto 1));
    res.B3 := std_logic_vector(x(2 downto 2));
    return res;
  end function;
  
  function to_slv(x : t_X2) return std_logic_vector is
    variable res : std_logic_vector(2 downto 0);
  begin
    res(0 downto 0) := std_logic_vector(x.B1);
    res(1 downto 1) := std_logic_vector(x.B2);
    res(2 downto 2) := std_logic_vector(x.B3);
    return res;
  end function;
  

end SYS1_pkg;
