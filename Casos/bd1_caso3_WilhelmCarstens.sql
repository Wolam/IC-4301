--%%%%%% BASES DE DATOS CASO 3 %%%%%%
--- Prof.Alberto Shum, I-Sem 2020
--- Est. WILHELM CARSTENS


SET serveroutput ON;

-- Dado un día devuelva el nombre de los cursos y horario en el que se imparte. Los cursos deben
--estar ordenados por el horario en el que se imparten, de menor a mayor

/*
ver_materias_y_horarios
ENTRADAS: UN DIA A LA SEMANA QUE SEA LA LETRA INICIAL L,K,M,J,V,S,D

SALIDAS: LAS MATERIAS QUE SE IMPARTEN DICHO DIA CON HORA DE INICIO O FIN
SI NO HAY, SE IMPRIME UN MSJ DE DATOS NO ENCONTRADOS

RESTRICCIONES: RECIBE 1 SOLO PARAMETRO CON EL DIA DE LA SEMANA TIPO VARCHAR2
*/
CREATE OR REPLACE PROCEDURE ver_materias_y_horarios (
    v_dia_semana IN VARCHAR2
) IS

    CURSOR cur_horarios_materias IS
    SELECT
        nombre_materia,
        hora_inicio,
        hora_fin
    FROM
        materia
        JOIN (SELECT * FROM grupo_horario_aula   gr_h_a
        JOIN horario h ON h.id_horario = gr_h_a.id_horario
        ) horarios_actuales ON materia.id_materia = horarios_actuales.id_materia
    WHERE
        dia = v_dia_semana
    ORDER BY
        hora_inicio;

    no_hay_materias BOOLEAN := true;
BEGIN
    FOR reg IN cur_horarios_materias LOOP
        no_hay_materias := false;
        dbms_output.put_line('El dia '|| v_dia_semana || ' se imparte la materia: ' || reg.nombre_materia
                             || chr(10)
                             || 'Inicia a las: ' || TO_CHAR(reg.hora_inicio, 'hh24:mi')
                             || chr(10) 
                             || 'Termina a las: ' || TO_CHAR(reg.hora_fin, 'hh24:mi')
                             || chr(10) || chr(10));

    END LOOP;

    IF no_hay_materias THEN
        dbms_output.put_line('No se encontraron materias para el dia: ' || v_dia_semana);
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('ERROR ENCONTRADO: ' || sqlerrm);
END;
/    
/* %%% PRUEBAS REALIZADAS %%%%
EXEC ver_materias_y_horarios(200);
EXEC ver_materias_y_horarios(TRUE);
EXEC ver_materias_y_horarios('M');
EXEC ver_materias_y_horarios('D');
EXEC ver_materias_y_horarios('DOMINGO');
EXEC ver_materias_y_horarios(sysdate);
*/


--Dada una materia (código), devuelva el nombre de la materia, nombre departamento al que
--pertenece y la lista estudiantes matriculados (carnet y nombre)

/*
 ------ ver_estudiantes_y_dpto ------
ENTRADAS: UN CODIGO DE MATERIA AL QUE SE LE QUIEREN REVISAR LOS  ESTUDIANTES MATRICULADOS
EJM: 'IC-3400','MA-121','IC-3200','CL-3213'... ETC

SALIDAS: UN MSJ EN PANTALLA CON LOS ESTUDIANTES MATRICULADOS EN DICHA MATERIA
CASO DE QUE NO EXISTA LA MATERIA O NO HAYAN ESTUDIANTES SE IMPRIME UN MSJ DE DATOS NO ENCONTRADOS

RESTRICCIONES: UN SOLO CODIGO DE MATERIA DE TIPO VARCHAR2  QUE CUMPLA EL TIPO VARCHAR2 Y ESTE EN LA BD
*/

CREATE OR REPLACE PROCEDURE ver_estudiantes_y_dpto (
    v_cod_materia IN VARCHAR2
) IS

    CURSOR estudiantes_matriculados IS
    SELECT
        est.carnet,
        est.nombre_estudiante
    FROM
        (SELECT num_grupo,id_materia FROM grupo WHERE id_materia = v_cod_materia) gr
        JOIN estudiante_grupo e_gr ON gr.num_grupo = e_gr.num_grupo
        JOIN estudiante est ON e_gr.carnet = est.carnet;

    v_nombre_materia     VARCHAR2(30);
    v_id_dpto            VARCHAR2(3 CHAR);
    v_nom_dpto          VARCHAR2(20 CHAR);
    NO_HAY_ESTUDIANTES   BOOLEAN := true;
