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

Testul izolat a folosit autentificare locală fără parolă în director privat; autentificarea TCP cu parolă din ghid trebuie verificată de cursant pe propria instalare. Nu este configurată încă integrarea continuă în GitHub Actions.
