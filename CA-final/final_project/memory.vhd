
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- ram is 512 words and page size is 128B.so page size need 7 bits.
-- virtual address is 16 bits.7 needed for page offset and 9 for vpn.
-- every amount of vpn refers to a row in page table so we need 2^9 line in page table
-- every row has a valid bit and ppn and we asume that ppn is 7 bits and with valid we have 8 bits
-- Finally we 8 bit and 2^9 rows that leads to 2^12 bit in page table
-- 2^12 / 2^5 = 2^7 that is number of the words in page table
-- size of ram is 512 words and size page table 128 words --> 512 - 128 = 384 words
-- 384 is count of words in data
-- 384 / 32(size of every page) = 12 that is count of blocks of data that we have

package MemoryType is
Type return_page is array (15 Downto 0) of std_logic_vector(63 Downto 0);
Type block_pages is array (11 Downto 0) of return_page; 
end package MemoryType;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.StorageType.all;


entity memory is
	port(
		check_bit : IN std_logic; --0 or 1 to know if the data is in the memory or not
		physical_address : IN std_logic_vector(13 downto 0); -- 7 bit for ppn and 7 bit for page offset 
		reading_from_disk : IN retuen_page;
		memory_data : OUT std_logic_vector(63 downto 0); 
	);
end memory;

architecture Behavioral of memory is

begin
process(check_bit, physical_address)
	variable block_index : integer := 0;
	variable blocks_of_data : block_pages;
	variable page_offset : Integer;
	variable ppn : integer;
	variable memory_page : return_page;
	begin
		
		if check_bit = 0 then 
			page_offset := to_integer(unsigned(physical_address(6 downto 0)));
			ppn := to_integer(unsigned(physical_address(13 downto 7)));
			memory_page := blocks_of_data(ppn);
			memory_data <= memory_page(page_offset);
		else:
			blocks_of_data(counter) := reading_from_disk;
			counter := counter + 1;
			if counter > 12 then
				counter := counter % 12;
			end if;
		end if;
	end process;
end Behavioral;

