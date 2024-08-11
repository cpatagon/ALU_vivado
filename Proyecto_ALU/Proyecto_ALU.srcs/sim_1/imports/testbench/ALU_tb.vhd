library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU_tb is
end entity ALU_tb;

architecture testbench of ALU_tb is
    -- Declaración de señales para conectar con la ALU
    signal clk: std_logic := '0'; -- Inicializar el reloj en '0'
    signal A, B: std_logic_vector(3 downto 0);
    signal ALU_Sel: std_logic_vector(1 downto 0);
    signal Result: std_logic_vector(3 downto 0);
    signal CarryOut: std_logic;

    -- Declaración del componente ALU
    component ALU
        port(
            clk : in std_logic; -- Reloj
            A : in std_logic_vector(3 downto 0);
            B : in std_logic_vector(3 downto 0);
            ALU_Sel : in std_logic_vector(1 downto 0);
            Result : out std_logic_vector(3 downto 0);
            CarryOut : out std_logic
        );
    end component;

begin
    -- Instanciación de la ALU dentro del banco de pruebas
    uut: ALU
        port map(
            clk => clk,
            A => A,
            B => B,
            ALU_Sel => ALU_Sel,
            Result => Result,
            CarryOut => CarryOut
        );

    -- Proceso para generar el reloj
    clock_gen: process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- Proceso para aplicar estímulos y verificar la operación de suma y resta
    stimulus: process
    begin
        -- Seleccionar operación de suma
        ALU_Sel <= "00";

        -- Prueba de suma: 3 + 4 = 7
        A <= "0011"; B <= "0100"; wait for 20 ns;
        assert (Result = "0111" and CarryOut = '0') report "Error: 3 + 4" severity error;

        -- Prueba de suma: 8 + 7 = 15
        A <= "1000"; B <= "0111"; wait for 20 ns;
        assert (Result = "1111" and CarryOut = '0') report "Error: 8 + 7" severity error;

        -- Prueba de resta: 5 - 3 = 2
        ALU_Sel <= "01";
        A <= "0101"; B <= "0011"; wait for 20 ns;
        assert (Result = "0010" and CarryOut = '0') report "Error: 5 - 3" severity error;

        -- Prueba de resta: 2 - 3 = -1 (con préstamo)
        A <= "0010"; B <= "0011"; wait for 20 ns;
        assert (Result = "1111" and CarryOut = '1') report "Error: 2 - 3" severity error;

        -- Finalizar simulación
        wait;
    end process;

end architecture testbench;


