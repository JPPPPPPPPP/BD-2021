--Integrity constraint: there cannot be more than 3 secondary suppliers
CREATE OR REPLACE FUNCTION check_if_three_secondary_supps()
RETURNS TRIGGER AS
$$
BEGIN
    IF (SELECT countSecondary FROM supplier_stats WHERE productean = NEW.ean) = 3 THEN
        RAISE EXCEPTION 'Maximum number of secondary suppliers has been reached for that product';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_max_secondary_supp
BEFORE UPDATE OR INSERT ON secondary_supplier
FOR EACH ROW EXECUTE PROCEDURE check_if_three_secondary_supps();


--Integrity constraint: A primary supplier cannot be secondary to a product and vice-versa
CREATE OR REPLACE FUNCTION check_if_pri_is_sec()
RETURNS TRIGGER AS
$$
BEGIN
    IF EXISTS ( SELECT * FROM
            (
                SELECT supp_nif FROM secondary_supplier
                WHERE ean = NEW.ean
            ) AS c
            WHERE c.supp_nif = NEW.supp_nif
        ) THEN
        RAISE EXCEPTION 'That supplier already secondarily supplied that product';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_if_already_a_secondary_supplier
BEFORE UPDATE OR INSERT ON primary_supplier
FOR EACH ROW EXECUTE PROCEDURE check_if_pri_is_sec();

--same but for secondary
CREATE OR REPLACE FUNCTION check_if_sec_is_pri()
RETURNS TRIGGER AS
$$
BEGIN
    IF EXISTS ( SELECT * FROM
            (
                SELECT supp_nif FROM primary_supplier
                WHERE ean = NEW.ean
            ) AS c
            WHERE c.supp_nif = NEW.supp_nif
        ) THEN
        RAISE EXCEPTION 'That supplier already primarily supplied that product';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_if_already_a_primary_supplier
BEFORE UPDATE OR INSERT ON secondary_supplier
FOR EACH ROW EXECUTE PROCEDURE check_if_sec_is_pri();