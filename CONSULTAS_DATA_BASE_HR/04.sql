/*
  1. crear una función llamada year que reciba un parámetro de tipo fecha y retorne el año correspondiente.
  elaborar una sentencia sql que retorne los empleados que ingresaron en el año 2007 utilizando la función year.
*/

create or replace

function year(fechaentrada date)
return number
is
  años number;
begin
  años := to_char(fechaentrada,'yyyy');
  return años;
end year;
/


select (first_name || ' ' || last_name) nameemployee, year(hire_date) as year from employees
where year(hire_date) = '2007';


/*
  2. crear una función llamada month que reciba un parámetro de tipo fecha y retorne el nombre del mes correspondiente
  (enero, febrero, marzo, etc.).
*/


create or replace 
function month(fechaentrada date)
return nvarchar2
is
  meses nvarchar2(20);
begin
  select to_char(fechaentrada,'month') into meses from dual;
  return meses;
end month;
/

declare
  mesprueba nvarchar2(20);
begin
  mesprueba := month('30/08/1995');
  dbms_output.put_line('mes: ' || mesprueba);
end;

/*
  3. crear una función llamada day que reciba un parámetro de tipo fecha y retorne el nombre del día correspondiente
  (lunes, martes, etc.).
*/

create or replace 
function day(fechaentrada date)
return nvarchar2
is
  dias nvarchar2(20);
begin
  select to_char(fechaentrada,'day') into dias from dual;
  return dias;
end day;
/

declare
  diaprueba nvarchar2(20);
begin
  diaprueba := day('30/08/1995');
  dbms_output.put_line('dia: '|| diaprueba);
end;

/*
  4. crear una función llamada fn_region que reciba un identificador de location (location_id) y retorne el nombre
  de la región a la cual pertenece.
*/


create or replace 
function fn_region(id_locations number)
return nvarchar2
is
  nombreregion nvarchar2(30);
begin

  select region_name into nombreregion from regions
  inner join countries on regions.region_id = countries.region_id
  inner join locations on locations.country_id = countries.country_id
  where locations.location_id = id_locations;
  return nombreregion;
end fn_region;

  select fn_region(location_id) from locations order by 1 ;
  
/*
  5. crear una función llamada fn_calcular_antig que reciba un id de empleado y retorne la cantidad de años
  trabajados desde su contratación hasta la actualidad.
*/

create or replace function fn_calcular_antig(id_empleado number)
return number
is
  cantidadañostrabajados number;
begin
  select trunc((sysdate - hire_date)/364) into cantidadañostrabajados from employees
  where employee_id = id_empleado;
  return cantidadañostrabajados;
end fn_calcular_antig;
/

select first_name,last_name,fn_calcular_antig(employee_id) as añostrabajados from employees;

/*
  6. crear un procedimiento llamado pr_aumento_sueldo_depto que reciba como parámetros un
  identificador de departamento y un valor numérico de porcentaje de aumento. dicho procedimiento debe efectuar
  un aumento del salario de cada empleado del departamento en base al valor (porcentaje) recibido como parámetro.
  el procedimiento debe devolver mediante un tercer parámetro de salida de tipo texto el valor ok en caso de
  aplicar el aumento para todos los empleados o bien retornar error en caso que ocurra algún error durante la
  ejecución.
  se debe verificar previamente a aplicar los cambios que ambos parámetros de entrada no sean nulos
  (si alguno es nulo retornar error  verificar parametros nulos en el parámetro de salida).
*/

create or replace procedure pr_aumento_sueldo_depto (id_dep number, pr number)
is
  vid_dep number;
  vpr number;
begin 
  vid_dep := id_dep;
  vpr := pr;
  if (vid_dep is not null) and (vpr is not null) then 
    dbms_output.put_line('ok');
    update employees set salary = salary + (salary*vpr/100) 
    where department_id = id_dep;
  else 
    dbms_output.put_line('error - verificar parametros nulos');
  end if;
end pr_aumento_sueldo_depto;
/

declare
  id_depart number;
  vporcentaje number;
begin
  id_depart := 90;
  vporcentaje := 30;
  pr_aumento_sueldo_depto(id_depart,vporcentaje);
end;
/


/*
  7. crear un procedimiento llamado pr_detalle_empleados_depto que reciba como parámetro un identificador de departamento e imprima en pantalla como primera línea el nombre
  del departamento y luego detalle el nombre y apellido de cada empleado del departamento junto con su función y salario.
  si el empleado cumple 10 años de antigüedad debe indicarse también.
*/

create or replace procedure pr_detalle_empleados_depto (id_dep number)
as
cursor curs_1
is
  select employee_id from employees where department_id=id_dep;
  
  vdep_name departments.department_name%type;
  vfirst_name employees.first_name%type;
  vlast_name employees.last_name%type;
  vfuncion jobs.job_title%type;
  vsalario employees.salary%type;
  vcant_empleados number;
  vid_empl number;
  vcontador number := 0;
  vaños number;
