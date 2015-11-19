library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity camera_starter is
PORT(
        clk       : IN     STD_LOGIC
    ;   reset     : IN     STD_LOGIC
    ;   sda       : INOUT  STD_LOGIC
    ;   scl       : INOUT  STD_LOGIC
    );
end camera_starter;

architecture Behavioral of camera_starter is
    subtype byte_t is std_logic_vector(7 downto 0);
    type i2c_message_t is
    record
        address : byte_t;
        data    : byte_t;
        rw      : std_logic; -- '1' is read
    end record;
    
    constant NUM_MESSAGES : integer := 645;
    type i2c_sequence is array (0 to NUM_MESSAGES-1) of i2c_message_t;
    constant SEQUENCE : i2c_sequence := (
        (x"6C", x"00", '0'),
        (x"6D", x"00", '1'),
        (x"6C", x"00", '0'),
        (x"6D", x"00", '1'),
        (x"6C", x"00", '0'),
        (x"6D", x"00", '1'),
        (x"6C", x"00", '0'),
        (x"6D", x"00", '1'),
        (x"6C", x"00", '0'),
        (x"6D", x"00", '1'),
        (x"6C", x"00", '0'),
        (x"6D", x"00", '1'),
        (x"6C", x"00", '0'),
        (x"6D", x"00", '1'),
        (x"6C", x"00", '0'),
        (x"6D", x"00", '1'),
        (x"6C", x"00", '0'),
        (x"6D", x"00", '1'),
        (x"6D", x"00", '1'),
        (x"6C", x"30", '0'),
        (x"6C", x"0A", '0'),
        (x"6D", x"56", '1'),
        (x"6D", x"47", '1'),
        (x"6C", x"01", '0'),
        (x"6C", x"03", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"03", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"30", '0'),
        (x"6C", x"34", '0'),
        (x"6C", x"1A", '0'),
        (x"6C", x"30", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"21", '0'),
        (x"6C", x"30", '0'),
        (x"6C", x"36", '0'),
        (x"6C", x"62", '0'),
        (x"6C", x"30", '0'),
        (x"6C", x"3C", '0'),
        (x"6C", x"11", '0'),
        (x"6C", x"31", '0'),
        (x"6C", x"06", '0'),
        (x"6C", x"F5", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"21", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"20", '0'),
        (x"6C", x"41", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"27", '0'),
        (x"6C", x"EC", '0'),
        (x"6C", x"37", '0'),
        (x"6C", x"0C", '0'),
        (x"6C", x"03", '0'),
        (x"6C", x"36", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"59", '0'),
        (x"6C", x"36", '0'),
        (x"6C", x"18", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"50", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"06", '0'),
        (x"6C", x"50", '0'),
        (x"6C", x"02", '0'),
        (x"6C", x"40", '0'),
        (x"6C", x"50", '0'),
        (x"6C", x"03", '0'),
        (x"6C", x"08", '0'),
        (x"6C", x"5A", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"08", '0'),
        (x"6C", x"30", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"30", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"30", '0'),
        (x"6C", x"02", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"30", '0'),
        (x"6C", x"16", '0'),
        (x"6C", x"08", '0'),
        (x"6C", x"30", '0'),
        (x"6C", x"17", '0'),
        (x"6C", x"E0", '0'),
        (x"6C", x"30", '0'),
        (x"6C", x"18", '0'),
        (x"6C", x"44", '0'),
        (x"6C", x"30", '0'),
        (x"6C", x"1C", '0'),
        (x"6C", x"F8", '0'),
        (x"6C", x"30", '0'),
        (x"6C", x"1D", '0'),
        (x"6C", x"F0", '0'),
        (x"6C", x"3A", '0'),
        (x"6C", x"18", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"3A", '0'),
        (x"6C", x"19", '0'),
        (x"6C", x"F8", '0'),
        (x"6C", x"3C", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"80", '0'),
        (x"6C", x"3B", '0'),
        (x"6C", x"07", '0'),
        (x"6C", x"0C", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"02", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"03", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"04", '0'),
        (x"6C", x"0A", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"05", '0'),
        (x"6C", x"3F", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"06", '0'),
        (x"6C", x"07", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"07", '0'),
        (x"6C", x"A3", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"08", '0'),
        (x"6C", x"05", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"09", '0'),
        (x"6C", x"10", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"0A", '0'),
        (x"6C", x"03", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"0B", '0'),
        (x"6C", x"CC", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"0C", '0'),
        (x"6C", x"07", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"0D", '0'),
        (x"6C", x"68", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"0E", '0'),
        (x"6C", x"04", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"0F", '0'),
        (x"6C", x"50", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"11", '0'),
        (x"6C", x"10", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"13", '0'),
        (x"6C", x"06", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"14", '0'),
        (x"6C", x"31", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"15", '0'),
        (x"6C", x"31", '0'),
        (x"6C", x"36", '0'),
        (x"6C", x"30", '0'),
        (x"6C", x"2E", '0'),
        (x"6C", x"36", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"E2", '0'),
        (x"6C", x"36", '0'),
        (x"6C", x"33", '0'),
        (x"6C", x"23", '0'),
        (x"6C", x"36", '0'),
        (x"6C", x"34", '0'),
        (x"6C", x"44", '0'),
        (x"6C", x"36", '0'),
        (x"6C", x"36", '0'),
        (x"6C", x"06", '0'),
        (x"6C", x"36", '0'),
        (x"6C", x"20", '0'),
        (x"6C", x"64", '0'),
        (x"6C", x"36", '0'),
        (x"6C", x"21", '0'),
        (x"6C", x"E0", '0'),
        (x"6C", x"36", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"37", '0'),
        (x"6C", x"37", '0'),
        (x"6C", x"04", '0'),
        (x"6C", x"A0", '0'),
        (x"6C", x"37", '0'),
        (x"6C", x"03", '0'),
        (x"6C", x"5A", '0'),
        (x"6C", x"37", '0'),
        (x"6C", x"15", '0'),
        (x"6C", x"78", '0'),
        (x"6C", x"37", '0'),
        (x"6C", x"17", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"37", '0'),
        (x"6C", x"31", '0'),
        (x"6C", x"02", '0'),
        (x"6C", x"37", '0'),
        (x"6C", x"0B", '0'),
        (x"6C", x"60", '0'),
        (x"6C", x"37", '0'),
        (x"6C", x"05", '0'),
        (x"6C", x"1A", '0'),
        (x"6C", x"3F", '0'),
        (x"6C", x"05", '0'),
        (x"6C", x"02", '0'),
        (x"6C", x"3F", '0'),
        (x"6C", x"06", '0'),
        (x"6C", x"10", '0'),
        (x"6C", x"3F", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"0A", '0'),
        (x"6C", x"3A", '0'),
        (x"6C", x"08", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"3A", '0'),
        (x"6C", x"09", '0'),
        (x"6C", x"28", '0'),
        (x"6C", x"3A", '0'),
        (x"6C", x"0A", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"3A", '0'),
        (x"6C", x"0B", '0'),
        (x"6C", x"F6", '0'),
        (x"6C", x"3A", '0'),
        (x"6C", x"0D", '0'),
        (x"6C", x"08", '0'),
        (x"6C", x"3A", '0'),
        (x"6C", x"0E", '0'),
        (x"6C", x"06", '0'),
        (x"6C", x"3A", '0'),
        (x"6C", x"0F", '0'),
        (x"6C", x"58", '0'),
        (x"6C", x"3A", '0'),
        (x"6C", x"10", '0'),
        (x"6C", x"50", '0'),
        (x"6C", x"3A", '0'),
        (x"6C", x"1B", '0'),
        (x"6C", x"58", '0'),
        (x"6C", x"3A", '0'),
        (x"6C", x"1E", '0'),
        (x"6C", x"50", '0'),
        (x"6C", x"3A", '0'),
        (x"6C", x"11", '0'),
        (x"6C", x"60", '0'),
        (x"6C", x"3A", '0'),
        (x"6C", x"1F", '0'),
        (x"6C", x"28", '0'),
        (x"6C", x"40", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"02", '0'),
        (x"6C", x"40", '0'),
        (x"6C", x"04", '0'),
        (x"6C", x"04", '0'),
        (x"6C", x"40", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"09", '0'),
        (x"6C", x"48", '0'),
        (x"6C", x"37", '0'),
        (x"6C", x"16", '0'),
        (x"6C", x"48", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"24", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"03", '0'),
        (x"6C", x"03", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"20", '0'),
        (x"6D", x"41", '1'),
        (x"6C", x"38", '0'),
        (x"6C", x"21", '0'),
        (x"6D", x"01", '1'),
        (x"6C", x"38", '0'),
        (x"6C", x"20", '0'),
        (x"6C", x"41", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"21", '0'),
        (x"6C", x"03", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0A", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0B", '0'),
        (x"6C", x"10", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"38", '0'),
        (x"6C", x"0E", '0'),
        (x"6C", x"05", '0'),
        (x"6C", x"9B", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"1A", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"02", '0'),
        (x"6C", x"F0", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"10", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"A0", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0A", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0B", '0'),
        (x"6C", x"10", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0A", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0B", '0'),
        (x"6C", x"10", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"1A", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"02", '0'),
        (x"6C", x"F0", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"10", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"A0", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0A", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0B", '0'),
        (x"6C", x"10", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"1A", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"02", '0'),
        (x"6C", x"F0", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"10", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"A0", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0A", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0B", '0'),
        (x"6C", x"13", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"58", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"02", '0'),
        (x"6C", x"D0", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"10", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"A0", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0A", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0B", '0'),
        (x"6C", x"13", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"58", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"02", '0'),
        (x"6C", x"D0", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"10", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"A0", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0A", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0B", '0'),
        (x"6C", x"1C", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"59", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"02", '0'),
        (x"6C", x"50", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"10", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"A0", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0A", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0B", '0'),
        (x"6C", x"23", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"59", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"02", '0'),
        (x"6C", x"50", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"10", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"A0", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0A", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0B", '0'),
        (x"6C", x"25", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"59", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"02", '0'),
        (x"6C", x"50", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"10", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"A0", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0A", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0B", '0'),
        (x"6C", x"26", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"59", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"02", '0'),
        (x"6C", x"50", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"10", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"A0", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0A", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0B", '0'),
        (x"6C", x"26", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"59", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"02", '0'),
        (x"6C", x"50", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"10", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"A0", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0A", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0B", '0'),
        (x"6C", x"26", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"59", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"02", '0'),
        (x"6C", x"50", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"10", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"A0", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0A", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0B", '0'),
        (x"6C", x"26", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"59", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"02", '0'),
        (x"6C", x"50", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"10", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"A0", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0A", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0B", '0'),
        (x"6C", x"26", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"59", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"02", '0'),
        (x"6C", x"50", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"10", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"A0", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0A", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"0B", '0'),
        (x"6C", x"27", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"00", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"01", '0'),
        (x"6C", x"59", '0'),
        (x"6C", x"35", '0'),
        (x"6C", x"02", '0'),
        (x"6C", x"50", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"10", '0'),
        (x"6C", x"32", '0'),
        (x"6C", x"12", '0'),
        (x"6C", x"A0", '0')
    );
    signal i2c_enable       : std_logic := '0';
    signal i2c_addr         : byte_t;
    signal i2c_rw           : std_logic;
    signal i2c_write_data   : byte_t;
    signal i2c_busy         : std_logic := '0';
    signal i2c_read_data    : byte_t;
    signal i2c_error        : std_logic := '0';
    signal i2c_reset_n      : std_logic := '1';
begin
    i2c : entity work.i2c_master
    generic map(
        input_clk   => 24_000_000,
        bus_clk     => 100_000
    )
    port map(
        clk         => clk,
        reset_n     => i2c_reset_n,
        ena         => i2c_enable,
        addr        => i2c_addr(7 downto 1),
        rw          => i2c_rw,
        data_wr     => i2c_write_data,
        busy        => i2c_busy,
        data_rd     => i2c_read_data,
        ack_error   => i2c_error,
        sda         => sda,
        scl         => scl
    );
    
    feed_messages: process(reset, clk, i2c_busy) is
        variable c    : integer := 0;
        type state_t is (READY, PASSING_MESSAGE, I2C_TRANSMITTING, DONE);
        variable state : state_t := READY;
    begin
        if reset = '1' then
            c := 0;
            state := READY;
        elsif rising_edge(clk) then
            case STATE is
            when READY =>
                i2c_addr <= SEQUENCE(c).address;
                i2c_write_data <= SEQUENCE(c).data;
                i2c_rw <= SEQUENCE(c).rw;
                i2c_enable <= '1';
                state := PASSING_MESSAGE;
            when PASSING_MESSAGE =>
                if i2c_busy = '1' then
                    c := (c + 1);
                    state := I2C_TRANSMITTING;
                end if;
            when I2C_TRANSMITTING =>
                if i2c_busy = '0' then
                    if c >= NUM_MESSAGES then
                        state := DONE;
                    else
                        state := READY;
                    end if;
                end if;
            when DONE =>
                i2c_enable <= '0';
            when others =>
                --
            end case;
        end if;
    end process feed_messages;
end Behavioral;

