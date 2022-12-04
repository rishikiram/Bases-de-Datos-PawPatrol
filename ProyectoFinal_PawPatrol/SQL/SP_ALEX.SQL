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

    IF num_programas_aprobados = num_programas_requeridos THEN 
        RETURN TRUE;
    ELSE 
        RAISE NOTICE 'El agente (%) no puede laborar en esta sala, ya que no ha aprobado algún curso con el programa necesario (%)', p_id_agente, p_id_programa_curso;
        RETURN false;
    END IF;
END;
$$;