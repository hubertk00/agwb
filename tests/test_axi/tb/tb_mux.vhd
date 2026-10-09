library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library common;
use common.addr_pkg.all;
library axi_lite;
use axi_lite.axi_lite_pkg.all;

entity tb_mux is
end entity;

architecture sim of tb_mux is
  constant c_period  : time    := 10 ns;
  constant c_timeout : natural := 1000; 

  -- mux base addresses
  constant c_base : addr_vec_t(0 to 1) := (0 => x"00001000", 1 => x"00002000");

  signal clk   : std_ulogic := '0';
  signal rst_n : std_ulogic := '0';
  signal done  : boolean    := false;

  -- master <-> mux
  signal m2s : axi_lite_m2s_t := axi_lite_m2s_init;
  signal s2m : axi_lite_s2m_t;
  -- mux <-> slave
  signal m2s_vec : axi_lite_m2s_vec_t(c_base'range);
  signal s2m_vec : axi_lite_s2m_vec_t(c_base'range);
begin
  clk   <= not clk after c_period / 2 when not done;
  rst_n <= '1' after 5 * c_period;

  mux : entity axi_lite.axi_lite_mux
    generic map(base_addresses => c_base)
    port map
    (
      clk              => clk,
      axi_lite_m2s     => m2s,
      axi_lite_s2m     => s2m,
      axi_lite_m2s_vec => m2s_vec,
      axi_lite_s2m_vec => s2m_vec);

  slave0 : entity work.dummy_axil_slave
    generic map(name => "S0")
    port map
      (clk => clk, rst_n => rst_n, axi_lite_m2s => m2s_vec(0), axi_lite_s2m => s2m_vec(0));

  slave1 : entity work.dummy_axil_slave
    generic map(name => "S1")
    port map
      (clk => clk, rst_n => rst_n, axi_lite_m2s => m2s_vec(1), axi_lite_s2m => s2m_vec(1));

  stim : process
    variable odp  : axi_lite_resp_t; 
    variable dane : std_ulogic_vector(31 downto 0); 

    procedure axil_write (addr : natural;
    data                       : std_ulogic_vector(31 downto 0);
    resp                       : out axi_lite_resp_t) is
    variable aw_czeka          : boolean := true;
    variable w_czeka           : boolean := true;
    variable takty             : natural := 0;
  begin
    null; -- TODO
  end procedure;

  procedure axil_read (addr : natural;
  data                      : out std_ulogic_vector(31 downto 0);
  resp                      : out axi_lite_resp_t) is
  variable ar_czeka         : boolean := true;
  variable takty            : natural := 0;
begin
  null; -- TODO
end procedure;

begin
wait until rst_n = '1';
wait until rising_edge(clk);

-- TODO: test

report "--- KONIEC";
  done <= true;
wait;
end process;
end architecture;