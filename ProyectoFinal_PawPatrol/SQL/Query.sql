SELECT a.id_empleado,
    a.nombre,
    a.id_edificio,
    s.num_piso
FROM sala_capacitacion s
    INNER JOIN agente a ON (
        a.num_piso = s.num_piso
        AND a.id_edificio = s.id_edificio
    )
WHERE s.num_piso = 5
    AND a.num_piso = 5;


SELECT a.id_empleado,
    a.nombre,
    a.id_edificio,
    s.num_piso
FROM sala_capacitacion s
    INNER JOIN entrenador a ON (
        a.num_piso = s.num_piso
        AND a.id_edificio = s.id_edificio
    )
WHERE s.num_piso = 5
    AND a.num_piso = 5;


SELECT DISTINCT faltar.id_empleado, empleado.nombre, faltar.fecha
FROM faltar
	INNER JOIN empleado ON(
	faltar.id_empleado = empleado.id_empleado)
WHERE fecha BETWEEN '2022-09-21' AND '2022-11-06';

--Todas los estaciones con sistema operativo 'Linux' y con un mouse
SELECT est.num_estacion, est.num_sala, est.num_piso, est.id_edificio, est.sistema_operativo, acc.tipo
FROM estacion est
	INNER JOIN accesorio acc ON(
    est.num_estacion = acc.num_estacion AND
    est.num_sala  = acc.num_sala AND
    est.num_piso = acc.num_piso  AND
    est.id_edificio = acc.id_edificio)
WHERE est.sistema_operativo = 'Linux' AND
  acc.tipo SIMILAR TO '%[Mm](OUSE|ouse)%';

-- Todos los dias que trabajo en operaciones el empleado numero 13 en 2022 y el costo por dia
SELECT emp.id_empleado, fro.fecha, sala.costo
FROM empleado emp INNER JOIN laborar_operaciones lo ON
emp.id_empleado = lo.id_empleado
INNER JOIN fecha_reservacion_operaciones fro ON
fro.id_reservacion_operaciones = lo.id_reservacion_operaciones
INNER JOIN sala ON(
    sala.num_sala  = lo.num_sala AND
    sala.num_piso = lo.num_piso  AND
    sala.id_edificio = lo.id_edificio)
WHERE emp.id_empleado = 13 and fro.fecha BETWEEN '2022-01-01' AND '2022-12-31';

-- Nombre completo de los agentes que sacaron la calificación de 10 en algun curso presencial 
SELECT evaluar.calificacion, agente.nombre , agente.apellido_paterno , 
	agente.apellido_materno, curso.modalidad
FROM evaluar INNER JOIN agente ON agente.id_empleado = evaluar.id_empleado 
	INNER JOIN curso ON curso.id_curso = agente.id_curso 
WHERE evaluar.calificacion = '10' and curso.modalidad = 'presencial';

-- Nombre y telefono de los empleados que faltaron en el 2022 en el curso "MOVIES" 
SELECT agente.nombre, agente.telefono
FROM agente INNER JOIN faltar ON faltar.id_empleado = agente.id_empleado 
	INNER JOIN curso ON curso.id_curso = faltar.id_curso 
	INNER JOIN programa_curso ON programa_curso.id_programa_curso = curso.id_programa_curso
WHERE faltar.fecha BETWEEN '2022-01-01' AND '2022-12-31' and programa_curso.nombre = 'Jewelry';
