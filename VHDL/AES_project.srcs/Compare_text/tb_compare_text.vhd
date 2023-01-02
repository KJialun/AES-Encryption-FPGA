----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/15/2022 12:36:06 PM
-- Design Name: 
-- Module Name: tb_led_display - Beh_tb_led_display
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_compare_text is
--  Port ( );
end tb_compare_text;

architecture Beh_tb_compare_text of tb_compare_text is
component compare_text is port(
    clk                                      : in STD_LOGIC;
    cipher_in                                : in STD_LOGIC_VECTOR(127 downto 0);
    result                                   : out STD_LOGIC -- 1 when correct, 0 when false. 
);end component;

signal clk                                   : STD_LOGIC := '1';
signal cipher_in                             : STD_LOGIC_VECTOR(127 downto 0);
signal result                                : STD_LOGIC;

begin

uut: compare_text port map(clk => clk, cipher_in => cipher_in, result => result);

    clk_pro:process
    begin
        clk <= not clk;
        wait for 5 ns;
    end process;
    
    cipher_pro:process
    begin
        cipher_in <= x"3AD77BB40D7A3660A89ECAF32466EF97";
        wait for 40 ns;
        cipher_in <= x"AE2D8A571E03AC9C9EB76FAC45AF8E51";
        wait for 40 ns;
        cipher_in <= x"00000000000000000000000000000000";
        wait for 40 ns;
    end process;

end Beh_tb_compare_text;
