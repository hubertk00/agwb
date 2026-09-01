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
use work.SYS1_pkg.all;

entity SYS1 is
  generic (
    g_CTRL_size : integer := c_CTRL_size;
    g_STATUS_size : integer := c_STATUS_size;
    g_RREG_size : integer := c_RREG_size;
    g_ENABLEs_size : integer := c_ENABLEs_size;

    g_ver_id : std_logic_vector(31 downto 0) := c_SYS1_ver_id;
    g_registered : integer := 0
  );
  port (
    slave_i : in t_wishbone_slave_in;
    slave_o : out t_wishbone_slave_out;

    out_regs : out t_SYS1_out_regs;
    in_regs : in t_SYS1_in_regs;
    ack_regs_o : out t_SYS1_ack_regs;

    rst_n_i : in std_logic;
    clk_sys_i : in std_logic
    );

end SYS1;

architecture gener of SYS1 is
  signal int_CTRL_o : t_CTRL := to_CTRL(std_logic_vector(to_unsigned(30,6))); -- Hex value: 0x1e
  signal int_CTRL_o_stb : std_logic;
  signal int_ENABLEs_o : ut_ENABLEs_array(g_ENABLEs_size - 1 downto 0) := (others => std_logic_vector(to_unsigned(0,32))); -- Hex value: 0x0
  signal int_ENABLEs_o_stb : std_logic_vector(g_ENABLEs_size - 1 downto 0);


  -- Internal WB declaration
  signal int_regs_wb_m_o : t_wishbone_master_out;
  signal int_regs_wb_m_i : t_wishbone_master_in;
  signal int_addr : std_logic_vector(5-1 downto 0);
  signal wb_up_o : t_wishbone_slave_out_array(1-1 downto 0);
  signal wb_up_i : t_wishbone_slave_in_array(1-1 downto 0);
  signal wb_up_r_o : t_wishbone_slave_out_array(1-1 downto 0);
  signal wb_up_r_i : t_wishbone_slave_in_array(1-1 downto 0);
  signal wb_m_o : t_wishbone_master_out_array(1-1 downto 0);
  signal wb_m_i : t_wishbone_master_in_array(1-1 downto 0) := (others => c_WB_SLAVE_OUT_ERR);

  -- Constants
  constant c_address : t_wishbone_address_array(1-1  downto 0) := (0=>"00000000000000000000000000000000");
  constant c_mask : t_wishbone_address_array(1-1 downto 0) := (0=>"00000000000000000000000000000000");
begin
  
  assert g_CTRL_size <= c_CTRL_size report "g_CTRL_size must be not greater than c_CTRL_size=1" severity failure;
  assert g_STATUS_size <= c_STATUS_size report "g_STATUS_size must be not greater than c_STATUS_size=1" severity failure;
  assert g_RREG_size <= c_RREG_size report "g_RREG_size must be not greater than c_RREG_size=3" severity failure;
  assert g_ENABLEs_size <= c_ENABLEs_size report "g_ENABLEs_size must be not greater than c_ENABLEs_size=10" severity failure;

  wb_up_i(0) <= slave_i;
  slave_o <= wb_up_o(0);
  int_addr <= int_regs_wb_m_o.adr(5-1 downto 0);

-- Conditional adding of xwb_register   
  gr1: if g_registered = 2 generate
    grl1: for i in 0 to 1-1 generate
      xwb_register_1: entity general_cores.xwb_register
      generic map (
        g_WB_MODE => CLASSIC)
      port map (
        rst_n_i  => rst_n_i,
        clk_i    => clk_sys_i,
        slave_i  => wb_up_i(i),
        slave_o  => wb_up_o(i),
        master_i => wb_up_r_o(i),
        master_o => wb_up_r_i(i));
    end generate grl1;
  end generate gr1;

  gr2: if g_registered /= 2 generate
      wb_up_r_i <= wb_up_i;
      wb_up_o <= wb_up_r_o;
  end generate gr2;

-- Main crossbar
  xwb_crossbar_1: entity general_cores.xwb_crossbar
  generic map (
     g_num_masters => 1,
     g_num_slaves  => 1,
     g_registered  => (g_registered = 1),
     g_address     => c_address,
     g_mask        => c_mask
  )
  port map (
     clk_sys_i => clk_sys_i,
     rst_n_i   => rst_n_i,
     slave_i   => wb_up_r_i,
     slave_o   => wb_up_r_o,
     master_i  => wb_m_i,
     master_o  => wb_m_o,
     sdb_sel_o => open
  );

