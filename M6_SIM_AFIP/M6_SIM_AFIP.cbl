*> ============================================================================
*> PROGRAM-ID : M6_SIM_P3_ANSES
*> PURPOSE    : Validación y clasificación de comprobantes
*> AUTHOR     : Axel Colace
*> DATE       : 01/11/2025
*> ============================================================================

IDENTIFICATION DIVISION.
  PROGRAM-ID. M6_SIM_P3_ANSES.

ENVIRONMENT DIVISION.
  INPUT-OUTPUT SECTION.
  FILE-CONTROL.

    SELECT COMP-IN ASSIGN TO "COMP_IN.txt"
    ORGANIZATION IS LINE SEQUENTIAL
    FILE STATUS IS FS-IN.

    SELECT COMP-OK ASSIGN TO "COMP_OK.txt"
    ORGANIZATION IS LINE SEQUENTIAL
    FILE STATUS IS FS-OK.

    SELECT COMP-ER ASSIGN TO "COMP_ER.txt"
    ORGANIZATION IS LINE SEQUENTIAL
    FILE STATUS IS FS-ER.

    SELECT COMP-PE ASSIGN TO "COMP_PE.txt"
    ORGANIZATION IS LINE SEQUENTIAL
    FILE STATUS IS FS-PE.


DATA DIVISION.
  FILE SECTION.

    FD COMP-IN.
      01 REG-IN.
        05 NC-IN     PIC X(13).
        05 FILLER    PIC X    VALUE "|".
        05 FA-IN     PIC X(8).
        05 FILLER    PIC X    VALUE "|".
        05 CT-IN     PIC X(11).
        05 FILLER    PIC X    VALUE "|".
        05 TO-IN     PIC X(1).
        05 FILLER    PIC X    VALUE "|".
        05 IE-IN     PIC X(9).
        05 FILLER    PIC X    VALUE "|".
        05 EO-IN     PIC X(10).
        05 FILLER    PIC X    VALUE "|".

    FD COMP-OK.
      01 REG-OK.
        05 NC-OK     PIC X(13).
        05 FILLER    PIC X    VALUE "|".
        05 FA-OK     PIC X(8).
        05 FILLER    PIC X    VALUE "|".
        05 CT-OK     PIC X(11).
        05 FILLER    PIC X    VALUE "|".
        05 TO-OK     PIC X(1).
        05 FILLER    PIC X    VALUE "|".
        05 IE-OK     PIC X(9).
        05 FILLER    PIC X    VALUE "|".
        05 EO-OK     PIC X(10).
        05 FILLER    PIC X    VALUE "|".

    FD COMP-ER.
      01 REG-ER.
        05 NC-ER     PIC X(13).
        05 FILLER    PIC X    VALUE "|".
        05 FA-ER     PIC X(8).
        05 FILLER    PIC X    VALUE "|".
        05 CT-ER     PIC X(11).
        05 FILLER    PIC X    VALUE "|".
        05 TO-ER     PIC X(1).
        05 FILLER    PIC X    VALUE "|".
        05 IE-ER     PIC X(9).
        05 FILLER    PIC X    VALUE "|".
        05 EO-ER     PIC X(10).
        05 FILLER    PIC X    VALUE "|".
        05 MO-ER     PIC X(7).

    FD COMP-PE.
      01 REG-PE.
        05 NC-PE     PIC X(13).
        05 FILLER    PIC X    VALUE "|".
        05 FA-PE     PIC X(8).
        05 FILLER    PIC X    VALUE "|".
        05 CT-PE     PIC X(11).
        05 FILLER    PIC X    VALUE "|".
        05 TO-PE     PIC X(1).
        05 FILLER    PIC X    VALUE "|".
        05 IE-PE     PIC X(9).
        05 FILLER    PIC X    VALUE "|".
        05 EO-PE     PIC X(10).
        05 FILLER    PIC X    VALUE "|".

  WORKING-STORAGE SECTION.

    77 FS-IN         PIC XX.
    77 FS-OK         PIC XX.
    77 FS-ER         PIC XX.
    77 FS-PE         PIC XX.

    77 FIN           PIC X    VALUE "N".

    77 CON-IN        PIC 9(2) VALUE ZEROS.
    77 CON-OK        PIC 9(2) VALUE ZEROS.
    77 CON-ER        PIC 9(2) VALUE ZEROS.

    77 CON-ER-NC     PIC 9(2) VALUE ZEROS.
    77 CON-ER-FA     PIC 9(2) VALUE ZEROS.
    77 CON-ER-CT     PIC 9(2) VALUE ZEROS.
    77 CON-ER-TO     PIC 9(2) VALUE ZEROS.
    77 CON-ER-IE     PIC 9(2) VALUE ZEROS.
    77 CON-ER-EO     PIC 9(2) VALUE ZEROS.
    77 CON-PE        PIC 9(2) VALUE ZEROS.


PROCEDURE DIVISION.

