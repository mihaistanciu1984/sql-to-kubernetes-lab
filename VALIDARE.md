# Validarea primei versiuni

Verificat la 15 octombrie 2026 pe Ubuntu 24.04, PostgreSQL 16.15, într-o instanță temporară separată de bazele existente, accesibilă numai prin socket Unix local.

| Verificare | Rezultat |
|---|---|
| Inițializare atomică schema.sql + seed.sql | Trecut |
| verify.sql pe datele inițiale | Trecut |
| Soluțiile 1–9 și anularea tranzacției | Trecut |
| Respingerea celui de-al doilea împrumut activ pentru același exemplar | Trecut |
| Respingerea unui împrumut cu carte inexistentă | Trecut |
| Sintaxa Bash a scripturilor | Trecut |
| Export și restaurare într-o bază goală | Trecut |
| Verificarea setului inițial după restaurare | Trecut |
| Respingerea restaurării peste tabele existente, cu rollback | Trecut |

Testul izolat a folosit autentificare locală fără parolă în director privat. Autentificarea TCP cu parolă a fost verificată ulterior în sesiunea practică de mai jos. Nu este configurată încă integrarea continuă în GitHub Actions.

## Sesiune practică în instanța principală — 15 octombrie 2026

Rezultatele de mai jos au fost executate manual de cursant și confirmate din ieșirile terminalului transmise în sesiunea de lucru. Nu reprezintă o rulare GitHub Actions.

Au fost create separat contul `library_owner` și baza `library_lab`, apoi încărcate `schema.sql` și `seed.sql`. Conectarea TCP cu parolă a reușit.

| Exercițiu | Rezultat observat | Stare |
|---|---|---|
| 1. Toate cărțile, ordonate după ID | 4 cărți, ID 1–4 | Trecut |
| 2. Publicate din 2021 inclusiv | ID 2 și 4 | Trecut |
| 3. Cititor după email | Ana Exemplu, ID 1 | Trecut |
| 4. JOIN între cele trei tabele | 3 împrumuturi cu titlu și cititor | Trecut |
| 5. Împrumuturi active | ID 2 și 3 | Trecut |
| 6. Numărare cu LEFT JOIN | Ana: 2, Mihai: 1, Ioana: 0 | Trecut |
| 7. Exemplare disponibile | ID 3 și 4 | Trecut |
| 8. Active cu scadența înainte de 2026-01-20 | Împrumutul 2 | Trecut |
| 9. UPDATE în tranzacție, apoi ROLLBACK | Data a devenit 2026-01-20 și apoi NULL | Trecut |
| 10. Al doilea împrumut activ pentru cartea 1 | Eroare la indexul unic; după ROLLBACK rămân 2 active | Trecut |

### Backup și restaurare

`backup.sh` a creat o arhivă custom PostgreSQL. `restore.sh` a importat-o în baza separată `library_restore`, creată cu proprietarul `library_owner`. Verificarea inclusă în script a afișat:

```text
   rezultat
---------------
 Verificari OK
(1 row)
```

Acest rezultat confirmă verificările introductive din `verify.sql`, nu o comparație exhaustivă a tuturor obiectelor și permisiunilor. Arhiva și parolele nu sunt incluse în repository.

### Utilizator cu drept de citire

După crearea contului `library_reader` și acordarea permisiunilor din [lecție](PERMISIUNI.md):

- `SELECT current_user` a fost confirmat ca `library_reader`.
- `SELECT id, titlu FROM carti ORDER BY id` a returnat cele 4 cărți.
- `UPDATE carti SET titlu = 'Test permisiuni' WHERE id = 1` a returnat `ERROR: permission denied for table carti`.
- `ROLLBACK` a încheiat tranzacția; titlul inițial a rămas `SQL pas cu pas`.

Au fost verificate direct SELECT și refuzul UPDATE. INSERT, DELETE și moștenirea permisiunilor pe un tabel viitor nu au fost testate în această sesiune; comanda de configurare a privilegiilor implicite a reușit.