-- Process for register access
  process(clk_sys_i)
  begin
    if rising_edge(clk_sys_i) then
      if rst_n_i = '0' then
        -- Reset of the core
        int_regs_wb_m_i <= c_DUMMY_WB_MASTER_IN;
        int_CTRL_o <= to_CTRL(std_logic_vector(to_unsigned(30,6))); -- Hex value: 0x1e
        int_ENABLEs_o <= (others => std_logic_vector(to_unsigned(0,32))); -- Hex value: 0x0

      else
        -- Clearing of trigger bits (if there are any)

        -- Normal operation
        int_regs_wb_m_i.rty <= '0';
        int_regs_wb_m_i.ack <= '0';
        int_regs_wb_m_i.err <= '0';
        int_CTRL_o_stb <= '0';
        ack_regs_o.STATUS <= '0';
        ack_regs_o.RREG <= (others => '0');
        int_ENABLEs_o_stb <= (others =>'0');

        if (int_regs_wb_m_o.cyc = '1') and (int_regs_wb_m_o.stb = '1')
            and (int_regs_wb_m_i.err = '0') and (int_regs_wb_m_i.rty = '0')
            and (int_regs_wb_m_i.ack = '0') then
          int_regs_wb_m_i.err <= '1'; -- in case of missed address
          -- Access, now we handle consecutive registers
          -- Set the error state so it is output when none register is accessed
          int_regs_wb_m_i.dat <= x"A5A5A5A5";
          int_regs_wb_m_i.ack <= '0';
          int_regs_wb_m_i.err <= '1';
          
          -- That's a single register that may be present (size=1) or not (size=0).
          -- The "for" loop works like "if".
          -- That's why we do not index the register inside the loop.
          for i in 0 to g_CTRL_size - 1 loop
            if int_addr = std_logic_vector(to_unsigned(2 + i, 5)) then
              int_regs_wb_m_i.dat <= (others => '0');
              int_regs_wb_m_i.dat(5 downto 0) <= to_slv(int_CTRL_o);
              if int_regs_wb_m_o.we = '1' then
                int_CTRL_o <= to_CTRL(int_regs_wb_m_o.dat(5 downto 0));
                if int_regs_wb_m_i.ack = '0' then
                  int_CTRL_o_stb <= '1';
                end if;
              end if;
              int_regs_wb_m_i.ack <= '1';
              int_regs_wb_m_i.err <= '0';
            end if;
          end loop; -- g_CTRL_size
          
          -- That's a single register that may be present (size=1) or not (size=0).
          -- The "for" loop works like "if".
          -- That's why we do not index the register inside the loop.
          for i in 0 to g_STATUS_size - 1 loop
            if int_addr = std_logic_vector(to_unsigned(3 + i, 5)) then
              int_regs_wb_m_i.dat <= (others => '0');
              int_regs_wb_m_i.dat(31 downto 0) <= std_logic_vector(in_regs.STATUS);
              if int_regs_wb_m_i.ack = '0' then
                 ack_regs_o.STATUS <= '1';
              end if;
              int_regs_wb_m_i.ack <= '1';
              int_regs_wb_m_i.err <= '0';
            end if;
          end loop; -- g_STATUS_size
          for i in 0 to g_RREG_size - 1 loop
            if int_addr = std_logic_vector(to_unsigned(4 + i, 5)) then
              int_regs_wb_m_i.dat <= (others => '0');
              int_regs_wb_m_i.dat(31 downto 0) <= std_logic_vector(in_regs.RREG( i ));
              if int_regs_wb_m_i.ack = '0' then
                 ack_regs_o.RREG( i ) <= '1';
              end if;
              int_regs_wb_m_i.ack <= '1';
              int_regs_wb_m_i.err <= '0';
            end if;
          end loop; -- g_RREG_size
          for i in 0 to g_ENABLEs_size - 1 loop
            if int_addr = std_logic_vector(to_unsigned(7 + i, 5)) then
              int_regs_wb_m_i.dat <= (others => '0');
              int_regs_wb_m_i.dat(31 downto 0) <= std_logic_vector(int_ENABLEs_o( i ));
              if int_regs_wb_m_o.we = '1' then
                int_ENABLEs_o( i ) <= std_logic_vector(int_regs_wb_m_o.dat(31 downto 0));
                if int_regs_wb_m_i.ack = '0' then
                  int_ENABLEs_o_stb( i ) <= '1';
                end if;
              end if;
              int_regs_wb_m_i.ack <= '1';
              int_regs_wb_m_i.err <= '0';
            end if;
          end loop; -- g_ENABLEs_size


          if int_addr = "00000" then
             int_regs_wb_m_i.dat <= x"5bd964c2";
             if int_regs_wb_m_o.we = '1' then
                int_regs_wb_m_i.err <= '1';
                int_regs_wb_m_i.ack <= '0';
             else
                int_regs_wb_m_i.ack <= '1';
                int_regs_wb_m_i.err <= '0';
             end if;
          end if;
          if int_addr = "00001" then
             int_regs_wb_m_i.dat <= g_ver_id;
             if int_regs_wb_m_o.we = '1' then
                int_regs_wb_m_i.err <= '1';
                int_regs_wb_m_i.ack <= '0';
             else
                int_regs_wb_m_i.ack <= '1';
                int_regs_wb_m_i.err <= '0';
             end if;
          end if;
        end if;
      end if;
    end if;
  end process;
  out_regs.CTRL <= int_CTRL_o;
  out_regs.CTRL_stb <= int_CTRL_o_stb;
  out_regs.ENABLEs <= int_ENABLEs_o;
  out_regs.ENABLEs_stb <= int_ENABLEs_o_stb;
  wb_m_i(0) <= int_regs_wb_m_i;
  int_regs_wb_m_o  <= wb_m_o(0);

end architecture;
