-- Realiza el check del constraint check_fk_asistencia_pk_empleado
CREATE OR REPLACE FUNCTION check_fk_asistencia_pk_empleado_function(
    p_id_empleado int
  ) RETURNS boolean LANGUAGE plpgsql AS
  $$
    DECLARE empleado_exists boolean;
    BEGIN
        SELECT
        EXISTS (SELECT
                    1
                FROM empleado -- Aquí sí incluye a agente y a entrenador
                WHERE id_empleado = p_id_empleado
                LIMIT 1)
        INTO empleado_exists;
        IF empleado_exists THEN
            RETURN TRUE;
        ELSE
            RAISE NOTICE 'El empleado con ID % no está registrado.', p_id_empleado;
            RETURN FALSE;
        END IF;
    END;
  $$;

-- Realiza el check del constraint check_fk_estacion_pk_sala
CREATE OR REPLACE FUNCTION check_fk_estacion_pk_sala_function(
    p_num_sala int,
    p_num_piso int,
    p_id_edificio int
  ) RETURNS boolean LANGUAGE plpgsql AS
  $$
    DECLARE sala_pk_exists boolean;
    BEGIN
        SELECT
        EXISTS (SELECT
                    1
                FROM sala -- Aquí sí incluye a sala_operaciones y a sala_reserva
                WHERE num_sala = p_num_sala
                    AND num_piso = p_num_piso
                    AND id_edificio = p_id_edificio
                LIMIT 1)
        INTO sala_pk_exists;
        IF sala_pk_exists THEN
            RETURN TRUE;
        ELSE
            RAISE NOTICE 'No existe una sala con número (%), piso (%) y edificio (%) en ninguna de las tablas de sala.', p_num_sala, p_num_piso, p_id_edificio;
            RETURN FALSE;
        END IF;
    END;
  $$;

-- Indica el número de veces que un agente ha faltado a un curso
CREATE OR REPLACE FUNCTION get_numero_de_faltas_en_curso(
        p_id_agente int,
        p_id_curso int,
        p_id_programa_curso int,
        p_id_cliente int
    ) RETURNS int LANGUAGE plpgsql AS $$
DECLARE num_faltas int;
BEGIN
    SELECT COUNT(*) INTO num_faltas
    FROM faltar
    WHERE id_empleado = p_id_agente
        AND id_curso = p_id_curso
        AND id_programa_curso = p_id_programa_curso
        AND id_cliente = p_id_cliente;
    RETURN num_faltas;
END;
$$;


-- Indica si un agente ya aprobó algún curso con el programa dado
CREATE OR REPLACE FUNCTION ya_aprobo_programa(
        p_id_agente int,
        p_id_programa_curso int,
        p_id_cliente int
    ) RETURNS boolean LANGUAGE plpgsql AS $$
DECLARE calificacion_mayor int;
BEGIN
    SELECT GREATEST(0, MAX(calificacion)) INTO calificacion_mayor
    FROM evaluar
    WHERE id_empleado = p_id_agente
        AND id_programa_curso = p_id_programa_curso
        AND id_cliente = p_id_cliente;
    RETURN calificacion_mayor>=8;
END;
$$;

-- Realiza el check del constraint laborar_operaciones_check_aprobacion
CREATE OR REPLACE FUNCTION laborar_operaciones_check_aprobacion_function(
        p_id_reservacion_operaciones int,
        p_num_sala int,
        p_num_piso int,
        p_id_edificio int,
        p_id_agente int
    ) RETURNS boolean LANGUAGE plpgsql AS $$
DECLARE num_programas_aprobados int;
DECLARE num_programas_requeridos int;
BEGIN
    SELECT
        COUNT(*),
        SUM(CASE
            WHEN ya_aprobo_programa(p_id_agente, requerir.id_programa_curso, requerir.id_cliente)
                THEN 1
                ELSE 0
            END
        )
    INTO
        num_programas_requeridos,
        num_programas_aprobados
    FROM requerir
    WHERE requerir.id_reservacion_operaciones = p_id_reservacion_operaciones
        AND requerir.num_sala = p_num_sala
        AND requerir.num_piso = p_num_piso
        AND requerir.id_edificio = p_id_edificio;

    IF COALESCE(num_programas_aprobados = num_programas_requeridos, true) THEN
        RETURN TRUE;
    ELSE
        RAISE NOTICE 'El agente (%) no puede laborar en esta sala, ya que no ha aprobado algún curso con el programa necesario (%)', p_id_agente, p_id_programa_curso;
        RETURN false;
    END IF;
END;
$$;


-- Revisa si una sala de operaciones está libre durante un rango de tiempo
CREATE OR REPLACE FUNCTION sala_de_operaciones_esta_libre_entre(
        p_num_sala int,
        p_num_piso int,
        p_id_edificio int,
        p_fecha_comienzo date,
        p_fecha_fin date
    ) RETURNS boolean LANGUAGE plpgsql AS $$
    DECLARE booked boolean;
    BEGIN
        SELECT
            EXISTS (SELECT
                        1
                    FROM fecha_reservacion_operaciones
                    WHERE p_fecha_comienzo <= fecha_reservacion_operaciones.fecha
                        AND fecha_reservacion_operaciones.fecha <= p_fecha_fin
                        AND fecha_reservacion_operaciones.num_sala = p_num_sala
                        AND fecha_reservacion_operaciones.num_piso = p_num_piso
                        AND fecha_reservacion_operaciones.id_edificio = p_id_edificio
                    LIMIT 1)
        INTO booked;
        RETURN NOT booked;
    END;
