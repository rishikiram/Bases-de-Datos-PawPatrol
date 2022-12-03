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
    correo_electronico varchar(100),
    telefono int, 
    fotografia_archivo varchar(100)
);

CREATE TABLE agente(
    id_curso int,
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
    fecha date
);

CREATE TABLE evaluar(
    id_empleado int,
    id_curso int,
    calificacion int
);

CREATE TABLE curso(
    id_curso int,
    id_cliente int,
    nombre_curso varchar(100),
    modalidad varchar(100)
);

CREATE TABLE horario_curso(
    id_curso int,
    rango tsrange
);

CREATE TABLE impartir(
    id_empleado int,
    id_curso int
);

CREATE TABLE sala(
    num_sala int,
    num_piso int,
    id_edificio int,
    costo int
);

CREATE TABLE sala_operaciones(
    num_sala int,
    costo int
) INHERITS (sala);

CREATE TABLE sala_capacitacion(
    num_sala int,
    costo int
) INHERITS (sala);


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
    tipo varchar(100) --Preguntar el tipo de dato de tipo jsjs
);

CREATE TABLE reservar(
    num_sala int,
    id_cliente int,
    horario_reserva time --Revisar si el dato está bien definido
);

CREATE TABLE asignar(
    num_sala int,
    id_curso int,
    horario_reserva time --Revisar si el dato está bien definido
);

CREATE TABLE estacion(
    num_estacion int,
    num_sala int,
    num_piso int, 
    id_edificio int,
    sistema_operativo varchar(100)
);

CREATE TABLE accesorio(
    id_accesorio int,
    num_estacion int,
    num_sala int,
    id_edificio int,
    num_piso int,
    tipo varchar(100) --Revisar si el dato está bien definido
);

