library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity ALU is   --Unit? arithm?tique logique
port(  
  OP:in std_logic_vector(1 downto 0);   --seleteur de la operation
	A,B:in std_logic_vector(31 downto 0);
	S:out std_logic_vector(31 downto 0);
	N:out std_logic);                      --testeur de la valeur de sortie est negatif ou pas
end entity;

Architecture rtl of ALU is
signal Y: std_logic_vector(31 downto 0);    --signal interne

begin

process(OP,A,B) 	
BEGIN
	if ( OP = "00") then
		Y <= std_logic_vector(signed(A)+signed(B));     --addition
	elsif ( OP = "01") then
		Y <= B;
	elsif ( OP ="10") then
		Y <= std_logic_vector(signed(A)-signed(B));     --soustraction
	else
		Y <= A;	
	end if;
end process;

N<=Y(31);     --tester par la bit le plus fort== bit de signe

S <= Y;

end architecture;

