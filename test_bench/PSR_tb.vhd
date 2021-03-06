library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PSR_tb is
end entity;

Architecture test_bench of PSR_tb is
  signal DataIn: std_logic_vector(31 downto 0);     --bus de chargement
  signal RST: std_logic;        --reset asynchrone, actif a l'etat haut
  signal CLK: std_logic;
  signal WE: std_logic;         -- commande de chargement   
  signal DataOut: std_logic_vector(31 downto 0);    --bus de sortie
  
begin
Clock: process
	begin
		Clk <= '0';
		wait for 5 ns;
		Clk <= '1';
		wait for 5 ns;
end process;

simulate: process
begin
  RST <= '1';     --initialisation
  wait for 5 ns;
  RST <= '0';
  wait for 5 ns;
  DataIn <=Std_logic_vector(To_signed(10,32));    
  WE <= '0';        --DataOut=0
  wait for 10 ns;
  WE <= '1';        --DataOut=10
  wait for 10 ns;
  DataIn <=Std_logic_vector(To_signed(1,32));   --DataOut=1
  wait for 10 ns;
  WE <= '0';        --DataOut=1
  wait for 10 ns;
  wait;
  
end process;

UUT:entity work.PSR port map(DataIn=>DataIn ,RST=>RST ,CLK=>CLK ,WE=>WE ,DataOut=>DataOut);

end Architecture;