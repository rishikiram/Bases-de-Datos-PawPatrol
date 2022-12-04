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

-- Realiza el check del constraint calificacion_check_faltas
CREATE OR REPLACE FUNCTION calificacion_check_faltas_function(
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