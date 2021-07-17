/*
Scripts para la creación de los objetos de la base de datos junto con 
todas sus restricciones de integridad, así como la inserción de los datos de prueba. 
También se deben incluir los scripts para el borrado de todos los objetos 
creados (en el orden correcto para que no de errores).  10 pts.
*/
SET SERVEROUTPUT ON;

--- CREAR LAS TABLAS CON RESPECTIVOS DATOS ---

CREATE TABLE provincia 
    (id_provincia NUMBER(1) NOT NULL,
    provincia VARCHAR2(15) NOT NULL,
    PRIMARY KEY (id_provincia),
    CONSTRAINT uc_provincia UNIQUE (provincia));


CREATE TABLE departamento
    (nombre_departamento VARCHAR2(20) NOT NULL,
    id_departamento VARCHAR2(3 CHAR) NOT NULL,
    PRIMARY KEY (id_departamento),
    CONSTRAINT uc_departamento UNIQUE (nombre_departamento));

CREATE TABLE profesor
    (id_profesor NUMBER(10) NOT NULL,
    nombre_profesor VARCHAR2(30) NOT NULL,
    id_departamento VARCHAR2(5 CHAR) NOT NULL,
    PRIMARY KEY (id_profesor));

--FORANEA DE PROFESOR
ALTER TABLE profesor 
    ADD CONSTRAINT fk_profesor
    FOREIGN KEY (id_departamento)
    REFERENCES departamento (id_departamento);    

CREATE TABLE materia
    (nombre_materia VARCHAR2(30) NOT NULL,
    id_materia VARCHAR2(8 CHAR) NOT NULL,
    creditos NUMBER(2) NOT NULL,
    id_departamento VARCHAR2(3 CHAR) NOT NULL,
    PRIMARY KEY (id_materia),
    CONSTRAINT uc_materia UNIQUE (nombre_materia));
   
--FORANEA DE MATERIA   
ALTER TABLE materia 
    ADD CONSTRAINT fk_materia
    FOREIGN KEY (id_departamento)
    REFERENCES departamento (id_departamento);

CREATE TABLE requisito
    (id_materia VARCHAR2(8 CHAR),
    id_materia_requerida  VARCHAR2(8 CHAR),
    PRIMARY KEY (id_materia,id_materia_requerida));

--FORANEA DE REQUISITO
ALTER TABLE requisito 
    ADD CONSTRAINT fk_requisito
    FOREIGN KEY (id_materia)
    REFERENCES materia (id_materia);

ALTER TABLE requisito 
    ADD CONSTRAINT fk_requisito_mrequerida
    FOREIGN KEY (id_materia_requerida)
    REFERENCES materia (id_materia); 
    
--VERIFICAR MATERIA Y REQUISITO DIFERENTE

ALTER TABLE requisito
    ADD CONSTRAINT chk_requisito CHECK (id_materia != id_materia_requerida); 

    
CREATE TABLE periodo
    (id_periodo VARCHAR2(8 CHAR),
    año NUMBER(4) NOT NULL,
    numero_periodo NUMBER(1) NOT NULL,
    PRIMARY KEY (id_periodo),
    CONSTRAINT uc_periodo_año UNIQUE (año,numero_periodo));

CREATE TABLE grupo
    (num_grupo NUMBER(2) ,
    id_profesor NUMBER(10),
    id_materia VARCHAR2(8 CHAR),
    id_periodo VARCHAR2(8 CHAR),
    id_grupo VARCHAR2(15 CHAR),
    PRIMARY KEY (id_grupo),
    CONSTRAINT uc_grupo UNIQUE (num_grupo,id_materia,id_periodo));


--FORANEAS DE GRUPO
ALTER TABLE grupo 
    ADD CONSTRAINT fk_periodo_grupo
    FOREIGN KEY (id_periodo)
    REFERENCES periodo (id_periodo);

ALTER TABLE grupo 
    ADD CONSTRAINT fk_grupo_profesor
    FOREIGN KEY (id_profesor)
    REFERENCES profesor (id_profesor);
    
ALTER TABLE grupo 
    ADD CONSTRAINT fk_grupo_materia
    FOREIGN KEY (id_materia)
    REFERENCES materia (id_materia);
      