$$;

-- Revisa si una sala de operaciones está libre en una fecha dada
CREATE OR REPLACE FUNCTION sala_de_operaciones_esta_libre_en(
        p_num_sala int,
        p_num_piso int,
        p_id_edificio int,
        p_fecha date
    ) RETURNS boolean LANGUAGE plpgsql AS $$
    DECLARE libre boolean;
    BEGIN
        SELECT
            sala_de_operaciones_esta_libre_entre(p_num_sala, p_num_piso, p_id_edificio, p_fecha, p_fecha)
        INTO libre;
        RETURN libre;
    END;
$$;


-- Realiza el check del constraint fecha_reservacion_operaciones_check_no_overlap
CREATE OR REPLACE FUNCTION fecha_reservacion_operaciones_check_no_overlap_function(
        p_num_sala int,
        p_num_piso int,
        p_id_edificio int,
        p_fecha date
    ) RETURNS boolean LANGUAGE plpgsql AS $$
    BEGIN
        IF sala_de_operaciones_esta_libre_en(p_num_sala, p_num_piso, p_id_edificio, p_fecha) THEN
            RETURN TRUE;
        ELSE
            RAISE NOTICE 'No se puede insertar la fecha de reservación, pues la sala (%) del piso (%) del edificio (%) ya está ocupada en la fecha (%)', p_num_sala, p_num_piso, p_id_edificio, p_fecha;
            RETURN FALSE;
        END IF;
    END;
$$;


-- Revisa si una sala de operaciones está libre durante un rango de tiempo
CREATE OR REPLACE FUNCTION sala_de_operaciones_esta_libre_durante(
        p_num_sala int,
        p_num_piso int,
        p_id_edificio int,
        p_rango tsrange
    ) RETURNS boolean LANGUAGE plpgsql AS $$
    DECLARE booked boolean;
    BEGIN
        SELECT
            EXISTS (SELECT
                        1
                    FROM asignar
                    WHERE p_rango && asignar.horario_reserva -- Traslape de tsrange
                        AND p_num_sala = asignar.num_sala
                        AND p_num_piso = asignar.num_piso
                        AND p_id_edificio = asignar.id_edificio
                    LIMIT 1)
        INTO booked;
        RETURN NOT booked;
    END;
$$;

-- Realiza el check del constraint asignar_check_no_overlap
CREATE OR REPLACE FUNCTION asignar_check_no_overlap_function(
        p_num_sala int,
        p_num_piso int,
        p_id_edificio int,
        p_horario tsrange
    ) RETURNS boolean LANGUAGE plpgsql AS $$
    BEGIN
        IF sala_de_operaciones_esta_libre_durante(p_num_sala, p_num_piso, p_id_edificio, p_horario) THEN
            RETURN TRUE;
        ELSE
            RAISE NOTICE 'No se puede asignar la sala durante el horario solicitado, pues la sala (%) del piso (%) del edificio (%) ya está ocupada durante el rango (%)', p_num_sala, p_num_piso, p_id_edificio, p_horario;
            RETURN FALSE;
        END IF;
    END;
$$;

-- Extrae las fechas diferentes que ocurren durante un tsrange
CREATE OR REPLACE FUNCTION get_dates_in_tsrange(
        p_range tsrange
    ) RETURNS TABLE (d date) LANGUAGE plpgsql AS $$
    BEGIN
        RETURN QUERY (
            SELECT
                date_trunc('day', dd)::date AS d
            FROM
                generate_series(
                    lower(p_range)::timestamp,
                    upper(p_range)::timestamp,
                    '1 day'::interval
                ) dd
        );
    END;
$$;


-- Revisa si alguna parte de un ts-range sucede durante un domingo. Realiza el check del constraint asignar_check_no_sunday
CREATE OR REPLACE FUNCTION asignar_check_no_sunday_function(
        p_horario tsrange
    ) RETURNS boolean LANGUAGE plpgsql AS $$
    DECLARE has_sunday boolean;
    BEGIN
        SELECT
            EXISTS (
                WITH dates AS (
                    SELECT * FROM get_dates_in_tsrange(p_horario)
                )
                SELECT
                    1
                FROM dates
                WHERE EXTRACT(isodow FROM dates.d) = 7
                LIMIT 1
            )
        INTO has_sunday;
        IF has_sunday THEN
            RAISE NOTICE 'No se puede asignar la sala durante un domingo';
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    END;
$$;


