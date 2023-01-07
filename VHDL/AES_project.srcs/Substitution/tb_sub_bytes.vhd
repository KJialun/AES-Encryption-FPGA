library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_sub_bytes is
--  Port ( );
end tb_sub_bytes;

architecture Beh_tb_sub_bytes of tb_sub_bytes is
    component sub_bytes is port(
        clk, rst,en         : in STD_LOGIC;
        sb_byte_in          : in STD_LOGIC_VECTOR(127 downto 0); 
        sb_byte_out         : out STD_LOGIC_VECTOR(127 downto 0)
    );
    end component;
    
signal clk                  : STD_LOGIC := '1';
signal rst                  : STD_LOGIC := '1';
signal en                  : STD_LOGIC := '1';  
signal sb_byte_in           : STD_LOGIC_VECTOR(127 downto 0);
signal sb_byte_out          : STD_LOGIC_VECTOR(127 downto 0);
    
begin
    
    uut: sub_bytes port map(clk => clk, rst => rst,en=>en, sb_byte_in => sb_byte_in, sb_byte_out => sb_byte_out);
    
    clk_proc : process  --to control the clock signal
        begin
            clk <= NOT clk;
            wait for 5 ns;
        end process;
        
    RST_proc: process
        begin
            rst <= NOT rst;
            wait for 100 ns;
        end process;
    en_proc : process
        begin
            en <= NOT en;
            wait for 30 ns;
        end process; 
    
    SB_porc: process    --to control the input signal
        begin
            sb_byte_in <= x"40BFABF406EE4D3042CA6B997A5C5816";
            wait for 100 ns;
        end process;
        
end Beh_tb_sub_bytes;
