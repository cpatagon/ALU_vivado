library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;  -- Para tipos unsigned

entity ALU is
    port(
        clk : in std_logic;  -- Reloj para la ALU
        A : in std_logic_vector(3 downto 0);  -- Entrada A de 4 bits
        B : in std_logic_vector(3 downto 0);  -- Entrada B de 4 bits
        ALU_Sel : in std_logic_vector(1 downto 0);  -- Selector de operación
        Result : out std_logic_vector(7 downto 0);  -- Resultado de la operación (8 bits para manejar multiplicación)
        CarryOut : out std_logic   -- Salida de acarreo o préstamo
    );
end entity ALU;

architecture Behavioral of ALU is
    -- Señales internas para la operación
    signal Sum: std_logic_vector(3 downto 0);  -- Resultado de la suma
    signal Difference: std_logic_vector(3 downto 0);  -- Resultado de la resta
    signal Product: std_logic_vector(7 downto 0);  -- Resultado de la multiplicación
    signal Carry: std_logic;  -- Acarreo de la suma
    signal Borrow: std_logic; -- Préstamo de la resta

    -- Declaración del componente VIO
    COMPONENT vio_0
        PORT (
            clk : IN STD_LOGIC;
            probe_in0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Monitorea internal_result (ahora 8 bits)
            probe_in1 : IN STD_LOGIC;  -- Monitorea internal_carryout (ancho de 1 bit)
            probe_out0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);  -- Controla A
            probe_out1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);  -- Controla B
            probe_out2 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)   -- Controla ALU_Sel
        );
    END COMPONENT;

    -- Señales para conectar el VIO con la ALU
    signal vio_A: std_logic_vector(3 downto 0);
    signal vio_B: std_logic_vector(3 downto 0);
    signal vio_ALU_Sel: std_logic_vector(1 downto 0);

    -- Señales internas para los resultados
    signal internal_result: std_logic_vector(7 downto 0);
    signal internal_carryout: std_logic;

begin
    -- Instancia del sumador de 4 bits usando sumNb
    sumador_inst: entity work.sumNb
        generic map(N => 4)  -- Define el tamaño del sumador
        port map(
            a_i => vio_A,  -- Usa la señal interna vio_A
            b_i => vio_B,  -- Usa la señal interna vio_B
            ci_i => '0',  -- Acarreo de entrada inicial es 0
            s_o => Sum,
            co_o => Carry
        );

    -- Instancia del subtractor de 4 bits
    subtractor_inst: entity work.subtractor4b
        port map(
            a => vio_A,
            b => vio_B,
            diff => Difference,
            borrow => Borrow
        );

    -- Instancia del multiplicador de 4 bits
    multiplier_inst: entity work.multiplier4b
        port map(
            a => vio_A,
            b => vio_B,
            product => Product
        );

    -- Proceso para seleccionar la operación de la ALU
    process(clk)
    begin
        if rising_edge(clk) then
            case vio_ALU_Sel is
                when "00" =>  -- Operación de suma
                    internal_result <= "0000" & Sum; -- Extender el resultado a 8 bits
                    internal_carryout <= Carry;
                when "01" =>  -- Operación de resta
                    internal_result <= "0000" & Difference; -- Extender el resultado a 8 bits
                    internal_carryout <= Borrow;  -- Usar Borrow para indicar el préstamo
                when "10" =>  -- Operación de multiplicación
                    internal_result <= Product;
                    internal_carryout <= '0'; -- No se usa CarryOut en multiplicación
                when others =>
                    internal_result <= (others => '0');  -- Estado por defecto (sin operación)
                    internal_carryout <= '0';
            end case;

            -- Actualizar salidas
            Result <= internal_result;
            CarryOut <= internal_carryout;
        end if;
    end process;

    -- Instancia del VIO para controlar y monitorear señales
    vio_inst: vio_0
        port map (
            clk => clk,  -- Conectar el reloj
            probe_in0 => internal_result,  -- Monitorea internal_result
            probe_in1 => internal_carryout,  -- Monitorea internal_carryout (debe ser de 1 bit)
            probe_out0 => vio_A,  -- Controla A
            probe_out1 => vio_B,  -- Controla B
            probe_out2 => vio_ALU_Sel  -- Controla ALU_Sel
        );

end architecture Behavioral;
