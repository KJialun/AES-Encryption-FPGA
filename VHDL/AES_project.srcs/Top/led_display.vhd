library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity led_display is
  Port (
  clk                                       : in STD_LOGIC;
  compare_res:in std_logic;
  status:in std_logic;
  seg0, seg1, seg2, seg3, seg4, seg5, seg6          : out STD_LOGIC;
  dp                                                : out STD_LOGIC;
  an0, an1, an2, an3                                : out STD_LOGIC
   );                                                           
end led_display;                                        
                                                                
architecture Beh_led_display of led_display is              
    type state_type is (s0, s1, s2, s3);                
    signal c_state, n_state                         : state_type;  
      
    signal new_clk                                  : STD_LOGIC := '0';
    signal an_vector                                : STD_LOGIC_VECTOR(3 downto 0);
begin

    clk1: process(clk)
    variable count: integer:= 0;
    begin
        if(rising_edge(clk)) then
            count := count + 1;
            if (count = 80000) then
                count :=0;
                new_clk <= not new_clk;
            end if;
         end if;
     end process;
     
     
      REG: process(new_clk)    
     begin
        if(rising_edge(new_clk))then     
            c_state <= n_state;
       end if;
     end process;
    
     
         COM1: process(c_state,status)
         begin
         if(status = '1') and (compare_res = '1')then --finished with correct answer
         --if(btnC = '1')then 
            case c_state is
                when s0 => an_vector <= (0 => '0', others => '1'); n_state <= s1; seg0 <= '1'; seg1 <= '1'; seg2 <= '1'; seg3 <= '1'; seg4 <= '0'; seg5 <= '0'; seg6 <= '1'; dp <= '1'; 
                when s1 => an_vector <= (1 => '0', others => '1'); n_state <= s2; seg0 <= '0'; seg1 <= '1'; seg2 <= '0'; seg3 <= '0'; seg4 <= '1'; seg5 <= '0'; seg6 <= '0'; dp <= '0'; 
                when s2 => an_vector <= (2 => '0', others => '1'); n_state <= s3; seg0 <= '0'; seg1 <= '1'; seg2 <= '1'; seg3 <= '0'; seg4 <= '0'; seg5 <= '0'; seg6 <= '0'; dp <= '0'; 
                when s3 => an_vector <= (3 => '0', others => '1'); n_state <= s0; seg0 <= '0'; seg1 <= '0'; seg2 <= '0'; seg3 <= '1'; seg4 <= '0'; seg5 <= '0'; seg6 <= '0'; dp <= '0'; 
            end case; 
          elsif(status = '1') and (compare_res = '0')then  --finished with false answer
         --if(btnC = '1')then 
            case c_state is
                when s0 => an_vector <= (0 => '0', others => '1'); n_state <= s1; seg0 <= '1'; seg1 <= '1'; seg2 <= '1'; seg3 <= '1'; seg4 <= '0'; seg5 <= '1'; seg6 <= '0'; dp <= '1'; 
                when s1 => an_vector <= (1 => '0', others => '1'); n_state <= s2; seg0 <= '1'; seg1 <= '1'; seg2 <= '1'; seg3 <= '1'; seg4 <= '0'; seg5 <= '1'; seg6 <= '0'; dp <= '0'; 
                when s2 => an_vector <= (2 => '0', others => '1'); n_state <= s3; seg0 <= '1'; seg1 <= '1'; seg2 <= '1'; seg3 <= '1'; seg4 <= '0'; seg5 <= '1'; seg6 <= '0'; dp <= '0'; 
                when s3 => an_vector <= (3 => '0', others => '1'); n_state <= s0; seg0 <= '1'; seg1 <= '1'; seg2 <= '1'; seg3 <= '1'; seg4 <= '0'; seg5 <= '1'; seg6 <= '0'; dp <= '0'; 
            end case; 
          elsif(status = '0')then  --unfinished
   --elsif(btnC = '0')then 
            case c_state is
                when s0 => an_vector <= (0 => '0', others => '1'); n_state <= s1; seg0 <= '0'; seg1 <= '0'; seg2 <= '0'; seg3 <= '0'; seg4 <= '0'; seg5 <= '0'; seg6 <= '1'; dp <= '0'; 
                when s1 => an_vector <= (1 => '0', others => '1'); n_state <= s2; seg0 <= '0'; seg1 <= '0'; seg2 <= '0'; seg3 <= '0'; seg4 <= '0'; seg5 <= '0'; seg6 <= '1'; dp <= '0'; 
                when s2 => an_vector <= (2 => '0', others => '1'); n_state <= s3; seg0 <= '0'; seg1 <= '0'; seg2 <= '0'; seg3 <= '0'; seg4 <= '0'; seg5 <= '0'; seg6 <= '1'; dp <= '0'; 
                when s3 => an_vector <= (3 => '0', others => '1'); n_state <= s0; seg0 <= '0'; seg1 <= '0'; seg2 <= '0'; seg3 <= '0'; seg4 <= '0'; seg5 <= '0'; seg6 <= '1'; dp <= '0'; 
            end case; 
           else     --others
           case c_state is
                when s0 => an_vector <= (0 => '0', others => '1'); n_state <= s1; seg0 <= '1'; seg1 <= '1'; seg2 <= '1'; seg3 <= '1'; seg4 <= '1'; seg5 <= '0'; seg6 <= '0'; dp <= '1'; 
                when s1 => an_vector <= (1 => '0', others => '1'); n_state <= s2; seg0 <= '1'; seg1 <= '1'; seg2 <= '1'; seg3 <= '1'; seg4 <= '1'; seg5 <= '0'; seg6 <= '0'; dp <= '1'; 
                when s2 => an_vector <= (2 => '0', others => '1'); n_state <= s3; seg0 <= '1'; seg1 <= '1'; seg2 <= '1'; seg3 <= '1'; seg4 <= '1'; seg5 <= '0'; seg6 <= '0'; dp <= '1'; 
                when s3 => an_vector <= (3 => '0', others => '1'); n_state <= s0; seg0 <= '1'; seg1 <= '1'; seg2 <= '1'; seg3 <= '1'; seg4 <= '1'; seg5 <= '0'; seg6 <= '0'; dp <= '1'; 
            end case; 
            end if;
         end process;
         an0 <= an_vector(0);
         an1 <= an_vector(1);
         an2 <= an_vector(2);
         an3 <= an_vector(3);
         
     --verified use btnC button as status, 
     --after everythings' done, just change btnC into status;
    
end Beh_led_display;