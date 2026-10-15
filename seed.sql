INSERT INTO carti (titlu, autor, an_publicare) VALUES
('SQL pas cu pas', 'Autor Exemplu A', 2020),
('Linux pentru incepatori', 'Autor Exemplu B', 2021),
('Bazele retelelor', 'Autor Exemplu C', 2019),
('Introducere in Kubernetes', 'Autor Exemplu A', 2024);
INSERT INTO cititori (nume, email) VALUES
('Ana Exemplu', 'ana@example.test'),
('Mihai Exemplu', 'mihai@example.test'),
('Ioana Exemplu', 'ioana@example.test');
INSERT INTO imprumuturi (carte_id, cititor_id, data_imprumut, data_scadenta, data_returnare) VALUES
(1, 1, '2026-01-01', '2026-01-15', '2026-01-10'),
(2, 1, '2026-01-05', '2026-01-19', NULL),
(1, 2, '2026-01-12', '2026-01-26', NULL);
