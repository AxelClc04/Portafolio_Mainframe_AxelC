📘 Objetivo funcional

El programa batch evalúa un número de legajo y de salario actual para iniciar
un proceso de actualización de sueldo o registro de nuevo usuario. Se encarga
de consultar las tablas SQL para obtener la información que valide el proceso y
para modificarla también.


⚙️ Estructura general

Su estructura está optimizada para ejecutar una función de consulta, tal que se
omite la ENVIRONMENT DIVISION al no requerir archivos INPUT. De principio se
define la IDENTIFICATION asignando el ID M9_P2_MANTENIMIENTO. Luego, en la DATA
se definen las variables host para el proceso DB2. Ya en la PROCEDURE se
solicitan los datos de legajo para búsqueda; nombre, en caso de registrar un
nuevo usuario; y salario, para actualizar o registrar. En esta última DIVISION
es donde se realiza el proceso de validación con uso del IF. Finalmente, si el
proceso fue exitoso se setea el RETURN-CODE y se detiene el programa.


🧱 Entradas

Los INPUT son tanto la tabla SQL a procesar como los datos solicitados al
usuario: WS-LEGAJO, WS-NOMBRE y WS-SALARIO. Estos datos son los utilizados para
realizar la consulta.


📤 Salidas

Como OUTPUT se encuentran varios DISPLAY, así como los cambios ejecutados en la
tabla SQL.


🔍 Control de errores y validaciones

De principio, en la DATA DIVISION se establece la inclusión de SQL en el
proceso y también se definen las variables con sus normas de cada campo,
marcando tipo y longitud. Estas son: WS-LEGAJO PIC 9(4), WS-NOMBRE PIC X(20),
WS-SALARIO PIC 9(7). Todo esto garantiza el funcionamiento de la consulta DB2 y
también la correcta asignación de datos a las variables utilizadas. Además, el
control para la validación completa sucede con los IF y las consultas al estado
de SQLCODE.


📈 Resultado esperado

Lo que se logra al utilizar el programa es realizar la consulta, validación y
registro de los salarios de usuarios existentes o el registro de los nuevos.
Logrando así también identificar casos de error.


🧠 Observaciones técnicas

En este programa se logró realizar una estructura de consulta DB2 con un código
simple y corto, simplificando la lectura, el análisis y las posibles
modificaciones. Se utilizaron las funciones UPDATE e INSERT, consolidando la
relación COBOL-SQL.