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


SELECT est.num_estacion, est.sistema_operativo, acc.tipo
FROM estacion est
	INNER JOIN accesorio acc ON(
    est.num_estacion = acc.num_estacion AND
    est.num_sala  = acc.num_sala AND
    est.num_piso = acc.num_piso  AND
    est.id_edificio = acc.id_edificio)
WHERE est.sistema_operativo = 'Linux' AND
  acc.tipo SIMILAR TO '%[Mm](OUSE|ouse)%';
