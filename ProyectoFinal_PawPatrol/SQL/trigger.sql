CREATE OR REPLACE TRIGGER num_de_pisos
    BEFORE INSERT
    ON piso FOR EACH ROW
    BEGIN
        IF (SELECT COUNT(num_piso) AS count FROM piso GROUP BY id_edificio HAVING id_edificio = NEW.id_edificio).count > 10
            THEN RAISE EXCEPTION 'El Edificio %d ya tiene 10 pisos', NEW.id_edificio
            USING HINT 'Los Edificios tiene 10 piso al maximo';
        END IF
    END
