library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Memoir is
port(	
  Clk:in std_logic;
	DataIn:in std_logic_vector(31 downto 0);  	--bus donn?e en ecriture
	DataOut: out  std_logic_vector(31 downto 0); 	--bus donn?e en lecture
	Addr: in std_logic_vector(5 downto 0);		--bus d'adresses en lecture et ?criture 
	WrEN: in std_logic				--Write enable
);
end entity;

Architecture rtl of Memoir is
	type Ramtype is array(0 to 63) of std_logic_vector(31 downto 0);   --definie un tableau de 64 mots de 32 bits
  
  --fonction d'initialisation du tableau
	function init_Banc return Ramtype is
	
	variable result : Ramtype;

begin
 	for i in 63 downto 0 loop
		result(i):= Std_logic_vector(To_unsigned(i,32));
	end loop;

	return result;
end init_Banc;

signal Ram: Ramtype:= init_banc;

begin

	DataOut<= Ram(to_integer(unsigned(Addr)));   --DataOut prend la vealeur de Addr_eme ligne du tableau

process(CLK)
 begin
	if rising_edge(CLK) then
		if ( WrEN = '1' ) then
			Ram(to_integer(unsigned(Addr)))<= DataIn;      --On met la valeur DataIn dans la Addr_eme ligne du tableau
		end if;
	end if;
end process;

end architecture;

	