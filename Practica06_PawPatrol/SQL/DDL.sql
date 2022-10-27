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
id_vivero int NOT NULL,
FOREIGN KEY(id_vivero)REFERENCES vivero(id_vivero)
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
id_vivero int NOT NULL,
FOREIGN KEY(id_vivero)REFERENCES vivero(id_vivero)
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
id_vivero int NOT NULL,
FOREIGN KEY(id_vivero)REFERENCES vivero(id_vivero)
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
id_vivero int NOT NULL,
FOREIGN KEY(id_vivero)REFERENCES vivero(id_vivero)
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