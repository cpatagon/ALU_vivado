# Pasos para Ejecutar ModelSim con un Nuevo Proyecto

## 1. Iniciar ModelSim

**Abrir ModelSim:**
- Abre ModelSim desde tu entorno de desarrollo o directamente desde la línea de comandos escribiendo `vsim` en la terminal.

## 2. Crear un Nuevo Proyecto

**Crear un Proyecto:**
- En la ventana principal de ModelSim, ve a `File > New > Project...`.
- Asigna un nombre al proyecto, por ejemplo, `ALU_Project`.
- Elige un directorio donde guardarás los archivos del proyecto. Asegúrate de que sea un directorio limpio y bien organizado.

**Configurar el Proyecto:**
- En la ventana de configuración, selecciona `Add existing file` para añadir los archivos VHDL que ya has creado (por ejemplo, `sum1b.vhd`, `sumNb.vhd`, `ALU.vhd`, y `ALU_tb.vhd`).
- Si los archivos están en diferentes ubicaciones, navega a cada uno de ellos y añádelos al proyecto.

## 3. Compilar los Archivos VHDL

**Seleccionar Archivos para Compilación:**
- En la ventana de **Library** en ModelSim, asegúrate de que la biblioteca `work` esté seleccionada.
- Selecciona los archivos VHDL (`sum1b.vhd`, `sumNb.vhd`, `ALU.vhd`, y `ALU_tb.vhd`) y compílalos haciendo clic derecho y seleccionando `Compile > Compile Selected`.

**Verificar la Compilación:**
- Revisa la ventana de **Transcript** para asegurarte de que no haya errores de compilación. Si ves errores, verifica el código VHDL y corrige cualquier problema.

## 4. Iniciar la Simulación

**Abrir la Ventana de Simulación:**
- Ve a `Simulate > Start Simulation`.
- En la ventana de "Start Simulation", navega hasta la biblioteca `work`, expándela, y selecciona el archivo de banco de pruebas `ALU_tb`.

**Configurar la Simulación:**
- En la ventana de simulación, selecciona las señales que deseas observar desde la sección de **Objects** (como `A`, `B`, `ALU_Sel`, `Result`, `CarryOut`).
- Arrastra estas señales a la ventana de **Wave** para poder visualizarlas durante la simulación.

**Ejecutar la Simulación:**
- Utiliza los controles en la parte superior de ModelSim para correr la simulación:
  - **Run:** Ejecuta la simulación por un periodo de tiempo específico. Puedes ingresar un valor en nanosegundos (e.g., `100 ns`) y presionar Enter.
  - **Restart:** Reinicia la simulación desde el principio si necesitas ejecutar nuevos cambios o ajustes.
  - **Pause/Stop:** Pausa o detiene la simulación si deseas observar un momento específico en el tiempo.

**Verificar los Resultados:**
- Observa las formas de onda generadas en la ventana de **Wave**. Verifica que las salidas de la ALU sean correctas para las operaciones de suma probadas en tu banco de pruebas.

## Consejos Adicionales

- **Guardar Configuraciones:** Una vez que hayas configurado las ondas y la simulación, guarda tu configuración para que sea fácil de ejecutar en el futuro.
- **Documentar Resultados:** Mantén un registro de los resultados de las simulaciones para comparar y validar en futuras pruebas.
