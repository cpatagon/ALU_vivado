library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU is
    port(
        clk : in std_logic;
        A : in std_logic_vector(3 downto 0);
        B : in std_logic_vector(3 downto 0);
        ALU_Sel : in std_logic_vector(1 downto 0);
        Result : out std_logic_vector(7 downto 0);
        CarryOut : out std_logic
    );
end entity ALU;

architecture Behavioral of ALU is
    -- Señales internas para la operación
    signal Sum, Difference : std_logic_vector(3 downto 0) := (others => '0');
    signal Product : std_logic_vector(7 downto 0) := (others => '0');
    signal Quotient, Remainder : std_logic_vector(3 downto 0) := (others => '0');
    signal Carry, Borrow : std_logic := '0';
    
    signal vio_A, vio_B : std_logic_vector(3 downto 0) := (others => '0');
    signal vio_ALU_Sel : std_logic_vector(1 downto 0) := (others => '0');
    
    signal internal_result : std_logic_vector(7 downto 0) := (others => '0');
    signal internal_carryout : std_logic := '0';

    COMPONENT vio_0
        PORT (
            clk : IN STD_LOGIC;
            probe_in0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            probe_in1 : IN STD_LOGIC;
            probe_out0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            probe_out1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            probe_out2 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
        );
    END COMPONENT;

begin
    -- Instancia del sumador de 4 bits
    sumador_inst: entity work.sumNb
        generic map(N => 4)
        port map(
            a_i => vio_A,
            b_i => vio_B,
            ci_i => '0',
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

    -- Instancia del divisor de 4 bits
    divider_inst: entity work.divider4b
        port map(
            dividend => vio_A,
            divisor => vio_B,
            quotient => Quotient,
            remainder => Remainder
        );

    -- Proceso sincronizado para la ALU
    process(clk)
    begin
        if rising_edge(clk) then
            case vio_ALU_Sel is
                when "00" =>  -- Operación de suma
                    internal_result <= "0000" & Sum;
                    internal_carryout <= Carry;
                when "01" =>  -- Operación de resta
                    internal_result <= "0000" & Difference;
                    internal_carryout <= Borrow;
                when "10" =>  -- Operación de multiplicación
                    internal_result <= Product;
                    internal_carryout <= '0';
                when "11" =>  -- Operación de división
                    internal_result <= "0000" & Quotient;
                    internal_carryout <= '0';  -- No se usa CarryOut en división
                when others =>
                    internal_result <= (others => '0');
                    internal_carryout <= '0';
            end case;

            -- Actualizar salidas
            Result <= internal_result;
            CarryOut <= internal_carryout;
        end if;
    end process;

    -- Instancia del VIO
    vio_inst: vio_0
        port map (
            clk => clk,
            probe_in0 => internal_result,
            probe_in1 => internal_carryout,
            probe_out0 => vio_A,
            probe_out1 => vio_B,
            probe_out2 => vio_ALU_Sel
        );

end architecture Behavioral;