CREATE TABLE estudiante
    (carnet NUMBER(10) NOT NULL,
    nombre_estudiante VARCHAR2(30) NOT NULL,
    id_provincia NUMBER NOT NULL,
    PRIMARY KEY (carnet)); 
    
--FORANEA DE ESTUDIANTE
ALTER TABLE estudiante 
    ADD CONSTRAINT fk_est_provincia
    FOREIGN KEY (id_provincia)
    REFERENCES provincia(id_provincia);

CREATE TABLE beca
    (id_beca VARCHAR2(5 CHAR) NOT NULL,
    nombre_beca VARCHAR2(20) NOT NULL,
    monto NUMBER(10,2) NOT NULL,
    PRIMARY KEY (id_beca),
    CONSTRAINT uc_beca_nombre_monto UNIQUE (nombre_beca,monto));
       
CREATE TABLE aula
    (id_aula NUMBER(3) NOT NULL,
    nombre_aula VARCHAR2(8 CHAR) NOT NULL,
    PRIMARY KEY (id_aula),
    CONSTRAINT uc_aula UNIQUE (nombre_aula));
    
CREATE TABLE horario
    (id_horario NUMBER(3) NOT NULL,
    dia CHAR(1) NOT NULL,
    hora_inicio DATE NOT NULL,
 --se utilizo date para poder realizar operaciones con las horas a futuras consultas
    hora_fin DATE NOT NULL, 
    PRIMARY KEY (id_horario),
    CONSTRAINT uc_horario UNIQUE (dia, hora_inicio, hora_fin));

    
 --- INSERTAR VALORES A LAS TABLAS SIN RELACIONAR ---    

---VALORES A PROVINCIA
INSERT INTO provincia 
    VALUES (1, 'San Jose');
INSERT INTO provincia 
    VALUES (2, 'Alajuela');
INSERT INTO provincia 
    VALUES (3, 'Cartago');
INSERT INTO provincia 
    VALUES (4, 'Heredia');
INSERT INTO provincia 
    VALUES (5, 'Guanacaste');
INSERT INTO provincia 
    VALUES (6, 'Puntarenas');
INSERT INTO provincia 
    VALUES (7, 'Limon');


---VALORES A ESTUDIANTE
INSERT INTO estudiante 
    VALUES (2019039864, 'Andres Madrigal', 7);
INSERT INTO estudiante 
    VALUES (2019344583, 'Wilhelm Carstens Soto', 2);
INSERT INTO estudiante 
    VALUES (2015329584, 'Marco Solano', 4);
INSERT INTO estudiante 
    VALUES (2008654327, 'Felipe Suarez Rodriguez', 2);
INSERT INTO estudiante 
    VALUES (2016175133, 'David Lopez', 6);   
INSERT INTO estudiante 
    VALUES (202132453, 'Andres Grap', 5);   
INSERT INTO estudiante 
    VALUES (2020313987, 'Renato Perez', 4); 

---VALORES A BECA
INSERT INTO beca 
    VALUES ('B10', 'Socioeconomica',1000);
INSERT INTO beca 
    VALUES ('B20', 'Socioeconomica',200000);
INSERT INTO beca 
    VALUES ('B3', 'Deportiva',32000);
INSERT INTO beca 
    VALUES ('B4', 'Academica',1500);
INSERT INTO beca 
    VALUES ('B5', 'Residencia',0);
INSERT INTO beca 
    VALUES ('B6', 'Honor',200000);
    
---VALORES A DEPARTAMENTO

INSERT INTO departamento
    VALUES ('ING. Computacion','IC');
    
INSERT INTO departamento
    VALUES ('ING. Electronica','IE');
    
INSERT INTO departamento
    VALUES ('Escuela Matematica','MA');

INSERT INTO departamento
    VALUES ('Escuela Ciencias','CE');
    
INSERT INTO departamento
    VALUES ('Escuela Lenguaje','CL');
INSERT INTO departamento
    VALUES ('Escuela de Artes','EA');
        
    
---VALORES A PROFESOR
INSERT INTO profesor 
    VALUES (2436276430, 'Jaime Alfaro', 'IC');
INSERT INTO profesor 
    VALUES (4629510894, 'Diego Solano', 'IC');
