-- CREACION DE TABLAS

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
-- ALTER TABLE curso
-- ADD CONSTRAINT fk_curso
-- FOREIGN KEY (id_cliente)
-- REFERENCES cliente(id_cliente);

ALTER TABLE impartir
ADD CONSTRAINT fk_impartir_id_curso
FOREIGN KEY (id_curso)
REFERENCES curso(id_curso);

ALTER TABLE impartir
ADD CONSTRAINT fk_impartir_id_empleado
FOREIGN KEY (id_empleado)
REFERENCES empleado(id_empleado);
-- Restricciones CHECK

ALTER TABLE piso
ADD CONSTRAINT check_num_piso
CHECK num_piso <= 8;