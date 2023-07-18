
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_Std.ALL;



entity Processor is
	port(
		i: IN STD_LOGIC_VECTOR(4 Downto 0); -- choose one of the 8 addresses below to translate
		Output: OUT STD_LOGIC_VECTOR(15 Downto 0));
end Processor;

architecture Behavioral of Processor is

begin
process(i)
		Variable input:Integer; 
		Type virtual_array_of_addresses is array (31 Downto 0) of std_logic_vector(15 Downto 0);
		Variable Addresses: virtual_array_of_addresses;
		
		begin
		input := to_integer(unsigned(i));
		Addresses := ("1101001110001101"
							,"0111010001101111"
							,"1111011011001110"
							,"1010010110011001"
							,"1101011111011100"
							,"0110101011100001"
							,"1001111011011000"
							,"0010001011110100"
							,"1100100001011010"
							,"1101111110100111"
							,"1100100111110101"
							,"0010001010010010"
							,"0110101111010110"
							,"0011010111000111"
							,"1001000001010011"
							,"1011101100100111"
							,"1010101011111000"
							,"0010001101100101"
							,"0000100000011110"
							,"0101011001100111"
							,"1100010111000010"
							,"1100001000110100"
							,"0101101111010110"
							,"1000010101110010"
							,"1100100001011101"
							,"1001000101100110"
							,"1011010000010111"
							,"0100110011001111"
							,"1000010101111101"
							,"0010101100111010"
							,"0001111111111101"
							,"1000101010011111");
		Output <= Addresses(input);
	end process;
end Behavioral;

