
/*
1 Elaborar una sentencia SQL que permita crear la tabla CURSOS. La configuraci?n de
los campos debe ser
*/

CREATE TABLE CURSOS(
CURSO_ID NUMBER NOT NULL,
CURSO_NOMBRE VARCHAR2(50) NOT NULL,
CURSO_DOCENTE NUMBER NOT NULL
);
/*
2. Elaborar una sentencia SQL que permita modificar la tabla CURSOS agreg?ndole una
primary key sobre el campo CURSO_ID.
*/
ALTER TABLE CURSOS 
ADD CONSTRAINT PK_CURSOS PRIMARY KEY (CURSO_ID);
/*
3. Elaborar una sentencia SQL que permita modificar la tabla CURSOS 
agreg?ndole una foreign key sobre el campo CURSO_DOCENTE que referencie hacia el campo EMPLOYEE_ID de la tabla EMPLOYEES.
*/

ALTER TABLE CURSOS 
ADD CONSTRAINT FK_CURSO_DOCENTE FOREIGN KEY (CURSO_DOCENTE)
REFERENCES EMPLOYEES (EMPLOYEE_ID);

/*
Elaborar una sentencia SQL que permita crear la tabla CURSOS_CONFIRMADOS. La configuraci?n de los campos debe ser:
*/
/
CREATE TABLE CURSOS_CONFIRMADOS (
CURSO_ID NUMBER NOT NULL,
FECHA DATE,
LOCATION_ID NUMBER, 
HORA_INICIO VARCHAR2(10),
HORA_FIN  VARCHAR2
);
/*
Incluir en la sentencia de creaci?n la generaci?n de la clave primaria formada por los campos CURSO_ID y FECHA.
Incluir tambi?n la creaci?n de la clave for?nea en el campo LOCATION_ID que referencia al campo LOCATION_ID de la tabla LOCATIONS
*/
ALTER TABLE CURSOS_CONFIRMADOS 
ADD CONSTRAINT PK_CURSO_ID PRIMARY KEY (CURSO_ID);

ALTER TABLE CURSOS_CONFIRMADOS 
ADD CONSTRAINT PK_FECHA PRIMARY KEY (FECHA);
SELECT * FROM CURSOS_CONFIRMADOS;