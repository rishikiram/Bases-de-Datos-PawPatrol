CREATE TABLE vivero(
  id_vivero int,
  nombre_vivero varchar(100),
  calle varchar(100),
  numero_exterior int,
  cp int,
  fecha_apertura date
);

CREATE TABLE empleado(
  id_persona int,
  numero_exterior int,
  cp int,
  calle varchar(100),
  fecha_nacimiento date,
  nombre varchar(100),
  apellido_paterno varchar(100),
  apellido_materno varchar(100),
  salario int,
  id_vivero int
);

CREATE TABLE cajero(cantidad_recaudada int) INHERITS (empleado);

CREATE TABLE cuidador(turno_es_matutino bit) INHERITS (empleado);

CREATE TABLE gerente(fecha_comienzo date) INHERITS (empleado);

CREATE TABLE encargado(num_clientes_ayudados int) INHERITS (empleado);

CREATE TABLE cliente(
  id_persona int,
  numero_exterior int,
  cp int,
  calle varchar(100),
  fecha_nacimiento date,
  nombre varchar(100),
  apellido_paterno varchar(100),
  apellido_materno varchar(100)
);

CREATE TABLE c_info_planta(
  nombre varchar(100),
  riego int,
  cuidados varchar(100),
  area varchar(100),
  --este no estoy segura a q se referia
  genero varchar(100),
  precio int,
  tipo_luz varchar(100),
  tipo_sustrato varchar(100)
);

CREATE TABLE planta(
  id_planta int,
  id_info_planta varchar(100),
  id_vivero int NOT NULL,
  id_venta int,
  fecha_germinacion date
);

CREATE TABLE pago(id_pago int, id_venta int, cantidad int);

CREATE TABLE efectivo(cantidad_recibida int, cantidad_dado int) INHERITS (pago);

CREATE TABLE tarjeta_credito(num_meses_sinintereses int) INHERITS (pago);

CREATE TABLE tarjeta_debito(cantidad_retiro_efectivo int) INHERITS (pago);

CREATE TABLE venta(id_venta int, fecha date);

CREATE TABLE venta_fisica(id_cajero int) INHERITS (venta);

CREATE TABLE venta_en_linea(
  num_seguimiento int,
  numero_ex int,
  cp int,
  calle varchar(100),
  id_cliente int
) INHERITS (venta);

CREATE TABLE ayudar(
  id_empleado_encargado int,
  id_venta_fisica int
);

CREATE TABLE correo(correo varchar(100), id_persona int);

CREATE TABLE telefono_persona(
  telefono_persona varchar(100),
  id_persona int
);

CREATE TABLE telefono_vivero(telefono varchar(100), id_vivero int);

ALTER TABLE
  vivero
ADD
  CONSTRAINT pk_vivero PRIMARY KEY (id_vivero);

ALTER TABLE
  empleado
ADD
  CONSTRAINT pk_empleado PRIMARY KEY (id_persona),
ADD
  CONSTRAINT fk1_empleado FOREIGN KEY(id_vivero) REFERENCES vivero(id_vivero);

ALTER TABLE
  cliente
ADD
  CONSTRAINT pk_cliente PRIMARY KEY (id_persona);

ALTER TABLE
  c_info_planta
ADD
  CONSTRAINT pk_c_info_planta PRIMARY KEY (nombre);

ALTER TABLE
  planta
ADD
  CONSTRAINT pk_planta PRIMARY KEY (id_planta, id_info_planta),
ADD
  CONSTRAINT fk1_planta FOREIGN KEY (id_info_planta) REFERENCES c_info_planta(nombre);

ALTER TABLE
  venta
ADD
  CONSTRAINT pk_venta PRIMARY KEY (id_venta);

ALTER TABLE
  pago
ADD
  CONSTRAINT pk_pago PRIMARY KEY (id_pago),
ADD
  CONSTRAINT fk_pago FOREIGN KEY (id_venta) REFERENCES venta(id_venta);

ALTER TABLE
  cajero
ADD
  CONSTRAINT pk_cajero PRIMARY KEY (id_persona),
ADD
  CONSTRAINT fk1_cajero FOREIGN KEY (id_vivero) REFERENCES vivero(id_vivero);

ALTER TABLE
  cuidador
ADD
  CONSTRAINT fk_cuidador FOREIGN KEY (id_vivero) REFERENCES vivero(id_vivero);

ALTER TABLE
  gerente
ADD
  CONSTRAINT fk_gerente FOREIGN KEY (id_vivero) REFERENCES vivero(id_vivero);

ALTER TABLE
  encargado
ADD
  CONSTRAINT pk_encargado PRIMARY KEY(id_persona),
ADD
  CONSTRAINT fk_encargado FOREIGN KEY (id_vivero) REFERENCES vivero(id_vivero);

ALTER TABLE
  venta_fisica
ADD
  CONSTRAINT pk_venta_fisica PRIMARY KEY(id_venta),
ADD
  CONSTRAINT fk_venta_fisica FOREIGN KEY(id_cajero) REFERENCES cajero(id_persona);

ALTER TABLE
  venta_en_linea
ADD
  CONSTRAINT pk_venta_en_linea PRIMARY KEY(id_venta),
ADD
  CONSTRAINT fk_venta_en_linea FOREIGN KEY(id_cliente) REFERENCES cliente(id_persona);

ALTER TABLE
  ayudar
ADD
  CONSTRAINT fk1_ayudar FOREIGN KEY(id_empleado_encargado) REFERENCES encargado(id_persona),
ADD
  CONSTRAINT fk2_ayudar FOREIGN KEY(id_venta_fisica) REFERENCES venta_fisica(id_venta);

ALTER TABLE
  correo
