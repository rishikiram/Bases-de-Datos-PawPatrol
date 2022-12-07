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
    AND a.num_piso = 5
	
	
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
    AND a.num_piso = 5
		

SELECT DISTINCT faltar.id_empleado, empleado.nombre, faltar.fecha
FROM faltar 
	INNER JOIN empleado ON(
	faltar.id_empleado = empleado.id_empleado)
WHERE fecha BETWEEN '2022-09-21' AND '2022-11-06'

	
	
	