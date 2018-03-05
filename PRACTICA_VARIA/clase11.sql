-- ejemplo

--CURSOR SIN PARAMETROS

DECLARE CURSOR NOMBRE_CURSOR 
IS 
SELECT CAMPO1 [,CAMPO2,CAMPO3,…] 
FROM TABLA; 
BEGIN  SENTENCIAS ... 

END;

--CURSOR CON PARAMETROS
 DECLARE CURSOR NOMBRE_CURSOR (PARAMETRO NUMBER)
  IS 
 SELECT CAMPO1 [,CAMPO2,CAMPO3,…] 
 FROM TABLA 
 WHERE CAMPO_X = PARAMETRO ; 
 BEGIN  SENTENCIAS ...
 END;

 Apertura de Cursores
 Si la consulta no devuelve ninguna fila, no se producirá ninguna excepción al abrir el cursor
 --CURSOR SIN PARAMETROS 
 OPEN nombre_cursor; 
 --CURSOR CON PARAMETROS
 OPEN nombre_cursor(valor1, valor2);


--FETCH INTO VARIABLES
FETCH nombre_cursor INTO var1[,var2,…);
--FETCH INTO REGISTRO 
FETCH nombre_cursor INTO registro;

-- cierres de cursores 
* al finalisar el prosesamiento de las filas se debe cerrar el cursos
* No se pueden recuperar datos de un cursosr una vez que hasido cerrado (exeception INVALID_CURSOR)
-- CURSOSR CON / SIN PARAMETROS 
CLOSE NOMBRE_CURSOSR;

-- VARIABLES PARA CURSORES 
DECLARE 
    CURSOR NOMBRE_CURSOR
    IS 
  SELECT CAMPO1 , CAMPO2 
  FROM NOMBRE_TABLA; VARIABLE1 NOMBRE_TABLA.CAMPO1%TYPE; 
  
  VARIABLE2 NOMBRE_TABLA.CAMPO2%TYPE;
BEGIN 
OPEN NOMBRE_CURSOR; 
FETCH NOMBRE_CURSOR 
INTO VARIABLE1,VARIABLE2; 

DBMS_OUTPUT.PUT_LINE(VARIABLE1); 
DBMS_OUTPUT.PUT_LINE(VARIABLE2); 
CLOSE NOMBRE_CURSOR; 

END

--VARIABLES PARA CURSORES 
DECLARE 
    CURSOR NOMBRE_CURSOR 
    IS 
    SELECT * 
      FROM NOMBRE_TABLA;
      REGISTRO NOMBRE_TABLA%ROWTYPE;
BEGIN
  OPEN NOMBRE_CURSOR; 
  FETCH NOMBRE_CURSOR 
  INTO REGISTRO; 
  
  DBMS_OUTPUT.PUT_LINE(REGISTRO.CAMPO1); 
  DBMS_OUTPUT.PUT_LINE(REGISTRO.CAMPO2); 
CLOSE NOMBRE_CURSOR; 
END;

/*
UTILISACION DE CURSORES 

*No se puede leer un cursor que está cerrado
?El motor arrojará un error al intentar cerrar un cursor ya cerrado o que no haya sido abierto
?Al recuperar datos de un cursor se recomienda comprobar el resultado de lectura utilizando los atributos de los cursores

*/ 

--VERIFICACION DE CURSOR ABIERTO 
IF NOT NOMBRE_CURSOR%ISOPEN THEN 
  OPEN NOMBRE_CURSOR;
  END IF;
  
 --VERIFICACION DE CURSOR CON DATOS
 
 LOOP 
    FETCH NOMBRE_CURSOR INTO REGISTRO;
    EXIT WHEN NOMBRE_CURSOR%NOTFOUND; 
    
    DBMS_OUTPUT.PUT_LINE(REGISTRO.CAMPO);
  END LOOP; 
  
  --VERIFICACION ANTES DE CERRAR CURSOR 
  IF NOMBRE_CURSOR%ISOPEN THEN 
  CLOSE NOMBRE_CURSOR; 
  END IF;
  
  /* pODEMOS ITERAR A TRAVES DE LOS REGISTROS DEL CURSOR MEDIANTE LOP */
  --LOOP + EXIT 
  OPEN nombre_cursor; 
   LOOP 
   FETCH nombre_cursor INTO registro; 
   EXIT WHEN nombre_cursor%NOTFOUND;
   
   /* Procesamiento de los registros recuperados */
   END LOOP; 
   CLOSE nombre_cursor;
  
  --PODEMOS ITERAR A TRAVES DELOS REGISTROS DEL CURSOS MEDIANTE LOOP Y WHILE. LA INSTRUCCION FECH APARECE DOS VECES 
  --LOOP +WHILE
  OPEN nombre_cursor; 
  FETCH nombre_cursor INTO registro; 
  WHILE nombre_cursor%FOUND; 
  LOOP 
  /* Procesamiento de los registros recuperados */ 
  FETCH nombre_cursor INTO registro; 
    END LOOP; 
    CLOSE nombre_cursor;  
/*Utilizando cursores mostrar en pantalla los nombres de los empleados que son programadores
(JOB_ID = 'IT_PROG').
Mostrar únicamente 3 registros.*/