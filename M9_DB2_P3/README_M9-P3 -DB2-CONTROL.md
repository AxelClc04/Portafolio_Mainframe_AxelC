# 📘 Objetivo funcional

Este programa batch tiene como objetivo recibir un archivo de registros
salariales de usuarios, evaluarlos y actualizar una tabla SQL. También, para los
casos de error, genera un archivo de registros erróneos para un mayor control de
los casos. Para terminar, cuenta con DISPLAY de contadores que muestran en la
pantalla los registros leídos y su resultado según la evaluación del programa.

---

# ⚙️ Estructura general

El programa cuenta con una estructura robusta, con todas las DIVISION,
como la IDENTIFICATION, que define al programa como M9_P3_BATCH_DB2; la
ENVIRONMENT, que define los archivos a utilizar en el programa dándoles una
ORGANIZATION IS LINE SEQUENTIAL, y con sus correspondientes FILE STATUS; luego,
en la DATA se definen los registros de cada archivo con sus campos, y también
se establecen las variables a utilizar, como los FS, los host para SQL, los
contadores, y además se sentencia la implementación de SQL. Finalmente, en la
PROCEDURE sucede el proceso de lectura, análisis y modificación, junto con la
actualización constante de los contadores, que son mostrados al final del
proceso mediante DISPLAY.

---

# 🧱 Entradas

Las entradas que recibe el programa son dos: primero está el archivo que en la
ENVIRONMENT se definió como IN-SUELDOS; con ese mismo se inicia el flujo y, como
todo archivo, tiene en la DATA sus campos definidos dentro del registro. Estos
son: IN-LEGAJO, IN-NOMBRE, IN-SALARIO, y entre ellos un FILLER que da una
separación visual para facilitar la lectura. La segunda es la tabla EMPLEADOS,
a la que se accede para actualizar o ingresar registros.

---

# 📤 Salidas

En el caso de las salidas del programa, contamos con el archivo “.txt” de error,
donde irán todos los registros inválidos. Este también está definido en la DATA
con sus campos, aunque se reemplaza el SALARIO por un SQLCOD-ER, donde se
marcará el error dentro del proceso. Luego, las modificaciones serán efectuadas
en la tabla SQL EMPLEADOS mediante el uso de las variables host de la WS.

---

# 🔍 Control de errores y validaciones

El programa posee varios puntos de control, como los FILE STATUS, que permiten
conocer los posibles códigos que devolverán al operar con los archivos afines.
En la DATA están definidos los tipos de variable junto con su longitud, como
por ejemplo: IN-LEGAJO PIC 9(5), entre otras. También se trabaja con el
RETURN-CODE y el SQLCODE para manipular el control de errores. Finalmente, vale
mencionar el trabajo de las funciones IF, PERFORM y EVALUATE dentro del
proceso, ya que controlan el flujo y validan según las reglas establecidas.

---

# 📈 Resultado esperado

El resultado de este programa será la actualización de la tabla EMPLEADOS en su
respectiva base SQL. Para los casos no validados, se espera recibir un archivo
“.txt” donde también se indique el error SQL del proceso. Como parte del
resumen, se mostrarán al final del proceso los contadores de los registros
procesados mediante DISPLAY.

---

# 🧠 Observaciones técnicas

En este programa se pudo integrar todo el conocimiento de COBOL y DB2,
creando así un programa con un flujo de control completo en la ejecución de

COBOL y la manipulación de tablas SQL.
