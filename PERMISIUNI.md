# Un utilizator care poate citi biblioteca

Obiectiv: conectare ca `library_reader`, citire permisă și modificare refuzată. Pornește de la baza `library_lab` inițializată conform [README](README.md).

## 1. Crearea contului — în terminalul Linux

```bash
sudo -u postgres createuser --pwprompt library_reader
```

Alege o parolă proprie. Nu o publica. Contul este creat fără drepturi de superutilizator, creare de baze sau creare de roluri. Dacă există deja, verifică-i configurația cu administratorul înainte să continui; nu presupune că un cont reutilizat are drepturi limitate.

## 2. Acordarea permisiunilor — ca proprietar

```bash
psql -h 127.0.0.1 -U library_owner -d library_lab -W
```

La promptul `library_lab=>`, rulează:

```sql
GRANT CONNECT ON DATABASE library_lab TO library_reader;
GRANT USAGE ON SCHEMA public TO library_reader;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO library_reader;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT ON TABLES TO library_reader;
```

Rezultat: trei mesaje `GRANT` și unul `ALTER DEFAULT PRIVILEGES`.

`CONNECT` permite conectarea la bază, `USAGE` permite accesarea obiectelor din schemă, iar `SELECT` permite citirea tabelelor existente. Ultima comandă se aplică tabelelor viitoare create de **library_owner**, în schema `public` a acestei baze; nu celor create de orice alt cont.

Aceste comenzi adaugă drepturi. Ele nu elimină drepturi anterioare, apartenențe la roluri sau privilegii primite prin `PUBLIC`. Lecția presupune contul nou și schema PostgreSQL 16 creată conform proiectului. Nu configurează izolare față de toate celelalte baze de pe server.

Ieși cu `\q`.

## 3. Testarea citirii — ca library_reader

În terminalul Linux:

```bash
psql -h 127.0.0.1 -U library_reader -d library_lab -W
```

Folosește parola lui `library_reader`, apoi rulează în consola SQL:

```sql
SELECT current_user;
SELECT id, titlu FROM carti ORDER BY id;
```

Rezultat: `library_reader` și cele patru cărți. Primul titlu este `SQL pas cu pas`.

## 4. Testarea refuzului de modificare

În aceeași consolă SQL, execută interactiv:

```sql
BEGIN;
UPDATE carti SET titlu = 'Test permisiuni' WHERE id = 1;
ROLLBACK;
```

Rezultat așteptat:

```text
BEGIN
ERROR:  permission denied for table carti
ROLLBACK
```

Eroarea este intenționată. Dacă rulezi instrucțiunile separat, promptul `library_lab=!>` indică o tranzacție în eroare: execută `ROLLBACK` pentru a reveni la `library_lab=>`. Dacă UPDATE reușește, tot execută ROLLBACK și verifică drepturile contului cu administratorul; testul de restricționare a eșuat.

Confirmă că datele au rămas intacte:

```sql
SELECT current_user;
SELECT id, titlu FROM carti ORDER BY id;
```

Ieși cu `\q`. Vezi [rezultatele sesiunii practice](VALIDARE.md).
