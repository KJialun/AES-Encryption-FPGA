library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity XOR_calc is
    Port ( 
        clk, rst, en  : in STD_LOGIC;
        byte_in1      : in STD_LOGIC_VECTOR(7 downto 0);    --input 8 bits
        byte_in2      : in STD_LOGIC_VECTOR(7 downto 0);    --input 8 bits
        byte_in3      : in STD_LOGIC_VECTOR(7 downto 0);    --input 8 bits
        byte_in4      : in STD_LOGIC_VECTOR(7 downto 0);    --input 8 bits
        xor_out       : out STD_LOGIC_VECTOR(7 downto 0) --:= x"ff"   --input 8 bits         
    );
end XOR_calc;

architecture Beh of XOR_calc is
    
    component LUT_mul2                                             --use the component
        port( 
            byte_in : in STD_LOGIC_VECTOR (7 downto 0);
            byte_out : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;
    
    component LUT_mul3                                             --use the component
        port( 
            byte_in : in STD_LOGIC_VECTOR (7 downto 0);
            byte_out : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

signal  byte_out1      :  STD_LOGIC_VECTOR(7 downto 0);    --internal 8 bits
signal  byte_out2      :  STD_LOGIC_VECTOR(7 downto 0);    --internal 8 bits
signal  byte_out3      :  STD_LOGIC_VECTOR(7 downto 0);    --internal 8 bits
signal  byte_out4      :  STD_LOGIC_VECTOR(7 downto 0);    --internal 8 bits     

begin

Mul2 : LUT_mul2 port map (byte_in => byte_in1,byte_out => byte_out1);
Mul3 : LUT_mul3 port map (byte_in => byte_in2,byte_out => byte_out2);
byte_out3 <= byte_in3;
byte_out4 <= byte_in4;



 Xor_calc : process(clk, rst)
    begin
        if (rst = '1') then
        xor_out <= (others => '0'); --all output byte become 0
        elsif (rising_edge(clk)) and (rst = '0') then   --shift rowns
            if (en = '1') then
                xor_out <= byte_out1 xor byte_out2 xor byte_out3 xor byte_out4; 
            end if;      
        end if;
    end process; 


end Beh;
