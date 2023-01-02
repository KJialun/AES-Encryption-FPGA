library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity One_Column is
    Port ( 
        clk, rst, en  : in STD_LOGIC;
        byte_in1      : in STD_LOGIC_VECTOR(7 downto 0);    --input 8 bits
        byte_in2      : in STD_LOGIC_VECTOR(7 downto 0);    --input 8 bits
        byte_in3      : in STD_LOGIC_VECTOR(7 downto 0);    --input 8 bits
        byte_in4      : in STD_LOGIC_VECTOR(7 downto 0);    --input 8 bits
        
        byte_out1      : out STD_LOGIC_VECTOR(7 downto 0);    --out 8 bits
        byte_out2      : out STD_LOGIC_VECTOR(7 downto 0);    --out 8 bits
        byte_out3      : out STD_LOGIC_VECTOR(7 downto 0);    --out 8 bits
        byte_out4      : out STD_LOGIC_VECTOR(7 downto 0)     --out 8 bits
      
    );
end One_Column;

architecture Beh of One_Column is
    
    component XOR_calc                                             --use the component
    Port ( 
        clk, rst, en  : in STD_LOGIC;
        byte_in1      : in STD_LOGIC_VECTOR(7 downto 0);    --input 8 bits
        byte_in2      : in STD_LOGIC_VECTOR(7 downto 0);    --input 8 bits
        byte_in3      : in STD_LOGIC_VECTOR(7 downto 0);    --input 8 bits
        byte_in4      : in STD_LOGIC_VECTOR(7 downto 0);    --input 8 bits
        xor_out       : out STD_LOGIC_VECTOR(7 downto 0)    --out 8 bits         
    );
    end component;
    
begin

row1 : XOR_calc port map (clk =>clk ,   rst=>rst,   en=>en,      byte_in1 => byte_in1,   byte_in2 => byte_in2,   byte_in3 => byte_in3,   byte_in4 => byte_in4,   xor_out => byte_out1);

row2 : XOR_calc port map (clk =>clk ,   rst=>rst,   en=>en,      byte_in1 => byte_in2,   byte_in2 => byte_in3,   byte_in3 => byte_in4,   byte_in4 => byte_in1,   xor_out => byte_out2);

row3 : XOR_calc port map (clk =>clk ,   rst=>rst,   en=>en,      byte_in1 => byte_in3,   byte_in2 => byte_in4,   byte_in3 => byte_in1,   byte_in4 => byte_in2,   xor_out => byte_out3);

row4 : XOR_calc port map (clk =>clk ,   rst=>rst,   en=>en,      byte_in1 => byte_in4,   byte_in2 => byte_in1,   byte_in3 => byte_in2,   byte_in4 => byte_in3,   xor_out => byte_out4);

end Beh;