*> ==========================================================
*> SECCIÓN: PROCESO DE INICIALIZACION DE ARCHIVOS Y CONTROL.
*> ==========================================================

  OPEN INPUT  COMP-IN
       OUTPUT COMP-OK
       OUTPUT COMP-ER
       OUTPUT COMP-PE

  IF FS-IN NOT = "00"
      DISPLAY "Error al abrir el archivo de ingreso, FILE STATUS: " FS-IN
      STOP RUN
  END-IF

  IF FS-OK NOT = "00"
      DISPLAY "Error al crear el archivo de salida 'ok', FILE STATUS:" FS-OK
      STOP RUN
  END-IF

  IF FS-ER NOT = "00"
      DISPLAY "Error al abrir el archivo de salida 'error', FILE STATUS:" FS-ER
      STOP RUN
  END-IF

  IF FS-PE NOT = "00"
      DISPLAY "Error al abrir el archivo de salida 'pend.', FILE STATUS:" FS-PE
      STOP RUN
  END-IF

*> ==========================================================
*> SECCIÓN: LECTURA Y CLASIFICACIÓN DE REGISTROS.
*> ==========================================================

  PERFORM UNTIL FIN = "1"
    READ COMP-IN
      AT END
        MOVE "1" TO FIN
      NOT AT END
        ADD 1 TO CON-IN
        MOVE REG-IN TO REG-OK
        MOVE REG-IN TO REG-ER
        MOVE REG-IN TO REG-PE
        PERFORM FILTRO
    END-READ
    IF FS-IN NOT = "00" AND FS-IN NOT = "10"
      DISPLAY "Error al leer archivo de ingreso, FILE STATUS: " FS-IN
      MOVE "S" TO FIN
      STOP RUN
    END-IF
  END-PERFORM


*> ==========================================================
*> SECCIÓN: MENSAJES A MOSTRAR EN PANTALLA.
*> ==========================================================

  DISPLAY "Total de registros leidos:    " CON-IN
  DISPLAY "Total de registros correctos: " CON-OK
  DISPLAY "Total de registros erroneos:  " CON-ER
  DISPLAY "Total de registros pendientes:" CON-PE
  DISPLAY "--------------------------------"
  DISPLAY "Errores por motivo:"
  DISPLAY "  NRO/FORMATO: " CON-ER-NC
  DISPLAY "  FECHA:       " CON-ER-FA
  DISPLAY "  CUIT:        " CON-ER-CT
  DISPLAY "  TIPO:        " CON-ER-TO
  DISPLAY "  IMPORTE:     " CON-ER-IE
  DISPLAY "  ESTADO:      " CON-ER-EO

  DISPLAY "---------FIN DE PROCESO---------"

  CLOSE COMP-IN
        COMP-OK
        COMP-ER
        COMP-PE
  STOP RUN.

*> ==========================================================
*> SECCIÓN: PROCESO DE CLASIFICACION DE ERRORES Y PENDIENTES.
*> ==========================================================

  FILTRO.
    EVALUATE TRUE
      WHEN NOT NC-IN(1:4) IS NUMERIC
        MOVE "NRO-COM" TO MO-ER
        WRITE REG-ER
        ADD 1 TO CON-ER
        ADD 1 TO CON-ER-NC
      WHEN NC-IN(5:1) NOT = "-"
        MOVE "NRO-COM" TO MO-ER
        WRITE REG-ER
        ADD 1 TO CON-ER
        ADD 1 TO CON-ER-NC
      WHEN NOT NC-IN(6:8) IS NUMERIC
        MOVE "NRO-COM" TO MO-ER
        WRITE REG-ER
        ADD 1 TO CON-ER
        ADD 1 TO CON-ER-NC

      WHEN NOT FA-IN IS NUMERIC
        MOVE "FECHA"   TO MO-ER
        WRITE REG-ER
        ADD 1 TO CON-ER
        ADD 1 TO CON-ER-FA

      WHEN NOT (TO-IN = "A" OR TO-IN = "B" OR TO-IN = "C")
        MOVE "TIPO"      TO MO-ER
        WRITE REG-ER
        ADD 1 TO CON-ER
        ADD 1 TO CON-ER-TO

      WHEN IE-IN = "000000000"
        MOVE "IMPORTE" TO MO-ER
        WRITE REG-ER
        ADD 1 TO CON-ER
        ADD 1 TO CON-ER-IE

      WHEN NOT (EO-IN = "AUTORIZADO" OR EO-IN = "PENDIENTE"
                OR EO-IN = "RECHAZADO")
        MOVE "ESTADO" TO MO-ER
        WRITE REG-ER
        ADD 1 TO CON-ER
        ADD 1 TO CON-ER-EO

      WHEN EO-IN = "PENDIENTE"
        WRITE REG-PE
        ADD 1 TO CON-PE

      WHEN EO-IN = "RECHAZADO"
        MOVE "ESTADO" TO MO-ER
        WRITE REG-ER
        ADD 1 TO CON-ER
        ADD 1 TO CON-ER-EO

      WHEN OTHER
        WRITE REG-OK
        ADD 1 TO CON-OK

    END-EVALUATE.
