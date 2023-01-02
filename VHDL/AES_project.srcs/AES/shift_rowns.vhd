
library IEEE;                                               
use IEEE.STD_LOGIC_1164.ALL;


entity shift_rowns is
    Port (
        clk, rst,en            : in STD_LOGIC;
        sh_byte_in          : in STD_LOGIC_VECTOR(127 downto 0);
        sh_byte_out         : out STD_LOGIC_VECTOR(127 downto 0)
   );
end shift_rowns;

architecture Beh_shift_rowns of shift_rowns is

begin
    proc_shift_rowns : process(clk, rst)
    
        begin
            if (rst = '1') then
                sh_byte_out <= (others => '0'); --all output byte become 0
                
            elsif (rising_edge(clk)) and (rst = '0') then   --shift rowns
                     if (en = '1') then
                            -----first rows     
                            sh_byte_out(127 downto 120) <= sh_byte_in(127 downto 120);
                            sh_byte_out(95 downto 88) <= sh_byte_in(95 downto 88);
                            sh_byte_out(63 downto 56) <= sh_byte_in(63 downto 56);
                            sh_byte_out(31 downto 24) <= sh_byte_in(31 downto 24);
                            
                            -----second rows
                            sh_byte_out(119 downto 112) <= sh_byte_in(87 downto 80);
                            sh_byte_out(87 downto 80) <= sh_byte_in(55 downto 48);
                            sh_byte_out(55 downto 48) <= sh_byte_in(23 downto 16);
                            sh_byte_out(23 downto 16) <= sh_byte_in(119 downto 112);
                            
                            -----third rows
                            sh_byte_out(111 downto 104) <= sh_byte_in(47 downto 40);
                            sh_byte_out(79 downto 72) <= sh_byte_in(15 downto 8);
                            sh_byte_out(47 downto 40) <= sh_byte_in(111 downto 104);
                            sh_byte_out(15 downto 8) <= sh_byte_in(79 downto 72);
                            
                            -----fourth rows
                            sh_byte_out(103 downto 96) <= sh_byte_in(7 downto 0);
                            sh_byte_out(71 downto 64) <= sh_byte_in(103 downto 96);
                            sh_byte_out(39 downto 32) <= sh_byte_in(71 downto 64);
                            sh_byte_out(7 downto 0) <= sh_byte_in(39 downto 32);    
                    end if;
            end if;
        end process; 
        
end Beh_shift_rowns;
