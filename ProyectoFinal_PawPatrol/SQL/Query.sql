-- Consulta 1:
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

-- Consulta 2:
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

-- Consulta 3: Empleados que han faltado entre el 21 de septiembre y el 6 de noviembre de 2022
SELECT DISTINCT faltar.id_empleado, empleado.nombre, faltar.fecha
FROM faltar
	INNER JOIN empleado ON(
	faltar.id_empleado = empleado.id_empleado)
WHERE fecha BETWEEN '2022-09-21' AND '2022-11-06';

-- Consulta 3: Todas los estaciones con sistema operativo 'Linux' y con un mouse
SELECT est.num_estacion, est.num_sala, est.num_piso, est.id_edificio, est.sistema_operativo, acc.tipo
FROM estacion est
	INNER JOIN accesorio acc ON(
    est.num_estacion = acc.num_estacion AND
    est.num_sala  = acc.num_sala AND
    est.num_piso = acc.num_piso  AND
    est.id_edificio = acc.id_edificio)
WHERE est.sistema_operativo = 'Linux' AND
  acc.tipo SIMILAR TO '%[Mm](OUSE|ouse)%';

-- Consulta 4: Todos los dias que trabajo en operaciones el empleado numero 13 en 2022 y el costo por dia
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

-- Consulta 5: Nombre completo de los agentes que sacaron la calificación de 10 en algun curso presencial 
SELECT evaluar.calificacion, agente.nombre , agente.apellido_paterno , 
	agente.apellido_materno, curso.modalidad
FROM evaluar INNER JOIN agente ON agente.id_empleado = evaluar.id_empleado 
	INNER JOIN curso ON curso.id_curso = agente.id_curso 
WHERE evaluar.calificacion = '10' and curso.modalidad = 'presencial';

-- Consulta 6: Nombre y telefono de los empleados que faltaron en el 2022 en el curso "MOVIES" 
SELECT agente.nombre, agente.telefono
FROM agente INNER JOIN faltar ON faltar.id_empleado = agente.id_empleado 
	INNER JOIN curso ON curso.id_curso = faltar.id_curso 
	INNER JOIN programa_curso ON programa_curso.id_programa_curso = curso.id_programa_curso
WHERE faltar.fecha BETWEEN '2022-01-01' AND '2022-12-31' and programa_curso.nombre = 'Jewelry';


-- Consulta 7: Las 5 salas de capacitación más caras  y las 5 salas de capacitación más baratas así como lo que cuestan en términos del costo promedio de todas las salas de capacitación
WITH precio_promedio AS(
    SELECT AVG(costo) AS costo_promedio
    FROM sala_capacitacion
),
costos_sobre_promedio AS(
    SELECT num_sala,
        num_piso,
        id_edificio,
        costo,
        costo / costo_promedio AS porcentaje_de_costo_promedio
    FROM sala_capacitacion
        CROSS JOIN precio_promedio    
)
(
    SELECT *
    FROM costos_sobre_promedio
    ORDER BY costo DESC
    LIMIT 5
)
UNION
(
    SELECT *
    FROM costos_sobre_promedio
    ORDER BY costo ASC
    LIMIT 5
)
ORDER BY costo DESC;

-- Consulta 8: Tiempo promedio por semana de los 5 cursos con más horas de trabajo por semana
WITH bloques_horario AS (
    SELECT id_curso,
        id_programa_curso,
        id_cliente,
        LOWER(rango) AS ts_inicio,
        UPPER(rango) AS ts_fin
    FROM horario_curso
),
horarios_semanales AS(
    SELECT id_curso,
        id_programa_curso,
        id_cliente,
        COALESCE(SUM(ts_fin - ts_inicio), '00:00:00'::INTERVAL) AS duracion_semana
    FROM bloques_horario
    GROUP BY id_curso,
        id_programa_curso,
        id_cliente,
        -- Como no hay reservas en domingo, ts_inicio y ts_fin están en la misma semana para cada bloque
        EXTRACT(
            week
            FROM ts_inicio::date
        ),
        EXTRACT(
            year
            FROM ts_inicio::date
        )
)
SELECT id_curso,
    id_programa_curso,
    id_cliente,
    AVG(duracion_semana) AS duracion_semanal_promedio
FROM horarios_semanales
GROUP BY id_curso,
    id_programa_curso,
    id_cliente
ORDER BY duracion_semanal_promedio DESC
LIMIT 5;

-- Consulta 9: Edad promedio de los entrenadores y de los agentes registrados al 7 de diciembre de 2022
WITH edad_promedio_agentes AS (
    SELECT AVG(age('2022-12-07'::date, fecha_nacimiento)) AS edad_promedio_agentes
    FROM agente
),
edad_promedio_entrenadores AS (
    SELECT AVG(age('2022-12-07'::date, fecha_nacimiento)) AS edad_promedio_entrenador
    FROM entrenador
)
SELECT *
FROM edad_promedio_agentes
    CROSS JOIN edad_promedio_entrenadores;