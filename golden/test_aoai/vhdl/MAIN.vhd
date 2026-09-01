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
use work.MAIN_pkg.all;

entity MAIN is
  generic (
    g_CR1_size : integer := c_CR1_size;
    g_CTRL_size : integer := c_CTRL_size;
    g_CR2_size : integer := c_CR2_size;
    g_TEST_OUT_size : integer := c_TEST_OUT_size;
    g_TEST_IN_size : integer := c_TEST_IN_size;
    g_EXTHUGE_size : integer := c_EXTHUGE_size;
    g_EXTERN_size : integer := c_EXTERN_size;
    g_LINKS_size : integer := c_LINKS_size;

    g_ver_id : std_logic_vector(31 downto 0) := c_MAIN_ver_id;
    g_registered : integer := 0
  );
  port (
    slave_i : in t_wishbone_slave_in;
    slave_o : out t_wishbone_slave_out;
    EXTHUGE_wb_m_o : out t_wishbone_master_out;
    EXTHUGE_wb_m_i : in t_wishbone_master_in := c_WB_SLAVE_OUT_ERR;
    EXTERN_wb_m_o : out t_wishbone_master_out_array( g_EXTERN_size - 1 downto 0 );
    EXTERN_wb_m_i : in t_wishbone_master_in_array( g_EXTERN_size - 1 downto 0 ) := ( others => c_WB_SLAVE_OUT_ERR);
    LINKS_wb_m_o : out t_wishbone_master_out_array( g_LINKS_size - 1 downto 0 );
    LINKS_wb_m_i : in t_wishbone_master_in_array( g_LINKS_size - 1 downto 0 ) := ( others => c_WB_SLAVE_OUT_ERR);

    CR1_o : out  t_CR1;
    CTRL_o : out  t_CTRL;
    CR2_o : out  t_CR2;
    TEST_OUT_o : out  ut_TEST_OUT_array(g_TEST_OUT_size - 1 downto 0);
    TEST_IN_i : in  ut_TEST_IN_array(g_TEST_IN_size - 1 downto 0);

    rst_n_i : in std_logic;
    clk_sys_i : in std_logic
    );

end MAIN;

architecture gener of MAIN is
  signal int_CR1_o : t_CR1 := std_logic_vector(to_unsigned(16843009,32)); -- Hex value: 0x1010101
  signal int_CTRL_o : t_CTRL := to_CTRL(std_logic_vector(to_unsigned(103,10))); -- Hex value: 0x67
  signal int_CR2_o : t_CR2 := std_logic_vector(to_unsigned(538976288,32)); -- Hex value: 0x20202020
  signal int_TEST_OUT_o : ut_TEST_OUT_array(g_TEST_OUT_size - 1 downto 0) := (others => std_logic_vector(to_unsigned(23,17))); -- Hex value: 0x17


  -- Internal WB declaration
  signal int_regs_wb_m_o : t_wishbone_master_out;
  signal int_regs_wb_m_i : t_wishbone_master_in;
  signal int_addr : std_logic_vector(4-1 downto 0);
  signal wb_up_o : t_wishbone_slave_out_array(1-1 downto 0);
  signal wb_up_i : t_wishbone_slave_in_array(1-1 downto 0);
  signal wb_up_r_o : t_wishbone_slave_out_array(1-1 downto 0);
  signal wb_up_r_i : t_wishbone_slave_in_array(1-1 downto 0);
  signal wb_m_o : t_wishbone_master_out_array(37-1 downto 0);
  signal wb_m_i : t_wishbone_master_in_array(37-1 downto 0) := (others => c_WB_SLAVE_OUT_ERR);

  -- Constants
  constant c_address : t_wishbone_address_array(37-1  downto 0) := (0=>"00000000000000010000000000000000",1=>"00000000000000001111000000000000",2=>"00000000000000001111010000000000",3=>"00000000000000001111100000000000",4=>"00000000000000001111110000000000",5=>"00000000000000001110110000000000",6=>"00000000000000001110110000100000",7=>"00000000000000001110110001000000",8=>"00000000000000001110110001100000",9=>"00000000000000001110110010000000",10=>"00000000000000001110110010100000",11=>"00000000000000001110110011000000",12=>"00000000000000001110110011100000",13=>"00000000000000001110110100000000",14=>"00000000000000001110110100100000",15=>"00000000000000001110110101000000",16=>"00000000000000001110110101100000",17=>"00000000000000001110110110000000",18=>"00000000000000001110110110100000",19=>"00000000000000001110110111000000",20=>"00000000000000001110110111100000",21=>"00000000000000001110111000000000",22=>"00000000000000001110111000100000",23=>"00000000000000001110111001000000",24=>"00000000000000001110111001100000",25=>"00000000000000001110111010000000",26=>"00000000000000001110111010100000",27=>"00000000000000001110111011000000",28=>"00000000000000001110111011100000",29=>"00000000000000001110111100000000",30=>"00000000000000001110111100100000",31=>"00000000000000001110111101000000",32=>"00000000000000001110111101100000",33=>"00000000000000001110111110000000",34=>"00000000000000001110111110100000",35=>"00000000000000001110111111000000",36=>"00000000000000000000010000000000");
  constant c_mask : t_wishbone_address_array(37-1 downto 0) := (0=>"00000000000000010000000000000000",1=>"00000000000000011111110000000000",2=>"00000000000000011111110000000000",3=>"00000000000000011111110000000000",4=>"00000000000000011111110000000000",5=>"00000000000000011111111111100000",6=>"00000000000000011111111111100000",7=>"00000000000000011111111111100000",8=>"00000000000000011111111111100000",9=>"00000000000000011111111111100000",10=>"00000000000000011111111111100000",11=>"00000000000000011111111111100000",12=>"00000000000000011111111111100000",13=>"00000000000000011111111111100000",14=>"00000000000000011111111111100000",15=>"00000000000000011111111111100000",16=>"00000000000000011111111111100000",17=>"00000000000000011111111111100000",18=>"00000000000000011111111111100000",19=>"00000000000000011111111111100000",20=>"00000000000000011111111111100000",21=>"00000000000000011111111111100000",22=>"00000000000000011111111111100000",23=>"00000000000000011111111111100000",24=>"00000000000000011111111111100000",25=>"00000000000000011111111111100000",26=>"00000000000000011111111111100000",27=>"00000000000000011111111111100000",28=>"00000000000000011111111111100000",29=>"00000000000000011111111111100000",30=>"00000000000000011111111111100000",31=>"00000000000000011111111111100000",32=>"00000000000000011111111111100000",33=>"00000000000000011111111111100000",34=>"00000000000000011111111111100000",35=>"00000000000000011111111111100000",36=>"00000000000000011111111111110000");
