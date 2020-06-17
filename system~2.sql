
--- seleccionar los que empiezan con a----
SELECT * FROM
    sucursal
WHERE
    nombre_sucursal LIKE '%a';

--- pruebas outer / inner joins ----
SELECT
    *
FROM
    sucursal   s
    LEFT JOIN cuenta c ON s.nombre_sucursal = c.nombre_sucursal;
    
    
--- insertar sin todad la cantidad de valores (probar default) ---
select * from cuenta;
INSERT into  cuenta(numero_cuenta, nombre_sucursal) VALUES ('C-333', 'Atenea');


--- ALTERS ---
--- Renombrar el nombre de la tabla
ALTER TABLE cuentaCliente RENAME TO impositor;

--- crear valor x defecto ---
--- los objetos dentro de la tabla quedan igual ---
ALTER TABLE cuenta modify (saldo DEFAULT 10);