INSERT INTO profesor 
    VALUES (9754210874, 'Roberto Cubero', 'MA');
INSERT INTO profesor 
    VALUES (5028791983, 'Ernesto Carrera Granadoz', 'MA');
INSERT INTO profesor 
    VALUES (6879102576, 'Andrea Varela', 'IE');
INSERT INTO profesor 
    VALUES (30303030, 'Daniel Mares', 'CL');
INSERT INTO profesor 
    VALUES (777777777, 'Benito Martinez', 'IE');

--- VALORES A PERIODO
INSERT INTO periodo(id_periodo,numero_periodo,año)
    SELECT 'I-2017',1,2017 FROM dual
	UNION ALL SELECT 'II-2017',2,2017 FROM dual
	UNION ALL SELECT 'I-2018',1,2018 FROM dual
	UNION ALL SELECT 'II-2018',2,2018 FROM dual
	UNION ALL SELECT 'I-2019',1,2019 FROM dual
	UNION ALL SELECT 'II-2019',2,2019 FROM dual
	UNION ALL SELECT 'I-2020',1,2020 FROM dual
UNION ALL SELECT 'II-2020',2,2020 FROM dual;


---VALORES A MATERIA

INSERT INTO materia
    VALUES ('Bases de Datos 2','IC-4301',4,'IC');
    
INSERT INTO materia
    VALUES ('Analisis de Algoritmos','IC-3400', 4,'IC');
    
INSERT INTO materia
    VALUES ('Estructuras de Datos','IC-2020', 4,'IC');
    
INSERT INTO materia
    VALUES ('Mate General','MA-000', 2,'MA');
    
INSERT INTO materia
    VALUES ('Calculo diferencial e Integral', 'MA-1012', 4,'MA');

INSERT INTO materia
    VALUES ('Comunicacion Tecnica','CL-9832', 2,'CL');  
    
INSERT INTO materia
    VALUES ('Matematica Discreta','MA-321',4,'CE');
    
INSERT INTO materia
    VALUES ('Laboratorio Robotica','IE-3047',2,'IE');
    
INSERT INTO materia
    VALUES ('Ambiente Humano','EA-666',0,'EA');

---VALOREAS A REQUISITO
INSERT INTO requisito(id_materia,id_materia_requerida)
    SELECT 'IC-3400','MA-321' FROM dual
	UNION ALL SELECT 'IC-3400','MA-1012' FROM dual
	UNION ALL SELECT 'IC-4301','MA-321' FROM dual
    UNION ALL SELECT 'IC-4301','IC-2020' FROM dual
    UNION ALL SELECT 'CL-9832','EA-666' FROM dual
    UNION ALL SELECT 'IE-3047','MA-000' FROM dual
UNION ALL SELECT 'MA-1012','MA-000' FROM dual;

---VALORES A GRUPO
INSERT INTO grupo 
    VALUES (90, 2436276430, 'IC-4301','I-2017','IC-90-2017'); 
INSERT INTO grupo 
    VALUES (87, 30303030, 'CL-9832','I-2017','CL-87-2017'); 
INSERT INTO grupo 
    VALUES (75, 4629510894, 'IC-3400','II-2017','IC-75-2017');
INSERT INTO grupo 
    VALUES (22, 9754210874, 'MA-1012','II-2017','MA-22-2017');
INSERT INTO grupo 
    VALUES (35, 5028791983, 'MA-321','I-2018','MA-35-2018');
INSERT INTO grupo 
    VALUES (5, 5028791983, 'IE-3047','I-2018','IE-5-2018');
INSERT INTO grupo 
    VALUES (99,NULL, 'IE-3047','II-2018','IE-90-2018');   
INSERT INTO grupo 
    VALUES (98,NULL, 'EA-666','I-2019','AE-98-2019');
    
---VALORES A AULA
INSERT INTO aula
    VALUES (120,'D-110');
    
INSERT INTO aula
    VALUES (32,'E-40');

INSERT INTO aula
    VALUES (43,'I-910');
    
INSERT INTO aula
    VALUES (53,'A-540');

INSERT INTO aula
    VALUES (21,'E-225'); 
    

---VALORES A HORARIO

