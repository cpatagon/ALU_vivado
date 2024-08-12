library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;  -- Necesario para usar el tipo unsigned

entity subtractor4b is
    port(
        a : in std_logic_vector(3 downto 0);  -- Minuendo de 4 bits
        b : in std_logic_vector(3 downto 0);  -- Sustraendo de 4 bits
        diff : out std_logic_vector(3 downto 0);  -- Resultado de la resta
        borrow : out std_logic  -- Préstamo de la resta
    );
end entity subtractor4b;

architecture Behavioral of subtractor4b is
    signal a_unsigned, b_unsigned: unsigned(3 downto 0);
    signal temp_result: unsigned(4 downto 0); -- Incluye bit de acarreo/borrow
begin
    -- Convertir a y b a tipo unsigned
    a_unsigned <= unsigned(a);
    b_unsigned <= unsigned(b);

    -- Sumar el complemento a 2 de B
    temp_result <= ("0" & a_unsigned) - ("0" & b_unsigned);

    -- Asignar el resultado de la resta
    diff <= std_logic_vector(temp_result(3 downto 0));

    -- El bit más significativo de temp_result indica si hubo préstamo
    borrow <= not temp_result(4);

end architecture Behavioral;



-- Complemento a 2: Se calcula el complemento a 2 del número
-- b para realizar la resta utilizando la suma. Esto implica
-- invertir los bits de b (not b) y luego sumar 1 ("0001").

-- Suma con Préstamo: Se realiza la suma del minuendo a y el
-- complemento a 2 de b. El resultado es almacenado en una
-- señal temp_sum que tiene 5 bits para incluir el posible
-- bit de préstamo.

-- Resultado y Préstamo:

--     diff se asigna a los 4 bits menos significativos de
--     temp_sum.
--     borrow se determina por el bit más significativo de
--     temp_sum, que indica si hay un préstamo.