BEGIN
    SELECT
        nombre_materia,
        dpto.id_departamento,
        dpto.nombre_departamento
    INTO
        v_nombre_materia,
        v_id_dpto,
        v_nom_dpto
    FROM
        (SELECT * FROM materia WHERE id_materia=v_cod_materia) mat
        JOIN departamento dpto ON dpto.id_departamento = mat.id_departamento;

    dbms_output.put_line('**Estudiantes matriculados en '
                         || v_nombre_materia
                         || ' ('
                         || v_cod_materia
                         || ')**'
                         || chr(10));

    FOR reg IN estudiantes_matriculados LOOP
        NO_HAY_ESTUDIANTES := false;
        dbms_output.put_line(reg.nombre_estudiante
                             || '('
                             || reg.carnet
                             || ')'
                             || chr(10));

    END LOOP;

    IF NO_HAY_ESTUDIANTES THEN
        dbms_output.put_line('No se encontraron estudiantes matriculados para la materia: ' || v_cod_materia);
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No se encontro la materia con cod: ' || v_cod_materia);
    WHEN OTHERS THEN
        dbms_output.put_line('SQLERRM: ' || sqlerrm);
END;
/
/* %%% PRUEBAS REALIZADAS %%%%

EXEC ver_estudiantes_y_dpto(200);
EXEC ver_estudiantes_y_dpto('IC-3400');
EXEC ver_estudiantes_y_dpto('MA-321');
EXEC ver_estudiantes_y_dpto(32.32);
EXEC ver_estudiantes_y_dpto('CL');
EXEC ver_estudiantes_y_dpto(True);
EXEC ver_estudiantes_y_dpto('ADASDADSADSADASDSADADASDASDASDSADASDFDSFSFDS');
EXEC ver_estudiantes_y_dpto(sysdate);
EXEC ver_estudiantes_y_dpto('');

*/
--3. Para optar por la beca para residencias estudiantiles el estudiante debe matricular y aprobar 10
--créditos semestrales. Cree una función que sirva para determinar si un estudiante cumple o no
--ese requisito. 

/*
 ------ aprueba_beca_residencia ------
ENTRADAS: NUMERO DE CARNET AL QUE SE LE DESEA SABER SI OPTA POR B-RESIDENCIA

SALIDAS: UN BOOLEANO CORRESPONDIENTE A SI EL ESTUDIANTE APRUEBA O NO LA BECA

RESTRICCIONES: UN SOLO CARNET DE TIPO NUMBER QUE SEA PROPIO DE UN ESTUDIANTE INSCRITO
EN EL SISTEMA DE MATRICULA
*/

CREATE OR REPLACE FUNCTION aprueba_beca_residencia (
    v_carnet_char IN VARCHAR2
--- UTILIZAR VARCHAR2 PARA QUE PERMITA DATOS DE TIPO NUMBER O VARCHAR2
--- DE LO CONTRARIO SOLO ACEPTA NUMBERS
) RETURN BOOLEAN IS
    creditos_aprobados   NUMBER;
    v_carnet_int NUMBER;
    nombre_solicitante   VARCHAR2(30);
BEGIN
    v_carnet_int := TO_NUMBER(v_carnet_char);
    SELECT
        nombre_estudiante,
        SUM(creditos)
    INTO
        nombre_solicitante,
        creditos_aprobados
    FROM
        ( (SELECT carnet, nombre_estudiante FROM estudiante WHERE carnet = v_carnet_int) est
        JOIN estudiante_grupo  e_gr ON e_gr.carnet = est.carnet
        JOIN (SELECT creditos, id_materia FROM materia) mat ON e_gr.id_materia = mat.id_materia )
    WHERE
        nota >= 70 group by
        nombre_estudiante;

    IF creditos_aprobados >= 10 THEN
        dbms_output.put_line ('El estudiante: ' 
                            || nombre_solicitante
                            || ' puede optar por beca de residencia');
        RETURN TRUE;
    ELSE
        dbms_output.put_line ('El estudiante: ' 
                            || nombre_solicitante
                            || ' no puede optar por beca de residencia');
        RETURN FALSE;
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No se encontraron datos para carnet: ' || v_carnet_char);
         RETURN FALSE; 
    WHEN VALUE_ERROR THEN
        dbms_output.put_line('ERROR EN LOS PARAMETROS INGRESADOS');
        RETURN FALSE;
    WHEN OTHERS THEN
        dbms_output.put_line('ERROR ENCONTRADO: ' || sqlerrm);
        RETURN FALSE;
