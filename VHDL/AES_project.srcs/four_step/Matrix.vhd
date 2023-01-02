library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mix_clolumn is
    Port ( 
        clk, rst, en  : in STD_LOGIC;
        Mix_byte_in      : in STD_LOGIC_VECTOR(127 downto 0);    --input 8 bits      
        Mix_byte_out     : out STD_LOGIC_VECTOR(127 downto 0)    --out 8 bits      
    );
end Mix_clolumn;

architecture Beh of Mix_clolumn is
    
    component One_Column                                             --use the component
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
    end component;
    
 
begin 

        Col: for i in 1 to 4 generate
            uut: One_Column port map(
                clk => clk,
                rst => rst, 
                en  => en ,
                byte_in1 => Mix_byte_in( 127- ((i-1)*8    + 24*(i-1)) downto 127- (i*8-1     + 24*(i-1)) ), --byte_in connect to component input
                byte_in2 => Mix_byte_in( 127- ((i-1)*8+8  + 24*(i-1)) downto 127- (i*8-1+8   + 24*(i-1)) ), --byte_in connect to component input
                byte_in3 => Mix_byte_in( 127- ((i-1)*8+16 + 24*(i-1)) downto 127- (i*8-1+16  + 24*(i-1)) ), --byte_in connect to component input
                byte_in4 => Mix_byte_in( 127- ((i-1)*8+24 + 24*(i-1)) downto 127- (i*8-1+24  + 24*(i-1)) ), --byte_in connect to component input
                                
                byte_out1 => Mix_byte_out( 127- ((i-1)*8    + 24*(i-1)) downto 127- (i*8-1     + 24*(i-1)) ), --byte_in connect to component input
                byte_out2 => Mix_byte_out( 127- ((i-1)*8+8  + 24*(i-1)) downto 127- (i*8-1+8   + 24*(i-1)) ), --byte_in connect to component input
                byte_out3 => Mix_byte_out( 127- ((i-1)*8+16 + 24*(i-1)) downto 127- (i*8-1+16  + 24*(i-1)) ), --byte_in connect to component input
                byte_out4 => Mix_byte_out( 127- ((i-1)*8+24 + 24*(i-1)) downto 127- (i*8-1+24  + 24*(i-1)) ) --byte_in connect to component input
                                            
            ); 
        end generate Col;

end Beh;