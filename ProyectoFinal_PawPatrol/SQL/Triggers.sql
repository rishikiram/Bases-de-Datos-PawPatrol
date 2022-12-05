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
	
--Max cantidad de salas de cada piso es 8 (NO FUNCIONA)
-- CREATE OR REPLACE FUNCTION check_num_salas() RETURNS TRIGGER
-- AS
-- $$
-- DECLARE
-- -- op BIGINT;
-- -- cap BIGINT;
-- sal BIGINT;
-- BEGIN
-- -- 	RAISE NOTICE 'test';
-- -- 	RETURN NULL;
-- --     SELECT COUNT(num_sala)
-- --     AS cnt
-- --     FROM sala_operacion
-- --     GROUP BY id_edificio, num_piso
-- --     HAVING id_edificio = NEW.id_edificio AND num_piso = NEW.num_piso
-- --     INTO op;
-- --     SELECT COUNT(num_sala)
-- --     AS cnt
-- --     FROM sala_capacitacion
-- --     GROUP BY id_edificio, num_piso
-- --     HAVING id_edificio = NEW.id_edificio AND num_piso = NEW.num_piso
-- --     INTO cap;
--     SELECT COUNT(sala.num_sala)
--     AS cnt
--     FROM sala
--     GROUP BY sala.id_edificio, sala.num_piso
--     HAVING sala.id_edificio = NEW.id_edificio AND sala.num_piso = NEW.num_piso
--     INTO sal;
-- --     RAISE NOTICE 'o % c % s %', op, cap, sal;
--     IF (sal > 8)
--         THEN RAISE EXCEPTION 'El Piso % en Edificio % ya tiene 8 pisos', NEW.num_piso, NEW.id_edificio
--         USING HINT = 'Los Piso tiene 8 salas al maximo';
--     END IF;
--     RETURN NULL;
-- END
-- $$
-- LANGUAGE plpgsql;
-- CREATE OR REPLACE TRIGGER num_de_salas
--     BEFORE INSERT
--     ON sala
--     FOR EACH ROW
--     EXECUTE PROCEDURE check_num_salas();
-- CREATE OR REPLACE TRIGGER num_de_salas_capacitacion
--     BEFORE INSERT
--     ON sala_capacitacion
--     FOR EACH ROW
--     EXECUTE PROCEDURE check_num_salas();
-- CREATE OR REPLACE TRIGGER num_de_salas_operacion
--     BEFORE INSERT
--     ON sala_operacion
--     FOR EACH ROW
--     EXECUTE PROCEDURE check_num_salas();

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
-- DELETE FROM sala;
-- INSERT INTO sala_capacitacion( num_sala, num_piso, id_edificio, costo)
-- VALUES(1, 1, 1, 1);
-- INSERT INTO sala_operacion( num_sala, num_piso, id_edificio, costo)
-- VALUES(2, 1, 1, 1);
-- INSERT INTO sala_capacitacion( num_sala, num_piso, id_edificio, costo)
-- VALUES(3, 1, 1, 1);
-- INSERT INTO sala_operacion( num_sala, num_piso, id_edificio, costo)
-- VALUES(4, 1, 1, 1);
-- INSERT INTO sala( num_sala, num_piso, id_edificio, costo)
-- VALUES(5, 1, 1, 1);
-- INSERT INTO sala_capacitacion( num_sala, num_piso, id_edificio, costo)
-- VALUES(6, 1, 1, 1);
-- INSERT INTO sala_capacitacion( num_sala, num_piso, id_edificio, costo)
-- VALUES(7, 1, 1, 1);
-- INSERT INTO sala_capacitacion( num_sala, num_piso, id_edificio, costo)
-- VALUES(8, 1, 1, 1);
-- INSERT INTO sala_capacitacion( num_sala, num_piso, id_edificio, costo)
-- VALUES(9, 1, 1, 1);
-- INSERT INTO sala_capacitacion( num_sala, num_piso, id_edificio, costo)
-- VALUES(10, 1, 1, 1);
-- INSERT INTO sala_capacitacion( num_sala, num_piso, id_edificio, costo)
-- VALUES(11, 1, 1, 1);
