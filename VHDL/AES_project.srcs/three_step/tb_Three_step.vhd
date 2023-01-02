library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_Three_step is
--  Port ( );
end tb_Three_step;

architecture Beh of tb_Three_step is

    component Three_step is port(
        clk, rst,en          : in STD_LOGIC;                        --clock and reset
        byte_in              : in STD_LOGIC_VECTOR(127 downto 0);   --input 128 bits
        key                  : in STD_LOGIC_VECTOR(127 downto 0);   --key 128 bits
        byte_out             : out STD_LOGIC_VECTOR(127 downto 0)   --output 128 bits
    );
    end component;
    
signal clk                    : STD_LOGIC := '0';
signal rst                    : STD_LOGIC := '1';
signal en                     : STD_LOGIC := '0';  
signal test_byte_in           : STD_LOGIC_VECTOR(127 downto 0);
signal test_byte_out          : STD_LOGIC_VECTOR(127 downto 0);
signal key                    : STD_LOGIC_VECTOR(127 downto 0); --:= "00101011"; --2b in binary 2B7E1516 28AED2A6 ABF71588 09CF4F3C    


begin
    
    uut: Three_step port map(clk => clk, rst => rst, en=>en, byte_in => test_byte_in, byte_out => test_byte_out , key=>key);
    
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
            wait for 50 ns;
        end process; 
    
    SB_porc: process    --to control the input signal
        begin
            test_byte_in <= x"BB36C7EB88334D49A4E7112E74F182C4";
            key          <= x"d014f9a8c9ee2589e13f0cc8b6630ca6";--"00101011";
            wait for 100 ns;
        end process;
        
end Beh;

