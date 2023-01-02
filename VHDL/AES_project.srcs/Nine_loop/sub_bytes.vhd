library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sub_bytes is
    Port ( 
        clk, rst,en        : in STD_LOGIC;                         --clock and reset
        sb_byte_in         : in STD_LOGIC_VECTOR(127 downto 0);    --input 128 bits       
        sb_byte_out        : out STD_LOGIC_VECTOR(127 downto 0)    --output 128 bits
    );
end sub_bytes;

architecture Beh_sub_bytes of sub_bytes is
    
    component S_box                                             --use the component
        port( 
            byte_in     : in STD_LOGIC_VECTOR (7 downto 0);
            byte_out    : out STD_LOGIC_VECTOR (7 downto 0);           
            clk, rst,en : in STD_LOGIC
        );
    end component;
   
begin
        GEN1: for i in 1 to 16 generate
            uut: S_box port map(                
                clk => clk, 
                rst=> rst, 
                en => en,      
                byte_in => sb_byte_in(i * 8-1 downto (i-1) * 8),             
                byte_out => sb_byte_out(i * 8-1 downto (i-1) * 8)
            ); 
        end generate GEN1;
end Beh_sub_bytes;
