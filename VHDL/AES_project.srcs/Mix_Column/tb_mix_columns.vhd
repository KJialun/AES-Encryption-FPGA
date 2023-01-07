library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_mix_columns is
--  Port ( );
end tb_mix_columns;

architecture Beh_tb_mix_columns of tb_mix_columns is
    component Matrix is 
    Port ( 
        clk, rst,en  : in STD_LOGIC;
        byte_in      : in STD_LOGIC_VECTOR(127 downto 0);    --input 8 bits      
        Calc_out     : out STD_LOGIC_VECTOR(127 downto 0)    --out 8 bits      
    );
    end component;
    
signal clk                  : STD_LOGIC := '0';
signal rst                  : STD_LOGIC := '1';    
signal en                   : STD_LOGIC := '0'; 
signal mc_byte_in           : STD_LOGIC_VECTOR(127 downto 0);
signal mc_byte_out          : STD_LOGIC_VECTOR(127 downto 0);



begin

    uut: Matrix port map( clk => clk, rst => rst, en=>en, byte_in => mc_byte_in, Calc_out => mc_byte_out );

    clk_proc : process
        begin
            clk <= NOT clk;
            wait for 5 ns;
        end process;
        
    en_proc : process
        begin
            en <= NOT en;
            wait for 30 ns;
        end process;        
    RST_proc: process
        begin
             
             rst <= NOT rst;
             wait for 150 ns;
        end process;
        
    MC_proc: process
        begin
            mc_byte_in <= x"09287F476F746ABF2C4A6204DA08E3EE";
            wait for 100 ns;
        end process;

end Beh_tb_mix_columns;
