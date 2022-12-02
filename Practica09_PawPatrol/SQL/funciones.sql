--Una funci ́on que reciba el identificador de empleado y regrese la edad del mismo.
CREATE OR REPLACE FUNCTION getEdad(empleado_id)
  RETURNS int
  AS $$
  DECLARE
  edad int;
  BEGIN
  IF (EXISTS (SELECT nacimiento FROM empleado WHERE id_persona = empleado_id))
  edad  = 
  END IF;
  RETURN edad;
  END;
  $$
  Language plpgsql;
--Una funci ́on que reciba idVivero y regrese las ganancias de ese Vivero.
CREATE OR REPLACE FUNCTION nombreFuncion(param,param,param,...)
RETURNS tipoDeDatoDeRetorno
AS $$
DECLARE
variable;
variable;
BEGIN
sentencia; --Comentario
sentencia; /*Bloque de Comentarios*/
sentencia;
RETURN retorno;
END;
$$
Language plpgsql;
