library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_AES is
--  Port ( );
end tb_AES;

architecture Beh of tb_AES is

    component AES is port(
        clk, rst,en          : in STD_LOGIC;                        --clock and reset
        byte_in              : in STD_LOGIC_VECTOR(127 downto 0);   --input 128 bits
        byte_out             : out STD_LOGIC_VECTOR(127 downto 0);   --output 128 bits  
        status               : out STD_LOGIC  
    );
    end component;
    
signal clk                    : STD_LOGIC := '0';
signal rst                    : STD_LOGIC := '1';
signal en                     : STD_LOGIC := '0';  
signal status                 : STD_LOGIC := '0';  
signal test_byte_in           : STD_LOGIC_VECTOR(127 downto 0);
signal test_byte_out          : STD_LOGIC_VECTOR(127 downto 0);

begin
    
    uut: AES port map(clk => clk, rst => rst, en=>en, byte_in => test_byte_in, byte_out => test_byte_out , status=>status);
    
    clk_proc : process  --to control the clock signal
        begin
            clk <= NOT clk;
            wait for 5 ns;
        end process;
        
    RST_proc: process
        begin
            rst <= NOT rst;
            wait for 500 ns;
        end process;
    en_proc : process
        begin
            en <= NOT en;
--            en <='1';
            wait for 1000 ns;
        end process; 
    
    SB_porc: process    --to control the input signal
        begin
            test_byte_in <= x"6BC1BEE22E409F96E93D7E117393172A";
           wait for 100 ns;
        end process;
        
end Beh;

