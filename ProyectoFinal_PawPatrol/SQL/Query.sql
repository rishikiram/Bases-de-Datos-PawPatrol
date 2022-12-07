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

--Todos los estaciones con sistema operativo 'Linux' y con un mouse
SELECT est.num_estacion, est.num_sala, est.num_piso, est.id_edificio, est.sistema_operativo, acc.tipo
FROM estacion est
	INNER JOIN accesorio acc ON(
    est.num_estacion = acc.num_estacion AND
    est.num_sala  = acc.num_sala AND
    est.num_piso = acc.num_piso  AND
    est.id_edificio = acc.id_edificio)
WHERE est.sistema_operativo = 'Linux' AND
  acc.tipo SIMILAR TO '%[Mm](OUSE|ouse)%';

--todos los dias trabajado en operaciones de empleado numero 13 en 2022
SELECT emp.id_empleado, fro.fecha
FROM empleado emp INNER JOIN laborar_operaciones lo ON 
emp.id_empleado = lo.id_empleado
INNER JOIN fecha_reservacion_operaciones fro ON 
fro.id_reservacion_operaciones = lo.id_reservacion_operaciones
WHERE emp.id_empleado = 13 and fro.fecha BETWEEN '2022-01-01' AND '2022-12-31';
