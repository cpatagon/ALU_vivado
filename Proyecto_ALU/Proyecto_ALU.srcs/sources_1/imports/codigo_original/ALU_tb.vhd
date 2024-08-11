library IEEE;
use IEEE.std_logic_1164.all;

entity ALU_tb is
end entity ALU_tb;

architecture testbench of ALU_tb is
    signal A, B: std_logic_vector(3 downto 0);
    signal ALU_Sel: std_logic_vector(1 downto 0);
    signal Result: std_logic_vector(3 downto 0);
    signal CarryOut: std_logic;
    
    component ALU
        port(
            clk : in std_logic;
            A : in std_logic_vector(3 downto 0);
            B : in std_logic_vector(3 downto 0);
            ALU_Sel : in std_logic_vector(1 downto 0);
            Result : out std_logic_vector(3 downto 0);
            CarryOut : out std_logic
        );
    end component;
    
begin
    -- Instantiate the ALU
    uut: ALU
        port map(
            clk => open,
            A => A,
            B => B,
            ALU_Sel => ALU_Sel,
            Result => Result,
            CarryOut => CarryOut
        );
    
    -- Test process
    process
    begin
        -- Test addition: 3 + 4 = 7
        A <= "0011"; B <= "0100"; ALU_Sel <= "00"; wait for 10 ns;
        assert (Result = "0111" and CarryOut = '0') report "Error: 3 + 4" severity error;
        
        -- Test subtraction: 5 - 2 = 3
        A <= "0101"; B <= "0010"; ALU_Sel <= "01"; wait for 10 ns;
        assert (Result = "0011" and CarryOut = '0') report "Error: 5 - 2" severity error;
        
        -- Add more test cases as needed
        wait;
    end process;
end architecture testbench;
