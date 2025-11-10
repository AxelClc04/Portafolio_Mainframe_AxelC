📘 Objetivo funcional

Este JOB busca generar un archivo, luego evaluarlo y derivarlo a otros dos: uno
de registros validados y otro de errores. Este último servirá para la parte
final del JOB, donde se hará una auditoría de esos registros no válidos. El
sistema mostrará por pantalla el resultado de cada STEP.



⚙️ Estructura general

La estructura comienza con la definición del JOB y sus clases. Le sigue el
primer STEP, en el cual se genera un archivo de padrón; luego se muestra el
resultado en pantalla y se continúa al próximo STEP, donde se realizará el
proceso de lectura de los registros del archivo generado en el STEP anterior.
De allí se generarán dos archivos nuevos: uno de registros válidos y otro de
registros erróneos. En caso de que el RC del STEP anterior sea mayor a cero, se
procede al último STEP, donde se hará una auditoría de esos registros erróneos,
y finalmente se mostrarán los resultados en pantalla.

🧱 Entradas

Los programas son las entradas principales de este JOB; estos mismos dan
sentido a este flujo de trabajo.


📤 Salidas

En el caso de las salidas de este JOB, tenemos los archivos generados. El
primero es un padrón, el cual es utilizado por el STEP2, que a su vez genera
dos nuevos archivos: uno de padrón validado y otro de invalidados. Para cerrar
el JOB, el padrón de invalidados pasa a un proceso de auditoría, el cual genera
un registro de errores, y finalmente los SYSOUT son otras de las salidas de
este JOB.


🔍 Control de errores y validaciones

En el JOB se establecen controles de error desde el principio, como las CLASS,
y para finalizar un IF en conjunto con el RC regulan la validación de un STEP
previo al último, que finaliza el proceso.


📈 Resultado esperado

Lo que hace el JOB es generar un padrón nuevo, analizarlo y derivarlo en dos
padrones: uno de válidos y otro de inválidos. Este último será procesado en un
programa que generará un registro de esos errores. Finalmente, se mostrarán en
pantalla los resultados del proceso.


🧠 Observaciones técnicas

Este esquema de JCL me permitió afianzar los conocimientos de sintaxis de un
JOB, logrando implementar varios STEP y un bloque condicional que actúa con un
RC, controlando el flujo del JOB.