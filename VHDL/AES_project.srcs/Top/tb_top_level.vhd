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

entity tb_top_level  is
--  Port ( );
end tb_top_level ;

architecture Behavioral of tb_top_level is
component top_level is port(
    btnR, clk, btnC                                   : in std_logic;   --btnR for restart, btnC for enable
   -- plain_text                                        : in std_logic_vector(127 downto 0);
    
    --ciphered                                          : out std_logic_vector(31 downto 0);
   -- states:inout std_logic;
    seg0, seg1, seg2, seg3, seg4, seg5, seg6          : out STD_LOGIC;
    dp                                                : out STD_LOGIC;
    an0, an1, an2, an3                                : out STD_LOGIC
);end component;

signal clk, btnC                                   : STD_LOGIC := '0';
signal btnR                                                 : STD_LOGIC := '0';
--signal plain_text                                        : STD_LOGIC_vector(127 downto 0);
signal seg0, seg1, seg2, seg3, seg4, seg5, seg6          : STD_LOGIC;
signal dp                                                : STD_LOGIC;
signal an0, an1, an2, an3                                : STD_LOGIC;

begin

uut: top_level port map(clk => clk, btnR => btnR, btnC => btnC, --plain_text => plain_text, 
                          seg0 => seg0, seg1 => seg1, seg2 => seg2, seg3 => seg3, seg4 => seg4, seg5 => seg5, seg6 => seg6, dp => dp, 
                          an0 => an0, an1 => an1, an2 => an2, an3 => an3);

    clk_pro:process
    begin
        clk <= not clk;
        wait for 5 ns;
    end process;
    
--    btnR_pro:process
--    begin
--        wait for 10 ns;
--        btnR <= not btnR;
--        wait for 5 ms;
--    end process;
    
    btnC_pro:process
    begin
        btnC <= not btnC;
        wait for 5 ms;
    end process;
    
--    input_pro:process
--    begin
--        plain_text <= x"6BC1BEE22E409F96E93D7E117393172A";
--        wait for 1 ms;
--        plain_text <= x"AE2D8A571E03AC9C9EB76FAC45AF8E51";
--        wait for 1 ms;
--        plain_text <= x"30C81C46A35CE411E5FBC1191A0A52EF";
--        wait for 1 ms;
--        plain_text <= x"F69F2445DF4F9B17AD2B417BE66C3710";
--        wait for 1 ms;
--    end process;

end Behavioral;
