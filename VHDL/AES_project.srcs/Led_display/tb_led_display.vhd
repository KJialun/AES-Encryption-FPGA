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

entity tb_led_display is
--  Port ( );
end tb_led_display;

architecture Beh_tb_led_display of tb_led_display is
component led_display is port(
    clk,status                                        : in STD_LOGIC;
    compare_res                                       : in STD_LOGIC;
    seg0, seg1, seg2, seg3, seg4, seg5, seg6          : out STD_LOGIC;
    dp                                                : out STD_LOGIC;
    an0, an1, an2, an3                                : out STD_LOGIC
);end component;

signal clk,status                                        : STD_LOGIC := '1';
signal seg0, seg1, seg2, seg3, seg4, seg5, seg6          : STD_LOGIC;
signal dp                                                : STD_LOGIC;
signal an0, an1, an2, an3                                : STD_LOGIC;
signal compare_res                                       : STD_LOGIC := '1';
begin

uut: led_display port map(clk => clk, status => status, compare_res => compare_res,
                          seg0 => seg0, seg1 => seg1, seg2 => seg2, seg3 => seg3, seg4 => seg4, seg5 => seg5, seg6 => seg6, dp => dp, 
                          an0 => an0, an1 => an1, an2 => an2, an3 => an3);

    clk_pro:process
    begin
        clk <= not clk;
        wait for 5 ns;
    end process;
    
    sta_pro:process
    begin
        status <= not status;
        wait for 400 ms;
    end process;
    
    com_pro:process
    begin
        compare_res <= not compare_res;
        wait for 100 ms;
    end process;

end Beh_tb_led_display;
