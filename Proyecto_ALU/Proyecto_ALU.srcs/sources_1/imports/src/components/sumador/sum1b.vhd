-- Sumador de 1 bit
-- Importamos la biblioteca IEEE para usar sus paquetes estándar de lógica
library IEEE;
use IEEE.std_logic_1164.all;

-- Definimos la entidad 'sum1b', que representa un sumador de un bit con acarreo
entity sum1b is
	port(
		a_i: in std_logic;  -- Entrada 'a_i' (primer bit de entrada)
		b_i: in std_logic;  -- Entrada 'b_i' (segundo bit de entrada)
		ci_i: in std_logic; -- Entrada 'ci_i' (bit de acarreo de entrada)
		s_o: out std_logic; -- Salida 's_o' (bit de suma de salida)
		co_o: out std_logic -- Salida 'co_o' (bit de acarreo de salida)
	);
end;

-- Definimos la arquitectura del sumador de un bit
architecture sum1b_arq of sum1b is
begin
	-- La salida de la suma 's_o' se calcula usando la operación XOR en
        -- los bits de entrada y el acarreo de entrada
	s_o <= a_i xor b_i xor ci_i;
	
	-- La salida del acarreo 'co_o' se calcula usando las operaciones
        -- AND y OR en los bits de entrada y el acarreo de entrada
	co_o <= (a_i and b_i) or (a_i and ci_i) or (b_i and ci_i);
	
end;
