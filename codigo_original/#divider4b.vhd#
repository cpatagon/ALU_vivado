library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity divider4b is
    port(
        clk : in std_logic;
        dividend : in std_logic_vector(3 downto 0);
        divisor : in std_logic_vector(3 downto 0);
        quotient : out std_logic_vector(3 downto 0);
        remainder : out std_logic_vector(3 downto 0)
    );
end entity divider4b;

architecture Behavioral of divider4b is
    signal dividend_reg, divisor_reg : unsigned(3 downto 0);
    signal quot_reg, rem_reg : unsigned(3 downto 0);
begin
    process(clk)
    begin
        if rising_edge(clk) then
            -- Registrar las entradas
            dividend_reg <= unsigned(dividend);
            divisor_reg <= unsigned(divisor);
            
            -- Realizar la división
            if divisor_reg /= 0 then
                quot_reg <= dividend_reg / divisor_reg;
                rem_reg <= dividend_reg rem divisor_reg;
            else
                -- Manejar la división por cero
                quot_reg <= (others => '1');  -- Todos unos para indicar error
                rem_reg <= dividend_reg;      -- El dividendo se convierte en el resto
            end if;
        end if;
    end process;

    -- Asignar los resultados a las salidas
    quotient <= std_logic_vector(quot_reg);
    remainder <= std_logic_vector(rem_reg);
end architecture Behavioral;
