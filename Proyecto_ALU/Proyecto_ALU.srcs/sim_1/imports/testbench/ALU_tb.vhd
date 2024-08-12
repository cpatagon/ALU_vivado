library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity divider4b_tb is
end entity divider4b_tb;

architecture testbench of divider4b_tb is
    -- Señales para conectar con el módulo divisor
    signal clk : std_logic := '0';
    signal dividend : std_logic_vector(3 downto 0);
    signal divisor : std_logic_vector(3 downto 0);
    signal quotient : std_logic_vector(3 downto 0);
    signal remainder : std_logic_vector(3 downto 0);

    -- Periodo de reloj
    constant clk_period : time := 10 ns;

begin
    -- Instancia del módulo divisor
    uut: entity work.divider4b
        port map(
            clk => clk,
            dividend => dividend,
            divisor => divisor,
            quotient => quotient,
            remainder => remainder
        );

    -- Generación del reloj
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end loop;
    end process;

    -- Estímulos de prueba
    stimulus_process: process
    begin
        -- Prueba 1: División sin residuo
        dividend <= "1000";  -- 8
        divisor <= "0010";   -- 2
        wait for clk_period;
        
        -- Verificación del resultado
        assert (quotient = "0100" and remainder = "0000")  -- 8 / 2 = 4, resto = 0
        report "Error: 8 / 2 no es 4 con residuo 0"
        severity error;

        -- Prueba 2: División con residuo
        dividend <= "1001";  -- 9
        divisor <= "0011";   -- 3
        wait for clk_period;
        
        -- Verificación del resultado
        assert (quotient = "0011" and remainder = "0000")  -- 9 / 3 = 3, resto = 0
        report "Error: 9 / 3 no es 3 con residuo 0"
        severity error;

        -- Prueba 3: División por cero
        dividend <= "1010";  -- 10
        divisor <= "0000";   -- 0
        wait for clk_period;
        
        -- Verificación del resultado
        assert (quotient = "0000" and remainder = dividend)  -- División por 0, cociente = 0, resto = dividendo
        report "Error: División por 0 no es manejada correctamente"
        severity error;

        -- Fin de la simulación
        wait;
    end process;
end architecture testbench;



