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

  constant c_SYS1_ver_id : std_logic_vector(31 downto 0) := x"ad9541a4";
  constant v_SYS1_ver_id : t_ver_id_variants(0 downto 0) := (0 => x"ad9541a4");
  constant c_CTRL_size : integer := 1;
  constant c_Test1_size : integer := 1;
  constant c_STATUS_size : integer := 1;
  constant c_ENABLEs_size : integer := 10;


  constant C_CTRL_REG_ADDR: unsigned := x"00000002";
  type t_CTRL is record
    START:std_logic_vector(0 downto 0);
    SPEED:signed(3 downto 0);
    STOP:std_logic_vector(0 downto 0);
  end record;
  
  function to_CTRL(x : std_logic_vector) return t_CTRL;
  function to_slv(x : t_CTRL) return std_logic_vector;
  constant C_Test1_REG_ADDR: unsigned := x"00000003";
  type t_Test1 is record
    FIELD1:std_logic_vector(0 downto 0);
    FIELD2:signed(3 downto 0);
    FIELD3:std_logic_vector(0 downto 0);
  end record;
  
  function to_Test1(x : std_logic_vector) return t_Test1;
  function to_slv(x : t_Test1) return std_logic_vector;
  type ut_Test1_array is array( natural range <> ) of t_Test1;
  subtype t_Test1_array is ut_Test1_array(c_Test1_size - 1 downto 0);
  constant C_STATUS_REG_ADDR: unsigned := x"00000004";
  subtype t_STATUS is std_logic_vector(31 downto 0);
  constant C_ENABLEs_REG_ADDR: unsigned := x"00000005";
  subtype t_ENABLEs is std_logic_vector(31 downto 0);
  type ut_ENABLEs_array is array( natural range <> ) of t_ENABLEs;
  subtype t_ENABLEs_array is ut_ENABLEs_array(c_ENABLEs_size - 1 downto 0);

  type t_SYS1_out_regs is record
    CTRL : t_CTRL;
    CTRL_stb : std_logic;
    Test1 : ut_Test1_array(c_Test1_size - 1 downto 0);
    Test1_stb : std_logic_vector(c_Test1_size - 1 downto 0);
    ENABLEs : ut_ENABLEs_array(c_ENABLEs_size - 1 downto 0);
    ENABLEs_stb : std_logic_vector(c_ENABLEs_size - 1 downto 0);
  end record;
  



end SYS1_pkg;

package body SYS1_pkg is
  function to_CTRL(x : std_logic_vector) return t_CTRL is
    variable res : t_CTRL;
  begin
    res.START := std_logic_vector(x(0 downto 0));
    res.SPEED := signed(x(4 downto 1));
    res.STOP := std_logic_vector(x(5 downto 5));
    return res;
  end function;
  
  function to_slv(x : t_CTRL) return std_logic_vector is
    variable res : std_logic_vector(5 downto 0);
  begin
    res(0 downto 0) := std_logic_vector(x.START);
    res(4 downto 1) := std_logic_vector(x.SPEED);
    res(5 downto 5) := std_logic_vector(x.STOP);
    return res;
  end function;
  
  function to_Test1(x : std_logic_vector) return t_Test1 is
    variable res : t_Test1;
  begin
    res.FIELD1 := std_logic_vector(x(0 downto 0));
    res.FIELD2 := signed(x(4 downto 1));
    res.FIELD3 := std_logic_vector(x(5 downto 5));
    return res;
  end function;
  
  function to_slv(x : t_Test1) return std_logic_vector is
    variable res : std_logic_vector(5 downto 0);
  begin
    res(0 downto 0) := std_logic_vector(x.FIELD1);
    res(4 downto 1) := std_logic_vector(x.FIELD2);
    res(5 downto 5) := std_logic_vector(x.FIELD3);
    return res;
  end function;
  

end SYS1_pkg;
