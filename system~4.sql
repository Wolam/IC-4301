SET serveroutput ON;

DECLARE
    v_ciudad VARCHAR(20) := '';
    
BEGIN
    SELECT ciudad_cliente INTO v_ciudad
    FROM cliente
    WHERE nombre_cliente = 'Santos';
    
    dbms_output.put_line (v_ciudad || 'concatenado');

    INSERT INTO cliente
        VALUES('Daniel','La Puebla',v_ciudad);

END;

/
--- ejemplo de cursores  y LOOPS----

DECLARE
    v_nombre_sucursal VARCHAR2(30);
    v_saldo NUMBER(10);
    CURSOR cur_cuenta is
        SELECT nombre_sucursal,saldo
            FROM cuenta;
    
BEGIN
    OPEN cur_cuenta;
    
    LOOP 
    FETCH cur_cuenta
    INTO v_nombre_sucursal, v_saldo;
        
    
    EXIT WHEN cur_cuenta%NOTFOUND;
    dbms_output.put_line ('sucursal: ' || v_nombre_sucursal ||chr(13) ||'Saldo: ' || v_saldo);

    END LOOP;
    CLOSE cur_cuenta;

END;
    
/
--- otra forma de loop-

DECLARE
    CURSOR cur_cuenta is
        SELECT nombre_sucursal,saldo
            FROM cuenta;
    
BEGIN
    FOR reg in cur_cuenta    
        LOOP  
            dbms_output.put_line ('sucursal: ' || reg.nombre_sucursal ||chr(13) ||'Saldo: ' || reg.saldo);

        END LOOP;


END;
/

CREATE OR REPLACE PROCEDURE agregar_sucursal( v_nombre IN VARCHAR2, v_ciudad IN VARCHAR2, v_activos IN NUMBER)

IS
BEGIN
    insert into sucursal values(v_nombre,v_ciudad,v_activos);
    dbms_output.put_line ('Se ha insertado la sucursal: '|| v_nombre);
END;
/

EXEC agregar_sucursal('Aquel lugar','Cartaghetto',1000);

BEGIN
agregar_sucursal('NIC lugar','Alajuela',1000);
END;
/

CREATE OR REPLACE PROCEDURE cuentas_mayores_sp(v_cuenta VARCHAR2, c1 IN OUT SYS_REFCURSOR)

IS
BEGIN
    open c1 for
    select * from cuenta where saldo > (select saldo from cuenta where numero_cuenta = v_cuenta);
END;
/

VAR c1 REFCURSOR
EXEC cuentas_mayores_sp('C-102', :c1);

PRINT c1;


CREATE OR REPLACE FUNCTION superior_al_promedio (cuenta_deseada VARCHAR2) 
    RETURN BOOLEAN
    IS
    V_SALDO NUMBER;
    V_PROMEDIO NUMBER;

BEGIN
    SELECT saldo into V_SALDO
    from cuenta
    where numero_cuenta = cuenta_deseada;
    
    SELECT AVG(saldo) INTO V_PROMEDIO
    FROM cuenta;
    
    IF V_SALDO < V_PROMEDIO THEN 
        RETURN FALSE;
    ELSE 
        RETURN TRUE;
    END IF;
END;
/

--- DRIVER CODE PARA EL PROMEDIO----

SET SERVEROUTPUT ON;

BEGIN
    IF SUPERIOR_AL_PROMEDIO ('C-333') THEN
        DBMS_OUTPUT.put_line ('Cuenta Superior al Prom');
        
    ELSE
        DBMS_OUTPUT.put_line ('Cuenta No Superior al Prom');
    END IF;
END;
/
--- DRIVER DE LA FUNCION DATE----
SELECT SYSDATE FROM dual;
SELECT * FROM USER_OBJECTS ;

DROP PROCEDURE SYSTEM.superior_al_promedio; 

