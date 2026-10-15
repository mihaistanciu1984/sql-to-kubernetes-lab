# Zece exerciții PostgreSQL

Conectează-te cu `psql -h 127.0.0.1 -U library_owner -d library_lab`.
Comenzile SQL se încheie cu `;`. Ieși cu `\q`.

Rezolvă pe datele inițiale. Pentru exercițiile care schimbă date, folosește o tranzacție și `ROLLBACK` la final.

1. Listează toate cărțile, ordonate după ID. **4 rânduri.**
2. Selectează cărțile publicate din 2021 inclusiv. **2 rânduri.**
3. Găsește cititorul cu emailul `ana@example.test`. **Ana Exemplu.**
4. Afișează titlul și numele cititorului pentru fiecare împrumut, folosind JOIN. **3 rânduri.**
5. Afișează doar împrumuturile active. **2 rânduri.**
6. Numără împrumuturile fiecărui cititor, inclusiv cei fără împrumuturi. **Ana: 2, Mihai: 1, Ioana: 0.**
7. Găsește exemplarele disponibile: fără împrumut activ. **ID 3 și 4.**
8. Găsește împrumuturile active întârziate la data fixă `2026-01-20`. **ID 2.** Folosim o dată fixă pentru rezultate reproductibile.
9. Marchează împrumutul 2 ca returnat la `2026-01-20`, verifică rezultatul, apoi anulează tranzacția. **UPDATE 1; după ROLLBACK există din nou 2 împrumuturi active.**
10. Încearcă să împrumuți cartea 1 încă o dată fără returnare. **Eroare unique constraint**, apoi `ROLLBACK`. Explică rolul indexului parțial.

Compară cu [soluțiile](solutii.sql) doar după ce ai încercat.
