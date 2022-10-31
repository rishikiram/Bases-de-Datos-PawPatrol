CREATE TABLE vivero(
  id_vivero int PRIMARY KEY,
  nombre_vivero varchar(100),
  calle varchar(100),
  numero_exterior int,
  cp int,
  fecha_apertura date
);

CREATE TABLE cajero(
  id_persona int PRIMARY KEY,
  numero_exterior int,
  cp int,
  calle varchar(100),
  fecha_nacimiento date,
  nombre varchar(100),
  apellido_paterno varchar(100),
  apellido_materno varchar(100),
  salario int,
  cantidad_recaudada int,
  id_vivero int NOT NULL
    FOREIGN KEY(id_vivero)
    REFERENCES vivero(id_vivero),
);

CREATE TABLE cuidador(
  id_persona int PRIMARY KEY,
  numero_exterior int,
  cp int,
  calle varchar(100),
  fecha_nacimiento date,
  nombre varchar(100),
  apellido_paterno varchar(100),
  apellido_materno varchar(100),
  salario int,
  turno_es_matutino bool,
  id_vivero int NOT NULL
    FOREIGN KEY(id_vivero)
    REFERENCES vivero(id_vivero),
);

CREATE TABLE gerente(
  id_persona int PRIMARY KEY,
  numero_exterior int,
  cp int,
  calle varchar(100),
  fecha_nacimiento date,
  nombre varchar(100),
  apellido_paterno varchar(100),
  apellido_materno varchar(100),
  salario int,
  fecha_comienzo date,
  id_vivero int NOT NULL
    FOREIGN KEY(id_vivero)
    REFERENCES vivero(id_vivero),
);

CREATE TABLE encargado(
  id_persona int PRIMARY KEY,
  numero_exterior int,
  cp int,
  calle varchar(100),
  fecha_nacimiento date,
  nombre varchar(100),
  apellido_paterno varchar(100),
  apellido_materno varchar(100),
  salario int,
  num_clientes_ayudados int,
  id_vivero int NOT NULL
    FOREIGN KEY(id_vivero)
    REFERENCES vivero(id_vivero),
);

CREATE TABLE cliente(
  id_persona int PRIMARY KEY,
  numero_exterior int,
  cp int,
  calle varchar(100),
  fecha_nacimiento date,
  nombre varchar(100),
  apellido_paterno varchar(100),
  apellido_materno varchar(100),
);

CREATE TABLE planta(
  CONSTRAINT pk_planta
  PRIMARY KEY (id_planta, id_info_planta),

  id_planta int,
  id_info_planta varchar(100)
    CONSTRAINT fk_info_planta
    FOREIGN KEY (id_info_plant)
    REFERENCES c_info_planta(nombre),
  id_vivero int NOT NULL,
  id_venta int,
  fecha_germinacion date
);

CREATE TABLE c_info_planta(
  nombre varchar(100) PRIMARY KEY,
  riego int,
  cuidados varchar(100),
  area varchar(100), --este no estoy segura a q se referia
  genero varchar(100),
  precio int,
  tipo_luz varchar(100),
  tipo_sustrato varchar(100)
);

CREATE TABLE venta_fisica(
  CONSTRAINT pk_venta_fisica
  PRIMARY KEY (id_venta, id_pago),

  id_venta int,
  id_pago int
    CONSTRAINT fk_id_pago
    FOREIGN KEY(id_pago)
    REFERENCES efectivo(id_pago), tarjeta_debito(id_pago), tarjeta_credito(id_pago),
  fecha date,
  id_cajero int
    FOREIGN KEY(id_cajero)
    REFERENCES cajero(id_persona),
);

CREATE TABLE venta_en_linea(
  CONSTRAINT pk_venta_en_linea
  PRIMARY KEY(id_cliente, id_pago),

  id_venta int,
  id_pago int
    CONSTRAINT fk_id_pago
    FOREIGN KEY(id_pago)
    REFERENCES efectivo(id_pago), tarjeta_debito(id_pago), tarjeta_credito(id_pago),
  fecha date,
  num_seguimiento int,
  numero_ex int,
  cp int,
  calle varchar(100),
  id_cliente int
    FOREIGN KEY(id_cliente)
    REFERENCES cliente(id_persona),
);

CREATE TABLE efectivo(
  id_pago int PRIMARY KEY,
  cantidad int,
  cantidad_recibida int,
  cantidad_dado int
);

CREATE TABLE tarjeta_credito(
  id_pago int PRIMARY KEY,
  cantidad int,
  num_meses_sinintereses int
);

CREATE TABLE tarjeta_debito(
  id_pago int PRIMARY KEY,
  cantidad int,
  cantidad_retiro_efectivo int
);

CREATE TABLE ayudar(
  id_empleado_encargado int
    FOREIGN KEY (id_empleado_encargado)
    REFERENCES encargado(id_persona),
  id_venta_fisica int
  FOREIGN KEY (id_venta_fisica)
  REFERENCES venta_fisica(id_venta),
);

CREATE TABLE correo(
  correo varchar(100),
  id_persona int NOT NULL
    FOREIGN KEY(id_persona)
    REFERENCES encargado(id_persona), gerente(id_persona), cuidador(id_persona), cajero(id_persona),
);

CREATE TABLE telefono_persona(
  telefono_persona varchar(100),
  id_persona int NOT NULL
    FOREIGN KEY(id_persona)
    REFERENCES encargado(id_persona), gerente(id_persona), cuidador(id_persona), cajero(id_persona),
);
CREATE TABLE telefono_vivero(
  telefono varchar(100),
  id_vivero int NOT NULL
    FOREIGN KEY(id_vivero)
    REFERENCES vivero(id_vivero),
);