begin
  
  assert g_CR1_size <= c_CR1_size report "g_CR1_size must be not greater than c_CR1_size=1" severity failure;
  assert g_CTRL_size <= c_CTRL_size report "g_CTRL_size must be not greater than c_CTRL_size=1" severity failure;
  assert g_CR2_size <= c_CR2_size report "g_CR2_size must be not greater than c_CR2_size=1" severity failure;
  assert g_TEST_OUT_size <= c_TEST_OUT_size report "g_TEST_OUT_size must be not greater than c_TEST_OUT_size=3" severity failure;
  assert g_TEST_IN_size <= c_TEST_IN_size report "g_TEST_IN_size must be not greater than c_TEST_IN_size=5" severity failure;
  assert g_EXTHUGE_size <= c_EXTHUGE_size report "g_EXTHUGE_size must be not greater than c_EXTHUGE_size=1" severity failure;
  assert g_EXTERN_size <= c_EXTERN_size report "g_EXTERN_size must be not greater than c_EXTERN_size=4" severity failure;
  assert g_LINKS_size <= c_LINKS_size report "g_LINKS_size must be not greater than c_LINKS_size=31" severity failure;

  wb_up_i(0) <= slave_i;
  slave_o <= wb_up_o(0);
  int_addr <= int_regs_wb_m_o.adr(4-1 downto 0);

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
     g_num_slaves  => 37,
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
        int_CR1_o <= std_logic_vector(to_unsigned(16843009,32)); -- Hex value: 0x1010101
        int_CTRL_o <= to_CTRL(std_logic_vector(to_unsigned(103,10))); -- Hex value: 0x67
        int_CR2_o <= std_logic_vector(to_unsigned(538976288,32)); -- Hex value: 0x20202020
        int_TEST_OUT_o <= (others => std_logic_vector(to_unsigned(23,17))); -- Hex value: 0x17

      else
        -- Clearing of trigger bits (if there are any)

        -- Normal operation
        int_regs_wb_m_i.rty <= '0';
        int_regs_wb_m_i.ack <= '0';
        int_regs_wb_m_i.err <= '0';

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
          for i in 0 to g_CR1_size - 1 loop
            if int_addr = std_logic_vector(to_unsigned(2 + i, 4)) then
              int_regs_wb_m_i.dat <= (others => '0');
              int_regs_wb_m_i.dat(31 downto 0) <= std_logic_vector(int_CR1_o);
              if int_regs_wb_m_o.we = '1' then
                int_CR1_o <= std_logic_vector(int_regs_wb_m_o.dat(31 downto 0));
              end if;
              int_regs_wb_m_i.ack <= '1';
              int_regs_wb_m_i.err <= '0';
            end if;
          end loop; -- g_CR1_size
          
          -- That's a single register that may be present (size=1) or not (size=0).
          -- The "for" loop works like "if".
          -- That's why we do not index the register inside the loop.
          for i in 0 to g_CTRL_size - 1 loop
            if int_addr = std_logic_vector(to_unsigned(3 + i, 4)) then
              int_regs_wb_m_i.dat <= (others => '0');
              int_regs_wb_m_i.dat(9 downto 0) <= to_slv(int_CTRL_o);
              if int_regs_wb_m_o.we = '1' then
                int_CTRL_o <= to_CTRL(int_regs_wb_m_o.dat(9 downto 0));
              end if;
              int_regs_wb_m_i.ack <= '1';
              int_regs_wb_m_i.err <= '0';
            end if;
          end loop; -- g_CTRL_size
          
          -- That's a single register that may be present (size=1) or not (size=0).
          -- The "for" loop works like "if".
          -- That's why we do not index the register inside the loop.
          for i in 0 to g_CR2_size - 1 loop
            if int_addr = std_logic_vector(to_unsigned(4 + i, 4)) then
              int_regs_wb_m_i.dat <= (others => '0');
              int_regs_wb_m_i.dat(31 downto 0) <= std_logic_vector(int_CR2_o);
              if int_regs_wb_m_o.we = '1' then
                int_CR2_o <= std_logic_vector(int_regs_wb_m_o.dat(31 downto 0));
              end if;
              int_regs_wb_m_i.ack <= '1';
              int_regs_wb_m_i.err <= '0';
            end if;
          end loop; -- g_CR2_size
          for i in 0 to g_TEST_OUT_size - 1 loop
            if int_addr = std_logic_vector(to_unsigned(5 + i, 4)) then
              int_regs_wb_m_i.dat <= (others => '0');
              int_regs_wb_m_i.dat(16 downto 0) <= std_logic_vector(int_TEST_OUT_o( i ));
              if int_regs_wb_m_o.we = '1' then
                int_TEST_OUT_o( i ) <= std_logic_vector(int_regs_wb_m_o.dat(16 downto 0));
              end if;
              int_regs_wb_m_i.ack <= '1';
              int_regs_wb_m_i.err <= '0';
            end if;
          end loop; -- g_TEST_OUT_size
          for i in 0 to g_TEST_IN_size - 1 loop
            if int_addr = std_logic_vector(to_unsigned(8 + i, 4)) then
              int_regs_wb_m_i.dat <= (others => '0');
              int_regs_wb_m_i.dat(15 downto 0) <= std_logic_vector(TEST_IN_i( i ));
              int_regs_wb_m_i.ack <= '1';
              int_regs_wb_m_i.err <= '0';
            end if;
          end loop; -- g_TEST_IN_size


          if int_addr = "0000" then
             int_regs_wb_m_i.dat <= x"89bd20d0";
             if int_regs_wb_m_o.we = '1' then
                int_regs_wb_m_i.err <= '1';
                int_regs_wb_m_i.ack <= '0';
             else
                int_regs_wb_m_i.ack <= '1';
                int_regs_wb_m_i.err <= '0';
             end if;
          end if;
          if int_addr = "0001" then
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
  CR1_o <= int_CR1_o;
  CTRL_o <= int_CTRL_o;
  CR2_o <= int_CR2_o;
  TEST_OUT_o <= int_TEST_OUT_o;
  bg1: if g_EXTHUGE_size > 0 generate
    wb_m_i(0) <= EXTHUGE_wb_m_i;
    EXTHUGE_wb_m_o  <= wb_m_o(0);
  end generate; -- g_EXTHUGE_size
  bg2: for i in 0 to g_EXTERN_size - 1 generate
    wb_m_i(1 + i) <= EXTERN_wb_m_i(i);
    EXTERN_wb_m_o(i)  <= wb_m_o(1 + i);
  end generate; -- for g_EXTERN_size
  bg3: for i in 0 to g_LINKS_size - 1 generate
    wb_m_i(5 + i) <= LINKS_wb_m_i(i);
    LINKS_wb_m_o(i)  <= wb_m_o(5 + i);
  end generate; -- for g_LINKS_size
  wb_m_i(36) <= int_regs_wb_m_i;
  int_regs_wb_m_o  <= wb_m_o(36);

end architecture;
