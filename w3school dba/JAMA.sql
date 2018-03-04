
SELECT R.REGION_NAME , C.COUNTRY_NAME
FROM REGIONS R
RIGHT OUTER  JOIN COUNTRIES C 
ON R.REGION_ID = C.REGION_ID
ORDER BY R.REGION_ID,
C.COUNTRY_NAME;


SELECT * FROM nombre_alumno;


ALTER TABLE NOMBRE_ALUMNO 
ADD E_Mail varchar2 (100);


SELECT *
FROM NOMBRE_ALUMNO;

insert into NOMBRE_ALUMNO (nombre, apellido, escuela, dni, e_mail)
values ('Pablo','Vallejos','Davinci','1222222', 'vallejos@live.com');

ALTER TABLE NOMBRE_ALUMNO 
ADD fecha  date ;


insert into NOMBRE_ALUMNO (FECHA)
values  ( TO_DATE ('10-3-2015','DD-MON-YY'));

VI