END;
/
/* %%% PRUEBAS REALIZADAS %%%%

DECLARE 
   c BOOLEAN; 
   --f FLOAT := 10 * POWER(10,123);
BEGIN 
--c := aprueba_beca_residencia(2021);
--c := aprueba_beca_residencia(2019344583);
--c := aprueba_beca_residencia('2019344583');
--c := aprueba_beca_residencia(f);
--c := aprueba_beca_residencia(true);
--c := aprueba_beca_residencia('hola');
--c := aprueba_beca_residencia(308193190831923821903821093810931321312312312312312);
END; 
/
*/

--4. Dado un departamento (código), se quiere el nombre del departamento y la lista de todos los
--cursos y un conteo de la cantidad de estudiantes matriculados en cada curso. 

/*
 ------ ver_conteo_estudiantes ------
ENTRADAS :UN CODIGO DEL DEPARTAMENTO AL QUE SE LE QUIEREN REVISAR LA 
CANTIDAD ESTUDIANTES MATRICULADOS EN CADA MATERIA PERTENECIENTE AL DPTO
EJM: 'IC','MA','IA','IE'... ETC

SALIDAS: UN MSJ QUE CONTENGA LA LISTA DE MATERIAS DEL DPTO
JUNTO A LA CANTIDAD DE ESTUDIANTES MATRICULADOS EN CADA MATERIA


RESTRICCIONES: UN SOLO CODIGO DE DPTO QUE ESTE EN BD DEL SISTEMA Y **TENGA MATERIAS**
*/
CREATE OR REPLACE PROCEDURE ver_conteo_estudiantes (
    v_cod_dpto IN CHAR
) IS
    CURSOR cur_cursos_estudiantes is
    
    SELECT
        COUNT(carnet) estudiantes_en_curso,
        mat.nombre_materia,
        nombre_departamento
    FROM
        ( (SELECT * FROM departamento WHERE id_departamento = v_cod_dpto) dpto_buscado
        LEFT JOIN materia  mat ON dpto_buscado.id_departamento = mat.id_departamento
        LEFT JOIN grupo ON grupo.id_materia = mat.id_materia
        LEFT JOIN estudiante_grupo e_gr ON e_gr.num_grupo = grupo.num_grupo )
    GROUP BY
        mat.nombre_materia,
        nombre_departamento;
        
    NO_EXISTE_DPTO BOOLEAN := TRUE;
    
BEGIN
    dbms_output.PUT_LINE('INFORMACION DEL DPTO: ' || v_cod_dpto);
    FOR reg IN cur_cursos_estudiantes LOOP 
        NO_EXISTE_DPTO := FALSE;
        IF reg.nombre_materia IS NULL THEN 
            reg.nombre_materia := 'NINGUNA';
        END IF;
        dbms_output.put_line(chr(10) || 
                            'Se tiene registrada la materia: ' 
                            || reg.nombre_materia 
                            || chr(10)
                            || 'TOTAL Estudiante(s): ' 
                            || reg.estudiantes_en_curso
                            || chr(10));
    
    END LOOP;
    IF NO_EXISTE_DPTO THEN
        dbms_output.put_line('No se encontro el dpto');
    END IF;
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('ERROR ENCONTRADO: ' || sqlerrm);

END;
/
/* %%% PRUEBAS REALIZADAS %%%%


EXEC ver_conteo_estudiantes(POWER(2,256));
EXEC ver_conteo_estudiantes('IC');
EXEC ver_conteo_estudiantes('DPTO NO REGISTRADO');
EXEC ver_conteo_estudiantes('DPTO SIN MATERIAS'');
EXEC ver_conteo_estudiantes('UN DEPARTAMENTO CON AL MENOS UNA MATERIA SIN NINGUN ESTUDIANTE');
EXEC ver_conteo_estudiantes(True); --ERROR DEL PARAMETRO Y NO DEL PROCEDURE
EXEC ver_conteo_estudiantes('DOMINGO');
EXEC ver_conteo_estudiantes(sysdate);

*/