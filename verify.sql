-- Verifică setul inițial de date, înainte de modificări sau după restore.
DO $$
BEGIN
    IF (SELECT count(*) FROM carti) <> 4
       OR (SELECT count(*) FROM cititori) <> 3
       OR (SELECT count(*) FROM imprumuturi) <> 3
       OR (SELECT count(*) FROM imprumuturi WHERE data_returnare IS NULL) <> 2
    THEN RAISE EXCEPTION 'Setul de date nu corespunde exemplului initial';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM carti WHERE id=1 AND titlu='SQL pas cu pas')
    THEN RAISE EXCEPTION 'Cartea de referinta lipseste';
    END IF;
END $$;
SELECT 'Verificari OK' AS rezultat;
