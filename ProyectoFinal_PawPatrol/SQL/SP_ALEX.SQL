CREATE OR REPLACE FUNCTION get_numero_de_faltas_en_curso(
        id_agente int,
        id_curso int,
        id_programa_curso int,
        id_cliente int
    ) RETURNS boolean LANGUAGE plpgsql AS $$
DECLARE num_faltas boolean;
BEGIN
SELECT COUNT(*) INTO num_faltas
FROM faltar
WHERE faltar.id_agente = id_agente
    AND id_curso = id_curso
    AND faltar.id_programa_curso = id_programa_curso
    AND faltar.id_cliente = id_cliente;
RETURN num_faltas;
END;
$$;