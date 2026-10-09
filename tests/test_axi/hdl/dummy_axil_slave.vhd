library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library axi_lite;
use axi_lite.axi_lite_pkg.all;

entity dummy_axil_slave is
  generic (
    name        : string   := "SLAVE";
    g_addr_bits : positive := 6
  );
  port (
    clk          : in std_logic;
    rst_n        : in std_logic;
    axi_lite_m2s : in axi_lite_m2s_t;
    axi_lite_s2m : out axi_lite_s2m_t := axi_lite_s2m_init
  );
end entity dummy_axil_slave;

architecture rtl of dummy_axil_slave is
  constant c_reg_bits : natural := 4; -- 4 registers * 4 bytes = 16 B = 2**4
  type wstate_t is (wridle, wrdata, wrresp);
  type rstate_t is (rdidle, rddata);
  type regs_t is array(0 to 3) of std_ulogic_vector(31 downto 0);

  signal wstate : wstate_t                           := wridle;
  signal rstate : rstate_t                           := rdidle;
  signal waddr  : unsigned(g_addr_bits - 1 downto 0) := (others => '0');
  signal regs   : regs_t                             := (others => (others => '0'));

begin
  assert g_addr_bits >= 5
  report "g_addr_bits has to be >= 5" severity failure;
  axi_lite_s2m.write.aw.ready <= '1' when wstate = wridle else
  '0';
  axi_lite_s2m.write.w.ready <= '1' when wstate = wrdata else
  '0';
  axi_lite_s2m.write.b.valid <= '1' when wstate = wrresp else
  '0';
  axi_lite_s2m.write.b.resp <= axi_lite_resp_okay;

  axi_lite_s2m.read.ar.ready <= '1' when rstate = rdidle else
  '0';
  axi_lite_s2m.read.r.valid <= '1' when rstate = rddata else
  '0';
  axi_lite_s2m.read.r.resp <= axi_lite_resp_okay;

  wr : process (clk)
  begin
    if rising_edge(clk) then
      if rst_n = '0' then
        wstate <= wridle;
        regs   <= (others => (others => '0'));
      else
        case wstate is
          when wridle =>
            if axi_lite_m2s.write.aw.valid = '1' then
              wstate <= wrdata;
              waddr  <= axi_lite_m2s.write.aw.addr(g_addr_bits - 1 downto 0);
            end if;
          when wrdata =>
            if axi_lite_m2s.write.w.valid = '1' then
              if waddr(g_addr_bits - 1 downto c_reg_bits) = 0 then
                regs(to_integer(waddr(3 downto 2))) <= axi_lite_m2s.write.w.data(31 downto 0);
              end if;
              report name & ": write address=0x" & to_hstring(waddr)
                & " data=0x" & to_hstring(axi_lite_m2s.write.w.data(31 downto 0));
              wstate <= wrresp;
            end if;
          when wrresp =>
            if axi_lite_m2s.write.b.ready = '1' then
              wstate <= wridle;
            end if;
        end case;
      end if;
    end if;
  end process;

  rd : process (clk)
    variable a : unsigned(g_addr_bits - 1 downto 0);
    variable d : std_ulogic_vector(31 downto 0);
  begin
    if rising_edge(clk) then
      if rst_n = '0' then
        rstate <= rdidle;
      else
        case rstate is
          when rdidle =>
            if axi_lite_m2s.read.ar.valid = '1' then
              a := axi_lite_m2s.read.ar.addr(g_addr_bits - 1 downto 0);
              if a(g_addr_bits - 1 downto c_reg_bits) = 0 then
                d := regs(to_integer(a(3 downto 2)));
              else
                d := x"5678" & std_ulogic_vector(axi_lite_m2s.read.ar.addr(15 downto 0));
              end if;
              axi_lite_s2m.read.r.data <= x"00000000" & d;
              rstate <= rddata;
              report name & ": read address=0x" & to_hstring(a) & " data=0x" & to_hstring(d);
            end if;
          when rddata =>
            if axi_lite_m2s.read.r.ready = '1' then
              rstate <= rdidle;
            end if;
        end case;
      end if;
    end if;
  end process;

end architecture;
