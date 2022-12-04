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

-- Realiza el check del constraint evaluar_check_faltas
CREATE OR REPLACE FUNCTION evaluar_check_faltas_function(
    calificacion int,
    id_empleado int,
    id_curso int,
    id_programa_curso int,
    id_cliente int
  ) RETURNS boolean LANGUAGE plpgsql AS 
  $$
    BEGIN 
      IF (
        calificacion < 8
        OR get_numero_de_faltas_en_curso (
          id_empleado,
          id_curso,
          id_programa_curso,
          id_cliente
        ) < 3
      ) THEN 
        RETURN true;
      ELSE 
        RAISE NOTICE 'La calificación no puede ser aprobatoria si faltó 3 veces';
        RETURN false;
      END IF;
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