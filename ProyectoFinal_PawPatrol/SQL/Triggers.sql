--Max cantidad pisos de cada edificio es 10
CREATE OR REPLACE FUNCTION check_num_pisos() RETURNS TRIGGER
AS
$$
BEGIN
    IF (SELECT COUNT(num_piso) AS count FROM piso GROUP BY id_edificio HAVING id_edificio = NEW.id_edificio).count >= 10
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
BEGIN
    IF (SELECT COUNT(num_sala) AS count FROM sala GROUP BY id_edificio, num_piso HAVING id_edificio = NEW.id_edificio AND num_piso = NEW.num_piso).count >= 8
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
