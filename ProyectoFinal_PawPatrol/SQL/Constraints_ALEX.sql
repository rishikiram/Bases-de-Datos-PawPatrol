-- ELIMINAR DROP ANTES DE ENTREGAR
ALTER TABLE evaluar DROP CONSTRAINT evaluar_check_faltas;
ALTER TABLE evaluar
ADD CONSTRAINT evaluar_check_faltas CHECK (
    evaluar_check_faltas_function(
      calificacion,
      id_empleado,
      id_curso,
      id_programa_curso,
      id_cliente
    )
  );

-- ELIMINAR DROP ANTES DE ENTREGAR
ALTER TABLE laborar_operaciones DROP CONSTRAINT laborar_operaciones_check_aprobacion;
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

-- ELIMINAR DROP ANTES DE ENTREGAR
ALTER TABLE fecha_reservacion_operaciones DROP CONSTRAINT fecha_reservacion_operaciones_check_no_overlap;
ALTER TABLE fecha_reservacion_operaciones
ADD CONSTRAINT fecha_reservacion_operaciones_check_no_overlap CHECK (
    fecha_reservacion_operaciones_check_no_overlap_function(
      num_sala,
      num_piso,
      id_edificio,
      fecha
    )
  );