begin
  open curs_1;
  fetch curs_1 into vid_empl;
 
  select count(employee_id) into vcant_empleados from employees where department_id=id_dep;
  while (vcontador < vcant_empleados)
      loop
        select departments.department_name,employees.first_name,employees.last_name,jobs.job_title,employees.salary,trunc((sysdate - to_date(hire_date, 'dd/mm/yyyy'))/364) into vdep_name,vfirst_name,vlast_name,vfuncion,vsalario,vaños
        from employees inner join departments on employees.department_id = departments.department_id inner join jobs on employees.job_id = jobs.job_id where employees.department_id=id_dep and employees.employee_id=vid_empl order by employees.employee_id;
        
          dbms_output.put_line('departamento: ' || vdep_name);
          dbms_output.put_line('-----------------');
          dbms_output.put_line('empleado: ' || vfirst_name ||', '|| vlast_name);
          dbms_output.put_line('puesot: ' || vfuncion);
          dbms_output.put_line('salario: ' || vsalario);
          if (vaños = 10) then
            dbms_output.put_line('** cumple 10 años **');
          end if;
          dbms_output.put_line('-----------------');
          vcontador := vcontador + 1;
          vid_empl := vid_empl + 1;
      end loop;
      close curs_1;
    exception when others then dbms_output.put_line('error: '||sqlerrm);
end pr_detalle_empleados_depto;
/

declare
  vid_depto number;
begin
  vid_depto := 60;
pr_detalle_empleados_depto(vid_depto);
end;
/ 

/*
  8. crear un procedimiento llamado pr_aumentos que lea los registros de la tabla temporal cfg_aumento_departamento mediante un cursor
  y ejecute el procedure del punto 6 (pr_aumento_sueldo_depto) para cada registro configurado.
  los campos de la tabla son:
  department_id - number
  porcentaje_aumento - number(5,2)
  El proceso debe ir mostrando en pantalla el nombre del departamento procesado y el resultado de ejecutar el procedure pr_aumento_sueldo_depto.
*/

create global temporary table cfg_aumento_departamento (department_id number,porcentaje_aumento number(5,2));
  insert into cfg_aumento_departamento (department_id,porcentaje_aumento) values (10,60);
  insert into cfg_aumento_departamento (department_id,porcentaje_aumento) values (20,30);
  insert into cfg_aumento_departamento (department_id,porcentaje_aumento) values (40,10);
  
  select * from cfg_aumento_departamento;

create or replace procedure pr_aumentos 
as
cursor curs_1_temp
is
  select department_id,porcentaje_aumento from cfg_aumento_departamento;
  vid_dep number;
  vpr number;
  vdep_name departments.department_name%type;
begin
  open curs_1_temp;
  fetch curs_1_temp into vid_dep, vpr;
  
  while (curs_1_temp%found)
    loop
      select department_name into vdep_name from departments where department_id = vid_dep;
      dbms_output.put_line('departamento: ' || vdep_name);
      pr_aumento_sueldo_depto(vid_dep,vpr);
      dbms_output.put_line(' ');
      fetch curs_1_temp into vid_dep,vpr;
    end loop;
end pr_aumentos;
/

begin
  pr_aumentos;
end;
/

/*
  9. elaborar una sentencia que permita modificar la tabla employees agregándole dos nuevos campos:
  -usuario - varchar2(30)
  -fecha_modificacion - date
  crear un trigger en la tabla employees que grabe, ante un insert o update de algún
  registro, en los campos usuario y fecha_modificacion los valores correspondientes
  al usuario que realiza la acción y la fecha de ocurrencia. 
*/

alter table employees add(usuario nvarchar2, fecha_modificacion date);

create or replace trigger employeetrigger
  before update or insert on employees
  for each row
begin
  if inserting then
      dbms_output.put_line('insertando datos');
  dbms_output.put_line('inserting');
  :new.usuario := user;
  :new.fecha_modificacion := sysdate;
  elsif updating then
   dbms_output.put_line(' - updating');
  :new.usuario := user;
  :new.fecha_modificacion := sysdate;
end if;
end employeetrigger;

update employees set last_name = 'paz' where employee_id = 100;

select * from employees where employee_id= 100;

/*
  10. elaborar una sentencia sql que permita crear la tabla employees_audit con los siguientes campos:
    -employee_id  number(6)
    -salary_old  number(8,2)
    -salary_new  number(8,2)
    -fecha_modificacion  date
  crear un trigger en la tabla employees que grabe, ante una modificación de salario
  de algún empleado, los valores de salario actual y nuevo en la tabla employees_audit
  (campos salary_old y salary_new) junto con la fecha de modificación
  correspondiente.
*/
CREATE TABLE EMPLOYEE_AUDIT(
  employee_id NUMBER(6),
  salary_old NUMBER(8,2),
  salary_new NUMBER(8,2),
  fecha_modificacion DATE
);

CREATE OR REPLACE 
    TRIGGER employee_audit_trigger
BEFORE UPDATE ON EMPLOYEES 
 for each row
    declare
      sal_new number(8,2);
BEGIN 
    :new.salary_old := old.salary_new;
    :new.salary_new := sal_new;
    :new.fecha_modificacion := sysdate;
END employee_audit_trigger;
/

update employees set salary = 3000 where employee_id = 100;
select * from employees where employee_id = 100 ;
