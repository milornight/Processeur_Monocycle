library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity instructionMemory_tb is
end  entity;

Architecture testbench of instructionMemory_tb is 
  signal Clk: std_logic;
	signal Addr: std_logic_vector(31 downto 0);		--bus d'adresses 
	signal Instruction: std_logic_vector(31 downto 0); 

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
  Addr <= Std_logic_vector(To_signed(10,32));   --Instruction=mem(10)
  wait for 10 ns;
  Addr <= Std_logic_vector(To_signed(1,32));    --Instruction=mem(1)
  wait for 10 ns;
  Addr <= Std_logic_vector(To_signed(3,32));    --Instruction=mem(3)
  wait for 10 ns;
  Addr <= Std_logic_vector(To_signed(8,32));    --Instruction=mem(8)
  wait for 10 ns;

  wait;

end process;

UUT:Entity work.Instruction_Memory port map(Clk=>Clk ,Addr=>Addr ,Instruction=>Instruction);
end architecture;