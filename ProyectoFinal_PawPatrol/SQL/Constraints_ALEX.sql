-- ELIMINAR DROP ANTES DE ENTREGAR
ALTER TABLE evaluar DROP CONSTRAINT calificacion_check_faltas;
ALTER TABLE evaluar
ADD CONSTRAINT calificacion_check_faltas CHECK (
    calificacion_check_faltas_function(
      calificacion,
      id_empleado,
      id_curso,
      id_programa_curso,
      id_cliente
    )
  );