# Backup și restaurare verificată

Rulează din rădăcina proiectului, pe datele inițiale. Parola este cerută de uneltele PostgreSQL; nu se stochează în scripturi.

## 1. Export

```bash
bash backup.sh
```

Reține calea afișată. Fiecare execuție produce un fișier separat, cu acces doar pentru utilizatorul curent. Arhiva include schema și datele, nu rolurile globale sau configurația serverului.

## 2. Destinație goală

```bash
sudo -u postgres createdb --owner=library_owner library_restore
```

Dacă baza există deja, oprește-te și verifică ce conține. Scriptul nu șterge baza și nu suprascrie automat tabele existente.

## 3. Restaurare

Înlocuiește numele de mai jos cu fișierul afișat la export:

```bash
bash restore.sh backups/NUMELE_FISIERULUI.dump
psql -h 127.0.0.1 -U library_owner -d library_restore -c 'SELECT * FROM carti ORDER BY id;'
```

Rezultat: `Verificari OK`, apoi cele patru cărți. Restaurarea este atomică: o eroare anulează importul. Opțiunile `--no-owner --no-privileges` fac ca obiectele să fie deținute de utilizatorul restaurării, fără a recrea permisiunile originale.

Verificarea numărului de rânduri este un test introductiv, nu o comparație exhaustivă. Pentru date reale verifică și conținutul, aplicația, rolurile și posibilitatea de restaurare pe alt server.

Un backup ținut doar pe aceeași VM nu protejează împotriva pierderii VM-ului. Copiază arhiva într-un spațiu separat, protejat. Nu publica backup-uri în GitHub.
