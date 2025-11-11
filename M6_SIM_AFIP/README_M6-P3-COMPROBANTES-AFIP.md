# 📘 Objetivo funcional

Este programa batch procesa un archivo de comprobantes provenientes de
entidades administrativas (similares a AFIP). Su función es leer cada registro,
aplicar reglas de validación predefinidas y clasificar los resultados en tres
salidas: comprobantes validados, rechazados y pendientes.
Al finalizar, genera un resumen del proceso con contadores de registros leídos,
validados, rechazados y pendientes, mostrando los totales por pantalla.

---

# ⚙️ Estructura general

La estructura tiene sus Divisions: IDENTIFICATION definiendo nombre
descriptivo; ENVIRONMENT con la descripción de cada archivo utilizado, tanto la
del INPUT como la de los OUTPUT; DATA aplicando tanto las descripciones
estructurales, como definiendo variables que se utilizarán en el programa;
PROCEDURE donde finalmente se abren los archivos a utilizar, se leen y aplican
las reglas del negocio mediante estructuras condicionales, además de la
constante actualización de los contadores con su DISPLAY final.

---

# 🧱 Entradas

El único INPUT es el archivo de comprobantes de la entidad emisora (COMP-IN), de
organización LINE SEQUENTIAL. De ese mismo, en la FILE SECTION, se describe
cómo está compuesto cada registro del archivo, sus campos, con un FILLER "|"
que marca la separación entre ellos, que son: NOMBRE, FECHA, CUIT, TIPO,
IMPORTE y ESTADO.

---

# 📤 Salidas

El programa genera tres archivos de salida (LINE SEQUENTIAL) resultantes del
procesamiento principal: COMP-OK, donde se almacenan los registros validados;
COMP-ER, que será el destino de los registros no validados, con un campo extra
dedicado al motivo del rechazo; luego, COMP-PE almacena los registros válidos
cuyo estado es "PENDIENTE". Finalmente, el programa muestra por pantalla los
contadores finales del proceso mediante los DISPLAY.

---

# 🔍 Control de errores y validaciones

Ya desde el FILE-CONTROL están definidos los FILE STATUS, que controlan. En la
FILE SECTION están definidas las longitudes que debe respetar cada campo.
Las longitudes de cada campo son: NOMBRE PIC X(13), FECHA PIC X(8),
CUIT PIC X(11), TIPO PIC X(1), IMPORTE PIC X(9) y ESTADO PIC X(10).
Todos con PIC X para facilitar la manipulación textual y la validación de
estructura. También está la variable FIN-PROCESO, que controla la finalización
del ciclo de lectura mediante PERFORM UNTIL FIN-PROCESO = "S". Además, las
estructuras EVALUATE e IF regulan el cumplimiento de ciertas reglas en su
rol de condicionales.

---

# 📈 Resultado esperado

Al final del ciclo del programa se obtienen los tres resultados del análisis
del archivo ingresado: se tendrá un archivo para los registros validados, otro
para los rechazados con su respectivo motivo indicado y un último para los
válidos pero con estado pendiente. Luego, en pantalla se muestra un resumen con
el número de registros evaluados. La ejecución correcta confirma que los
archivos se procesaron sin errores de entorno y que todas las validaciones se
aplicaron con éxito.

---

# 🧠 Observaciones técnicas

Durante la implementación se priorizó la claridad del flujo lógico y la
optimización del bloque EVALUATE, reduciendo código redundante dentro de los
condicionales. El diseño favorece la trazabilidad del proceso y la comprensión
del flujo batch, aplicando buenas prácticas de redacción COBOL puro. Este
ejercicio consolidó la comprensión del manejo de archivos y control secuencial,

sirviendo como base sólida para la posterior integración con JCL y DB2.
