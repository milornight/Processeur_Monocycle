library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity AUT_Modif_tb is
end  entity;

Architecture testbench of AUT_Modif_tb is 
  signal Reset,Clk: std_logic;
	signal RegWr,RegSel: std_logic;
	signal Rn,Rd,Rm: std_logic_vector(3 downto 0);
  signal Imm: std_logic_vector(7 downto 0);
	signal COM1,COM2: std_logic;
	signal OP: std_logic_vector(1 downto 0);
	signal WrEn: std_logic:='0';
	signal busW: std_logic_vector(31 downto 0);
	signal flag: std_logic;
	
begin
  
  Clock: process
	begin
		Clk <= '0';
		wait for 5 ns;
		Clk <= '1';
		wait for 5 ns;
  end process;

  simulate:process
  begin
    
    --initialisation
	  Reset <= '1';
	  wait for 5 ns;
	  Reset <= '0';
	  wait for 5 ns;
    
    --Addition de 2 registres
    RegSel <= '0';  --Rb=Rm
    RegWr <= '0';   --on n'ecrit rien dans le registre
	  wait for 10 ns;
	  OP <= "00";     --ALUOut=busA+busB
	  Rn <= "0001";   --busA=R(1)
	  Rd <= "1111";   --busB=R(15)
	  Rm <= "0010";   --R(2)=busW
	  COM1 <= '0';    --multiOut=busB
	  COM2 <= '0';    --busW=ALUOut
	  WrEn <= '0';    --on n'ecrit rien dans le memoir
	  wait for 10 ns;
	  
	  --Addition d'un registre avec une valeur immediate( ALUOut=busA+ExOut )
	  Imm <= "01100101";   --valeur immediate
	  COM1 <= '1';         --multiOut=ExOut
	  Rd <= "0011";        --R(3)=busW
	  wait for 10 ns;
	  
	  --Soustraction de 2 registres
	  OP <= "10";      --AluOut= busA-busB
	  Rd <= "0100";    --R(4)=busW
	  Rn <= "0101";    --busA=R(5)
	  COM1 <= '0';     --multiOut=busB
	  wait for 10 ns;
	  
	  --Soustraction d'un valeur immediate a 1 registre (AluOut=busA-ExOut)
	  Imm <= "00000111";  
	  Rd <= "0110";    --R(6)=busW
	  COM1 <= '1';     --multiOut=ExOut
	  wait for  10 ns;
	  
	  --copie de la valeur d'un registre dans un autre registre
	  Rn <= "1111";      --busA= R(15)
	  Rd <= "0111";      --R(7)=busW 
	  OP <= "11";        --ALUOut= busA
	  COM1 <= '0';       --multiOut= busB
	  RegWr <= '1';      --copie la valeur busA(R(15)) dans R(7)
	  wait for 10 ns;
	  
	  --Lecture d'un mot de la memoire dans un registre
	  RegWr <= '0';
	  wait for 10 ns;
	  Imm <= "10000111"; 
	  COM1 <= '1';     --multiOut=ExOut
	  COM2 <= '1';     --busW=DataOut (un mot)
	  Rd <= "1000";    --R(8)=busW
	  Rm <= "1110";    --busB=R(14)
	  OP <= "01";      --ALUOut = busB
	  wait for 10 ns;
	  
	  --L'ecriture d'un registre dans un mot de la memoire
	  Rm <= "1111";      --busB=R(15)
	  Imm <= "00000001";  
	  WrEn <= '1';       --Ecriture dans la memoire
	  wait for 10 ns;
	  RegSel <= '1';     --Rb=Rd
	  Rd <= "0001";
	  wait for 10 ns;
	  
	  wait;
	 end process;
	
UUT: entity work.AUT_Modif port map(Clk=>Clk ,RegWr=>RegWr ,RegSel=>RegSel ,Rn=>Rn ,Rd=>Rd ,Rm=>Rm ,Imm=>Imm ,
                              	   COM1=>COM1 ,COM2=>COM2 ,OP=>OP ,WrEn=>WrEn ,busW=>busW ,flag=>flag);
		
end architecture ;
	  
    
