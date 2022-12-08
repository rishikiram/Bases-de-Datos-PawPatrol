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
    fotografia_archivo varchar(100),
    num_piso int,
    id_edificio int
);

CREATE TABLE agente(
    id_curso int,
    id_programa_curso int,
    id_cliente int
) INHERITS (empleado);

CREATE TABLE entrenador(
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

ALTER TABLE asistencia
ADD CONSTRAINT pk_asistencia
PRIMARY KEY (id_empleado, id_edificio, num_piso);

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
ADD CONSTRAINT fk_entrenador_pk_piso
FOREIGN KEY (num_piso, id_edificio)
REFERENCES piso(num_piso, id_edificio);

ALTER TABLE agente
ADD CONSTRAINT fk_agente_curso
FOREIGN KEY (id_curso, id_programa_curso, id_cliente)
REFERENCES curso(id_curso, id_programa_curso, id_cliente);

ALTER TABLE agente
ADD CONSTRAINT fk_agente_pk_edificio
FOREIGN KEY (num_piso, id_edificio)
REFERENCES piso(num_piso,id_edificio);

ALTER TABLE faltar
ADD CONSTRAINT fk_faltar_id_empleado
FOREIGN KEY (id_empleado)
REFERENCES agente(id_empleado);

ALTER TABLE faltar
ADD CONSTRAINT fk_faltar_pk_curso
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
REFERENCES entrenador(id_empleado);

-- ESTO NO SIRVE, VER CONSTRAINT check_fk_asistencia_pk_empleado EN Constraints.sql
-- https://stackoverflow.com/a/44422806/15217078
-- ALTER TABLE asistencia
-- ADD CONSTRAINT fk_asistencia_id_empleado
-- FOREIGN KEY (id_empleado)
-- REFERENCES empleado(id_empleado);

ALTER TABLE asistencia
ADD CONSTRAINT fk_asistencia_pk_piso
FOREIGN KEY (num_piso, id_edificio)
REFERENCES piso(num_piso, id_edificio);

ALTER TABLE registro_asistencia
ADD CONSTRAINT fk_registro_asistencia
FOREIGN KEY (id_empleado, num_piso, id_edificio)
REFERENCES asistencia(id_empleado, num_piso, id_edificio);

ALTER TABLE registro_asistencia
ADD CONSTRAINT fk_registro_asistencia_pk_piso
FOREIGN KEY (num_piso, id_edificio)
REFERENCES piso(num_piso, id_edificio);

-- ESTO NO SIRVE, VER CONSTRAINT check_fk_estacion_pk_sala EN Constraints.sql
-- https://stackoverflow.com/a/44422806/15217078
-- ALTER TABLE estacion
-- ADD CONSTRAINT fk_estacion_pk_sala
-- FOREIGN KEY (num_sala, num_piso, id_edificio)
-- REFERENCES sala(num_sala, num_piso, id_edificio);

ALTER TABLE sala
ADD CONSTRAINT fk_sala_pk_piso
FOREIGN KEY (num_piso, id_edificio)
REFERENCES piso(num_piso, id_edificio);

ALTER TABLE accesorio
ADD CONSTRAINT fk_accesorio_pk_estacion
FOREIGN KEY (num_estacion, num_sala, num_piso, id_edificio)
REFERENCES estacion(num_estacion, num_sala, num_piso, id_edificio);

ALTER TABLE asignar
ADD CONSTRAINT fk_asignar_pk_sala_capacitacion
FOREIGN KEY (num_sala, num_piso, id_edificio)
REFERENCES sala_capacitacion(num_sala, num_piso, id_edificio);

ALTER TABLE asignar
ADD CONSTRAINT fk_asignar_pk_curso
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

-- Comentarios
COMMENT ON TABLE empleado IS 'Tabla que representa a los trabajadores del centro de contacto ';
COMMENT ON COLUMN empleado.id_empleado IS 'ID del empleado del centro de contacto';
COMMENT ON COLUMN empleado.nombre IS 'Nombre que del empleado';
COMMENT ON COLUMN empleado.apellido_paterno IS 'Primer apellido del empleado';
COMMENT ON COLUMN empleado.apellido_materno IS 'Segundo apellido del empleado';
COMMENT ON COLUMN empleado.calle IS 'La calle de la direccion del empleado';
COMMENT ON COLUMN empleado.cp IS 'El codigo postal de la direccion del empleado';
COMMENT ON COLUMN empleado.num_exterior IS 'El numero exterior de la direccion del empleado';
COMMENT ON COLUMN empleado.fecha_nacimiento IS 'La fecha de nacimiento del empleado';
COMMENT ON COLUMN empleado.curp IS 'La Clave Única de Registro de Población del empleado';
COMMENT ON COLUMN empleado.correo_electronico IS 'La direccion del correo electronico del empleado';
COMMENT ON COLUMN empleado.telefono IS 'Teléfono del empleado';
COMMENT ON COLUMN empleado.fotografia_archivo IS 'Archivo que guardara la ruta del formato de la imagen';

COMMENT ON TABLE agente IS 'Tabla que representa los agentes telefonicos ';
COMMENT ON COLUMN agente.id_curso IS 'ID del curso que estan tomando los agentes';
COMMENT ON COLUMN agente.id_programa_curso IS 'ID del programa del curso que estan tomando los agentes';
COMMENT ON COLUMN agente.id_cliente IS 'ID del cliente al cual se le presta el servicio del programa';
COMMENT ON COLUMN agente.id_edificio IS 'ID del edificio que toma el curso';
COMMENT ON COLUMN agente.num_piso IS 'Numero de piso en el toma el curso';

COMMENT ON TABLE entrenador IS 'Tabla que representa los entrenadores acargo de los agentes';
COMMENT ON COLUMN entrenador.id_edificio IS 'ID del edificio que labora';
COMMENT ON COLUMN entrenador.num_piso IS 'Numero de piso en el que trabaja';
COMMENT ON COLUMN entrenador.fecha_ingresado IS 'Fecha de ingreso del entrenador';
COMMENT ON COLUMN entrenador.numero_seguridad_social IS 'Numero del seguro social del entrenador';

COMMENT ON TABLE edificio IS 'Tabla que representa un edificio del centro de control';
COMMENT ON COLUMN edificio.id_edificio IS 'ID del edificio';
COMMENT ON COLUMN edificio.calle IS 'La calle de la direccion del edificio';
COMMENT ON COLUMN edificio.cp IS 'El codigo postal de la direccion del edificio';
COMMENT ON COLUMN edificio.numero_exterior IS 'El numero exterior de la direccion del edificio';

COMMENT ON TABLE piso IS 'Tabla que representa un piso de un edificio del centro de control';
COMMENT ON COLUMN piso.num_piso IS 'Numero del piso';
COMMENT ON COLUMN piso.id_edificio IS 'ID del edificio donde se encuentra';

COMMENT ON TABLE faltar IS 'Tabla que representa la relacion de faltar a algun curso';
COMMENT ON COLUMN faltar.id_empleado IS 'ID del empleado que realizo la falta';
COMMENT ON COLUMN faltar.id_curso IS 'ID del curso al cual falto';
COMMENT ON COLUMN faltar.id_programa_curso IS 'ID del programa del curso al cual falto';
COMMENT ON COLUMN faltar.id_cliente IS 'ID del cliente del curso';
COMMENT ON COLUMN faltar.fecha IS 'Fecha en la que se realizo la falta';

COMMENT ON TABLE evaluar IS 'Tabla que representa la relacion de evaluar a un agente';
COMMENT ON COLUMN evaluar.id_empleado IS 'ID del empleado a evaluar';
COMMENT ON COLUMN evaluar.id_curso IS 'ID del curso al cual se le va a evaluar';
COMMENT ON COLUMN evaluar.id_programa_curso IS 'ID del programa del curso al cual se le va a evaluar';
COMMENT ON COLUMN evaluar.id_cliente IS 'ID del cliente del curso';
COMMENT ON COLUMN evaluar.calificacion IS 'Calificación recibida del curso';

COMMENT ON TABLE programa_curso IS 'Tabla que representa el programa que será visto en el curso';
COMMENT ON COLUMN programa_curso.id_programa_curso IS 'ID del programa del curso';
COMMENT ON COLUMN programa_curso.id_cliente IS 'ID del cliente que contrato el programa';
COMMENT ON COLUMN programa_curso.nombre IS 'Nombre del programa del curso';
COMMENT ON COLUMN programa_curso.temario IS 'Lista de temas del curso';

COMMENT ON TABLE curso IS 'Tabla que representa curso de capacitacion';
COMMENT ON COLUMN curso.id_curso IS 'ID del curso de capacitacion';
COMMENT ON COLUMN curso.id_programa_curso IS 'ID del programa del curso';
COMMENT ON COLUMN curso.id_cliente IS 'ID del cliente que contrato el curso';
COMMENT ON COLUMN curso.modalidad IS 'Si será llevado acabo en linea o presencial';

COMMENT ON TABLE horario_curso IS 'Tabla que representa el horario del curso de capacitacion';
COMMENT ON COLUMN horario_curso.id_curso IS 'ID del curso de capacitacion';
COMMENT ON COLUMN horario_curso.id_programa_curso IS 'ID del programa del curso';
COMMENT ON COLUMN horario_curso.id_cliente IS 'ID del cliente que contrato el curso';
COMMENT ON COLUMN horario_curso.rango IS 'Restriccion en el horario que será llevado cada curso';

COMMENT ON TABLE impartir IS 'Tabla que representa el entrenador que impartira el curso';
COMMENT ON COLUMN impartir.id_empleado IS 'ID del entrenador ';
COMMENT ON COLUMN impartir.id_curso IS 'ID del curso de capacitacion que será impartido';
COMMENT ON COLUMN impartir.id_programa_curso IS 'ID del programa del curso';
COMMENT ON COLUMN impartir.id_cliente IS 'ID del cliente que contrato el curso';


COMMENT ON TABLE sala IS 'Tabla que representa una sala de un piso del centro de control';
COMMENT ON COLUMN sala.num_sala IS 'Numero de sala';
COMMENT ON COLUMN sala.num_piso IS 'Numero del piso en el que encuentra';
COMMENT ON COLUMN sala.id_edificio IS 'ID del edificio donde se encuentra';
COMMENT ON COLUMN sala.costo IS 'Costo de la sala';

COMMENT ON TABLE sala_operacion IS 'Tabla que representa una sala de operaciones del centro de control';
COMMENT ON COLUMN sala_operacion.num_sala IS 'Numero de sala de operacion';
COMMENT ON COLUMN sala_operacion.num_piso IS 'Numero del piso en el que encuentra';
COMMENT ON COLUMN sala_operacion.id_edificio IS 'ID del edificio donde se encuentra';
COMMENT ON COLUMN sala_operacion.costo IS 'Costo de la sala';

COMMENT ON TABLE sala_capacitacion IS 'Tabla que representa una sala de capacitacion del centro de control';
COMMENT ON COLUMN sala_capacitacion.num_sala IS 'Numero de sala de operacion';
COMMENT ON COLUMN sala_capacitacion.num_piso IS 'Numero del piso en el que encuentra';
COMMENT ON COLUMN sala_capacitacion.id_edificio IS 'ID del edificio donde se encuentra';
COMMENT ON COLUMN sala_capacitacion.costo IS 'Costo de la sala';

COMMENT ON TABLE asistencia IS 'Tabla que representa la asistencia de un empleado a un piso';
COMMENT ON COLUMN asistencia.id_empleado IS 'ID del empleado al que se le tomará asistencia';
COMMENT ON COLUMN asistencia.id_edificio IS 'ID del edificio al que asistio';
COMMENT ON COLUMN asistencia.num_piso IS 'Numero de piso al que asistio';

COMMENT ON TABLE registro_asistencia IS 'Tabla que representa el registro de la asistencia de un empleado';
COMMENT ON COLUMN registro_asistencia.id_empleado IS 'ID del empleado al que se le tomará el registro de asistencia';
COMMENT ON COLUMN registro_asistencia.num_piso IS 'Numero de piso al que se registrara la asistencia';
COMMENT ON COLUMN registro_asistencia.id_edificio IS 'ID del edificio al que se registrara la asistencia';
COMMENT ON COLUMN registro_asistencia.fecha IS 'Fecha en la cual asistio';
COMMENT ON COLUMN registro_asistencia.hora IS 'Hora en la cual asistio';
COMMENT ON COLUMN registro_asistencia.tipo IS 'El registro de entrada/salida del empleado';

COMMENT ON TABLE asignar IS 'Tabla que representa la sala a la cual fue asignado un curso';
COMMENT ON COLUMN asignar.num_sala IS 'Numero de sala a la que se asigno el curso';
COMMENT ON COLUMN asignar.num_piso IS 'Numero del piso a la que se asigno el curso';
COMMENT ON COLUMN asignar.id_edificio IS 'ID del edificio a la que se asigno el curso';
COMMENT ON COLUMN asignar.id_curso IS 'ID del curso al cual se le asigno una sala';
COMMENT ON COLUMN asignar.id_programa_curso IS 'ID del programa del curso al cual se le asigno una sala';
COMMENT ON COLUMN asignar.id_cliente IS 'ID del cliente al cual se le presta el servicio del curso';
COMMENT ON COLUMN asignar.horario_reserva IS 'Horario en que el que esta reservada la sala';

COMMENT ON TABLE estacion IS 'Tabla que representa una estacion de una sala del centro de control';
COMMENT ON COLUMN estacion.num_estacion IS 'Numero de estacion';
COMMENT ON COLUMN estacion.num_sala IS 'Numero de sala en la que se encuentra';
COMMENT ON COLUMN estacion.num_piso IS 'Numero del piso en el que encuentra';
COMMENT ON COLUMN estacion.id_edificio IS 'ID del edificio donde se encuentra';
COMMENT ON COLUMN estacion.sistema_operativo IS 'Si es Windows o Linux';

COMMENT ON TABLE accesorio IS 'Tabla que representa una accesorio de una estacion del centro de control';
COMMENT ON COLUMN accesorio.id_accesorio IS 'ID del acessorio';
COMMENT ON COLUMN accesorio.num_estacion IS 'Numero de estacion donde se encuentra';
COMMENT ON COLUMN accesorio.num_sala IS 'Numero de sala en la que se encuentra';
COMMENT ON COLUMN accesorio.num_piso IS 'Numero del piso en el que encuentra';
COMMENT ON COLUMN accesorio.id_edificio IS 'ID del edificio donde se encuentra';
COMMENT ON COLUMN accesorio.tipo IS 'Si es mouse, teclado o headset';

COMMENT ON TABLE cliente IS 'Tabla que representa un cliente que contrato un curso';
COMMENT ON COLUMN cliente.id_cliente IS 'ID del cliente';
COMMENT ON COLUMN cliente.razon_social IS 'Es el nombre mediante el cual se identifica a una persona moral inscrita en el RFC';
COMMENT ON COLUMN cliente.rfc IS 'Registro Federal de Contribuyentes del cliente';
COMMENT ON COLUMN cliente.telefono IS 'Numero telefonico del cliente';
COMMENT ON COLUMN cliente.persona_contacto IS 'Persona a la que se le puede contactar por referencias';
COMMENT ON COLUMN cliente.correo_contacto IS 'Correo electronico de la persona de contacto';

COMMENT ON TABLE reservacion_operaciones IS 'Tabla que representa una reservacion de la sala de operaciones del centro de control';
COMMENT ON COLUMN reservacion_operaciones.id_reservacion_operaciones IS 'ID del numero de reservacion de la sala de operaciones';
COMMENT ON COLUMN reservacion_operaciones.num_sala IS 'Numero de sala que se reserva';
COMMENT ON COLUMN reservacion_operaciones.num_piso IS 'Numero del piso que se reserva';
COMMENT ON COLUMN reservacion_operaciones.id_edificio IS 'ID del edificio que se reserva';
COMMENT ON COLUMN reservacion_operaciones.sistema_operativo IS 'Si es Windows o Linux';


COMMENT ON TABLE fecha_reservacion_operaciones IS 'Tabla que representa la fecha de una reservacion de la sala de operaciones del centro de control';
COMMENT ON COLUMN fecha_reservacion_operaciones.id_reservacion_operaciones IS 'ID del numero de reservacion de la sala de operaciones';
COMMENT ON COLUMN fecha_reservacion_operaciones.num_sala IS 'Numero de sala que se reserva';
COMMENT ON COLUMN fecha_reservacion_operaciones.num_piso IS 'Numero del piso que se reserva';
COMMENT ON COLUMN fecha_reservacion_operaciones.id_edificio IS 'ID del edificio que se reserva';
COMMENT ON COLUMN fecha_reservacion_operaciones.fecha IS 'Fecha en la que se reserva';


COMMENT ON TABLE laborar_operaciones IS 'Tabla que representa en que sala de operaciones labora un agente';
COMMENT ON COLUMN laborar_operaciones.id_reservacion_operaciones IS 'ID del numero de reservacion de la sala de operaciones';
COMMENT ON COLUMN laborar_operaciones.num_sala IS 'Numero de sala que se reserva';
COMMENT ON COLUMN laborar_operaciones.num_piso IS 'Numero del piso que se reserva';
COMMENT ON COLUMN laborar_operaciones.id_edificio IS 'ID del edificio que se reserva';
COMMENT ON COLUMN laborar_operaciones.id_empleado IS 'Empleado que labora';


COMMENT ON TABLE requerir IS 'Tabla que representa en que programa del curso labora un agente en una sala de operaciones';
COMMENT ON COLUMN requerir.id_reservacion_operaciones IS 'ID del numero de reservacion de la sala de operaciones';
COMMENT ON COLUMN requerir.num_sala IS 'Numero de sala que se reserva';
COMMENT ON COLUMN requerir.num_piso IS 'Numero del piso que se reserva';
COMMENT ON COLUMN requerir.id_edificio IS 'ID del edificio que se reserva';
COMMENT ON COLUMN requerir.id_programa_curso IS 'ID del programa del curso que necesita';
COMMENT ON COLUMN requerir.id_cliente IS 'ID del cliente que contrato el curso';