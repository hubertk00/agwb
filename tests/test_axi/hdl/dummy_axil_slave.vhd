library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library axi_lite;
use axi_lite.axi_lite_pkg.all;

entity dummy_axil_slave is
  generic (
    name : string );

  port (
    clk   : in  std_logic;
    rst_n : in  std_logic;
    axi_lite_m2s   : in  axi_lite_m2s_t;
    axi_lite_s2m  : out axi_lite_s2m_t := axi_lite_s2m_init
    );

end entity dummy_axil_slave;