INSERT INTO horario
    VALUES (1,'M',TO_DATE('1:00', 'hh24:mi'),TO_DATE('3:00', 'hh24:mi'));
    
INSERT INTO horario
    VALUES (2,'K',TO_DATE('9:00', 'hh24:mi'),TO_DATE('11:00', 'hh24:mi'));
    
INSERT INTO horario
    VALUES (3,'L',TO_DATE('10:00', 'hh24:mi'),TO_DATE('12:40', 'hh24:mi'));
    
INSERT INTO horario
    VALUES (4,'M',TO_DATE('7:00', 'hh24:mi'),TO_DATE('10:00', 'hh24:mi'));    
    
INSERT INTO horario
    VALUES (5,'V',TO_DATE('8:00', 'hh24:mi'),TO_DATE('12:00', 'hh24:mi'));
    
INSERT INTO horario
    VALUES (6,'S',TO_DATE('9:00', 'hh24:mi'),TO_DATE('12:40', 'hh24:mi'));
    
INSERT INTO horario
    VALUES (7,'M',TO_DATE('13:00', 'hh24:mi'),TO_DATE('14:00', 'hh24:mi'));

--utilizar este query para ver las horas de los horarios y no las fechas
--select id_horario, dia, to_char(hora_inicio, 'hh24:mi')hora_inicio, to_char(hora_fin, 'hh24:mi')hora_fin from horario;     
    
  
---CREAR TABLAS RELACIONADAS
CREATE TABLE estudiante_beca
    (carnet NUMBER(10),
    id_beca VARCHAR2(10 CHAR) ,
    id_periodo VARCHAR2(8 CHAR),
    PRIMARY KEY(carnet, id_beca,id_periodo));

--FORANEAS DE ESTUDIANTE_BECA

ALTER TABLE estudiante_beca 
    ADD CONSTRAINT fk_beca_estudiante_periodo
    FOREIGN KEY (id_periodo)
    REFERENCES periodo(id_periodo);

ALTER TABLE estudiante_beca 
    ADD CONSTRAINT fk_beca_estudiante_carnet
    FOREIGN KEY (carnet)
    REFERENCES estudiante(carnet);
    
ALTER TABLE estudiante_beca 
    ADD CONSTRAINT fk_beca_id
    FOREIGN KEY (id_beca)
    REFERENCES beca(id_beca);

CREATE TABLE estudiante_grupo
    (carnet NUMBER(10),
    id_grupo VARCHAR2(15),
    nota NUMBER(3) NOT NULL,
    PRIMARY KEY (carnet,id_grupo));
 
--FORANEAS DE ESTUDIANTE_GRUPO   
ALTER TABLE estudiante_grupo 
    ADD CONSTRAINT fk_est_grup_id_grupo
    FOREIGN KEY (id_grupo)
    REFERENCES grupo(id_grupo);
    
ALTER TABLE estudiante_grupo 
    ADD CONSTRAINT fk_est_grup_carnet
    FOREIGN KEY (carnet)
    REFERENCES estudiante(carnet);

CREATE TABLE grupo_horario_aula
    (id_horario NUMBER(3),
    id_aula NUMBER(3),  
    id_grupo VARCHAR2(15 CHAR),
    PRIMARY KEY (id_grupo,id_horario),
    CONSTRAINT uc_gpha_id_grupo UNIQUE (id_grupo));  
    
--FORANEAS GRUPO_HORARIO_AULA  

ALTER TABLE grupo_horario_aula 
    ADD CONSTRAINT fk_gha_grupo_pk
    FOREIGN KEY (id_grupo)
    REFERENCES grupo(id_grupo);

    
ALTER TABLE grupo_horario_aula 
    ADD CONSTRAINT fk_gha_horario_id
    FOREIGN KEY (id_horario)
    REFERENCES horario(id_horario);

    
ALTER TABLE grupo_horario_aula 
    ADD CONSTRAINT fk_gha_aula_id
    FOREIGN KEY (id_aula)
    REFERENCES aula(id_aula);
   
--AGREGAR ATRIBUTOS A TABLAS CON RELACIONES

--AGREGAR A ESTUDIANTE_BECA
INSERT INTO estudiante_beca
    VALUES (2019344583, 'B3','I-2017');
