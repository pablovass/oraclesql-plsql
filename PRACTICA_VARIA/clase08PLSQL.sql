BEGIN 
  DBMS_OUTPUT.PUT_LINE('HOLA MUNDO !!');
  DBMS_OUTPUT.PUT_LINE('FECHA: '|| SYSDATE);
  END;
  /
  
  DECLARE
  V_MENSAJE VARCHAR2(100):= '!HOLA MUNDO DE VUELTA';
  BEGIN 
  DBMS_OUTPUT.PUT_LINE(V_MENSAJE);
  V_MENSAJE:='CHAU!!';
  DBMS_OUTPUT.PUT_LINE(V_MENSAJE);
  END;
  
  /
  
  --ESTRUCTURA DE CONTROL
  DECLARE 
    VID_EMPLEADO EMPLOYEES.EMPLOYEE_ID%TYPE;
  BEGIN
    IF (VID_EMPLEADO IS NULL )
  THEN 
  DBMS_OUTPUT.put_line('EMPLOYEE_ID NULO 2 ');
  ELSE
  DBMS_OUTPUT.PUT_LINE('EMPLOYEE_iD NULO'|| VID_EMPLEADO);
  END IF;
END; 
--BUCLES 
-- EJECUTA EL LOOP HASTA QUE OCURRE UNA CONDICION 
-- SE FUERZA EL CORTE DEL LOOP CON EXIT

DECLARE 
VCONTADOR NUMBER :=0;
BEGIN 
  DBMS_OUTPUT.PUT_LINE('--INICIO LOOP--');
  LOOP
  DBMS_OUTPUT.PUT_LINE ('CONTADOR: ' || VCONTADOR );
    IF (VCONTADOR>5) THEN
       DBMS_OUTPUT.PUT_LINE('--FIN DEL LOOP--');
       EXIT;
      END IF;
  VCONTADOR :=VCONTADOR+1;
  END LOOP;
  END;
  /
    DECLARE 
    VCONTADORwasp NUMBER := 0;
    BEGIN 
     WHILE (VCONTADORwasp < 10)
      LOOP
    DBMS_OUTPUT.PUT_LINE('VALOR CONTADOR : '|| VCONTADORwasp);
    VCONTADORwasp := VCONTADORwasp +1;
    END LOOP;
    END ;
    / 
    -- loop for 
    -- se ejecuta hasta que un valor inicial 
    -- hasta alcanzar un valor final 
    begin
    FOR i  IN 1.. 10 LOOP
          DBMS_OUTPUT.PUT_LINE('Iteracion: '|| i);
        END LOOP;
    end ;
    
    /
    -- SELECT INTO- 
    DECLARE
        VID_EMPLEADO  EMPLOYEES.EMPLOYEE_ID%TYPE := 100;
        VSALARIO  EMPLOYEES.SALARY%TYPE;
    BEGIN 
        SELECT SALARY 
        INTO VSALARIO
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = VID_EMPLEADO;
    
        DBMS_OUTPUT.PUT_LINE('ID_EMPLEADO: ' || VID_EMPLEADO);
        DBMS_OUTPUT.PUT_LINE('SALARIO : ' || VSALARIO);
    END ;
    /
    -- EXCEPCIONES 
    DECLARE 
          VID_EMPLEADO  EMPLOYEES.EMPLOYEE_ID%TYPE:= 100;
          VSALARIO  EMPLOYEES.SALARY%TYPE;
    BEGIN 
        SELECT SALARY 
        INTO VSALARIO
        FROM EMPLOYEES 
        WHERE EMPLOYEE_ID IN (101,102);
        
          DBMS_OUTPUT.PUT_LINE('ID_EMPLEADO: '|| VID_EMPLEADO );
          DBMS_OUTPUT.PUT_LINE('SALARIO:' || VSALARIO);
          
          EXCEPTION WHEN OTHERS THEN
          
          DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM );
          END;
          /
          --EXCEPCIONESTECNICAS DE ALMACENAMIENTO DE DATOS--EJEMPLO EXCEPCIONES
          DECLARE
              VID_EMPLEADO EMPLOYEES.EMPLOYEE_ID%TYPE:= 100;
              VSALARY EMPLOYEES.SALARY%TYPE;
          BEGIN
            SELECT SALARY
            INTO VSALARY
            FROM EMPLOYEES
            WHERE EMPLOYEE_ID = 1;
            
            DBMS_OUTPUT.PUT_LINE('ID_EMPLEADO: '||VID_EMPLEADO);
            DBMS_OUTPUT.PUT_LINE('SALARIO: '||VSALARY);
            
            EXCEPTION WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE('ERROR: '||SQLERRM);
            END;
            /
            -- OTRO EJEMPLO DE ECEPCIONES
            DECLARE 
                VNUM NUMBER; 
            BEGIN 
                SELECT 1/0 
                INTO VNUM 
                FROM DUAL ; 
            EXCEPTION WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE('ERROR: '||SQLERRM);
             END ;   
             /
             
             CREATE OR REPLACE PROCEDURE AUMENTO_MASIVO
             IS
             VPCT_AUMENTO NUMBER; 
             BEGIN 
                SELECT VALOR 
                INTO VPCT_AUMENTO
                FROM CONFIG_AUMENTOS
                WHERE CONCEPTO = 'AUMENTO_GRAL';
                
                UPDATE EMPLOYEES 
                SET SALARY= SALARY +(SALARY*VPCT_AUMENTO/100);
             END AUMENTO_MASIVO;
             /
             EXECUTE AUMENTO_MASIVO;
             
             BEGIN
             AUMENTO_MASIVO;
             END;
             /
             -- EJECUCION DE SP - DDL / DML 
             CREATE TABLE CONFIG_AUMENTO (
              CONSEPTO VARCHAR2 (30),
              VALOR NUMBER(5,2)
             );
             INSERT INTO CONFIG_AUMENTO
             VALUES ('AUMENTO_GRAL',12.5);
             /*  PARAMETRO SP
             *PUEDE SER LA ENTRADA IN , DE SALIDA (OUT) 
              O DE ENTRADA SALIDA IN OUT 
              
              * SIN NO SE ESPESIFICA EL VALOR OR DEFECTO ES IN
             */
             SELECT * FROM CONFIG_AUMENTO;
             -- DECLARACION SP CON PARAMETROS 
             CREATE OR REPLACE 
             PROCEDURE AUMENTO_MASIVO (PPCT_AUMENTO OUT NUMBER)
             IS 
             BEGIN 
                  SELECT VALOR 
                  INTO PPCT_AUMENTO
                  FROM CONFIG_AUMENTOS
                  WHERE CONSEPTO = 'AUMENTO_GRAL' ;
                UPDATE EMPLOYEES 
                SET SALARY = SALARY +(SALARY*PPCT_AUMENTO/100);
                  END AUMENTO_MASIVO; 
                  
                  -- PARA EJECUTARLO 
                  /
                  DECLARE 
                  VPCT_AUMENTO NUMBER ;
                  BEGIN 
                  AUMENTO_MASIVO(VPCT_AUMENTO);
                  DBMS_OUTPUT.PUT_LINE ('AUMENTO OTORGADO: '|| VPCT_AUMENTO);
                  END;
             
             