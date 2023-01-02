library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity compare_text is
  Port (
    clk                                       : in STD_LOGIC;
    cipher_in                                 : in STD_LOGIC_VECTOR(127 downto 0);
    result                                    : out STD_LOGIC -- 1 when correct, 0 when false. 
   );                                                           
end compare_text;                                        
                                                                
architecture Beh_compare_text of compare_text is         
begin
    proc: process(clk, cipher_in)
    begin
        if(rising_edge(clk))then
            case cipher_in is
                when  x"3AD77BB40D7A3660A89ECAF32466EF97" => result <= '1';
                when  x"F5D3D58503B9699DE785895A96FDBAAF" => result <= '1';
                when  x"43B1CD7F598ECE23881B00E3ED030688" => result <= '1';
                when  x"7B0C785E27E8AD3F8223207104725DD4" => result <= '1';
                when  x"6BC1BEE22E409F96E93D7E117393172A" => result <= '1';
                when  x"AE2D8A571E03AC9C9EB76FAC45AF8E51" => result <= '1';
                when  x"30C81C46A35CE411E5FBC1191A0A52EF" => result <= '1';
                when  x"F69F2445DF4F9B17AD2B417BE66C3710" => result <= '1';
                when others => result <= '0';
            end case;
        end if;    
    end process;
end Beh_compare_text;