INSERT INTO estudiante_beca 
    VALUES (2019344583, 'B4','II-2017');
INSERT INTO estudiante_beca
    VALUES (2015329584, 'B3','I-2018');
INSERT INTO estudiante_beca
    VALUES (2008654327, 'B4','I-2020');
INSERT INTO estudiante_beca 
    VALUES (2016175133, 'B5','II-2020');

--AGREGAR A ESTUDIANTE_GRUPO

INSERT INTO estudiante_grupo
    VALUES (2019039864,'IC-90-2017' , 85);
INSERT INTO estudiante_grupo
    VALUES (2015329584,'IC-75-2017', 67);
INSERT INTO estudiante_grupo
    VALUES (2008654327,'AE-98-2019', 78);
INSERT INTO estudiante_grupo
    VALUES (2016175133,'MA-22-2017', 32);
INSERT INTO estudiante_grupo
    VALUES (2016175133,'IC-75-2017', 95);
INSERT INTO estudiante_grupo 
    VALUES (2020313987,'MA-22-2017', 67.5);  
 INSERT INTO estudiante_grupo 
    VALUES (2020313987,'MA-35-2018', 67.5);     


--AGREGAR A GRUPO_HORARIO_AULA
INSERT INTO grupo_horario_aula
    VALUES (1, 120,'IC-90-2017');
INSERT INTO grupo_horario_aula
    VALUES (2, 32,'IC-75-2017' );
INSERT INTO grupo_horario_aula
    VALUES ( 3, 43,'AE-98-2019');
INSERT INTO grupo_horario_aula
    VALUES (6, 21,'CL-87-2017');

    
CREATE GLOBAL TEMPORARY TABLE temp_ponderados(
    carnet NUMBER(10),
    nombre_estudiante VARCHAR2(30),
    nota_ponderada NUMBER(3)
)ON COMMIT PRESERVE ROWS;

/*
Procedimiento almacenado para realizar la matrícula de un de un estudiante en un grupo específico.  
En este procedimiento es donde se debe hacer la validación de los requisitos. 
En caso de que el estudiante no cumpla los requisitos de la materia que desea matrícula entonces 
se debe mostrar un mensaje significativo en donde se indique cuál es el requisito que tiene pendiente.  
Para la implementación de esta validación puede usar cualquiera de los elementos vistos en clase.
*/

CREATE OR REPLACE FUNCTION buscar_requisitos_pendientes(v_id_materia IN VARCHAR2, v_carnet_estudiante NUMBER)
RETURN SYS_REFCURSOR
IS

  requisitos_pendientes SYS_REFCURSOR;
     
BEGIN
    OPEN requisitos_pendientes FOR
    SELECT id_materia_requerida 
    FROM requisito 
    WHERE id_materia = v_id_materia AND id_materia_requerida NOT IN(
            SELECT gr.id_materia materias_aprobadas FROM
                estudiante_grupo e_gr 
            JOIN 
                grupo gr ON e_gr.id_grupo = gr.id_grupo  
            WHERE e_gr.carnet =v_carnet_estudiante AND nota >= 67.5);
    RETURN requisitos_pendientes;
    
END buscar_requisitos_pendientes;
/


CREATE OR REPLACE  PROCEDURE revisar_requisitos(v_carnet_estudiante IN NUMBER,v_id_grupo IN VARCHAR2)
IS

    v_nombre_estudiante estudiante.nombre_estudiante%TYPE;
    v_id_materia materia.id_materia%TYPE ;
    v_id_materias_pendientes materia.id_materia%TYPE ;
    v_nom_materia_requerida materia.nombre_materia%TYPE;
    v_nombre_materia  materia.nombre_materia%TYPE;

    ref_requisitos_pendientes SYS_REFCURSOR;
    aprueba_requisitos BOOLEAN;
        
