library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity add_round_key is
    Port (
        clk, rst,en          : in STD_LOGIC;                        --clock and reset
        ark_byte_in          : in STD_LOGIC_VECTOR(127 downto 0);   --input 128 bits
        key                  : in STD_LOGIC_VECTOR(127 downto 0);   --key 128 bits
        ark_byte_out         : out STD_LOGIC_VECTOR(127 downto 0)   --output 128 bits
     );
end add_round_key;

architecture Beh_add_round_key of add_round_key is

begin
    proc_add_round_key : process(clk, rst)
    
    variable num_of_bit: integer:= 0;       --decide which bits should be XOR by the corrospending keys
    
        begin
            if (rst = '1') then
                ark_byte_out <= x"00000000000000000000000000000000";    --if rst is 1 then reset
            elsif(rst = '0') and (rising_edge(clk)) then
              if (en = '1') then
                    for num_of_bit in 0 to 127 loop
                        ark_byte_out(num_of_bit) <= ark_byte_in(num_of_bit) XOR key(num_of_bit);    --operate XOR caculate(bit by bit)
                    end loop;
                    num_of_bit := 0;
               end if;
            end if;   
        end process;

end Beh_add_round_key;