----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.11.2019 15:12:27
-- Design Name: 
-- Module Name: pwm_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.DSED.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pwm_tb is
--  Port ( );
end pwm_tb;

architecture Behavioral of pwm_tb is

component pwm is Port(
    clk_12megas : in STD_LOGIC;
    reset : in STD_LOGIC;
    en_2_cycles: in STD_LOGIC;
    sample_in : in STD_LOGIC_VECTOR (sample_size-1 downto 0);
    sample_request : out STD_LOGIC;
    pwm_pulse : out STD_LOGIC);
end component;

component en_4_cycles is
    Port ( clk_12megas : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_3megas : out STD_LOGIC;
           en_2_cycles : out STD_LOGIC;
           en_4_cycles : out STD_LOGIC);
end component;

constant clk_period : time := 84 ns; 

signal clk_12megas, reset, en_2_cycles,sample_request,en,clk_3megas,pwm_pulse:std_logic;
signal sample_in:std_logic_vector(sample_size-1 downto 0);
begin

UUT: pwm port map(
    clk_12megas => clk_12megas,
    reset=>reset,
    en_2_cycles=>en_2_cycles,
    sample_in=>sample_in,
    sample_request=>sample_request,
    pwm_pulse=>pwm_pulse
);

UUT2:en_4_cycles port map
(       clk_12megas=>clk_12megas,
        reset=>reset,
        clk_3megas=>clk_3megas,
        en_2_cycles=>en_2_cycles,
        en_4_cycles=>en
        );

clk_process:process
begin
    clk_12megas <= '0';
    wait for clk_period/2;
    clk_12megas <= '1';
    wait for clk_period/2;
end process;

process
begin
 sample_in<="11111111";
 reset<='1';
 wait for 100 ns;
 reset<='0';
 wait;
end process;

end Behavioral;
