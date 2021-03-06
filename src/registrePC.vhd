library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registrePC is
port( 
  PCin: in std_logic_vector (31 downto 0);
	Clk: in std_logic;
	Reset: in std_logic;                  --actif a l'etat haut
	PCout: out std_logic_vector(31 downto 0)
);
end entity;

architecture rtl of registrePC is
	signal Y: std_logic_vector(31 downto 0);
	
begin
	
	process	(Reset,Clk)
		begin 
			if Reset = '1' then
				Y <= (others => '0');   --initialisation
			elsif rising_edge(Clk) then
				Y <= PCin;
			end if;

	end process;
	
	PCout <= Y;
end architecture;
