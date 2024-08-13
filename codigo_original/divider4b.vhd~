library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity divider4b is
    port(
        dividend : in std_logic_vector(3 downto 0);  -- Dividendo de 4 bits
        divisor : in std_logic_vector(3 downto 0);   -- Divisor de 4 bits
        quotient : out std_logic_vector(3 downto 0); -- Cociente de la división
        remainder : out std_logic_vector(3 downto 0) -- Residuo de la división
    );
end entity divider4b;

architecture Behavioral of divider4b is
    signal dividend_unsigned, divisor_unsigned: unsigned(3 downto 0);
    signal quotient_unsigned, remainder_unsigned: unsigned(3 downto 0);
begin
    process(dividend, divisor)
    begin
        -- Convertir las entradas a unsigned
        dividend_unsigned <= unsigned(dividend);
        divisor_unsigned <= unsigned(divisor);

        -- Inicializar cociente y residuo
        quotient_unsigned <= (others => '0');
        remainder_unsigned <= dividend_unsigned;

        -- División por restas sucesivas
        if divisor_unsigned /= 0 then
            while remainder_unsigned >= divisor_unsigned loop
                remainder_unsigned <= remainder_unsigned - divisor_unsigned;
                quotient_unsigned <= quotient_unsigned + 1;
            end loop;
        else
            -- Manejar división por cero
            quotient_unsigned <= (others => '1'); -- Indica un error de división
            remainder_unsigned <= dividend_unsigned;
        end if;

        -- Asignar resultados a las salidas
        quotient <= std_logic_vector(quotient_unsigned);
        remainder <= std_logic_vector(remainder_unsigned);
    end process;
end architecture Behavioral;