BEGIN
   SELECT nombre_estudiante INTO v_nombre_estudiante FROM estudiante WHERE carnet = v_carnet_estudiante;
   SELECT id_materia INTO v_id_materia FROM grupo WHERE id_grupo = v_id_grupo;
   aprueba_requisitos := TRUE;
   
        ref_requisitos_pendientes := buscar_requisitos_pendientes(v_id_materia, v_carnet_estudiante);
        dbms_output.put_line( v_nombre_materia 
                             || chr(10) 
                             ||'Grupo a matricular: ' 
                             || v_id_grupo
                             || CHR(10)
                             || 'Nombre de estudiante solicitante: '
                             || v_nombre_estudiante
                             || '(' ||v_carnet_estudiante|| ')'
                             || CHR(10)
                             || 'Materias pendientes para: ' 
                             || v_id_materia );
        LOOP
            FETCH ref_requisitos_pendientes INTO v_id_materias_pendientes;
            EXIT WHEN ref_requisitos_pendientes%notfound;
            aprueba_requisitos := FALSE;
            
            SELECT nombre_materia into v_nom_materia_requerida 
            FROM materia
            WHERE id_materia = v_id_materias_pendientes;
            
            dbms_output.put_line(CHR(10)
                             || '-------'
                             || v_id_materias_pendientes
                             || '-------'
                             || CHR(10)
                             || '-------'
                             || v_nom_materia_requerida
                             || '-------'
                             || CHR(10));
        END LOOP;
        
        IF aprueba_requisitos THEN
        SELECT nombre_materia into v_nombre_materia 
        FROM materia 
        WHERE id_materia = v_id_materia;
            dbms_output.put_line('----NINGUNA-----'
                                || CHR(10) 
                                || 'Puede matricular ' 
                                || v_id_materia
                                || '('
                                || v_nombre_materia
                                || ')');
            
        END IF; 

   
   EXCEPTION 
        WHEN NO_DATA_FOUND THEN
            IF  v_nombre_estudiante IS NULL  THEN
                dbms_output.put_line('No existe el estudiante ' || v_carnet_estudiante);
    

            ELSIF v_id_materia IS NULL THEN
                dbms_output.put_line('No existe el grupo ' || v_id_grupo);
             
            END IF;   
        WHEN OTHERS THEN
            dbms_output.put_line('ERROR: ' || SQLERRM);   
END;
/
--PRUEBAS A REVISAR REQUISITOS
--EXECUTE revisar_requisitos (2019344583, 'AE-98-2019');
--EXECUTE revisar_requisitos (204583, 'MA-35-2018');
--EXECUTE revisar_requisitos (2020313987,'IC-75-2017');
--EXECUTE revisar_requisitos (2016175133, 'IC-0-2017');
--EXECUTE revisar_requisitos (202132453, 'IE-90-2018');
--EXECUTE revisar_requisitos (202132453, 'IC-75-2017');

/*
Crear una función que calcule el promedio ponderado (basado en el último período matriculado)
para un estudiante dado. Dicha función debe ser invocada por un procedimiento que reciba como 
parámetro un año e inserte en una tabla temporal la información de todos estudiantes que tengan carnet 
con ese año (carnet, nombre, ponderado).  
Dicha tabla temporal se consultará después de la ejecución del procedimiento. 20pts.  
*/


CREATE OR REPLACE FUNCTION calcular_ponderado(v_carnet_estudiante NUMBER,v_numero_ultimo_periodo NUMBER,v_ultimo_año VARCHAR2)
RETURN NUMBER
IS
    v_periodo_buscado periodo.id_periodo%TYPE;
    v_nota_ponderada estudiante_grupo.nota%TYPE;
BEGIN
    
    SELECT id_periodo INTO v_periodo_buscado 
    FROM periodo
    WHERE año =v_ultimo_año AND numero_periodo = v_numero_ultimo_periodo;
    
    SELECT SUM(nota*materia.creditos)/SUM(creditos) INTO v_nota_ponderada FROM materia
    JOIN grupo ON grupo.id_materia = materia.id_materia
    JOIN (SELECT id_periodo id_periodo_buscado FROM periodo WHERE id_periodo=v_periodo_buscado) ON grupo.id_periodo =id_periodo_buscado
    JOIN (SELECT carnet,nota ,id_grupo FROM estudiante_grupo WHERE carnet= v_carnet_estudiante) egr ON egr.id_grupo = grupo.id_grupo
    JOIN estudiante ON egr.carnet= estudiante.carnet
    GROUP BY nombre_estudiante;
    
    RETURN v_nota_ponderada;
    
    EXCEPTION 
        WHEN zero_divide THEN
            RETURN 0;
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
            RETURN 0;