CREATE TABLE cliente(
    id_cliente int,
    razon_social varchar(100),
    rfc varchar(100),
    telefono varchar(100), --Revisar porque segun yo el int no daría para escribir un numero telefonico
    persona_contacto varchar(100),
    correo_contacto varchar(100)
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
PRIMARY KEY (num_piso);

ALTER TABLE curso
ADD CONSTRAINT pk_curso
PRIMARY KEY (id_curso);

ALTER TABLE horario_curso
ADD CONSTRAINT pk_horario_curso
PRIMARY KEY (id_curso, rango);

ALTER TABLE estacion
ADD CONSTRAINT pk_estacion
PRIMARY KEY (num_estacion);

ALTER TABLE accesorio
ADD CONSTRAINT pk_accesorio
PRIMARY KEY (id_accesorio);

ALTER TABLE sala
ADD CONSTRAINT pk_sala
PRIMARY KEY (num_sala);

ALTER TABLE sala_operaciones
ADD CONSTRAINT pk_sala_operaciones
PRIMARY KEY (num_sala);

ALTER TABLE sala_capacitacion
ADD CONSTRAINT pk_sala_capacitacion
PRIMARY KEY (num_sala);

ALTER TABLE cliente
ADD CONSTRAINT pk_cliente
PRIMARY KEY (id_cliente);


-- Llaves foraneas

ALTER TABLE piso
ADD CONSTRAINT fk_piso
FOREIGN KEY (id_edificio)
REFERENCES edificio(id_edificio);

ALTER TABLE entrenador
ADD CONSTRAINT fk_entrenador_num_piso
FOREIGN KEY (num_piso)
REFERENCES piso(num_piso);

ALTER TABLE entrenador
ADD CONSTRAINT fk_entrenador_id_edificio
FOREIGN KEY (id_edificio)
REFERENCES edificio(id_edificio);

ALTER TABLE agente
ADD CONSTRAINT fk_agente_id_curso
FOREIGN KEY (id_curso)
REFERENCES curso(id_curso);

ALTER TABLE agente
ADD CONSTRAINT fk_agente_id_edificio
FOREIGN KEY (id_edificio)
REFERENCES edificio(id_edificio);

ALTER TABLE agente
ADD CONSTRAINT fk_agente_num_piso
FOREIGN KEY (num_piso)
REFERENCES piso(num_piso);

ALTER TABLE faltar
ADD CONSTRAINT fk_faltar_id_empleado
FOREIGN KEY (id_empleado)
REFERENCES empleado(id_empleado);

ALTER TABLE faltar
ADD CONSTRAINT fk_faltar_id_curso
FOREIGN KEY (id_curso)
REFERENCES curso(id_curso);

-- *Descomentar cuando este la tabla cliente
ALTER TABLE curso
ADD CONSTRAINT fk_curso
FOREIGN KEY (id_cliente)
REFERENCES cliente(id_cliente);

ALTER TABLE impartir
ADD CONSTRAINT fk_impartir_id_curso
FOREIGN KEY (id_curso)
REFERENCES curso(id_curso);

ALTER TABLE impartir
ADD CONSTRAINT fk_impartir_id_empleado
FOREIGN KEY (id_empleado)
REFERENCES empleado(id_empleado);

ALTER TABLE asistencia
ADD CONSTRAINT fk_asistencia_id_empleado
FOREIGN KEY (id_empleado)
REFERENCES empleado(id_empleado);

ALTER TABLE asistencia
ADD CONSTRAINT fk_asistencia_id_edificio
FOREIGN KEY (id_edificio)
REFERENCES edificio(id_edificio);

ALTER TABLE asistencia
ADD CONSTRAINT fk_asistencia_num_piso
FOREIGN KEY (num_piso)
REFERENCES piso(num_piso);

ALTER TABLE registro_asistencia
ADD CONSTRAINT fk_registro_asistencia_id_empleado
FOREIGN KEY (id_empleado)
REFERENCES empleado(id_empleado);

ALTER TABLE registro_asistencia
ADD CONSTRAINT fk_registro_asistencia_num_piso
FOREIGN KEY (num_piso)
REFERENCES piso(num_piso);

ALTER TABLE registro_asistencia
ADD CONSTRAINT fk_registro_asistencia_id_edificio
FOREIGN KEY (id_edificio)
REFERENCES edificio(id_edificio);

ALTER TABLE estacion
ADD CONSTRAINT fk_estacion_num_sala
FOREIGN KEY (num_sala)
REFERENCES sala(num_sala);

ALTER TABLE estacion
ADD CONSTRAINT fk_estacion_num_piso
FOREIGN KEY (num_piso)
REFERENCES piso(num_piso);

ALTER TABLE estacion
ADD CONSTRAINT fk_estacion_id_edificio
FOREIGN KEY (id_edificio)
REFERENCES edificio(id_edificio);

ALTER TABLE sala
ADD CONSTRAINT fk_sala_num_piso
FOREIGN KEY (num_piso)
REFERENCES piso(num_piso);

ALTER TABLE sala
ADD CONSTRAINT fk_sala_id_edificio
FOREIGN KEY (id_edificio)
REFERENCES edificio(id_edificio);

ALTER TABLE accesorio
ADD CONSTRAINT fk_accesorio_num_estacion
FOREIGN KEY (num_estacion)
REFERENCES estacion(num_estacion);

ALTER TABLE accesorio
ADD CONSTRAINT fk_accesorio_num_sala
FOREIGN KEY (num_sala)
REFERENCES sala(num_sala);

ALTER TABLE accesorio
ADD CONSTRAINT fk_accesorio_id_edificio
FOREIGN KEY (id_edificio)
REFERENCES edificio(id_edificio);

ALTER TABLE accesorio
ADD CONSTRAINT fk_accesorio_num_piso
FOREIGN KEY (num_piso)
REFERENCES piso(num_piso);

ALTER TABLE reservar
ADD CONSTRAINT fk_reservar_num_sala
FOREIGN KEY (num_sala)
REFERENCES sala(num_sala);

ALTER TABLE reservar
ADD CONSTRAINT fk_reservar_id_cliente
FOREIGN KEY (id_cliente)
REFERENCES cliente(id_cliente);

ALTER TABLE asignar
ADD CONSTRAINT fk_asignar_num_sala
FOREIGN KEY (num_sala)
REFERENCES sala(num_sala);

ALTER TABLE asignar
ADD CONSTRAINT fk_asignar_id_curso
FOREIGN KEY (id_curso)
REFERENCES curso(id_curso);

-- Restricciones CHECK

ALTER TABLE piso
ADD CONSTRAINT check_num_piso
CHECK (num_piso <= 8);