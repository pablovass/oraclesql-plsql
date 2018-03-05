set linesize 800;
/
set pagesize 50000;
/
SELECT * FROM EMPLOYEES; 
DESCRIBE EMPLOYEES;


/* ddl */
/* create - alter - drop */

/* create table nombre_table (
nombre_columna1 datatype ,
nombre_columna2 datatype ,);

*/

create table Alumno(
legajo integer,
Fecha_de_ingreso date,
Nombre VARCHAR2 (30),
Apellido VARCHAR2 (30)
);

select* from Alumno;

DESCRIBE Alumno;

ALTER TABLE  Alumno 
ADD (DNI NUMBER,  E_MAIL VARCHAR2(200));
/*borrar tabla */
drop  alumno;

/*
create view nombre_vista
as 
SELECT from nombre_vista;*/

/*
drop view nombre_vista */
SELECT 


/
create OR REPLACE  view PAISES_DE_EUROPA
as 
SELECT UPPER (COUNTRY_NAME) AS PAIS_EU  FROM COUNTRIES
WHERE REGION_ID= 1;

/
SELECT * FROM  PAISES_DE_EUROPA;
/
/*
CREATE OR REPLACE VIEW VISTA_EMPLEADOS 
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID - 10
WITH CHECK OPTION ;
*/

SELECT * FROM REGIONS; 
SELECT  CITY FROM LOCATIONS;
/
/*ORDER BY */

SELECT *  FROM 
ORDER BY;

/* SINONIMO ES UN ALIAS DE UN SQUEMA  */
/* PRYMARY KEY  == CONSTRAIN */

