library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Four_step is
Port (
        clk, rst,en          : in STD_LOGIC;                        --clock and reset
        byte_in              : in STD_LOGIC_VECTOR(127 downto 0);   --input 128 bits
        key                  : in STD_LOGIC_VECTOR(127 downto 0);   --key 128 bits
        byte_out             : out STD_LOGIC_VECTOR(127 downto 0)   --output 128 bits

 );
end Four_step;

architecture Behavioral of Four_step is


    component sub_bytes    is port(
        clk, rst,en          : in STD_LOGIC;
        sb_byte_in           : in STD_LOGIC_VECTOR(127 downto 0); 
        sb_byte_out          : out STD_LOGIC_VECTOR(127 downto 0)
    );
    end component;
    
    component shift_rowns  is port(
        clk, rst , en        : in STD_LOGIC;
        sh_byte_in           : in STD_LOGIC_VECTOR(127 downto 0);       
        sh_byte_out          : out STD_LOGIC_VECTOR(127 downto 0)
    );
    end component;
    
    component Mix_clolumn  is Port(
        clk, rst,en          : in STD_LOGIC;
        Mix_byte_in          : in STD_LOGIC_VECTOR(127 downto 0);        
        Mix_byte_out         : out STD_LOGIC_VECTOR(127 downto 0)         
        );
    end component;
    
    component add_round_key is port(
        clk, rst,en          : in STD_LOGIC;
        ark_byte_in          : in STD_LOGIC_VECTOR(127 downto 0);
        key                  : in STD_LOGIC_VECTOR(127 downto 0);
        ark_byte_out         : out STD_LOGIC_VECTOR(127 downto 0)
        );
    end component;   
signal sb_byte_out           : STD_LOGIC_VECTOR(127 downto 0);
signal sh_byte_out           : STD_LOGIC_VECTOR(127 downto 0);
signal Mix_byte_out          : STD_LOGIC_VECTOR(127 downto 0);
signal order                 : STD_LOGIC_VECTOR(3   downto 0);
 type counttype is (idle,s1,s2,s3,s4);
 signal currentstate : counttype := idle;
 signal  nextstate : counttype;
        begin
            Sub  : sub_bytes     port map(clk => clk, rst => rst, en=>order(0), sb_byte_in => byte_in,       sb_byte_out => sb_byte_out);
            Shift: shift_rowns   port map(clk => clk, rst => rst, en=>order(1), sh_byte_in => sb_byte_out,   sh_byte_out => sh_byte_out);
            Mix  : Mix_clolumn   port map(clk => clk, rst => rst, en=>order(2), Mix_byte_in => sh_byte_out,  Mix_byte_out => Mix_byte_out );
            Add  : add_round_key port map(clk => clk, rst => rst, en=>order(3), ark_byte_in => Mix_byte_out, ark_byte_out => byte_out, key => key);
       fsm1: process (en , currentstate)
        begin 
          case currentstate is 
            when idle => order <= (others => '0');
                   nextstate <= s1 ;         
            when s1 => order <= (0 => '1', others => '0');
                   nextstate <= s2 ;
            when s2 => order <= (1 => '1', others => '0');
                   nextstate <= s3 ;

            when s3 => order <= (2 => '1', others => '0');
                   nextstate <= s4 ;
                   
            when s4 => order <= (3 => '1', others => '0');
                   nextstate <= idle ;           
        end case;
        end process;
        
        fsm2 : process (rst, clk)
            begin 
            if (rst = '1') then 
                 currentstate <= idle;
                 elsif rising_edge(clk) then
                    if en = '1' then
                    currentstate <= nextstate; 
                    end if;  
            end if;
        end process;                 
end Behavioral;
