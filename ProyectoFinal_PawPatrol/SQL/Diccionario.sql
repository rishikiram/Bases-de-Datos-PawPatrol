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
COMMENT ON COLUMN agente.pasar_piso IS 'Si el agente aprobo el curso será true, en otro caso false';

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


