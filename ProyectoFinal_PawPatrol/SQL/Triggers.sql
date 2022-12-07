--Max cantidad pisos de cada edificio es 10
CREATE OR REPLACE FUNCTION check_num_pisos() RETURNS TRIGGER
AS
$$
DECLARE
n BIGINT;
BEGIN
    SELECT COUNT(num_piso)
    AS cnt
    FROM piso
    GROUP BY id_edificio
    HAVING id_edificio = NEW.id_edificio
    INTO n;
    IF (n > 10)
        THEN RAISE EXCEPTION 'El Edificio % ya tiene 10 pisos', NEW.id_edificio
        USING HINT = 'Los Edificios tiene 10 piso al maximo';
    END IF;
    RETURN NULL;
END
$$
LANGUAGE plpgsql;


DROP TRIGGER IF EXISTS num_de_pisos ON piso;
CREATE TRIGGER num_de_pisos
    AFTER INSERT
    ON piso
    FOR EACH ROW
    EXECUTE PROCEDURE check_num_pisos();

  CREATE OR REPLACE FUNCTION check_num_faltas() RETURNS TRIGGER
  AS
  $$
  DECLARE
  f BIGINT;
  BEGIN
      SELECT COUNT(fecha)
      AS cnt
      FROM faltar
      WHERE faltar.id_curso = NEW.id_curso AND faltar.id_empleado = NEW.id_empleado
      GROUP BY NEW.id_curso, NEW.id_empleado
      INTO f;
      IF (f >= 3 AND NEW.calificacion >=8 )
          THEN RAISE EXCEPTION 'El calificacion no se puede ser 8 o más porque el empleado % faltó % veces a la clase %.', NEW.id_empleado, NEW.id_curso, f
          USING HINT = 'Para aprobar, los empleados no pueden faltar 3 o más clases.';
      END IF;
      RETURN NULL;
  END
  $$
  LANGUAGE plpgsql;


DROP TRIGGER IF EXISTS num_faltas_update ON evaluar;
CREATE TRIGGER num_faltas_update
  AFTER UPDATE of calificacion
  ON evaluar
  FOR EACH ROW
  EXECUTE PROCEDURE check_num_faltas();
  
DROP TRIGGER IF EXISTS num_faltas_insert ON evaluar;
CREATE TRIGGER num_faltas_insert
  AFTER INSERT
  ON evaluar
  FOR EACH ROW
  EXECUTE PROCEDURE check_num_faltas();

--Pruebas
--Despues de DML.sql, debe fallar
-- INSERT INTO evaluar(
--     id_empleado,
--     id_curso,
--     id_programa_curso,
--     id_cliente,
--     calificacion
-- ) VALUES (16,16,16,215,8);
--Despues de DML.sql, debe funciona
-- INSERT INTO evaluar(
--     id_empleado,
--     id_curso,
--     id_programa_curso,
--     id_cliente,
--     calificacion
-- ) VALUES (12,12,12,211,9);


-- DELETE FROM sala;
-- DELETE FROM piso;
-- DELETE FROM edificio;
-- INSERT INTO edificio(id_edificio, calle, cp, numero_exterior)
-- VALUES(1, 'avenida', 19540, 1234);
-- DELETE FROM piso;
-- INSERT INTO piso(num_piso, id_edificio)
-- VALUES (1, 1);
-- INSERT INTO piso(num_piso, id_edificio)
-- VALUES (2, 1);
-- INSERT INTO piso(num_piso, id_edificio)
-- VALUES (3, 1);
-- INSERT INTO piso(num_piso, id_edificio)
-- VALUES (4, 1);
-- INSERT INTO piso(num_piso, id_edificio)
-- VALUES (5, 1);
-- INSERT INTO piso(num_piso, id_edificio)
-- VALUES (6, 1);
-- INSERT INTO piso(num_piso, id_edificio)
-- VALUES (7, 1);
-- INSERT INTO piso(num_piso, id_edificio)
-- VALUES (8, 1);
-- INSERT INTO piso(num_piso, id_edificio)
-- VALUES (9, 1);
-- INSERT INTO piso(num_piso, id_edificio)
-- VALUES (10, 1);
-- INSERT INTO piso(num_piso, id_edificio)
-- VALUES (13, 1);

