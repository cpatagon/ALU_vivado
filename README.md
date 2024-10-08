# Proyecto ALU (Unidad Aritmético-Lógica) en VHDL


## Descripción

Este proyecto implementa una Unidad Aritmético-Lógica (ALU) en VHDL. Una ALU es un componente esencial en los procesadores modernos, responsable de realizar operaciones aritméticas y lógicas sobre los datos. Este diseño modular permite la simulación y prueba de diferentes operaciones mediante bancos de pruebas detallados.

![diagramaALUSUM_esquematico](./doc/img/video_alu.png)
*Fig 0: funcionamiento ejecución del proyecto ALU en Vivado sobre una placa ARTY Z7*  

## Presentación y Demostración en Video del Proyecto

A continuación se presenta una presentación resumen del proyecto con sus principales características 

- [Presentación PDF del proyecto](doc/GdP_LuisGomez.pdf)

Para ver una demostración en funcionamiento de la ALU implementada en este proyecto, 
consulta el siguiente video:

- [Video de demostración de la ALU en FPGA](https://www.youtube.com/watch?v=fYx1muBo78U)

Este video muestra el funcionamiento práctico de la ALU, incluyendo las operaciones 
de suma, resta, multiplicación y división implementadas en la FPGA.

### Características Técnicas
- Entradas: A[3:0], B[3:0], ALU_Sel[1:0]
- Salida principal: Result[7:0]
- Señal de control: CarryOut (para suma/resta)
- Frecuencia de operación: 125 MHz

## Código Implementado 

### Archivos Principales
- [ALU.vhd](codigo_original/ALU.vhd)
- [divider4b.vhd](codigo_original/divider4b.vhd)
- [multiplier4b.vhd](codigo_original/multiplier4b.vhd)
- [subtractor4b.vhd](codigo_original/subtractor4b.vhd)
- [sum1b.vhd](codigo_original/sum1b.vhd)
- [sumNb.vhd](codigo_original/sumNb.vhd)

### Archivos en la carpeta 'otros'
- [ALU_srm.vhd](codigo_original/otros/ALU_srm.vhd)
- [ALU_sum.vhd](codigo_original/otros/ALU_sum.vhd)
- [ALU_tb.vhd](codigo_original/otros/ALU_tb.vhd)
- [lab1_ArtyZ7_10.xdc](codigo_original/otros/lab1_ArtyZ7_10.xdc)

## Funcionalidades

La ALU soporta las siguientes operaciones:

- **Suma:** Realiza la suma de dos operandos de 4 bits y produce un resultado de 4 bits junto con un bit de acarreo.
- **Resta:** Realiza la resta entre dos operandos de 4 bits.
- **Multiplicación:** Calcula el producto de dos operandos de 4 bits.
- **División:** Realiza la división entre dos operandos de 4 bits y produce cociente y resto.
- **Operaciones Lógicas:** Incluye operaciones como AND, OR, y XOR entre los operandos de 4 bits.

![Esquema general del proyecto](doc/img/esquema_general.png)


### Implementación
- Sumador: Utiliza el método de propagación de acarreo (Ripple Carry)
- Restador: Emplea el método de complemento a 2 y suma
- Multiplicador: Implementa el algoritmo de suma y desplazamiento
- Divisor: Usa los operadores de división y módulo integrados de VHDL

![ALU General](doc/img/ALU_srmd.png)

### Características Adicionales
- Manejo de casos especiales (e.j., división por cero)
- Uso de Virtual I/O (VIO) para control y monitoreo en tiempo real
- Diseño modular con componentes separados para cada operación

### Herramientas y Tecnología
- Lenguaje: VHDL
- Plataforma de desarrollo: Vivado
- FPGA objetivo: Xilinx Zynq-Z7 (xc7z010clg400-1)

### Rendimiento
- Utilización eficiente de recursos de la FPGA como se muestra en las figuras que se presentan a continuación

![recursos utilizados](doc/img/utilizatio_table_srmd.png)



## Estructura del Proyecto

El proyecto está organizado en varias carpetas para facilitar la gestión de componentes, bancos de pruebas y documentación:

- **src/**: Contiene los archivos fuente VHDL, organizados por componentes y módulos.
- **testbench/**: Incluye bancos de pruebas para verificar la funcionalidad de cada componente y de la ALU en conjunto.
- **sim/**: Archivos de simulación y scripts para ModelSim y GHDL.
- **doc/**: Documentación del proyecto, incluyendo especificaciones de diseño e informes de prueba.


## Módulo de Resta de 4 Bits en VHDL

El módulo de resta de 4 bits está diseñado para realizar la operación de resta entre dos números binarios de 4 bits y gestionar el préstamo en caso de que el sustraendo sea mayor que el minuendo. Utiliza la lógica de complemento a dos para llevar a cabo la resta.

### Descripción del Código

#### Librerías

- `IEEE.std_logic_1164`: Proporciona tipos y funciones para manejar señales de lógica digital.
- `IEEE.numeric_std`: Permite manejar vectores de bits como números enteros sin signo (`unsigned`).

#### Entidad `subtractor4b`

- **Entradas**:
  - `a`: Minuendo de 4 bits, representado como un vector de lógica digital (`std_logic_vector`).
  - `b`: Sustraendo de 4 bits, también representado como un vector de lógica digital.

- **Salidas**:
  - `diff`: Resultado de la resta, un vector de 4 bits.
  - `borrow`: Señal de 1 bit que indica si se produjo un préstamo durante la operación de resta.

#### Arquitectura `Behavioral`

La arquitectura define el comportamiento del módulo de resta.

##### Señales Internas

- `a_unsigned`: Conversión del minuendo `a` a un número sin signo para realizar operaciones aritméticas.
- `b_unsigned`: Conversión del sustraendo `b` a un número sin signo.
- `temp_result`: Variable interna que almacena el resultado intermedio de la resta, incluyendo el bit de préstamo.

##### Proceso de Resta

1. **Conversión a `unsigned`**:
   - `a` y `b` se convierten a tipo `unsigned` para permitir la suma y resta de manera aritmética.

2. **Cálculo del Complemento a Dos**:
   - La resta se lleva a cabo sumando el complemento a dos del sustraendo `b_unsigned` al minuendo `a_unsigned`.
   - Ambos números se extienden a 5 bits para incluir el bit de préstamo en el cálculo.

3. **Asignación de Resultados**:
   - El resultado de la resta (`diff`) se extrae de los 4 bits menos significativos de `temp_result`.
   - El bit de préstamo se obtiene del bit más significativo de `temp_result`. Si este bit es 1, `borrow` será 0, indicando que se requirió un préstamo.

### Ejemplo de Uso

Para `a = "0010"` (2 en decimal) y `b = "0011"` (3 en decimal):

- El resultado (`diff`) será `"1111"`, que es -1 en complemento a dos para un vector de 4 bits.
- La señal `borrow` será `'1'`, indicando que se produjo un préstamo durante la resta.

Este módulo es fundamental para realizar operaciones de resta en diseños digitales donde se necesitan manejar números negativos o detectar préstamos.

![Modulo de Resta](doc/img/subtrastor.png)

## Módulo de Multiplicación de 4 Bits en VHDL

Este módulo implementa un multiplicador de 4 bits utilizando el lenguaje VHDL. La multiplicación se realiza sin recurrir a bibliotecas aritméticas avanzadas, utilizando un enfoque basado en la suma de desplazamientos.

### Descripción de la Entidad

La entidad `multiplier4b` define los puertos del módulo:

- **Entradas:**
  - `a`: Multiplicando de 4 bits (tipo `std_logic_vector(3 downto 0)`).
  - `b`: Multiplicador de 4 bits (tipo `std_logic_vector(3 downto 0)`).

- **Salida:**
  - `product`: Producto de 8 bits (tipo `std_logic_vector(7 downto 0)`), que es el resultado de la multiplicación de `a` y `b`.

### Arquitectura

La arquitectura `Behavioral` del módulo utiliza un proceso para realizar la multiplicación mediante suma de desplazamientos. Aquí está la explicación paso a paso de cómo funciona el código:

1. **Extensión del Multiplicando:**
   - El multiplicando `a` se extiende a 8 bits para manejar la multiplicación, agregando ceros en los bits más significativos. Esto se realiza con la concatenación `"0000" & a`.

2. **Bucle de Multiplicación:**
   - Se utiliza un bucle `for` que itera sobre cada bit del multiplicador `b`.
   - Si el bit actual del multiplicador es '1', se realiza una suma desplazada. Esto implica desplazar el multiplicando a la izquierda tantas posiciones como indique el índice del bit actual y sumar este valor al producto temporal.
   
3. **Asignación del Producto:**
   - Una vez completado el bucle, el producto calculado se asigna a la salida `product`.

#### Código VHDL

```vhdl
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;  -- Necesario para usar el tipo unsigned

entity multiplier4b is
    port(
        a : in std_logic_vector(3 downto 0);  -- Entrada: Multiplicando de 4 bits.
        b : in std_logic_vector(3 downto 0);  -- Entrada: Multiplicador de 4 bits.
        product : out std_logic_vector(7 downto 0)  -- Salida: Producto de 8 bits.
    );
end entity multiplier4b;

architecture Behavioral of multiplier4b is
begin
    process(a, b)
        variable temp_product: unsigned(7 downto 0) := (others => '0'); -- Almacena el producto temporalmente.
        variable multiplicand: unsigned(7 downto 0) := (others => '0'); -- Almacena el multiplicando extendido a 8 bits.
        variable multiplier: std_logic_vector(3 downto 0); -- Almacena el multiplicador.
    begin
        multiplicand := unsigned("0000" & a); -- Extiende 'a' a 8 bits.
        multiplier := b;

        for i in 0 to 3 loop
            if multiplier(i) = '1' then
                -- Desplaza el multiplicando y suma al producto temporal.
                temp_product := temp_product + shift_left(multiplicand, i);
            end if;
        end loop;

        product <= std_logic_vector(temp_product); -- Asigna el producto a la salida.
    end process;
end architecture Behavioral;
```


![esquematico multiplicador](doc/img/esquematico_multiplicador.png)

## Requisitos

Para compilar y simular este proyecto, se necesita:

- ModelSim o GHDL para la simulación de archivos VHDL.
- Git para la gestión de versiones.

## Instrucciones de Uso

1. **Clonar el repositorio:**

   ```bash
   git clone https://github.com/cpatagon/ALU_project.git
```
## Estructura de Archivos


```plaintext
Proyecto_ALU/
├── src/
│ ├── components/
│ │ ├── sumador/
│ │ │ ├── sum1b.vhd
│ │ │ └── sumNb.vhd
│ │ ├── restador/
│ │ │ └── restador.vhd
│ │ ├── multiplicador/
│ │ │ └── multiplicador.vhd
│ │ ├── divisor/
│ │ │ └── divisor.vhd
│ │ └── mux.vhd
│ ├── top/
│ │ └── ALU.vhd
│ └── utils/
│ └── packages.vhd
├── testbench/
│ ├── ALU_tb.vhd
│ ├── sumNb_tb.vhd
│ ├── restador_tb.vhd
│ ├── multiplicador_tb.vhd
│ └── divisor_tb.vhd
├── sim/
│ ├── modelsim/
│ │ ├── waves.do
│ │ └── init.do
│ └── ghdl/
├── doc/
│ ├── design_spec.md
│ └── test_report.md
└── work/
```


## Simulaciones 


En la figura N°1 se muestra la salida de una simulación de una parte sumadora de la ALU 

El ejemplo implementado es 

```vhd

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
```

![Simulacion](./doc/img/simulacion_suma.png)
*Fig 1: Vista ModelSim de la simulación ALU* 

## Análisis RTL del Código Fuente 

En vivado dentro de RTL ANALYSIS, Se generaron los esquemáticos de proyecto ALU sumador como se muestran en las figuras 2, 3 y 4. En la última figura se puede ver la vista lógica del sumador.

![diagramaALU](./doc/img/Dia_ALU_SUM.png)
*Fig 2: Vista general diagrama ALU sumador en Vivado* 

![diagramaALUSUM](./doc/img/sumador.png)
*Fig 3: Vista sumador de  diagrama ALU en Vivado* 

![diagramaALUSUM2](./doc/img/vista_logica_sumador.png)
*Fig 4: Vista lógica sumador  ALU en Vivado* 


## Síntesis del sistema y Análsis resumen



![diagramaALUSUM_sumario](./doc/img/Sumario_proyecto.png)
*Fig 5: Vista sumario del proyecto ALU en Vivado* 

![diagramaALUSUM_recurso](./doc/img/utilizacion_recursos.png)
*Fig 6: Vista tabla con los recursos empleados en el  proyecto ALU en Vivado* 

![diagramaALUSUM_esquematico](./doc/img/Esquematica_ALU.png)
*Fig 7: Vista esquemático general con los recursos empleados en el  proyecto ALU en Vivado* 


## Implementación de Sistema

Esta se llevo a cabo a  través del Project Summary Outut y en la figura 8 se puede ver el ruteo de la placa implementada con e código ALU

![diagramaALUSUM_esquematico](./doc/img/ruteo_result.png)
*Fig 8: Vista ruteo realizado del  proyecto ALU en Vivado* 



![diagramaALUSUM_esquematico](./doc/img/sumario_implementacion.png)
*Fig 9: Sumario implementación del  proyecto ALU en Vivado* 


![diagramaALUSUM_esquematico](./doc/img/warning_implementacion.png)
*Fig 10: Vista warning implementacion realizada del  proyecto ALU en Vivado* 


## Simulación en vivado

Se cargo el archivo testbench de la ALU y se configuró el tiempo a 40 ns y se procedió a correr la simulación 
La salida de la simulación se muestra en la figura 11

![diagramaALUSUM_esquematico](./doc/img/salida_simulacion_vivado.png)
*Fig 11: Salida simulación en Vivado del  proyecto ALU en Vivado* 



## Sumario Reportech

```plaintext
Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-------------------------------------------------------------------------------------------------
| Tool Version              : Vivado v.2018.1 (lin64) Build 2188600 Wed Apr  4 18:39:19 MDT 2018
| Date                      : Sun Aug  4 20:11:33 2024
| Host                      : meteo running 64-bit Ubuntu 20.04.6 LTS
| Command                   : report_io -file ALU_io_placed.rpt
| Design                    : ALU
| Device                    : xc7z010
| Speed File                : -1
| Package                   : clg400
| Package Version           : FINAL 2012-10-23
| Package Pin Delay Version : VERS. 2.0 2012-10-23
-------------------------------------------------------------------------------------------------

IO Information

Table of Contents
-----------------
1. Summary
2. IO Assignments by Package Pin

1. Summary
----------

+---------------+
| Total User IO |
+---------------+
|            15 |
+---------------+


2. IO Assignments by Package Pin
--------------------------------

+------------+-------------+------------+-------------------------+---------------+-------------+---------+------------+------+---------------------+----------------------+---------+------------+-----------+----------+------+------------------+--------------+-------------------+--------------+
| Pin Number | Signal Name | Bank Type  | Pin Name                | Use           | IO Standard | IO Bank | Drive (mA) | Slew | On-Chip Termination | Off-Chip Termination | Voltage | Constraint | Pull Type | DQS Bias | Vref | Signal Integrity | Pre Emphasis | Lvds Pre Emphasis | Equalization |
+------------+-------------+------------+-------------------------+---------------+-------------+---------+------------+------+---------------------+----------------------+---------+------------+-----------+----------+------+------------------+--------------+-------------------+--------------+
| A1         |             |            | PS_DDR_DM0_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| A2         |             |            | PS_DDR_DQ2_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| A3         |             |            | VCCO_DDR_502            | VCCO          |             |         |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| A4         |             |            | PS_DDR_DQ3_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| A5         |             |            | PS_MIO6_500             | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| A6         |             |            | PS_MIO5_500             | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| A7         |             |            | PS_MIO1_500             | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| A8         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| A9         |             |            | PS_MIO43_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| A10        |             |            | PS_MIO37_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| A11        |             |            | PS_MIO36_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| A12        |             |            | PS_MIO34_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| A13        |             |            | VCCO_MIO1_501           | VCCO          |             |         |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| A14        |             |            | PS_MIO32_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| A15        |             |            | PS_MIO26_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| A16        |             |            | PS_MIO24_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| A17        |             |            | PS_MIO20_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| A18        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| A19        |             |            | PS_MIO16_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| A20        |             | High Range | IO_L2N_T0_AD8N_35       | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| B1         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| B2         |             |            | PS_DDR_DQS_N0_502       | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| B3         |             |            | PS_DDR_DQ1_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| B4         |             |            | PS_DDR_DRST_B_502       | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| B5         |             |            | PS_MIO9_500             | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| B6         |             |            | VCCO_MIO0_500           | VCCO          |             |         |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| B7         |             |            | PS_MIO4_500             | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| B8         |             |            | PS_MIO2_500             | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| B9         |             |            | PS_MIO51_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| B10        |             |            | PS_SRST_B_501           | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| B11        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| B12        |             |            | PS_MIO48_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| B13        |             |            | PS_MIO50_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| B14        |             |            | PS_MIO47_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| B15        |             |            | PS_MIO45_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| B16        |             |            | VCCO_MIO1_501           | VCCO          |             |         |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| B17        |             |            | PS_MIO22_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| B18        |             |            | PS_MIO18_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| B19        |             | High Range | IO_L2P_T0_AD8P_35       | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| B20        |             | High Range | IO_L1N_T0_AD0N_35       | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| C1         |             |            | PS_DDR_DQ6_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| C2         |             |            | PS_DDR_DQS_P0_502       | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| C3         |             |            | PS_DDR_DQ0_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| C4         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| C5         |             |            | PS_MIO14_500            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| C6         |             |            | PS_MIO11_500            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| C7         |             |            | PS_POR_B_500            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| C8         |             |            | PS_MIO15_500            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| C9         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| C10        |             |            | PS_MIO52_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| C11        |             |            | PS_MIO53_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| C12        |             |            | PS_MIO49_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| C13        |             |            | PS_MIO29_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| C14        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| C15        |             |            | PS_MIO30_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| C16        |             |            | PS_MIO28_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| C17        |             |            | PS_MIO41_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| C18        |             |            | PS_MIO39_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| C19        |             | High Range | VCCO_35                 | VCCO          |             |      35 |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| C20        |             | High Range | IO_L1P_T0_AD0P_35       | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| D1         |             |            | PS_DDR_DQ5_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| D2         |             |            | VCCO_DDR_502            | VCCO          |             |         |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| D3         |             |            | PS_DDR_DQ4_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| D4         |             |            | PS_DDR_A13_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| D5         |             |            | PS_MIO8_500             | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| D6         |             |            | PS_MIO3_500             | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| D7         |             |            | VCCO_MIO0_500           | VCCO          |             |         |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| D8         |             |            | PS_MIO7_500             | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| D9         |             |            | PS_MIO12_500            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| D10        |             |            | PS_MIO19_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| D11        |             |            | PS_MIO23_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| D12        |             |            | VCCO_MIO1_501           | VCCO          |             |         |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| D13        |             |            | PS_MIO27_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| D14        |             |            | PS_MIO40_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| D15        |             |            | PS_MIO33_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| D16        |             |            | PS_MIO46_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| D17        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| D18        |             | High Range | IO_L3N_T0_DQS_AD1N_35   | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| D19        |             | High Range | IO_L4P_T0_35            | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| D20        |             | High Range | IO_L4N_T0_35            | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| E1         |             |            | PS_DDR_DQ7_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| E2         |             |            | PS_DDR_DQ8_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| E3         |             |            | PS_DDR_DQ9_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| E4         |             |            | PS_DDR_A12_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| E5         |             |            | VCCO_DDR_502            | VCCO          |             |         |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| E6         |             |            | PS_MIO0_500             | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| E7         |             |            | PS_CLK_500              | PSS Clock     |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| E8         |             |            | PS_MIO13_500            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| E9         |             |            | PS_MIO10_500            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| E10        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| E11        |             |            | PS_MIO_VREF_501         | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| E12        |             |            | PS_MIO42_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| E13        |             |            | PS_MIO38_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| E14        |             |            | PS_MIO17_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| E15        |             |            | VCCO_MIO1_501           | VCCO          |             |         |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| E16        |             |            | PS_MIO31_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| E17        |             | High Range | IO_L3P_T0_DQS_AD1P_35   | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| E18        |             | High Range | IO_L5P_T0_AD9P_35       | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| E19        |             | High Range | IO_L5N_T0_AD9N_35       | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| E20        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| F1         |             |            | PS_DDR_DM1_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| F2         |             |            | PS_DDR_DQS_N1_502       | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| F3         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| F4         |             |            | PS_DDR_A14_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| F5         |             |            | PS_DDR_A10_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| F6         |             | Dedicated  | TDO_0                   | Config        |             |       0 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| F7         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| F8         |             |            | VCCPAUX                 | PSS VCCAUX    |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| F9         |             | Dedicated  | TCK_0                   | Config        |             |       0 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| F10        |             |            | RSVDGND                 | GND           |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| F11        |             | Dedicated  | VCCBATT_0               | Config        |             |       0 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| F12        |             |            | PS_MIO35_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| F13        |             |            | PS_MIO44_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| F14        |             |            | PS_MIO21_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| F15        |             |            | PS_MIO25_501            | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| F16        |             | High Range | IO_L6P_T0_35            | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| F17        |             | High Range | IO_L6N_T0_VREF_35       | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| F18        |             | High Range | VCCO_35                 | VCCO          |             |      35 |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| F19        |             | High Range | IO_L15P_T2_DQS_AD12P_35 | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| F20        |             | High Range | IO_L15N_T2_DQS_AD12N_35 | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| G1         |             |            | VCCO_DDR_502            | VCCO          |             |         |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| G2         |             |            | PS_DDR_DQS_P1_502       | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| G3         |             |            | PS_DDR_DQ10_502         | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| G4         |             |            | PS_DDR_A11_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| G5         |             |            | PS_DDR_VRN_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| G6         |             | Dedicated  | TDI_0                   | Config        |             |       0 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| G7         |             |            | VCCPINT                 | PSS VCCINT    |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| G8         |             |            | VCCPLL                  | PSS VCCPLL    |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| G9         |             |            | VCCPAUX                 | PSS VCCAUX    |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| G10        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| G11        |             |            | VCCBRAM                 | VCCBRAM       |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| G12        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| G13        |             |            | VCCINT                  | VCCINT        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| G14        |             | High Range | IO_0_35                 | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| G15        |             | High Range | IO_L19N_T3_VREF_35      | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| G16        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| G17        |             | High Range | IO_L16P_T2_35           | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| G18        |             | High Range | IO_L16N_T2_35           | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| G19        |             | High Range | IO_L18P_T2_AD13P_35     | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| G20        |             | High Range | IO_L18N_T2_AD13N_35     | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| H1         |             |            | PS_DDR_DQ14_502         | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| H2         |             |            | PS_DDR_DQ13_502         | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| H3         |             |            | PS_DDR_DQ11_502         | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| H4         |             |            | VCCO_DDR_502            | VCCO          |             |         |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| H5         |             |            | PS_DDR_VRP_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| H6         |             |            | PS_DDR_VREF0_502        | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| H7         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| H8         |             |            | VCCPAUX                 | PSS VCCAUX    |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| H9         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| H10        |             |            | VCCBRAM                 | VCCBRAM       |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| H11        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| H12        |             |            | VCCINT                  | VCCINT        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| H13        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| H14        |             | High Range | VCCO_35                 | VCCO          |             |      35 |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| H15        |             | High Range | IO_L19P_T3_35           | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| H16        |             | High Range | IO_L13P_T2_MRCC_35      | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| H17        |             | High Range | IO_L13N_T2_MRCC_35      | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| H18        |             | High Range | IO_L14N_T2_AD4N_SRCC_35 | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| H19        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| H20        |             | High Range | IO_L17N_T2_AD5N_35      | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| J1         |             |            | PS_DDR_DQ15_502         | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| J2         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| J3         |             |            | PS_DDR_DQ12_502         | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| J4         |             |            | PS_DDR_A9_502           | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| J5         |             |            | PS_DDR_BA2_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| J6         |             | Dedicated  | TMS_0                   | Config        |             |       0 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| J7         |             |            | VCCPINT                 | PSS VCCINT    |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| J8         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| J9         |             | Dedicated  | VCCADC_0                | XADC          |             |       0 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| J10        |             | Dedicated  | GNDADC_0                | XADC          |             |       0 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| J11        |             |            | VCCAUX                  | VCCAUX        |             |         |            |      |                     |                      |    1.80 |            |           |          |      |                  |              |                   |              |
| J12        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| J13        |             |            | VCCINT                  | VCCINT        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| J14        |             | High Range | IO_L20N_T3_AD6N_35      | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| J15        |             | High Range | IO_25_35                | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| J16        |             | High Range | IO_L24N_T3_AD15N_35     | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| J17        |             | High Range | VCCO_35                 | VCCO          |             |      35 |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| J18        |             | High Range | IO_L14P_T2_AD4P_SRCC_35 | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| J19        |             | High Range | IO_L10N_T1_AD11N_35     | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| J20        |             | High Range | IO_L17P_T2_AD5P_35      | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| K1         |             |            | PS_DDR_A8_502           | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| K2         |             |            | PS_DDR_A1_502           | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| K3         |             |            | PS_DDR_A3_502           | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| K4         |             |            | PS_DDR_A7_502           | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| K5         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| K6         |             | Dedicated  | VCCO_0                  | VCCO          |             |       0 |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| K7         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| K8         |             |            | VCCPAUX                 | PSS VCCAUX    |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| K9         |             | Dedicated  | VP_0                    | XADC          |             |       0 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| K10        |             | Dedicated  | VREFN_0                 | XADC          |             |       0 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| K11        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| K12        |             |            | VCCINT                  | VCCINT        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| K13        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| K14        |             | High Range | IO_L20P_T3_AD6P_35      | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| K15        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| K16        |             | High Range | IO_L24P_T3_AD15P_35     | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| K17        |             | High Range | IO_L12P_T1_MRCC_35      | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| K18        |             | High Range | IO_L12N_T1_MRCC_35      | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| K19        |             | High Range | IO_L10P_T1_AD11P_35     | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| K20        |             | High Range | VCCO_35                 | VCCO          |             |      35 |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| L1         |             |            | PS_DDR_A5_502           | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| L2         |             |            | PS_DDR_CKP_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| L3         |             |            | VCCO_DDR_502            | VCCO          |             |         |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| L4         |             |            | PS_DDR_A6_502           | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| L5         |             |            | PS_DDR_BA0_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| L6         |             | Dedicated  | PROGRAM_B_0             | Config        |             |       0 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| L7         |             |            | VCCPINT                 | PSS VCCINT    |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| L8         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| L9         |             | Dedicated  | VREFP_0                 | XADC          |             |       0 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| L10        |             | Dedicated  | VN_0                    | XADC          |             |       0 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| L11        |             |            | VCCAUX                  | VCCAUX        |             |         |            |      |                     |                      |    1.80 |            |           |          |      |                  |              |                   |              |
| L12        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| L13        |             |            | VCCINT                  | VCCINT        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| L14        |             | High Range | IO_L22P_T3_AD7P_35      | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| L15        |             | High Range | IO_L22N_T3_AD7N_35      | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| L16        |             | High Range | IO_L11P_T1_SRCC_35      | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| L17        |             | High Range | IO_L11N_T1_SRCC_35      | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| L18        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| L19        |             | High Range | IO_L9P_T1_DQS_AD3P_35   | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| L20        |             | High Range | IO_L9N_T1_DQS_AD3N_35   | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| M1         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| M2         |             |            | PS_DDR_CKN_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| M3         |             |            | PS_DDR_A2_502           | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| M4         |             |            | PS_DDR_A4_502           | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| M5         |             |            | PS_DDR_WE_B_502         | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| M6         |             | Dedicated  | CFGBVS_0                | Config        |             |       0 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| M7         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| M8         |             |            | VCCPAUX                 | PSS VCCAUX    |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| M9         |             | Dedicated  | DXP_0                   | Temp Sensor   |             |       0 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| M10        |             | Dedicated  | DXN_0                   | Temp Sensor   |             |       0 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| M11        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| M12        |             |            | VCCINT                  | VCCINT        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| M13        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| M14        |             | High Range | IO_L23P_T3_35           | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| M15        |             | High Range | IO_L23N_T3_35           | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| M16        |             | High Range | VCCO_35                 | VCCO          |             |      35 |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| M17        |             | High Range | IO_L8P_T1_AD10P_35      | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| M18        |             | High Range | IO_L8N_T1_AD10N_35      | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| M19        |             | High Range | IO_L7P_T1_AD2P_35       | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| M20        |             | High Range | IO_L7N_T1_AD2N_35       | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| N1         |             |            | PS_DDR_CS_B_502         | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| N2         |             |            | PS_DDR_A0_502           | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| N3         |             |            | PS_DDR_CKE_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| N4         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| N5         |             |            | PS_DDR_ODT_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| N6         |             |            | RSVDVCC3                | Reserved      |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| N7         |             |            | VCCPINT                 | PSS VCCINT    |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| N8         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| N9         |             |            | VCCAUX                  | VCCAUX        |             |         |            |      |                     |                      |    1.80 |            |           |          |      |                  |              |                   |              |
| N10        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| N11        |             |            | VCCAUX                  | VCCAUX        |             |         |            |      |                     |                      |    1.80 |            |           |          |      |                  |              |                   |              |
| N12        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| N13        |             |            | VCCINT                  | VCCINT        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| N14        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| N15        |             | High Range | IO_L21P_T3_DQS_AD14P_35 | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| N16        |             | High Range | IO_L21N_T3_DQS_AD14N_35 | User IO       |             |      35 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| N17        | B[0]        | High Range | IO_L23P_T3_34           | INPUT         | LVCMOS18*   |      34 |            |      |                     |                 NONE |         | UNFIXED    |           |          |      | NONE             |              |                   |              |
| N18        |             | High Range | IO_L13P_T2_MRCC_34      | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| N19        |             | High Range | VCCO_34                 | VCCO          |             |      34 |            |      |                     |                      |    1.80 |            |           |          |      |                  |              |                   |              |
| N20        |             | High Range | IO_L14P_T2_SRCC_34      | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| P1         |             |            | PS_DDR_DQ16_502         | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| P2         |             |            | VCCO_DDR_502            | VCCO          |             |         |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| P3         |             |            | PS_DDR_DQ17_502         | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| P4         |             |            | PS_DDR_RAS_B_502        | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| P5         |             |            | PS_DDR_CAS_B_502        | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| P6         |             |            | PS_DDR_VREF1_502        | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| P7         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| P8         |             |            | VCCPINT                 | PSS VCCINT    |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| P9         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| P10        |             |            | VCCAUX                  | VCCAUX        |             |         |            |      |                     |                      |    1.80 |            |           |          |      |                  |              |                   |              |
| P11        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| P12        |             |            | VCCINT                  | VCCINT        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| P13        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| P14        |             | High Range | IO_L6P_T0_34            | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| P15        | A[2]        | High Range | IO_L24P_T3_34           | INPUT         | LVCMOS18*   |      34 |            |      |                     |                 NONE |         | UNFIXED    |           |          |      | NONE             |              |                   |              |
| P16        | A[1]        | High Range | IO_L24N_T3_34           | INPUT         | LVCMOS18*   |      34 |            |      |                     |                 NONE |         | UNFIXED    |           |          |      | NONE             |              |                   |              |
| P17        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| P18        | A[3]        | High Range | IO_L23N_T3_34           | INPUT         | LVCMOS18*   |      34 |            |      |                     |                 NONE |         | UNFIXED    |           |          |      | NONE             |              |                   |              |
| P19        |             | High Range | IO_L13N_T2_MRCC_34      | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| P20        |             | High Range | IO_L14N_T2_SRCC_34      | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| R1         |             |            | PS_DDR_DQ19_502         | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| R2         |             |            | PS_DDR_DQS_P2_502       | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| R3         |             |            | PS_DDR_DQ18_502         | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| R4         |             |            | PS_DDR_BA1_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| R5         |             |            | VCCO_DDR_502            | VCCO          |             |         |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| R6         |             |            | RSVDVCC2                | Reserved      |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| R7         |             |            | VCCPINT                 | PSS VCCINT    |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| R8         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| R9         |             |            | VCCAUX                  | VCCAUX        |             |         |            |      |                     |                      |    1.80 |            |           |          |      |                  |              |                   |              |
| R10        |             | Dedicated  | INIT_B_0                | Config        |             |       0 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| R11        |             | Dedicated  | DONE_0                  | Config        |             |       0 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| R12        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| R13        |             |            | VCCINT                  | VCCINT        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| R14        |             | High Range | IO_L6N_T0_VREF_34       | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| R15        |             | High Range | VCCO_34                 | VCCO          |             |      34 |            |      |                     |                      |    1.80 |            |           |          |      |                  |              |                   |              |
| R16        | Result[2]   | High Range | IO_L19P_T3_34           | OUTPUT        | LVCMOS18*   |      34 |         12 | SLOW |                     |            FP_VTT_50 |         | UNFIXED    |           |          |      | NONE             |              |                   |              |
| R17        | Result[1]   | High Range | IO_L19N_T3_VREF_34      | OUTPUT        | LVCMOS18*   |      34 |         12 | SLOW |                     |            FP_VTT_50 |         | UNFIXED    |           |          |      | NONE             |              |                   |              |
| R18        | ALU_Sel[1]  | High Range | IO_L20N_T3_34           | INPUT         | LVCMOS18*   |      34 |            |      |                     |                 NONE |         | UNFIXED    |           |          |      | NONE             |              |                   |              |
| R19        |             | High Range | IO_0_34                 | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| R20        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| T1         |             |            | PS_DDR_DM2_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| T2         |             |            | PS_DDR_DQS_N2_502       | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| T3         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| T4         |             |            | PS_DDR_DQ20_502         | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| T5         |             |            | NC                      | Not Connected |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| T6         |             |            | RSVDVCC1                | Reserved      |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| T7         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| T8         |             | Dedicated  | VCCO_13                 | VCCO          |             |      13 |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| T9         |             |            | NC                      | Not Connected |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| T10        |             | High Range | IO_L1N_T0_34            | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| T11        |             | High Range | IO_L1P_T0_34            | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| T12        |             | High Range | IO_L2P_T0_34            | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| T13        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| T14        |             | High Range | IO_L5P_T0_34            | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| T15        |             | High Range | IO_L5N_T0_34            | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| T16        |             | High Range | IO_L9P_T1_DQS_34        | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| T17        | Result[0]   | High Range | IO_L20P_T3_34           | OUTPUT        | LVCMOS18*   |      34 |         12 | SLOW |                     |            FP_VTT_50 |         | UNFIXED    |           |          |      | NONE             |              |                   |              |
| T18        |             | High Range | VCCO_34                 | VCCO          |             |      34 |            |      |                     |                      |    1.80 |            |           |          |      |                  |              |                   |              |
| T19        | A[0]        | High Range | IO_25_34                | INPUT         | LVCMOS18*   |      34 |            |      |                     |                 NONE |         | UNFIXED    |           |          |      | NONE             |              |                   |              |
| T20        |             | High Range | IO_L15P_T2_DQS_34       | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| U1         |             |            | VCCO_DDR_502            | VCCO          |             |         |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| U2         |             |            | PS_DDR_DQ22_502         | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| U3         |             |            | PS_DDR_DQ23_502         | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| U4         |             |            | PS_DDR_DQ21_502         | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| U5         |             |            | NC                      | Not Connected |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| U6         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| U7         |             |            | NC                      | Not Connected |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| U8         |             |            | NC                      | Not Connected |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| U9         |             |            | NC                      | Not Connected |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| U10        |             |            | NC                      | Not Connected |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| U11        |             | Dedicated  | VCCO_13                 | VCCO          |             |      13 |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| U12        |             | High Range | IO_L2N_T0_34            | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| U13        |             | High Range | IO_L3P_T0_DQS_PUDC_B_34 | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| U14        |             | High Range | IO_L11P_T1_SRCC_34      | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| U15        |             | High Range | IO_L11N_T1_SRCC_34      | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| U16        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| U17        |             | High Range | IO_L9N_T1_DQS_34        | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| U18        |             | High Range | IO_L12P_T1_MRCC_34      | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| U19        |             | High Range | IO_L12N_T1_MRCC_34      | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| U20        |             | High Range | IO_L15N_T2_DQS_34       | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| V1         |             |            | PS_DDR_DQ24_502         | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| V2         |             |            | PS_DDR_DQ30_502         | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| V3         |             |            | PS_DDR_DQ31_502         | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| V4         |             |            | VCCO_DDR_502            | VCCO          |             |         |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| V5         |             |            | NC                      | Not Connected |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| V6         |             |            | NC                      | Not Connected |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| V7         |             |            | NC                      | Not Connected |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| V8         |             |            | NC                      | Not Connected |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| V9         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| V10        |             |            | NC                      | Not Connected |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| V11        |             |            | NC                      | Not Connected |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| V12        |             | High Range | IO_L4P_T0_34            | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| V13        |             | High Range | IO_L3N_T0_DQS_34        | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| V14        |             | High Range | VCCO_34                 | VCCO          |             |      34 |            |      |                     |                      |    1.80 |            |           |          |      |                  |              |                   |              |
| V15        |             | High Range | IO_L10P_T1_34           | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| V16        | CarryOut    | High Range | IO_L18P_T2_34           | OUTPUT        | LVCMOS18*   |      34 |         12 | SLOW |                     |            FP_VTT_50 |         | UNFIXED    |           |          |      | NONE             |              |                   |              |
| V17        | ALU_Sel[0]  | High Range | IO_L21P_T3_DQS_34       | INPUT         | LVCMOS18*   |      34 |            |      |                     |                 NONE |         | UNFIXED    |           |          |      | NONE             |              |                   |              |
| V18        | B[3]        | High Range | IO_L21N_T3_DQS_34       | INPUT         | LVCMOS18*   |      34 |            |      |                     |                 NONE |         | UNFIXED    |           |          |      | NONE             |              |                   |              |
| V19        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| V20        |             | High Range | IO_L16P_T2_34           | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| W1         |             |            | PS_DDR_DQ26_502         | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| W2         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| W3         |             |            | PS_DDR_DQ29_502         | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| W4         |             |            | PS_DDR_DQS_N3_502       | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| W5         |             |            | PS_DDR_DQS_P3_502       | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| W6         |             |            | NC                      | Not Connected |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| W7         |             | Dedicated  | VCCO_13                 | VCCO          |             |      13 |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| W8         |             |            | NC                      | Not Connected |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| W9         |             |            | NC                      | Not Connected |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| W10        |             |            | NC                      | Not Connected |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| W11        |             |            | NC                      | Not Connected |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| W12        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| W13        |             | High Range | IO_L4N_T0_34            | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| W14        |             | High Range | IO_L8P_T1_34            | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| W15        |             | High Range | IO_L10N_T1_34           | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| W16        | Result[3]   | High Range | IO_L18N_T2_34           | OUTPUT        | LVCMOS18*   |      34 |         12 | SLOW |                     |            FP_VTT_50 |         | UNFIXED    |           |          |      | NONE             |              |                   |              |
| W17        |             | High Range | VCCO_34                 | VCCO          |             |      34 |            |      |                     |                      |    1.80 |            |           |          |      |                  |              |                   |              |
| W18        | B[2]        | High Range | IO_L22P_T3_34           | INPUT         | LVCMOS18*   |      34 |            |      |                     |                 NONE |         | UNFIXED    |           |          |      | NONE             |              |                   |              |
| W19        | B[1]        | High Range | IO_L22N_T3_34           | INPUT         | LVCMOS18*   |      34 |            |      |                     |                 NONE |         | UNFIXED    |           |          |      | NONE             |              |                   |              |
| W20        |             | High Range | IO_L16N_T2_34           | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| Y1         |             |            | PS_DDR_DM3_502          | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| Y2         |             |            | PS_DDR_DQ28_502         | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| Y3         |             |            | PS_DDR_DQ25_502         | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| Y4         |             |            | PS_DDR_DQ27_502         | PSS IO        |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| Y5         |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| Y6         |             |            | NC                      | Not Connected |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| Y7         |             |            | NC                      | Not Connected |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| Y8         |             |            | NC                      | Not Connected |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| Y9         |             |            | NC                      | Not Connected |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| Y10        |             | Dedicated  | VCCO_13                 | VCCO          |             |      13 |            |      |                     |                      |   any** |            |           |          |      |                  |              |                   |              |
| Y11        |             |            | NC                      | Not Connected |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| Y12        |             |            | NC                      | Not Connected |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| Y13        |             |            | NC                      | Not Connected |             |         |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| Y14        |             | High Range | IO_L8N_T1_34            | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| Y15        |             |            | GND                     | GND           |             |         |            |      |                     |                      |     0.0 |            |           |          |      |                  |              |                   |              |
| Y16        |             | High Range | IO_L7P_T1_34            | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| Y17        |             | High Range | IO_L7N_T1_34            | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| Y18        |             | High Range | IO_L17P_T2_34           | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| Y19        |             | High Range | IO_L17N_T2_34           | User IO       |             |      34 |            |      |                     |                      |         |            |           |          |      |                  |              |                   |              |
| Y20        |             | High Range | VCCO_34                 | VCCO          |             |      34 |            |      |                     |                      |    1.80 |            |           |          |      |                  |              |                   |              |
+------------+-------------+------------+-------------------------+---------------+-------------+---------+------------+------+---------------------+----------------------+---------+------------+-----------+----------+------+------------------+--------------+-------------------+--------------+
* Default value
** Special VCCO requirements may apply. Please consult the device family datasheet for specific guideline on VCCO requirements.
```
