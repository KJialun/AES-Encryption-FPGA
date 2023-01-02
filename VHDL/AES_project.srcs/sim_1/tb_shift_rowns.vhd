
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_shift_rowns is
--  Port ( );
end tb_shift_rowns;

architecture Beh_tb_shift_rowns of tb_shift_rowns is
    component shift_rowns is port(
        clk, rst , en            : in STD_LOGIC;
        sh_byte_in          : in STD_LOGIC_VECTOR(127 downto 0);       
        sh_byte_out         : out STD_LOGIC_VECTOR(127 downto 0)
    );
    end component;
    
signal clk                  : STD_LOGIC := '1';
signal rst                  : STD_LOGIC := '1';
signal en                   : STD_LOGIC := '1';
signal sh_byte_in           : STD_LOGIC_VECTOR(127 downto 0);
signal sh_byte_out          : STD_LOGIC_VECTOR(127 downto 0);
    
begin

uut : shift_rowns port map(clk => clk, rst => rst, en=>en, sh_byte_in => sh_byte_in, sh_byte_out => sh_byte_out);

    clk_proc : process
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
           
    SR_proc: process
        begin
            sh_byte_in <= --x"74A6A4ADEEF747C2403E82F6FB268090";
            x"090862BF6F28E3042C747FEEDA4A6A47";
            wait for 10 ns;
        end process;
 
end Beh_tb_shift_rowns;
