library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library axi_lite;
use axi_lite.axi_lite_pkg.all;
library general_cores;
use general_cores.axi4_pkg.all;

package axi_lite_conv_pkg is
    --hdl-modules master -> general-cores slave input
    function to_gc (m : axi_lite_m2s_t) return t_axi4_lite_master_out_32;
    --general-cores slave output -> hdl-modules master
    function to_hm (s : t_axi4_lite_master_out_32) return axi_lite_s2m_t;
end package;

package body axi_lite_conv_pkg is
    
end package body;