
library IEEE;                                                               --have to change the clk cycle
use IEEE.STD_LOGIC_1164.ALL;

entity tb_add_round_key is
--  Port ( );
end tb_add_round_key;

architecture Beh_tb_add_round_key of tb_add_round_key is
    component add_round_key is port(
        clk, rst,en          : in STD_LOGIC;
        ark_byte_in          : in STD_LOGIC_VECTOR(127 downto 0);
        key                  : in STD_LOGIC_VECTOR(127 downto 0);
        ark_byte_out         : out STD_LOGIC_VECTOR(127 downto 0)
        );
    end component;
    
signal clk                   : STD_LOGIC := '1';
signal rst                   : STD_LOGIC := '1';
signal en                    : STD_LOGIC := '0';
signal ark_byte_in           :  STD_LOGIC_VECTOR(127 downto 0); --:= "01101011"; --6b in binary 6BC1BEE2 2E409F96 E93D7E11 7393172A
signal key                   :  STD_LOGIC_VECTOR(127 downto 0); --:= "00101011"; --2b in binary 2B7E1516 28AED2A6 ABF71588 09CF4F3C
signal ark_byte_out          :  STD_LOGIC_VECTOR(127 downto 0); --:= "00000000";

begin

uut : add_round_key port map(clk => clk,rst => rst,en=>en, ark_byte_in => ark_byte_in, ark_byte_out => ark_byte_out, key => key);
    
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
    ARK_proc : process
        begin
           
            ark_byte_in <= x"529F16C2978615CAE01AAE54BA1A2659";--"01101011";
            key         <= x"a0fafe1788542cb123a339392a6c7605";--"00101011";
            wait for 10 ns;
        end process;

end Beh_tb_add_round_key;