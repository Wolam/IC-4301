--- %%%%%%%%% EXAMEN 2 BD1 I SEMESTRE 2020 %%%%%%%%%
--- WILHELM CARSTENS SOTO

-- %%%%%%%%% PRIMERA PARTE %%%%%%%%%%

---Ejercicio A

SELECT cliente.id_cliente,cliente.nombre AS clientes_con_ordenes
    FROM (cliente 
    JOIN orden_compra 
    ON cliente.id_cliente =orden_compra.id_cliente)

INTERSECT 

SELECT cliente.id_cliente,cliente.nombre
    FROM cliente;

    
--Ejercicio B

SELECT id,nombre_cliente,max(fecha) AS ultima_fecha FROM 
    (SELECT c.nombre nombre_cliente,c.id_cliente AS id,fecha FROM
    cliente c
    LEFT OUTER JOIN
    orden_compra oc
    ON oc.id_cliente=c.id_cliente) group by id,nombre_cliente;
   

--- Ejercicio C
SELECT * 
    FROM producto 
    WHERE precio=(SELECT max(precio) FROM producto);
      
-- Ejercicio D

SELECT avg(precio) AS Prom_Mayores_500 
    FROM (SELECT precio FROM producto WHERE precio >500);
    
    
-- Ejercicio E

SELECT nombre,descripcion,prom_tipo,id_tipo_producto 
    FROM (tipo_producto 
    JOIN
    (SELECT  avg(precio) AS prom_tipo, id_tipo_producto AS tipos_agrupados
    FROM producto group by id_tipo_producto) 
    ON tipo_producto.id_tipo_producto = tipos_agrupados);
    
-- Ejercicio F

SELECT sum(precio) AS Ventas_totales_periodo,  TO_CHAR(fecha,'MM-YYYY') AS Periodo
    FROM (factura fac
    JOIN   
    (factura_producto fac_pr 
    JOIN producto prod 
    ON fac_pr.id_producto =prod.id_producto) ON fac.id_factura = fac_pr.id_factura)
    group by TO_CHAR(fecha,'MM-YYYY');


--- Ejercicio G

SELECT sum(precio)AS deuda_total,c.nombre    
    FROM cliente c
    JOIN orden_compra oc
    ON c.id_cliente = oc.id_cliente
    JOIN orden_compra_producto ocp
    ON oc.id_orden_compra = ocp.id_orden_compra
    JOIN producto prod
    ON ocp.id_producto = prod.id_producto group by c.nombre ;


-- %%%%%%%%% SEGUNDA PARTE %%%%%%%%%%

-- Ejercicio A
SELECT nombre_pymes
    FROM pymes 
    WHERE nombre_pymes LIKE '%ENVIOS%';
    
-- Ejercicio B

SELECT nombre_cliente
    FROM clientes 
    WHERE UPPER(clientes.nombre_cliente) LIKE '_A%';
    
-- Ejercicio C

SELECT nombre_cliente FROM clientes

INTERSECT

SELECT nombre_cliente
    FROM clientes c
    INNER JOIN facturas fact
    ON c.cedula = fact.cedula
    INNER JOIN (SELECT id_factura,id_producto FROM detalle_facturas) det_f
    ON fact.id_factura = det_f.id_factura
    INNER JOIN (SELECT id_producto,id_pymes FROM productos) prod
    ON det_f.id_producto = prod.id_producto
    INNER JOIN pymes pym
    ON prod.id_pymes = pym.id_pymes
    WHERE c.id_provincia <> pym.id_provincia;
    
-- Ejercicio D
--SE ASUME COMO NULL PARA LAS PYMESE SIN VENTAS O SIN VENTAS A CONTADO
    
SELECT py.nombre_pymes, sum(monto_total) AS sumas_contado
    FROM (SELECT id_factura,monto_total FROM facturas WHERE tipo_factura =1) fac
    FULL OUTER JOIN (SELECT id_factura,id_producto FROM detalle_facturas) df 
    ON fac.id_factura = df.id_factura
    FULL OUTER JOIN (SELECT id_producto,id_pymes FROM productos) prod
    ON df.id_producto = prod.id_producto
    FULL OUTER JOIN (SELECT id_pymes,nombre_pymes FROM pymes) py
    ON prod.id_pymes = py.id_pymes
    group by py.nombre_pymes;
 
-- Ejercicio E
 
 SELECT nombre_pymes AS pymes_sin_ventas FROM pymes 
 
 MINUS
 
 SELECT nombre_pymes AS pymes_con_ventas
    FROM pymes py
    JOIN productos prod
    ON py.id_pymes = prod.id_pymes
    JOIN detalle_facturas det_fac
    ON prod.id_producto = det_fac.id_producto;
    
        
--- Ejercicio F

SELECT credito,contado FROM
    (SELECT sum(monto_total) AS credito 
    FROM facturas
    WHERE tipo_factura =  1)
  
  CROSS JOIN 
 
    (SELECT sum(monto_total) AS contado 
    FROM facturas
    WHERE tipo_factura =  2);

--- Ejercicio G
SELECT bienes, servicios FROM (
     
    (SELECT  sum(precio_venta*cantidad) servicios FROM productos p_serv
    JOIN detalle_facturas det_f
    ON p_serv.id_producto= det_f.id_producto
    JOIN (SELECT fecha_factura,id_factura,monto_total FROM facturas) fac
    ON det_f.id_factura= fac.id_factura
    WHERE  p_serv.tipo_producto= 'S' and fac.fecha_factura > sysdate-30)
    
    CROSS JOIN
    
    (SELECT sum(precio_venta*cantidad) AS bienes FROM productos p_bien
    JOIN detalle_facturas det_f
    ON p_bien.id_producto= det_f.id_producto
    JOIN  (SELECT fecha_factura,id_factura,monto_total FROM facturas) fac
    ON det_f.id_factura= fac.id_factura
    WHERE fac.fecha_factura > sysdate-30 and  p_bien.tipo_producto= 'B'));
     
       
--- EJercicio H
    
SELECT * FROM
    (SELECT fac.id_factura AS Top3_Facturas ,cantidad AS cantidad_productos FROM facturas fac
    JOIN 
    (SELECT cantidad, id_factura FROM detalle_facturas) det_f
    ON fac.id_factura = det_f.id_factura order by cantidad desc)
    WHERE rownum <4;


--- Ejercicio I

---Los plazos tienen que ser mayores a 3 meses.
---Por ejemplo un caso a 2 meses no lo seleccionaria
SELECT id_factura 
    FROM facturas 
    WHERE saldo <= 3*(monto_total)/plazo and saldo <> 0 and tipo_factura = 1;
    
--- Ejercicio J
UPDATE productos 
    SET precio = case   
    WHEN tipo_producto = 'B' THEN 
    (precio * 1.10) 
    ELSE
    (precio * 1.05) 
    END;

