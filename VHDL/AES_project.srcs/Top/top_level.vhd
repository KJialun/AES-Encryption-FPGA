----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/15/2022 02:53:13 PM
-- Design Name: 
-- Module Name: toptop - Behavioral
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

entity top_level is
  Port (
    btnR, clk, btnC                                   : in std_logic;   --btnR for restart, btnC for enable
    --plain_text                                        : in std_logic_vector(127 downto 0);
    
    --ciphered                                          : out std_logic_vector(31 downto 0);
   -- states:inout std_logic;
    seg0, seg1, seg2, seg3, seg4, seg5, seg6          : out STD_LOGIC;
    dp                                                : out STD_LOGIC;
    an0, an1, an2, an3                                : out STD_LOGIC
   );
end top_level;

architecture Behavioral of top_level is

component AES is port(
        clk, rst,en          : in STD_LOGIC;                        --clock and reset
        byte_in              : in STD_LOGIC_VECTOR(127 downto 0);   --input 128 bits
        byte_out             : out STD_LOGIC_VECTOR(127 downto 0) ;  --output 128 bits    
        status               : out STD_LOGIC := '0'
);end component;

component led_display is port(
  clk                                               : in STD_LOGIC;
  compare_res                                       : in STD_LOGIC;
  status                                            : in STD_LOGIC;
  seg0, seg1, seg2, seg3, seg4, seg5, seg6          : out STD_LOGIC;
  dp                                                : out STD_LOGIC;
  an0, an1, an2, an3                                : out STD_LOGIC
);end component;

component compare_text is port(
    clk                                       : in STD_LOGIC;
    cipher_in                                 : in STD_LOGIC_VECTOR(127 downto 0);
    result                                    : out STD_LOGIC -- 1 when correct, 0 when false. 
);end component;

signal states : std_logic;  --signal between AES_state and LEDdisplay_status

--signal states1 :std_logic:='1';
--signal compare1:std_logic_vector:=x"3AD77BB40D7A3660A89ECAF32466EF97";

signal compare: std_logic;  --signal between compare_result and LEDdisplay_compare_res
signal ciphered:std_logic_vector(127 downto 0):=(others => '0');  --signal between AES_byte_out and compare_result
signal plain_text: std_logic_vector(127 downto 0):=x"6BC1BEE22E409F96E93D7E117393172A";

begin
uut1: AES          port map(clk => clk, rst => btnR, en => btnC, byte_in => plain_text, byte_out => ciphered, status => states); --checked   --state missed
uut2: led_display  port map(clk => clk, status => states,
                            compare_res => compare,
                            seg0 => seg0, seg1 => seg1, seg2 => seg2, seg3 => seg3, seg4 => seg4, seg5 => seg5, seg6 => seg6, 
                            dp => dp, 
                            an0 => an0, an1 => an1, an2 => an2, an3 => an3);
uut3: compare_text port map(clk => clk, cipher_in => ciphered, result => compare);
end Behavioral;
