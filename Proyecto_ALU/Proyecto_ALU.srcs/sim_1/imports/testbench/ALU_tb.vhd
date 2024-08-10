-- Banco de pruebas de la ALU solo para la operación suma 
library IEEE;
use IEEE.std_logic_1164.all;

-- Definimos la entidad del banco de pruebas
entity ALU_tb is
end entity ALU_tb;

-- Implementamos la arquitectura del banco de pruebas
architecture testbench of ALU_tb is
    -- Declaración de señales para conectar con la ALU
    signal clk: std_logic := '0';  -- Señal de reloj
    signal A, B: std_logic_vector(3 downto 0);
    signal ALU_Sel: std_logic_vector(1 downto 0);
    signal Result: std_logic_vector(3 downto 0);
    signal CarryOut: std_logic;

    -- Declaración del componente ALU
    component ALU
        port(
            clk : in std_logic;  -- Puerto de reloj
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
            clk => clk,  -- Conectar el reloj
            A => A,
            B => B,
            ALU_Sel => ALU_Sel,
            Result => Result,
            CarryOut => CarryOut
        );
 -- Proceso para generar el reloj
           clk_process : process
           begin
               while true loop
                   clk <= '0';
                   wait for 5 ns;  -- Periodo del reloj de 10 ns
                   clk <= '1';
                   wait for 5 ns;
               end loop;
           end process;
    -- Proceso para aplicar estímulos y verificar la operación de suma
    process
    begin
        -- Seleccionar operación de suma
        ALU_Sel <= "00";

        -- Prueba de suma: 3 + 4 = 7
        A <= "0011"; B <= "0100"; wait for 10 ns;
        assert (Result = "0111" and CarryOut = '0') report "Error: 3 + 4" severity error;

        -- Prueba de suma: 8 + 7 = 15
        A <= "1000"; B <= "0111"; wait for 10 ns;
        assert (Result = "1111" and CarryOut = '0') report "Error: 8 + 7" severity error;

        -- Prueba de suma con acarreo: 15 + 1 = 16
        A <= "1111"; B <= "0001"; wait for 10 ns;
        assert (Result = "0000" and CarryOut = '1') report "Error: 15 + 1" severity error;

        -- Prueba de suma: 0 + 0 = 0
        A <= "0000"; B <= "0000"; wait for 10 ns;
        assert (Result = "0000" and CarryOut = '0') report "Error: 0 + 0" severity error;

        wait;
    end process;
end architecture testbench;
