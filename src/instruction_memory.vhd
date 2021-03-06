library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity instruction_memory is 
	port(
	  Clk: in std_logic;
	  Addr: in std_logic_vector (31 downto 0);
		Instruction: out std_logic_vector (31 downto 0)
    );
end entity;

architecture RTL of instruction_memory is
	type RAM64x32 is array (0 to 63) of std_logic_vector (31 downto 0);    --definie un tableau de 64 mots de 32 bits
	
	--fonction d'initialisation du tableau
  function init_mem return RAM64x32 is 
	
	variable result : RAM64x32;
	
begin
	for i in 63 downto 0 loop
		result(i):= (others => '0');
	end loop;					              -- Addr      -- INSTRUCTION  -- COMMENTAIRE
		result (0):=x"E3A01020";  -- 0x0 _main -- MOV R1,#0x20 -- R1 = 0x20
		result (1):=x"E3A02000";  -- 0x1		     -- MOV R2,#0x00 -- R2 = 0
		result (2):=x"E6110000";  -- 0x2 _loop -- LDR R0,0(R1) -- R0 = DATAMEM[R1] 
	  result (3):=x"E0822000";  -- 0x3		     -- ADD R2,R2,R0 -- R2 = R2 + R0
		result (4):=x"E2811001";  -- 0x4		     -- ADD R1,R1,#1 -- R1 = R1 + 1
		result (5):=x"E351002A";  -- 0x5		     -- CMP R1,0x2A  -- si R1 >= 0x2A 
		result (6):=x"BAFFFFFB";  -- 0x6		     -- BLT loop 	   -- PC = PC + (-5) si N = 1
		result (7):=x"E6012000";  -- 0x7		     -- STR R2,0(R1) -- DATAMEM[R1] = R2
		result (8):=x"EAFFFFF7";  -- 0x8		     -- BAL main	    -- PC = PC + (-7)
	return result;
end init_mem;	

signal mem: RAM64x32 := init_mem;

begin 

process(Clk)
  begin
  if rising_edge(Clk) then
		Instruction <= mem(to_integer (unsigned (Addr)));   --Instruction prend la valeur de la Addr_eme ligne du tableau
	end if;
end process;
			
end architecture;
	