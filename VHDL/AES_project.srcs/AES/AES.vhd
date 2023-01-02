
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AES is
  Port (
        clk, rst,en          : in STD_LOGIC;                        --clock and reset
        byte_in              : in STD_LOGIC_VECTOR(127 downto 0);   --input 128 bits
        byte_out             : out STD_LOGIC_VECTOR(127 downto 0) ;  --output 128 bits    
        status               : out STD_LOGIC := '0'
   );
end AES;

architecture Behavioral of AES is

    component add_round_key is port(
        clk, rst,en          : in STD_LOGIC;
        ark_byte_in          : in STD_LOGIC_VECTOR(127 downto 0);
        key                  : in STD_LOGIC_VECTOR(127 downto 0);
        ark_byte_out         : out STD_LOGIC_VECTOR(127 downto 0)
        );
    end component;
    
    component Nine_loop    is port(
        clk, rst,en          : in STD_LOGIC;                        --clock and reset
        byte_in              : in STD_LOGIC_VECTOR(127 downto 0);   --input 128 bits
        byte_out             : out STD_LOGIC_VECTOR(127 downto 0)   --output 128 bits
 );
    end component;
    
    component Three_step    is port(
        clk, rst,en          : in STD_LOGIC;                        --clock and reset
        byte_in              : in STD_LOGIC_VECTOR(127 downto 0);   --input 128 bits
        key                  : in STD_LOGIC_VECTOR(127 downto 0);   --key 128 bits
        byte_out             : out STD_LOGIC_VECTOR(127 downto 0)   --output 128 bits
 );
    end component;


    
signal order                     : STD_LOGIC_VECTOR(2   downto 0);

type mytype is array (1 downto 0) of std_logic_vector(127 downto 0);

signal key_array                 : mytype :=(
        0=>x"2b7e151628aed2a6abf7158809cf4f3c",
        1=>x"d014f9a8c9ee2589e13f0cc8b6630ca6"
);
    
signal internal_out              : mytype;
type counttype is (s1,s2,s3);
signal currentstate , nextstate : counttype;     
signal new_clk : STD_LOGIC := '0' ;
--signal status_nineloop  : STD_LOGIC ;
begin

            ADD    : add_round_key  port map(clk => clk, rst => rst, en=>order(0), ark_byte_in => byte_in,      ark_byte_out => internal_out(0) , key => key_array(0));
            Nine   : Nine_loop      port map(clk => clk, rst => rst, en=>order(1), byte_in => internal_out(0),  byte_out => internal_out(1));
            three  : Three_step     port map(clk => clk, rst => rst, en=>order(2), byte_in => internal_out(1),  byte_out => byte_out ,   key => key_array(1));
----------------------------------------------------------------           
   counter: process(clk)
    variable count: integer:= -1;
    begin
     if(rising_edge(clk)) and (en = '1') then
        new_clk <= '0';
        count := count + 1;      
        if (count = 1) then
            new_clk <= '1';
        end if;
        if (count = 37) then
            new_clk <= '1';          
        end if;  
        if (count = 40) then
            count :=0;
            new_clk <= '1';  
             status <='1';             
        end if;  
        if (rst = '1') then
           count := -1;
             status <='0';  
        end if;            
     end if;
     end process;
----------------------------------------------------------------
       fsm1: process (en , currentstate)
        begin 
          case currentstate is     
         
            when s1 => order <= (0 => '1', others => '0');
                   nextstate <= s2 ;
                                        
            when s2 => order <= (1 => '1', others => '0');
                   nextstate <= s3 ;
   
            when s3 => order <= (2 => '1', others => '0');
                   nextstate <= s1 ;  
                
--            when finish => order <= (others => '0');
----                   nextstate <= s1 ;  
                   
        end case;
        end process;
----------------------------------------------------------------        
        fsm2 : process (rst, new_clk)
            begin 
            if (rst = '1') then 
                 currentstate <= s1;                
                 elsif rising_edge(new_clk) then
                    if en = '1' then
                    currentstate <= nextstate; 
                    end if;  
            end if;
        end process;                 



end Behavioral;