ADD
  CONSTRAINT fk_correo FOREIGN KEY(id_persona) REFERENCES empleado(id_persona);

ALTER TABLE
  telefono_persona
ADD
  CONSTRAINT fk_telefono_persona FOREIGN KEY(id_persona) REFERENCES empleado(id_persona);

ALTER TABLE
  telefono_vivero
ADD
  CONSTRAINT fk_telefono_vivero FOREIGN KEY(id_vivero) REFERENCES vivero(id_vivero);

    
COMMENT ON TABLE ayudar IS 'Tabla que relaciona ventas fisicas con el encargado que ayudo en la venta';
COMMENT ON COLUMN ayudar.id_empleado_encargado IS 'ID del empleado que ayudo con la venta';
COMMENT ON COLUMN ayudar.id_venta_fisica IS 'ID de la venta fisica'

COMMENT ON TABLE c_info_planta IS 'Tabla catalogo de las plantas que maneja el vivero';
COMMENT ON COLUMN c_info_planta.nombre IS 'El nombre de la planta';
COMMENT ON COLUMN c_info_planta.riego IS 'Informacion del riego de la planta';
COMMENT ON COLUMN c_info_planta.cuidados IS 'Cuidados de la planta';
COMMENT ON COLUMN c_info_planta.area IS 'El area del vivero al que pertenecen las plantas. Africanas o Cactus';
COMMENT ON COLUMN c_info_planta.genero IS 'El genero de la planta';
COMMENT ON COLUMN c_info_planta.precio IS 'El precio de la planta';
COMMENT ON COLUMN c_info_planta.tipo_luz IS 'El tipo de luz que requiere la planta';
COMMENT ON COLUMN c_info_planta.tipo_sustrato IS 'El tipo de sustrato que requiere la planta';

COMMENT ON TABLE cajero IS 'Especializacion de la tabla empleado para los cajeros de los viveros';
COMMENT ON COLUMN cajero.id_persona IS 'El id de la persona';
COMMENT ON COLUMN cajero.numero_exterior IS 'El numero exterior de la direccion del empleado';
COMMENT ON COLUMN cajero.cp IS 'El codigo postal de la direccion del empleado';
COMMENT ON COLUMN cajero.calle IS 'La calle de la direccion del empleado';
COMMENT ON COLUMN cajero.fecha_nacimiento IS 'La fecha de nacimiento del empleado';
COMMENT ON COLUMN cajero.nombre IS 'El nombre del empleado';
COMMENT ON COLUMN cajero.apellido_paterno IS 'El apellido paterno del empleado';
COMMENT ON COLUMN cajero.apellido_materno IS 'El apellido materno del empleado';
COMMENT ON COLUMN cajero.salario IS 'El salario del empleado';
COMMENT ON COLUMN cajero.id_vivero IS 'El id del vivero donde trabaja el empleado';
COMMENT ON COLUMN cajero.cantidad_recaudada IS 'La cantidad recaudada por el empleado';

COMMENT ON TABLE cliente IS 'Tabla con informacion de los clientes';
COMMENT ON COLUMN cliente.id_persona IS 'El id de la persona';
COMMENT ON COLUMN cliente.numero_exterior IS 'El numero exterior de la direccion del cliente';
COMMENT ON COLUMN cliente.cp IS 'El codigo postal de la direccion del cliente';
COMMENT ON COLUMN cliente.calle IS 'La calle de la direccion del cliente';
COMMENT ON COLUMN cliente.fecha_nacimiento IS 'La fecha de nacimiento del cliente';
COMMENT ON COLUMN cliente.nombre IS 'El nombre del cliente';
COMMENT ON COLUMN cliente.apellido_paterno IS 'El apellido paterno del cliente';
COMMENT ON COLUMN cliente.apellido_materno IS 'El apellido materno del cliente';

COMMENT ON TABLE correo IS 'Tabla con el o los correos asociados a una persona';
COMMENT ON COLUMN correo.correo IS 'Correos asociados a una persona';

COMMENT ON TABLE cuidador IS 'Tabla con la informacion de los cuidadores de los viveros';
COMMENT ON COLUMN cuidador.id_persona IS 'El id de la persona';
COMMENT ON COLUMN cuidador.numero_exterior IS 'El numero exterior de la direccion del empleado';
COMMENT ON COLUMN cuidador.cp IS 'El codigo postal de la direccion del empleado';
COMMENT ON COLUMN cuidador.calle IS 'La calle de la direccion del empleado';
COMMENT ON COLUMN cuidador.fecha_nacimiento IS 'La fecha de nacimiento del empleado';
COMMENT ON COLUMN cuidador.nombre IS 'El nombre del empleado';
COMMENT ON COLUMN cuidador.apellido_paterno IS 'El apellido paterno del empleado';
COMMENT ON COLUMN cuidador.apellido_materno IS 'El apellido materno del empleado';
COMMENT ON COLUMN cuidador.salario IS 'El salario del empleado';
COMMENT ON COLUMN cuidador.id_vivero IS 'El id del vivero donde trabaja el empleado';
COMMENT ON COLUMN cuidador.turno_es_matutino IS 'Si el empleado tiene turno matutino o no';

COMMENT ON TABLE efectivo IS 'Generalizacion de la tabla pago, para pagos con efectivo';
COMMENT ON COLUMN efectivo.id_pago IS 'El id del pago';
COMMENT ON COLUMN efectivo.id_venta IS 'El id de la venta asociada al pago';
COMMENT ON COLUMN efectivo.cantidad IS 'La cantidad que se pago en efectivo';
COMMENT ON COLUMN efectivo.cantidad_recibida IS 'La cantidad de efectivo que dio el cliente';
COMMENT ON COLUMN efectivo.cantidad_dado IS 'El cambio devuelto al cliente';