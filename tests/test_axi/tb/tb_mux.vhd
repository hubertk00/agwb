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
    variable status  : axi_lite_resp_t; 
    variable rdata : std_ulogic_vector(31 downto 0); 
    variable errors             : natural := 0;

    procedure axil_write (addr : natural;
    data                       : std_ulogic_vector(31 downto 0);
    resp                       : out axi_lite_resp_t) is
    variable aw_pending          : boolean := true;
    variable w_pending           : boolean := true;
    variable cycles             : natural := 0;
    
  begin
    m2s.write.aw.valid <= '1';
    m2s.write.aw.addr <= to_unsigned(addr, 64);
    m2s.write.w.valid <= '1';
    m2s.write.w.data <= x"00000000" & data;
    m2s.write.w.strb <= x"0F";
    m2s.write.b.ready <= '1';
    
    write_loop : loop
      wait until rising_edge(clk);
      cycles := cycles + 1;

      if aw_pending and s2m.write.aw.ready = '1' then 
        m2s.write.aw.valid <= '0';
        aw_pending := false;
      end if;
      if w_pending and s2m.write.w.ready = '1' then 
        m2s.write.w.valid <= '0'; 
        w_pending := false; 
      end if;
      if s2m.write.b.valid = '1' then
        resp := s2m.write.b.resp;
        exit;
      end if;

      if cycles >= c_timeout then
        report "axil_write: TIMEOUT, address: " & integer'image(addr) severity error;
        resp := "XX";
        m2s.write.aw.valid <= '0'; 
        m2s.write.w.valid <= '0'; 
        exit;
      end if;
    end loop; -- write_loop
    m2s.write.b.ready <= '0';
  end procedure;

  procedure axil_read (addr : natural;
  data                      : out std_ulogic_vector(31 downto 0);
  resp                      : out axi_lite_resp_t) is
  variable ar_pending         : boolean := true;
  variable cycles            : natural := 0;
begin
  m2s.read.ar.valid <= '1'; 
  m2s.read.ar.addr <= to_unsigned(addr, 64);
  m2s.read.r.ready <= '1'; 

  read_loop : loop
    wait until rising_edge(clk);
    cycles := cycles + 1;

    if ar_pending and s2m.read.ar.ready = '1' then
      m2s.read.ar.valid <= '0'; 
      ar_pending := false;
    end if;

    if s2m.read.r.valid = '1' then
      data := s2m.read.r.data(31 downto 0);
      resp := s2m.read.r.resp;
      exit;
    end if;

    if cycles >= c_timeout then
      report "axil_write: TIMEOUT, address: " & integer'image(addr) severity error;
      resp := "XX";
      m2s.read.ar.valid <= '0'; 
      exit;
    end if;
  end loop; -- read_loop
  m2s.read.r.ready <= '0'; 
end procedure;

procedure check (name : string; ok : boolean) is 
begin
  if ok then 
    report "OK " & name;
  else
    report "FAIL " & name severity error;
    errors := errors + 1;
  end if;
end procedure;

begin
wait until rst_n = '1';
wait until rising_edge(clk);

report("read and write in both slaves");
axil_write(16#1004#, x"AAAA0001", status);
check("write 0x1004 -> S0 reg 1", status = axi_lite_resp_okay);
axil_write(16#2008#, x"BBBB0002", status);
check("write 0x2008 -> S1 reg 2", status = axi_lite_resp_okay);
axil_read(16#1004#, rdata, status);
check("read 0x1004 = AAAA0001", status = axi_lite_resp_okay and rdata = x"AAAA0001");
axil_read(16#2008#, rdata, status);
check("read 0x2008 = BBBB0002", status = axi_lite_resp_okay and rdata = x"BBBB0002");

report("empty area inside a slave");
axil_read(16#1030#, rdata, status);
check("read 0x1030 = 56781030", status = axi_lite_resp_okay and rdata = x"56781030");

--TODO more tests

report "finish";
  done <= true;
wait;
end process;
end architecture;