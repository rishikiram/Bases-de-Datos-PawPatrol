CREATE DOMAIN telephone AS text CHECK(VALUE ~ '^(\+\d{1,2}\s?)?1?\-?\.?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$'); -- https://stackoverflow.com/a/56450924/15217078
CREATE DOMAIN email AS text
  CHECK (value ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$' ); -- https://dba.stackexchange.com/a/165923
CREATE TYPE entrada_salida AS ENUM ('entrada', 'salida');
CREATE TYPE sistema_operativo AS ENUM ('Linux', 'Windows');

CREATE TABLE empleado(
    id_empleado int,
    nombre varchar(100),
    apellido_paterno varchar(100),
    apellido_materno varchar(100),
    calle varchar(100),
    cp int,
    num_exterior int,
    fecha_nacimiento date,
    curp varchar(100),
    correo_electronico email,
    telefono telephone,
    fotografia_archivo varchar(100)
);

CREATE TABLE agente(
    id_curso int,
    id_programa_curso int,
    id_cliente int,
    id_edificio int,
    num_piso int,
    pasar_piso boolean
) INHERITS (empleado);

CREATE TABLE entrenador(
    num_piso int,
    id_edificio int,
    fecha_ingresado date,
    numero_seguridad_social int
) INHERITS (empleado);

CREATE TABLE edificio(
    id_edificio int,
    calle varchar(100),
    cp int,
    numero_exterior int
);

CREATE TABLE piso(
    num_piso int,
    id_edificio int
);

CREATE TABLE faltar(
    id_empleado int,
    id_curso int,
    id_programa_curso int,
    id_cliente int,
    fecha date
);

CREATE TABLE evaluar(
    id_empleado int,
    id_curso int,
    id_programa_curso int,
    id_cliente int,
    calificacion int
);

CREATE TABLE programa_curso(
    id_programa_curso int,
    id_cliente int,
    nombre varchar(100),
    temario varchar(1000)
);

CREATE TABLE curso(
    id_curso int,
    id_programa_curso int,
    id_cliente int,
    modalidad varchar(100)
);

CREATE TABLE horario_curso(
    id_curso int,
    id_programa_curso int,
    id_cliente int,
    rango tsrange
);

CREATE TABLE impartir(
    id_empleado int,
    id_curso int,
    id_programa_curso int,
    id_cliente int
);

CREATE TABLE sala(
    num_sala int,
    num_piso int,
    id_edificio int,
    costo int
);

CREATE TABLE sala_operacion() INHERITS (sala);

CREATE TABLE sala_capacitacion() INHERITS (sala);


CREATE TABLE asistencia(
    id_empleado int,
    id_edificio int,
    num_piso int
);

CREATE TABLE registro_asistencia(
    id_empleado int,
    num_piso int,
    id_edificio int,
    fecha date,
    hora time, --Preguntar si está bien definido
    tipo entrada_salida NOT NULL
);

CREATE TABLE asignar(
    num_sala int,
    num_piso int,
    id_edificio int,
    id_curso int,
    id_programa_curso int,
    id_cliente int,
    horario_reserva tsrange
);

CREATE TABLE estacion(
    num_estacion int,
    num_sala int,
    num_piso int,
    id_edificio int,
    sistema_operativo sistema_operativo NOT NULL
);

CREATE TABLE accesorio(
    id_accesorio int,
    num_estacion int,
    num_sala int,
    num_piso int,
    id_edificio int,
    tipo varchar(100) --Revisar si el dato está bien definido
);

CREATE TABLE cliente(
    id_cliente int,
    razon_social varchar(100),
    rfc varchar(100),
    telefono telephone,
    persona_contacto varchar(100),
    correo_contacto email
);

CREATE TABLE reservacion_operaciones(
    id_reservacion_operaciones int,
    num_sala int, -- Sala de operaciones
    num_piso int,
    id_edificio int,
    sistema_operativo sistema_operativo NOT NULL
);

CREATE TABLE fecha_reservacion_operaciones(
    id_reservacion_operaciones int,
    num_sala int,
    num_piso int,
    id_edificio int,
    fecha date
);

CREATE TABLE laborar_operaciones(
    id_reservacion_operaciones int,
    num_sala int,
    num_piso int,
    id_edificio int,
    id_empleado int
);

CREATE TABLE requerir(
    id_reservacion_operaciones int,
    num_sala int,
    num_piso int,
    id_edificio int,
    id_programa_curso int,
    id_cliente int
);

-- CREACION DE RESTRICCIONES PARA TABLAS
-- Llaves primarias
ALTER TABLE empleado
ADD CONSTRAINT pk_empleado
PRIMARY KEY (id_empleado);

ALTER TABLE agente
ADD CONSTRAINT pk_agente
PRIMARY KEY (id_empleado);

ALTER TABLE entrenador
ADD CONSTRAINT pk_entrenador
PRIMARY KEY (id_empleado);

ALTER TABLE edificio
ADD CONSTRAINT pk_edificio
PRIMARY KEY (id_edificio);

ALTER TABLE piso
ADD CONSTRAINT pk_piso
PRIMARY KEY (num_piso, id_edificio);

ALTER TABLE programa_curso
ADD CONSTRAINT pk_programa_curso
PRIMARY KEY (id_programa_curso, id_cliente);

ALTER TABLE curso
ADD CONSTRAINT pk_curso
PRIMARY KEY (id_curso, id_programa_curso, id_cliente);

ALTER TABLE horario_curso
ADD CONSTRAINT pk_horario_curso
PRIMARY KEY (id_curso, id_programa_curso, id_cliente, rango);

ALTER TABLE estacion
ADD CONSTRAINT pk_estacion
PRIMARY KEY (num_estacion, num_sala, num_piso, id_edificio);

ALTER TABLE accesorio
ADD CONSTRAINT pk_accesorio
PRIMARY KEY (id_accesorio);

ALTER TABLE sala
ADD CONSTRAINT pk_sala
PRIMARY KEY (num_sala, num_piso, id_edificio);

ALTER TABLE sala_operacion
ADD CONSTRAINT pk_sala_operacion
PRIMARY KEY (num_sala, num_piso, id_edificio);

ALTER TABLE sala_capacitacion
ADD CONSTRAINT pk_sala_capacitacion
PRIMARY KEY (num_sala, num_piso, id_edificio);

ALTER TABLE cliente
ADD CONSTRAINT pk_cliente
PRIMARY KEY (id_cliente);

ALTER TABLE reservacion_operaciones
ADD CONSTRAINT pk_reservacion_operaciones
PRIMARY KEY (id_reservacion_operaciones, num_sala, num_piso, id_edificio);

ALTER TABLE fecha_reservacion_operaciones
ADD CONSTRAINT pk_fecha_reservacion_operaciones
PRIMARY KEY (id_reservacion_operaciones, num_sala, num_piso, id_edificio, fecha);


-- Llaves foraneas

ALTER TABLE piso
ADD CONSTRAINT fk_piso
FOREIGN KEY (id_edificio)
REFERENCES edificio(id_edificio);

ALTER TABLE entrenador
ADD CONSTRAINT fk_entrenador_num_piso
FOREIGN KEY (num_piso, id_edificio)
REFERENCES piso(num_piso, id_edificio);

-- ALTER TABLE entrenador
-- ADD CONSTRAINT fk_entrenador_id_edificio
-- FOREIGN KEY (id_edificio)
-- REFERENCES edificio(id_edificio);

ALTER TABLE agente
ADD CONSTRAINT fk_agente_curso
FOREIGN KEY (id_curso, id_programa_curso, id_cliente)
REFERENCES curso(id_curso, id_programa_curso, id_cliente);

ALTER TABLE agente
ADD CONSTRAINT fk_agente_id_edificio
FOREIGN KEY (num_piso, id_edificio)
REFERENCES piso(num_piso,id_edificio);

-- ALTER TABLE agente
-- ADD CONSTRAINT fk_agente_num_piso
-- FOREIGN KEY (id_edificio)
-- REFERENCES edificio(id_edificio);

ALTER TABLE faltar
ADD CONSTRAINT fk_faltar_id_empleado
FOREIGN KEY (id_empleado)
REFERENCES empleado(id_empleado);

ALTER TABLE faltar
ADD CONSTRAINT fk_faltar_curso
FOREIGN KEY (id_curso, id_programa_curso, id_cliente)
REFERENCES curso(id_curso, id_programa_curso, id_cliente);

ALTER TABLE evaluar
ADD CONSTRAINT fk_evaluar_id_empleado
FOREIGN KEY (id_empleado)
REFERENCES agente(id_empleado);

ALTER TABLE evaluar
ADD CONSTRAINT fk_evaluar_curso
FOREIGN KEY (id_curso, id_programa_curso, id_cliente)
REFERENCES curso(id_curso, id_programa_curso, id_cliente);

ALTER TABLE programa_curso
ADD CONSTRAINT fk_programa_curso_id_cliente
FOREIGN KEY (id_cliente)
REFERENCES cliente(id_cliente);

ALTER TABLE curso
ADD CONSTRAINT fk_curso_pk_programa_curso
FOREIGN KEY (id_cliente, id_programa_curso)
REFERENCES programa_curso(id_cliente, id_programa_curso);

ALTER TABLE horario_curso
ADD CONSTRAINT fk_horario_curso_curso
FOREIGN KEY (id_curso, id_programa_curso, id_cliente)
REFERENCES curso(id_curso, id_programa_curso, id_cliente);

ALTER TABLE impartir
ADD CONSTRAINT fk_impartir_curso
FOREIGN KEY (id_curso, id_programa_curso, id_cliente)
REFERENCES curso(id_curso, id_programa_curso, id_cliente);

ALTER TABLE impartir
ADD CONSTRAINT fk_impartir_id_empleado
FOREIGN KEY (id_empleado)
REFERENCES empleado(id_empleado);

ALTER TABLE asistencia
ADD CONSTRAINT fk_asistencia_id_empleado
FOREIGN KEY (id_empleado)
REFERENCES empleado(id_empleado);

-- ALTER TABLE asistencia
-- ADD CONSTRAINT fk_asistencia_id_edificio
-- FOREIGN KEY (id_edificio)
-- REFERENCES edificio(id_edificio);

ALTER TABLE asistencia
ADD CONSTRAINT fk_asistencia_num_piso
FOREIGN KEY (num_piso, id_edificio)
REFERENCES piso(num_piso, id_edificio);

ALTER TABLE registro_asistencia
ADD CONSTRAINT fk_registro_asistencia_id_empleado
FOREIGN KEY (id_empleado)
REFERENCES empleado(id_empleado);

ALTER TABLE registro_asistencia
ADD CONSTRAINT fk_registro_asistencia_num_piso
FOREIGN KEY (num_piso, id_edificio)
REFERENCES piso(num_piso, id_edificio);

-- ALTER TABLE registro_asistencia
-- ADD CONSTRAINT fk_registro_asistencia_id_edificio
-- FOREIGN KEY (id_edificio)
-- REFERENCES edificio(id_edificio);

ALTER TABLE estacion
ADD CONSTRAINT fk_estacion_num_sala
FOREIGN KEY (num_sala, num_piso, id_edificio)
REFERENCES sala(num_sala, num_piso, id_edificio);

-- ALTER TABLE estacion
-- ADD CONSTRAINT fk_estacion_num_piso
-- FOREIGN KEY (num_piso)
-- REFERENCES piso(num_piso);
--
-- ALTER TABLE estacion
-- ADD CONSTRAINT fk_estacion_id_edificio
-- FOREIGN KEY (id_edificio)
-- REFERENCES edificio(id_edificio);

ALTER TABLE sala
ADD CONSTRAINT fk_sala_num_piso
FOREIGN KEY (num_piso, id_edificio)
REFERENCES piso(num_piso, id_edificio);

-- ALTER TABLE sala
-- ADD CONSTRAINT fk_sala_id_edificio
-- FOREIGN KEY (id_edificio)
-- REFERENCES edificio(id_edificio);

ALTER TABLE accesorio
ADD CONSTRAINT fk_accesorio_num_estacion
FOREIGN KEY (num_estacion, num_sala, num_piso, id_edificio)
REFERENCES estacion(num_estacion, num_sala, num_piso, id_edificio);

-- ALTER TABLE accesorio
-- ADD CONSTRAINT fk_accesorio_num_sala
-- FOREIGN KEY (num_sala)
-- REFERENCES sala(num_sala);
--
-- ALTER TABLE accesorio
-- ADD CONSTRAINT fk_accesorio_id_edificio
-- FOREIGN KEY (id_edificio)
-- REFERENCES edificio(id_edificio);
--
-- ALTER TABLE accesorio
-- ADD CONSTRAINT fk_accesorio_num_piso
-- FOREIGN KEY (num_piso)
-- REFERENCES piso(num_piso);

ALTER TABLE asignar
ADD CONSTRAINT fk_asignar_fk_sala_capacitacion
FOREIGN KEY (num_sala, num_piso, id_edificio)
REFERENCES sala_capacitacion(num_sala, num_piso, id_edificio);

ALTER TABLE asignar
ADD CONSTRAINT fk_asignar_curso
FOREIGN KEY (id_curso, id_programa_curso, id_cliente)
REFERENCES curso(id_curso, id_programa_curso, id_cliente);

ALTER TABLE reservacion_operaciones
ADD CONSTRAINT fk_reservacion_operaciones_pk_sala_operacion
FOREIGN KEY (num_sala, num_piso, id_edificio)
REFERENCES sala_operacion(num_sala, num_piso, id_edificio);

ALTER TABLE fecha_reservacion_operaciones
ADD CONSTRAINT fk_fecha_reservacion_operaciones_pk_reservacion_operaciones
FOREIGN KEY (id_reservacion_operaciones, num_sala, num_piso, id_edificio)
REFERENCES reservacion_operaciones(id_reservacion_operaciones, num_sala, num_piso, id_edificio);

ALTER TABLE laborar_operaciones
ADD CONSTRAINT fk_laborar_operaciones_pk_reservacion_operaciones
FOREIGN KEY (id_reservacion_operaciones, num_sala, num_piso, id_edificio)
REFERENCES reservacion_operaciones(id_reservacion_operaciones, num_sala, num_piso, id_edificio);

ALTER TABLE laborar_operaciones
ADD CONSTRAINT fk_laborar_operaciones_id_empleado -- id de agente
FOREIGN KEY (id_empleado)
REFERENCES agente(id_empleado);

ALTER TABLE requerir
ADD CONSTRAINT fk_requerir_pk_reservacion_operaciones
FOREIGN KEY (id_reservacion_operaciones, num_sala, num_piso, id_edificio)
REFERENCES reservacion_operaciones(id_reservacion_operaciones, num_sala, num_piso, id_edificio);

ALTER TABLE requerir
ADD CONSTRAINT fk_requerir_pk_programa_curso
FOREIGN KEY (id_programa_curso, id_cliente)
REFERENCES programa_curso(id_programa_curso, id_cliente);
