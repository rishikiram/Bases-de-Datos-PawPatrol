DROP FUNCTION get_numero_de_faltas_en_curso(
    p_id_agente int,
    p_id_curso int,
    p_id_programa_curso int,
    p_id_cliente int
);

DROP FUNCTION ya_aprobo_programa(
    p_id_agente int,
    p_id_programa_curso int,
    p_id_cliente int
);

DROP FUNCTION laborar_operaciones_check_aprobacion_function(
    p_id_reservacion_operaciones int,
    p_num_sala int,
    p_num_piso int,
    p_id_edificio int,
    p_id_agente int
);

DROP FUNCTION sala_de_operaciones_esta_libre_entre(
    p_num_sala int,
    p_num_piso int,
    p_id_edificio int,
    p_fecha_comienzo date,
    p_fecha_fin date
);

DROP FUNCTION sala_de_operaciones_esta_libre_en(
    p_num_sala int,
    p_num_piso int,
    p_id_edificio int,
    p_fecha date
);

DROP FUNCTION fecha_reservacion_operaciones_check_no_overlap_function(
    p_num_sala int,
    p_num_piso int,
    p_id_edificio int,
    p_fecha date
);

DROP FUNCTION sala_de_operaciones_esta_libre_durante(
    p_num_sala int,
    p_num_piso int,
    p_id_edificio int,
    p_rango tsrange
);

DROP FUNCTION asignar_check_no_overlap_function(
    p_num_sala int,
    p_num_piso int,
    p_id_edificio int,
    p_horario tsrange
);

DROP FUNCTION get_dates_in_tsrange(p_range tsrange);

DROP FUNCTION asignar_check_no_sunday_function(p_horario tsrange);

DROP FUNCTION get_duracion_curso_durante_semana(
    p_id_curso int,
    p_id_programa_curso int,
    p_id_cliente int,
    p_anio int,
    p_semana int
);

DROP FUNCTION horario_curso_check_weekly_time_limit_function(
    p_id_curso int,
    p_id_programa_curso int,
    p_id_cliente int,
    p_rango tsrange
);
DROP FUNCTION check_numero_salas(
  num_pis int,
  id_edi int
);
