
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package CacheType is
Type cache_data is array (31 Downto 0) of std_logic_vector(63 Downto 0);
type tag_data is array (31 downto 0) of std_logic_vector(5 downto 0);
end package CacheType;

-- 2 bit for byte offset 
-- 1 bit for word offset 
-- 5 bit for index because we have 32 entries 
-- 6 bit for tag


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.StorageType.all;
-- Direct Mapped Cache 

entity Cache is
	port(
		check_cache : IN std_logic; 
		physical_address : IN std_logic_vector(13 downto 0); 
		read_memory : IN std_logic_vector(63 downto 0);
		byte_data : OUT std_logic_vector(7 downto 0)
		hit : OUT std_logic
	);
end Cache;

architecture Behavioral of Cache is

begin
process(check_cache, physical_address)
	variable cache_inside : cache_data := (others =>(others => '0'));
	variable tag_inside : tag_data := (others =>(others => '0'));
	variable cache_valid : std_logic_vector(31 downto 0) := (others => '0');
	variable I: Integer;
	variable byte_offset :std_logic_vector(1 downto 0);
	variable word_offset :std_logic;l
	variable cache_index :std_logic_vector(4 downto 0);
	variable cache_tag:std_logic_vector(5 downto 0);
	variable word_selection :std_logic_vector(63 downto 0);
	variable selected_word :std_logic_vector(31 downto 0);

	begin
		byte_offset := physical_address(1 downto 0);
		word_offset := physical_address(2);
		cache_index := physical_address(6 downto 3);
		cache_tag := physical_address(13 downto 7);
		if check_cache = 0 then
			I := to_integer(unsigned(cache_index));
			if cache_valid(I) = 0 then
				cache_valid(I) := 1;
				hit <= '0';
			else
				if tag_inside(I) = cache_tag then
					word_selection := cache_inside(I);
					hit <= '1';
					if word_offset = '0' then
						selected_word := word_selection(31 downto 0);
					else
						selected_word := word_selection(63 downto 32);
					end if
					case byte_offset is
						when '00' =>
							byte_data <= selected_word(7 downto 0);
						when '01' =>
							byte_data <= selected_word(15 downto 7);
						when '10' =>
							byte_data <= selected_word(23 downto 16);
						when '11' =>
							byte_data <= selected_word(31 downto 24);
				else
					hit <= '0';
				end if
			end if
		else
			I := to_integer(unsigned(cache_index));
			cache_valid(I) := '1';
			cache_inside(I) := read_memory;
			tag_inside(I) := cache_tag;
			
		end if
	end process;
end Behavioral;



-- 2-Way Associative


entity Cache1 is
	port(
		check_cache : IN std_logic; 
		physical_address : IN std_logic_vector(13 downto 0); 
		read_memory : IN std_logic_vector(63 downto 0);
		byte_data : OUT std_logic_vector(7 downto 0)
		hit : OUT std_logic
	);
end Cache1;

architecture Behavioral1 of Cache1 is

begin
process(check_cache, physical_address)
	variable cache_inside : cache_data := (others =>(others => '0'));
	variable tag_inside : tag_data := (others =>(others => '0'));
	variable cache_valid : std_logic_vector(31 downto 0) := (others => '0');
	variable I: Integer;
	variable byte_offset :std_logic_vector(1 downto 0);
	variable word_offset :std_logic;l
	variable cache_index :std_logic_vector(4 downto 0);
	variable cache_tag:std_logic_vector(5 downto 0);
	variable word_selection :std_logic_vector(63 downto 0);
	variable selected_word :std_logic_vector(31 downto 0);

	begin
		byte_offset := physical_address(1 downto 0);
		word_offset := physical_address(2);
		cache_index := physical_address(6 downto 3);
		cache_tag := physical_address(13 downto 7);
		if check_cache = 0 then
			I := to_integer(unsigned(cache_index));
			if cache_valid(I) = 0 then
				cache_valid(I) := 1;
				hir <= '0';
			else
				if tag_inside(I) = cache_tag then
					word_selection := cache_inside(I);
					hit <= '1';
					if word_offset = '0' then
						selected_word := word_selection(31 downto 0);
					else
						selected_word := word_selection(63 downto 32);
					end if
					case byte_offset is
						when '00' =>
							byte_data <= selected_word(7 downto 0);
						when '01' =>
							byte_data <= selected_word(15 downto 7);
						when '10' =>
							byte_data <= selected_word(23 downto 16);
						when '11' =>
							byte_data <= selected_word(31 downto 24);
				else
					hir <= '0';
				end if
			end if
		else
			I := to_integer(unsigned(cache_index));
			cache_valid(I) := '1';
			cache_inside(I) := read_memory;
			tag_inside(I) := cache_tag;
			
		end if
	end process;
end Behavioral1;