-- Obtiene el número de horas asignadas a una sala de capacitación durante
CREATE OR REPLACE FUNCTION get_duracion_curso_durante_semana(
        p_id_curso int,
        p_id_programa_curso int,
        p_id_cliente int,
        p_anio int,
        p_semana int -- Entre 1 y 52 (EXTRACT(week from date))
    ) RETURNS interval LANGUAGE plpgsql AS $$
    DECLARE duracion interval;
    BEGIN
        WITH tiempos AS (
            SELECT
                UPPER(rango) AS ts_fin,
                LOWER(rango) AS ts_inicio
            FROM horario_curso
            WHERE horario_curso.id_curso = p_id_curso
                AND horario_curso.id_programa_curso = p_id_programa_curso
                AND horario_curso.id_cliente = p_id_cliente
        )
        SELECT
            COALESCE(SUM(ts_fin-ts_inicio), '00:00:00'::interval)
        INTO duracion
        FROM tiempos
        WHERE
            -- Como no hay reservas en domingo, ts_inicio y ts_fin están en la misma semana
            EXTRACT(week from ts_inicio::date)=p_semana
            AND EXTRACT(year from ts_inicio::date)=p_anio;
        RETURN duracion;
    END;
$$;

-- Revisa si se puede agregar un nuevo rango de horas sin pasarse del límite de horas por semana. Realiza el check del constraint asignar_check_weekly_time_limit
CREATE OR REPLACE FUNCTION horario_curso_check_weekly_time_limit_function(
        p_id_curso int,
        p_id_programa_curso int,
        p_id_cliente int,
        p_rango tsrange
    ) RETURNS boolean LANGUAGE plpgsql AS $$
    DECLARE pasa_limite boolean;
    BEGIN
        SELECT
            (
                UPPER(p_rango)-LOWER(p_rango)
                +
                get_duracion_curso_durante_semana(
                    p_id_curso,
                    p_id_programa_curso,
                    p_id_cliente,
                    EXTRACT(year FROM LOWER(p_rango))::int,
                    EXTRACT(week FROM LOWER(p_rango))::int
                )
            )>'42:00:00'::interval
        INTO pasa_limite;
        IF pasa_limite THEN
            RAISE NOTICE 'No se puede agregar ese horario, ya que se superaría el límite de 42 horas por semana para este curso';
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    END;
$$;

CREATE OR REPLACE FUNCTION check_numero_salas(
  num_pis int,
  id_edi int
) RETURNS boolean LANGUAGE plpgsql AS $$
DECLARE
sal BIGINT;
BEGIN
  SELECT COUNT(sala.num_sala)
    AS cnt
    FROM sala
    GROUP BY sala.id_edificio, sala.num_piso
    HAVING sala.id_edificio = id_edi AND sala.num_piso = num_pis
    INTO sal;
    IF (sal > 7)
        THEN RAISE EXCEPTION 'El Piso % en Edificio % ya tiene 8 pisos', num_pis, id_edi
        USING HINT = 'Los Piso tiene 8 salas al maximo';
        RETURN FALSE;
    END IF;
    RETURN TRUE;
END
$$;

-- Indica si un empleado tiene acceso a un piso
CREATE OR REPLACE FUNCTION empleado_tiene_acceso_a_piso(
    p_id_empleado int,
    p_num_piso int,
    p_id_edificio int
) RETURNS boolean LANGUAGE plpgsql AS $$
    DECLARE tiene_acceso boolean;
    BEGIN
        SELECT
            EXISTS(
                SELECT
                    1
                FROM empleado
                WHERE id_empleado=p_id_empleado
                    AND num_piso=p_num_piso
                    AND id_edificio=p_id_edificio
                LIMIT 1
            )
        INTO tiene_acceso;

        RETURN tiene_acceso;
    END;
$$;

-- Realiza el check del constraint check_asistencia_acceso
CREATE OR REPLACE FUNCTION check_asistencia_acceso_function(
    id_empleado int,
    id_edificio int,
    num_piso int
) RETURNS boolean LANGUAGE plpgsql AS $$
    BEGIN
        IF empleado_tiene_acceso_a_piso(id_empleado, id_edificio, num_piso) THEN
            RETURN TRUE;
        ELSE
            RAISE NOTICE 'El empleado no tiene acceso al piso';
            RETURN FALSE;
        END IF;
    END;
$$;

-- Indica cuántas tuplas tiene cada una de las tablas en la base de datos
CREATE OR REPLACE FUNCTION get_database_row_counts()
RETURNS TABLE(table_name information_schema.sql_identifier, rows_n int)
LANGUAGE plpgsql AS $$
    BEGIN
        RETURN QUERY(
            WITH tbl AS (
                SELECT table_schema,
                    information_schema.tables.TABLE_NAME
                FROM information_schema.tables
                WHERE information_schema.tables.TABLE_NAME NOT LIKE 'pg_%'
                    AND table_schema IN ('public')
            )
            SELECT tbl.TABLE_NAME AS table_name,
                (
                    xpath(
                        '/row/c/text()',
                        query_to_xml(
                            format(
                                'select count(*) as c from %I.%I',
                                table_schema,
                                tbl.TABLE_NAME
                            ),
                            FALSE,
                            TRUE,
                            ''
                        )
                    )
                ) [1]::text::int AS rows_n
            FROM tbl
            ORDER BY rows_n DESC
        );
    END;
$$;
