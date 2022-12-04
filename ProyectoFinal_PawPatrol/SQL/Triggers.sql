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
        THEN RAISE EXCEPTION 'El Edificio %d ya tiene 10 pisos', NEW.id_edificio
        USING HINT = 'Los Edificios tiene 10 piso al maximo';
    END IF;
    RETURN NULL;
END
$$
LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER num_de_pisos
    AFTER INSERT
    ON piso
    FOR EACH ROW
    EXECUTE PROCEDURE check_num_pisos();
--Max cantidad de salas de cada piso es 8
CREATE OR REPLACE FUNCTION check_num_salas() RETURNS TRIGGER
AS
$$
DECLARE
n BIGINT;
BEGIN
    SELECT COUNT(num_sala)
    AS cnt
    FROM sala
    GROUP BY id_edificio, num_piso
    HAVING id_edificio = NEW.id_edificio AND num_piso = NEW.num_piso
    INTO n;
    IF n > 8
        THEN RAISE EXCEPTION 'El Piso %d en Edificio %d ya tiene 8 pisos', NEW.num_piso, NEW.id_edificio
        USING HINT = 'Los Piso tiene 8 salas al maximo';
    END IF;
    RETURN NULL;
END
$$
LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER num_de_salas
    BEFORE INSERT
    ON sala
    FOR EACH ROW
    EXECUTE PROCEDURE check_num_salas();

--Solo se puede reservar
-- CREATE OR REPLACE TRIGGER impartir_conflictos
--     BEFORE INSERT
--     ON impartir FOR EACH ROW
--     BEGIN
--         IF (SELECT COUNT(num_sala) AS count FROM sala GROUP BY id_edificio, num_piso HAVING id_edificio = NEW.id_edificio AND num_piso = NEW.num_piso).count >= 8
--             THEN RAISE EXCEPTION 'El Piso %d en Edificio %d ya tiene 8 pisos', NEW.num_piso, NEW.id_edificio
--             USING HINT 'Los Piso tiene 8 salas al maximo';
--         END IF
--     END
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
-- INSERT INTO sala( num_sala, num_piso, id_edificio, costo)
-- VALUES(1, 1, 1, 1);
-- INSERT INTO sala( num_sala, num_piso, id_edificio, costo)
-- VALUES(2, 1, 1, 1);
-- INSERT INTO sala( num_sala, num_piso, id_edificio, costo)
-- VALUES(3, 1, 1, 1);
-- INSERT INTO sala( num_sala, num_piso, id_edificio, costo)
-- VALUES(4, 1, 1, 1);
-- INSERT INTO sala( num_sala, num_piso, id_edificio, costo)
-- VALUES(5, 1, 1, 1);
-- INSERT INTO sala( num_sala, num_piso, id_edificio, costo)
-- VALUES(6, 1, 1, 1);
-- INSERT INTO sala( num_sala, num_piso, id_edificio, costo)
-- VALUES(7, 1, 1, 1);
-- INSERT INTO sala( num_sala, num_piso, id_edificio, costo)
-- VALUES(8, 1, 1, 1);
-- INSERT INTO sala( num_sala, num_piso, id_edificio, costo)
-- VALUES(9, 1, 1, 1);
