Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity Decodeur is
port(
  nPCsel: out std_logic;   
  PSR: in std_logic_vector(31 downto 0);  
  Instruction: in std_logic_vector(31 downto 0); 
  RegWr: out std_logic;
  RegSel: out std_logic;
  ALUctr: out std_logic_vector(1 downto 0);
  ALUsrc: out std_logic;
  PSREn: out std_logic;
  MemWr: out std_logic;
  WrSrc: out std_logic;
  Rn,Rd,Rm: out std_logic_vector(3 downto 0);
  Offset: out std_logic_vector(23 downto 0);
  Imm: out std_logic_vector(7 downto 0)
  );
end Entity;

Architecture rtl of Decodeur is
  
  --declaration le type enumere
  type enum_instruction is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT);
  
  signal instr_courante: enum_instruction;

begin
  
process(Instruction)    --processeur sensible par Instruction pour determiner l'etat 
begin
  if (Instruction(31 downto 20)= "111000101000") then
    instr_courante <= ADDi;
  elsif (Instruction(31 downto 20)= "111000001000")then
    instr_courante <= ADDr;
  elsif (Instruction(31 downto 24)= "11101010") then
    instr_courante <= BAL;
  elsif (Instruction(31 downto 24)= "10111010") then
    instr_courante <= BLT;
  elsif (Instruction(31 downto 20)= "111000110101") then
    instr_courante <= CMP;
  elsif (Instruction(31 downto 20)= "111001100001") then
    instr_courante <= LDR;
  elsif (Instruction(31 downto 16)= "1110001110100000") then
    instr_courante <= MOV;
  elsif (Instruction(31 downto 20)= "111001100000") then
    instr_courante <= STR; 
  else NULL;
  end if;
  
end process;

process(instr_courante,Instruction)   --processeur sensible par la valeur Instruction et instr_courante pour determiner la 
                                      --valeur des commandes, offset, address etc
begin
  
    offset  <= "000000000000000000000000";
    imm     <= "00000000";
    Rd      <= "0000";
    Rn      <= "0000";
    Rm      <= "0000";
    
  if (instr_courante=ADDi) then   
    nPCsel <= '0';
    RegWr <= '1';
    ALUSrc <= '1';
    ALUCtr <= "00";
    PSREn <= '0';
    MemWr <= '0';
    WrSrc <= '0';
    RegSel <= '0';
    Rn <= Instruction(19 downto 16);
    Rd <= Instruction(15 downto 12);
    Imm <= Instruction(7 downto 0);
    
  elsif (instr_courante=ADDr) then
    nPCsel <= '0';
    RegWr <= '1';
    ALUSrc <= '0';
    ALUCtr <= "00";
    PSREn <= '0';
    MemWr <= '0';
    WrSrc <= '0';
    RegSel <= '0';
    Rn <= Instruction(19 downto 16);
    Rd <= Instruction(15 downto 12);
    Rm <= Instruction(3 downto 0);
    
  elsif (instr_courante=BAL) then
    nPCsel <= '1';
    RegWr <= '0';
    ALUSrc <= '0';
    ALUCtr <= "00";
    PSREn <= '0';
    MemWr <= '0';
    WrSrc <= '0';
    RegSel <= '0';
    Offset <= Instruction(23 downto 0);
    
  elsif (instr_courante=BLT) then
    nPCsel <= PSR(0);
    RegWr <= '0';
    ALUSrc <= '0';
    ALUCtr <= "00";
    PSREn <= '1';
    MemWr <= '0';
    WrSrc <= '0';
    RegSel <= '0';  
    Offset <= Instruction(23 downto 0);
    
  elsif (instr_courante=CMP) then
    nPCsel <= '0';
    RegWr <= '0';
    ALUSrc <= '1';
    ALUCtr <= "10";
    PSREn <= '1';
    MemWr <= '0';
    WrSrc <= '0';
    RegSel <= '0';
    Rn <= Instruction(19 downto 16);
    Imm <= Instruction(7 downto 0);
    
  elsif (instr_courante=LDR) then
    nPCsel <= '0';
    RegWr <= '1';
    ALUSrc <= '1';
    ALUCtr <= "00";
    PSREn <= '0';
    MemWr <= '0';
    WrSrc <= '1';
    RegSel <= '0';   
    Rn <= Instruction(19 downto 16);
    Rd <= Instruction(15 downto 12);
    Offset(11 downto 0) <= Instruction(11 downto 0);
     
  elsif (instr_courante=MOV) then
    nPCsel <= '0';
    RegWr <= '1';
    ALUSrc <= '1';
    ALUCtr <= "01";
    PSREn <= '0';
    MemWr <= '0';
    WrSrc <= '0';
    RegSel <= '0';    
    Rd <= Instruction(15 downto 12);
    Imm <= Instruction(7 downto 0);
    
  elsif (instr_courante=STR) then
    nPCsel <= '0';
    RegWr <= '0';
    ALUSrc <= '1';
    ALUCtr <= "00";
    PSREn <= '0';
    MemWr <= '1';
    WrSrc <= '0';
    RegSel <= '1'; 
    Rn <= Instruction(19 downto 16);
    Rd <= Instruction(15 downto 12);
    Offset(11 downto 0) <= Instruction(11 downto 0); 
    
  end if;
end process;  
     
end architecture;
   