library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

Entity CompteurPC is
port(	
  PC,sExtender: in std_logic_vector(31 downto 0);
	nPCsel: in std_logic;          --commande de selection
	S: out std_logic_vector(31 downto 0));
end entity;

Architecture rtl of CompteurPC is

	signal Y1: std_logic_vector(31 downto 0);    
	signal Y0: std_logic_vector(31 downto 0);

begin 
	
	Y1<=std_logic_vector(unsigned(PC) +1);     --signal stock la valeur de PC+1
	Y0<=std_logic_vector(signed(Y1) + signed(sExtender));    --signal stock la valeur de PC+1+offset
	
	S<= Y1 when (nPCsel='0') else
	    Y0 when (nPCsel='1');



end architecture;