-- 1
SELECT * FROM carti ORDER BY id;
-- 2
SELECT * FROM carti WHERE an_publicare >= 2021 ORDER BY id;
-- 3
SELECT * FROM cititori WHERE email = 'ana@example.test';
-- 4
SELECT i.id, c.titlu, r.nume FROM imprumuturi i
JOIN carti c ON c.id=i.carte_id JOIN cititori r ON r.id=i.cititor_id ORDER BY i.id;
-- 5
SELECT * FROM imprumuturi WHERE data_returnare IS NULL ORDER BY id;
-- 6
SELECT r.nume, count(i.id) AS total FROM cititori r
LEFT JOIN imprumuturi i ON i.cititor_id=r.id GROUP BY r.id, r.nume ORDER BY r.id;
-- 7
SELECT c.* FROM carti c WHERE NOT EXISTS (
 SELECT 1 FROM imprumuturi i WHERE i.carte_id=c.id AND i.data_returnare IS NULL
) ORDER BY c.id;
-- 8
SELECT * FROM imprumuturi WHERE data_returnare IS NULL AND data_scadenta < DATE '2026-01-20';
-- 9
BEGIN;
UPDATE imprumuturi SET data_returnare='2026-01-20' WHERE id=2;
SELECT * FROM imprumuturi WHERE id=2;
ROLLBACK;
-- 10: rulează separat, interactiv; eroarea este intenționată.
-- BEGIN;
-- INSERT INTO imprumuturi (carte_id,cititor_id,data_imprumut,data_scadenta)
-- VALUES (1,3,'2026-01-15','2026-01-29');
-- ROLLBACK;
