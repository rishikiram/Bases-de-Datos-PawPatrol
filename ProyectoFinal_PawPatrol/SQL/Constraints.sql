ALTER TABLE asistencia
ADD CONSTRAINT check_fk_asistencia_pk_empleado CHECK(
  check_fk_asistencia_pk_empleado_function(
    id_empleado
  )
);

ALTER TABLE estacion
ADD CONSTRAINT check_fk_estacion_pk_sala CHECK(
  check_fk_estacion_pk_sala_function(
    num_sala,
    num_piso,
    id_edificio
  )
);


ALTER TABLE laborar_operaciones
ADD CONSTRAINT laborar_operaciones_check_aprobacion CHECK (
    laborar_operaciones_check_aprobacion_function(
      id_reservacion_operaciones,
      num_sala,
      num_piso,
      id_edificio,
      id_empleado
    )
  );

ALTER TABLE fecha_reservacion_operaciones
ADD CONSTRAINT fecha_reservacion_operaciones_check_no_overlap CHECK (
    fecha_reservacion_operaciones_check_no_overlap_function(
      num_sala,
      num_piso,
      id_edificio,
      fecha
    )
  );


ALTER TABLE asignar
ADD CONSTRAINT asignar_check_no_overlap CHECK (
    asignar_check_no_overlap_function(
      num_sala,
      num_piso,
      id_edificio,
      horario_reserva
    )
  );

ALTER TABLE asignar
ADD CONSTRAINT asignar_check_no_sunday CHECK (
    asignar_check_no_sunday_function(
      horario_reserva
    )
  );

ALTER TABLE horario_curso
ADD CONSTRAINT horario_curso_check_weekly_time_limit CHECK (
    horario_curso_check_weekly_time_limit_function(
      id_curso,
      id_programa_curso,
      id_cliente,
      rango
    )
  );

ALTER TABLE sala_operacion
ADD CONSTRAINT num_sala_operacion CHECK (
    check_numero_salas (
      num_piso,
      id_edificio
    )
  );

ALTER TABLE sala_capacitacion
ADD CONSTRAINT num_sala_capacitacion CHECK (
    check_numero_salas (
      num_piso,
      id_edificio
    )
  );

ALTER TABLE asistencia
ADD CONSTRAINT check_asistencia_acceso CHECK (
  check_asistencia_acceso_function(
    id_empleado,
    num_piso,
    id_edificio
  )
);
