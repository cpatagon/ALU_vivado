-- Estrategia de implementación:
-- Este módulo implementa un divisor de 4 bits utilizando una estrategia simple y directa.
-- La división se realiza en un solo ciclo de reloj utilizando los operadores de división (/)
-- y módulo (rem) integrados de VHDL. Esta aproximación aprovecha la capacidad de las
-- herramientas de síntesis para implementar estas operaciones para números pequeños. 
-- El módulo también maneja el caso de división por cero, proporcionando un resultado
-- predefinido en tal situación. Todas las entradas y salidas
-- están registradas para mejorar la estabilidad y el timing del diseño.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity divider4b is
    port(
        clk : in std_logic;                        -- Señal de reloj
        dividend : in std_logic_vector(3 downto 0);  -- Dividendo de 4 bits
        divisor : in std_logic_vector(3 downto 0);   -- Divisor de 4 bits
        quotient : out std_logic_vector(3 downto 0); -- Cociente resultante
        remainder : out std_logic_vector(3 downto 0) -- Resto resultante
    );
end entity divider4b;

architecture Behavioral of divider4b is
    -- Señales internas para registrar entradas y resultados
    signal dividend_reg, divisor_reg : unsigned(3 downto 0);
    signal quot_reg, rem_reg : unsigned(3 downto 0);
begin
    process(clk)
    begin
        if rising_edge(clk) then
            -- Registrar las entradas en cada flanco de subida del reloj
            dividend_reg <= unsigned(dividend);
            divisor_reg <= unsigned(divisor);
            
            -- Realizar la división
            if divisor_reg /= 0 then
                -- Si el divisor no es cero, realizar la división normal
                quot_reg <= dividend_reg / divisor_reg;  -- Cálculo del cociente
                rem_reg <= dividend_reg rem divisor_reg; -- Cálculo del resto
            else
                -- Manejar la división por cero
                quot_reg <= (others => '1');  -- Todos unos para indicar error
                rem_reg <= dividend_reg;      -- El dividendo se convierte en el resto
            end if;
        end if;
    end process;

    -- Asignar los resultados registrados a las salidas
    quotient <= std_logic_vector(quot_reg);
    remainder <= std_logic_vector(rem_reg);
end architecture Behavioral;