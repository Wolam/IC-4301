
/* 
 seccion de insertar y crear datos
*/

CREATE TABLE cliente
    (nombre_cliente VARCHAR2(20),
    calle_cliente VARCHAR2(30),
    ciudad_cliente VARCHAR2(30),
    PRIMARY KEY (nombre_cliente));
    
CREATE TABLE sucursal
    (nombre_sucursal VARCHAR2(15),
    ciudad_sucursal VARCHAR2(30),
    activos NUMBER(16,2),
    PRIMARY KEY(nombre_sucursal));

CREATE TABLE cuenta
    (numero_cuenta VARCHAR2(20),
    nombre_sucursal VARCHAR2(30),
    saldo NUMBER(12,2),
    PRIMARY KEY (numero_cuenta));

CREATE TABLE impositor
    (nombre_cliente VARCHAR2(20),
    numero_cuenta CHAR(10),
    PRIMARY KEY (nombre_cliente,numero_cuenta));
    
CREATE TABLE prestamo
    (numero_prestamo VARCHAR(5),
    nombre_sucursal VARCHAR(15),
    importe NUMBER(12,2),
    PRIMARY KEY (numero_prestamo));
    
CREATE TABLE prestario
    (nombre_cliente VARCHAR2(20),
    numero_prestamo VARCHAR2(5),
    PRIMARY KEY (nombre_cliente,numero_prestamo));     
 
INSERT INTO sucursal(nombre_sucursal,ciudad_sucursal,activos)
    VALUES ('Becerrill','Aluche',400000);

INSERT INTO sucursal (nombre_sucursal, ciudad_sucursal, activos) 
  WITH sucursales AS ( 
    SELECT 'Centro', 'Arganzuela',9000000 FROM dual UNION ALL 
    SELECT 'Collado Mediano', 'Aluche',8000000 FROM dual UNION ALL 
    SELECT 'Galapagar','Arganzuela',7100000 FROM dual UNION ALL 
    SELECT 'Moralzarzal','La Granja',2100000  FROM dual UNION ALL
    SELECT 'Navacerrada','Aluche',300000  FROM dual UNION ALL
    SELECT 'Navas Asuncion','Alcala de Henares',3700000  FROM dual UNION ALL
    SELECT 'Segovia','Cerceda',3700000  FROM dual 
  ) 
  SELECT * FROM sucursales;


INSERT INTO prestamo(numero_prestamo, nombre_sucursal, importe) 
  WITH prestamos AS ( 
    SELECT 'P-11', 'Collado Mediano',900 FROM dual UNION ALL 
    SELECT 'P-14', 'Centro',1500 FROM dual UNION ALL 
    SELECT 'P-15','Navacerrada',1500 FROM dual UNION ALL 
    SELECT 'P-16','Navacerrada',1300  FROM dual UNION ALL
    SELECT 'P-17','Centro',1000  FROM dual UNION ALL
    SELECT 'P-23','Moralzarzal',2000  FROM dual UNION ALL
    SELECT 'P-93','Becerril',500 FROM dual 
  )
  SELECT * FROM prestamo;
  
INSERT INTO cliente (nombre_cliente, calle_cliente, ciudad_cliente) 
  WITH clientes AS ( 
    SELECT 'Abril', 'Preciados','Valsain' FROM dual UNION ALL 
    SELECT 'Amo', 'Embajadores','Arganzuela' FROM dual UNION ALL 
    SELECT 'Badorrey','Delicias','Valsain' FROM dual UNION ALL 
    SELECT 'Fernandez','Jazmin','Leon'  FROM dual UNION ALL
    SELECT 'Gomez','Carretas','Cerceda'  FROM dual UNION ALL
    SELECT 'Gonzalez','Arenal','La Granja'  FROM dual UNION ALL
    SELECT 'Lopez','Mayor','Perguerinos' FROM dual UNION ALL
    SELECT 'Perez','Carretas','Cerceda' FROM dual UNION ALL
    SELECT 'Rodriguez','Yeserias','Cadiz' FROM dual UNION ALL
    SELECT 'Ruperez','Ramblas','Leon' FROM dual UNION ALL
    SELECT 'Santos','Mayor','Perguerinos' FROM dual UNION ALL
    SELECT 'Valdivieso','Goya','Vigo' FROM dual 
  )
  SELECT * FROM clientes;
  
 INSERT INTO cuenta (numero_cuenta, nombre_sucursal, saldo) 
  WITH cuentas AS ( 
    SELECT 'C-101', 'Centro',500 FROM dual UNION ALL 
    SELECT 'C-215', 'Becerril',700 FROM dual UNION ALL 
    SELECT 'C-102','Navacerrada',400 FROM dual UNION ALL 
    SELECT 'C-305','Collado Mediano',350 FROM dual UNION ALL
    SELECT 'C-201','Galapagar',900 FROM dual UNION ALL
    SELECT 'C-222','Moralzarzal',700  FROM dual UNION ALL
    SELECT 'C-217','Galapagar',750  FROM dual
  )
  SELECT * FROM cuentas;    

 INSERT INTO prestario (nombre_cliente, numero_prestamo) 
  WITH prestarios AS ( 
    SELECT 'Fernandez', 'P-16' FROM dual UNION ALL 
    SELECT 'Gomez', 'P-11' FROM dual UNION ALL 
    SELECT 'Gomez','P-23' FROM dual UNION ALL 
    SELECT 'Lopez','P-15' FROM dual UNION ALL
    SELECT 'Perez','P-93'  FROM dual UNION ALL
    SELECT 'Santos','P-17' FROM dual UNION ALL
    SELECT 'Sotoca','P-14'FROM dual UNION all
    SELECT 'Valdivieso','P-17'FROM dual
  )
  SELECT * FROM prestarios;

  
INSERT INTO impositor (nombre_cliente, numero_cuenta) 
  WITH impositores AS ( 
    SELECT 'Abril', 'C-305' FROM dual UNION ALL 
    SELECT 'Gomez', 'C-215' FROM dual UNION ALL 
    SELECT 'Gonzalez','C-101' FROM dual UNION ALL 
    SELECT 'Gonzalez','C-201' FROM dual UNION ALL
    SELECT 'Lopez','C-102'  FROM dual UNION ALL
    SELECT 'Ruperez','C-222' FROM dual UNION ALL
    SELECT 'Santos','C-217'FROM dual
  )
  SELECT * FROM impositores; 

SELECT * FROM impositor;
SELECT * FROM prestario;
SELECT * FROM prestamo;
SELECT * FROM sucursal;
SELECT * FROM cliente;
SELECT * FROM cuenta;

SELECT nombre_sucursal , to_char(activos, '999,999,999') activos
from sucursal;

 SELECT nombre_sucursal
 FROM cuenta;
 
 SELECT numero_prestamo
 from prestamo
 WHERE nombre_sucursal = 'Navacerrada' AND importe>1200;
 
 SELECT nombre_cliente, prestario.numero_prestamo,importe
 FROM  prestario, prestamo
 WHERE prestario.numero_prestamo = prestamo.numero_prestamo;