END;
/

CREATE OR REPLACE PROCEDURE obtener_ponderados_por_año(v_año NUMBER)
IS
    CURSOR estudiantes_año IS    
    SELECT estudiante_grupo.carnet, MAX(numero_periodo) ult_periodo, MAX(año) ult_año
    FROM estudiante_grupo
    JOIN grupo ON estudiante_grupo.id_grupo = grupo.id_grupo
    JOIN periodo ON grupo.id_periodo = periodo.id_periodo
    WHERE to_char(carnet) LIKE to_char(v_año)||'%_'
    GROUP BY estudiante_grupo.carnet;
    
    v_ponderado_estudiante estudiante_grupo.nota%TYPE;
    v_nombre_estudiante estudiante.nombre_estudiante%TYPE;
 BEGIN   
    FOR est IN estudiantes_año LOOP
      v_ponderado_estudiante := calcular_ponderado(est.carnet,est.ult_periodo,est.ult_año);
      SELECT nombre_estudiante INTO v_nombre_estudiante FROM estudiante WHERE carnet =est.carnet;
      INSERT INTO temp_ponderados VALUES (est.carnet,v_nombre_estudiante,floor(v_ponderado_estudiante));
    END LOOP;
 END obtener_ponderados_por_año;
/
---PRUEBAS REALIZADAS----
--EXECUTE obtener_ponderados_por_año(2008);
--EXECUTE obtener_ponderados_por_año(2015);
--EXECUTE obtener_ponderados_por_año(2016);
--EXECUTE obtener_ponderados_por_año(2017);
--EXECUTE obtener_ponderados_por_año(2018);
--EXECUTE obtener_ponderados_por_año(2019);
--EXECUTE obtener_ponderados_por_año(2020);
--EXECUTE obtener_ponderados_por_año(2049);
--TRUNCATE TABLE temp_ponderados;
--SELECT  * from temp_ponderados;

/* PRUEBAS ADICIONALES A  obtener_ponderados_por_año 
INSERT INTO estudiante_grupo values (2019344583,'AE-98-2019',80);
INSERT INTO estudiante_grupo values (2019344583,'MA-35-2018',80);
INSERT INTO estudiante_grupo values (2016175133,'AE-98-2019',100);


EXECUTE obtener_ponderados_por_año(2019);
EXECUTE obtener_ponderados_por_año(2016);

*/

    
--- PROCEDURE DE DROPEAR TABLAS----
CREATE OR REPLACE PROCEDURE dropear_datos
IS
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE estudiante_beca';
    EXECUTE IMMEDIATE 'DROP TABLE estudiante_grupo';
    EXECUTE IMMEDIATE 'DROP TABLE grupo_horario_aula';
    EXECUTE IMMEDIATE 'DROP TABLE estudiante';
    EXECUTE IMMEDIATE 'DROP TABLE provincia';
    EXECUTE IMMEDIATE 'DROP TABLE grupo';
    EXECUTE IMMEDIATE 'DROP TABLE periodo';
    EXECUTE IMMEDIATE 'DROP TABLE beca';
    EXECUTE IMMEDIATE 'DROP TABLE profesor';
    EXECUTE IMMEDIATE 'DROP TABLE requisito';
    EXECUTE IMMEDIATE 'DROP TABLE materia';
    EXECUTE IMMEDIATE 'DROP TABLE departamento';
    EXECUTE IMMEDIATE 'DROP TABLE aula';
    EXECUTE IMMEDIATE 'DROP TABLE horario';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_ponderados';
    EXECUTE IMMEDIATE 'DROP TABLE temp_ponderados';
    EXECUTE IMMEDIATE 'DROP PROCEDURE obtener_ponderados_por_año';
    EXECUTE IMMEDIATE 'DROP PROCEDURE revisar_requisitos';
    EXECUTE IMMEDIATE 'DROP FUNCTION calcular_ponderado';
    EXECUTE IMMEDIATE 'DROP FUNCTION buscar_requisitos_pendientes';
END dropear_datos;
/
EXECUTE dropear_datos;