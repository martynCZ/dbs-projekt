-- Vzorová data. Spouští se po licence.sql.
-- Datumy jsou počítané od dnešního dne (CURRENT_DATE), aby vzorový dotaz
-- vracel stejný výsledek v kterýkoliv den, kdy se databáze vytvoří.

SET search_path TO licence;


-- Školy
INSERT INTO zakaznici (zakaznik_id, nazev, ico, adresa, email, kontakt, telefon, stav, ozvat_se, vytvoreno)
VALUES
    (1, 'ZŠ Lipová, Ostrava',          '71234501', 'Lipová 12, 708 00 Ostrava',         'info@zslipova.example.cz',    'Petr Novák',        '+420 601 111 001', 'plati', CURRENT_DATE + 5, CURRENT_DATE - 360),
    (2, 'Gymnázium Na Kopci, Opava',   '71234502', 'Na Kopci 3, 746 01 Opava',          'sekretariat@gnk.example.cz',  'Martin Svoboda',    '+420 602 222 001', 'plati', NULL,             CURRENT_DATE - 700),
    (3, 'SPŠ Havířov',                 '71234503', 'Technická 45, 736 01 Havířov',      'spsh@spsh.example.cz',        'Tomáš Černý',       '+420 603 333 001', 'plati', NULL,             CURRENT_DATE - 170),
    (4, 'ZŠ Pod Lesem, Frýdek-Místek', '71234504', 'Pod Lesem 8, 738 01 Frýdek-Místek', 'skola@zspodlesem.example.cz', 'Lucie Procházková', '+420 604 444 001', 'plati', NULL,             CURRENT_DATE - 320);

-- Verze programu (nejnovější je 1.7.8)
INSERT INTO verze_programu (verze, odkaz, poznamky, vydano)
VALUES
    ('1.6.0', 'https://example.cz/stazeni/program-1.6.0.msi', 'Nový způsob aktivace licence.', CURRENT_DATE - 300),
    ('1.7.0', 'https://example.cz/stazeni/program-1.7.0.msi', 'Instalace přes MSI balíček.',    CURRENT_DATE - 160),
    ('1.7.6', 'https://example.cz/stazeni/program-1.7.6.msi', 'Opravy chyb a zrychlení.',       CURRENT_DATE - 60),
    ('1.7.8', 'https://example.cz/stazeni/program-1.7.8.msi', 'Nové funkce a opravy chyb.',     CURRENT_DATE - 10);

-- Licence
INSERT INTO licence (licence_id, zakaznik_id, kod, popisek, edice, max_stanic, plati_do, vytvoreno)
VALUES
    (1, 1, 'RSTR-7K4M-9XQP-2B8T', 'Budova A – 1',    'pro',   30, CURRENT_DATE + 25,  CURRENT_DATE - 340),
    (2, 1, 'RSTR-3HDR-W5NC-8FZA', 'Budova A – 2',    'pro',   30, CURRENT_DATE + 25,  CURRENT_DATE - 340),
    (3, 1, 'RSTR-Q6TJ-2MXE-H9VB', 'Budova B',        'basic', 20, CURRENT_DATE + 25,  CURRENT_DATE - 340),
    (4, 2, 'RSTR-K8PW-4RZN-7CDE', 'Pavilon B – 204', 'pro',   30, CURRENT_DATE + 40,  CURRENT_DATE - 690),
    (5, 2, 'RSTR-5GYT-M3QH-B2XK', 'Pavilon B – 205', 'pro',   30, CURRENT_DATE + 40,  CURRENT_DATE - 690),
    (6, 3, 'RSTR-W9CF-6NPA-T4RJ', 'Dílny 1',         'pro',   30, CURRENT_DATE + 200, CURRENT_DATE - 165),
    (7, 3, 'RSTR-H2VE-8KDM-Z5QG', 'Dílny 2',         'pro',   30, CURRENT_DATE + 200, CURRENT_DATE - 165),
    (8, 4, 'RSTR-T6RK-5WCN-J8VH', 'Hlavní budova',   'pro',   30, CURRENT_DATE + 55,  CURRENT_DATE - 310),
    (9, 4, 'RSTR-B3ZP-7EXQ-M4KF', 'Přístavba',       'basic', 20, CURRENT_DATE + 55,  CURRENT_DATE - 310);

-- Aktivace
-- Aktivace 4 je starý počítač, který škola vyměnila (vyrazeno).
-- Aktivace 8 nehlásí verzi (licence nahraná ze souboru, bez internetu).
INSERT INTO aktivace (aktivace_id, licence_id, machine_id, poradi, prvni_vydani, posledni, vyrazeno, hlaseno, verze_konzole, hlasenych_stanic)
VALUES
    (1,  1, 'PC-LIPOVA-A1',        1, CURRENT_DATE - 340, CURRENT_DATE - 1,   NULL,               CURRENT_DATE - 1,   '1.7.0', 24),
    (2,  2, 'PC-LIPOVA-A2',        1, CURRENT_DATE - 340, CURRENT_DATE - 1,   NULL,               CURRENT_DATE - 1,   '1.7.0', 20),
    (3,  3, 'PC-LIPOVA-B',         1, CURRENT_DATE - 340, CURRENT_DATE - 2,   NULL,               CURRENT_DATE - 2,   '1.7.8', 16),
    (4,  4, 'PC-KOPEC-204-STARY',  1, CURRENT_DATE - 690, CURRENT_DATE - 120, CURRENT_DATE - 120, CURRENT_DATE - 120, '1.6.0', 30),
    (5,  4, 'PC-KOPEC-204-NOVY',   2, CURRENT_DATE - 120, CURRENT_DATE - 1,   NULL,               CURRENT_DATE - 1,   '1.7.8', 30),
    (6,  5, 'PC-KOPEC-205',        1, CURRENT_DATE - 690, CURRENT_DATE - 1,   NULL,               CURRENT_DATE - 1,   '1.7.8', 28),
    (7,  6, 'PC-SPSH-DILNY-1',     1, CURRENT_DATE - 165, CURRENT_DATE - 1,   NULL,               CURRENT_DATE - 1,   '1.7.6', 18),
    (8,  7, 'PC-SPSH-DILNY-2',     1, CURRENT_DATE - 165, CURRENT_DATE - 30,  NULL,               NULL,               NULL,    NULL),
    (9,  8, 'PC-PODLESEM-HLAVNI',  1, CURRENT_DATE - 310, CURRENT_DATE - 1,   NULL,               CURRENT_DATE - 1,   '1.6.0', 25),
    (10, 9, 'PC-PODLESEM-PRISTAV', 1, CURRENT_DATE - 310, CURRENT_DATE - 1,   NULL,               CURRENT_DATE - 1,   '1.7.8', 15);

-- Poznámky a požadavky škol
INSERT INTO zakaznik_zaznamy (zaznam_id, zakaznik_id, kdy, druh, text, vyreseno)
VALUES
    (1, 1, CURRENT_DATE - 30, 'poznamka',  'Ředitelka chce nabídku na čtvrtou licenci.',                NULL),
    (2, 1, CURRENT_DATE - 6,  'pozadavek', 'Po aktualizaci Windows program na 3 počítačích nenaběhne.', NULL),
    (3, 1, CURRENT_DATE - 2,  'pozadavek', 'Program po nastavení proxy nevidí licenční server.',        NULL),
    (4, 2, CURRENT_DATE - 20, 'pozadavek', 'Jak převést vlastní nastavení při přechodu na 1.7.8?',      CURRENT_DATE - 13),
    (5, 4, CURRENT_DATE - 1,  'pozadavek', 'Po výměně počítače nejde aktivovat licenci.',               NULL);

-- Faktury (splatnost 14 dní)
INSERT INTO faktury (faktura_id, cislo, zakaznik_id, odb_nazev, odb_ico, popis, vystaveno, splatnost, celkem, stav, zaplaceno, stornovano)
VALUES
    (1, '20250002', 2, 'Gymnázium Na Kopci, Opava',   '71234502', 'Licence – 2 instalace, 1 rok',             CURRENT_DATE - 690, CURRENT_DATE - 676, 5976, 'zaplacena',  CURRENT_DATE - 680, NULL),
    (2, '20250029', 2, 'Gymnázium Na Kopci, Opava',   '71234502', 'Prodloužení licence – 2 instalace, 1 rok', CURRENT_DATE - 325, CURRENT_DATE - 311, 5976, 'zaplacena',  CURRENT_DATE - 315, NULL),
    (3, '20250031', 1, 'ZŠ Lipová, Ostrava',          '71234501', 'Licence – 3 instalace, 1 rok',             CURRENT_DATE - 340, CURRENT_DATE - 326, 8964, 'zaplacena',  CURRENT_DATE - 330, NULL),
    (4, '20250035', 4, 'ZŠ Pod Lesem, Frýdek-Místek', '71234504', 'Licence – 2 instalace, 1 rok',             CURRENT_DATE - 310, CURRENT_DATE - 296, 5976, 'zaplacena',  CURRENT_DATE - 290, NULL),
    (5, '20260012', 3, 'SPŠ Havířov',                 '71234503', 'Licence – 2 instalace, 1 rok',             CURRENT_DATE - 165, CURRENT_DATE - 151, 5976, 'zaplacena',  CURRENT_DATE - 150, NULL),
    (6, '20260038', 4, 'ZŠ Pod Lesem, Frýdek-Místek', '71234504', 'Školení obsluhy (2 h)',                    CURRENT_DATE - 50,  CURRENT_DATE - 36,  2400, 'vystavena',  NULL,               NULL),
    (7, '20260040', 1, 'ZŠ Lipová, Ostrava',          '71234501', 'Servisní zásah na místě',                  CURRENT_DATE - 40,  CURRENT_DATE - 26,  1800, 'vystavena',  NULL,               NULL),
    (8, '20260041', 3, 'SPŠ Havířov',                 '71234503', 'Servisní zásah (chybně vystaveno)',        CURRENT_DATE - 100, CURRENT_DATE - 86,  1500, 'stornovana', NULL,               CURRENT_DATE - 95);

-- Předpisy plateb (každá licence a každé období má svůj řádek)
-- Licence 4 a 5 mají dva předpisy (založení a prodloužení) na dvou fakturách.
INSERT INTO platby (platba_id, licence_id, faktura_id, vznik, duvod, plati_do, castka, stav, zaplaceno)
VALUES
    (1,  1, 3, CURRENT_DATE - 340, 'zalozeni',    CURRENT_DATE + 25,  2988, 'zaplaceno', CURRENT_DATE - 330),
    (2,  2, 3, CURRENT_DATE - 340, 'zalozeni',    CURRENT_DATE + 25,  2988, 'zaplaceno', CURRENT_DATE - 330),
    (3,  3, 3, CURRENT_DATE - 340, 'zalozeni',    CURRENT_DATE + 25,  2988, 'zaplaceno', CURRENT_DATE - 330),
    (4,  4, 1, CURRENT_DATE - 690, 'zalozeni',    CURRENT_DATE - 325, 2988, 'zaplaceno', CURRENT_DATE - 680),
    (5,  5, 1, CURRENT_DATE - 690, 'zalozeni',    CURRENT_DATE - 325, 2988, 'zaplaceno', CURRENT_DATE - 680),
    (6,  4, 2, CURRENT_DATE - 325, 'prodlouzeni', CURRENT_DATE + 40,  2988, 'zaplaceno', CURRENT_DATE - 315),
    (7,  5, 2, CURRENT_DATE - 325, 'prodlouzeni', CURRENT_DATE + 40,  2988, 'zaplaceno', CURRENT_DATE - 315),
    (8,  6, 5, CURRENT_DATE - 165, 'zalozeni',    CURRENT_DATE + 200, 2988, 'zaplaceno', CURRENT_DATE - 150),
    (9,  7, 5, CURRENT_DATE - 165, 'zalozeni',    CURRENT_DATE + 200, 2988, 'zaplaceno', CURRENT_DATE - 150),
    (10, 8, 4, CURRENT_DATE - 310, 'zalozeni',    CURRENT_DATE + 55,  2988, 'zaplaceno', CURRENT_DATE - 290),
    (11, 9, 4, CURRENT_DATE - 310, 'zalozeni',    CURRENT_DATE + 55,  2988, 'zaplaceno', CURRENT_DATE - 290);

-- Pohyby z banky
-- 105 přišel bez VS a byl spárován ručně.
-- 107 je platba faktury 20260040 se špatným VS – zatím nespárovaná.
-- 108 se systému netýká (soukromá platba).
INSERT INTO pohyby (pohyb_id, datum, castka, vs, protiucet, kod_banky, nazev_protiuctu, stav, faktura_id, sparovano, samo)
VALUES
    (26100000102, CURRENT_DATE - 680, 5976.00, '20250002', '2200112233', '2010', 'Gymnázium Na Kopci', 'sparovano', 1,    CURRENT_DATE - 680, TRUE),
    (26100000103, CURRENT_DATE - 315, 5976.00, '20250029', '2200112233', '2010', 'Gymnázium Na Kopci', 'sparovano', 2,    CURRENT_DATE - 315, TRUE),
    (26100000104, CURRENT_DATE - 330, 8964.00, '20250031', '123456789',  '0800', 'ZŠ Lipová',          'sparovano', 3,    CURRENT_DATE - 330, TRUE),
    (26100000105, CURRENT_DATE - 290, 5976.00, NULL,       '987654321',  '0100', 'ZŠ Pod Lesem',       'sparovano', 4,    CURRENT_DATE - 289, FALSE),
    (26100000106, CURRENT_DATE - 150, 5976.00, '20260012', '192000145',  '0800', 'SPŠ Havířov',        'sparovano', 5,    CURRENT_DATE - 150, TRUE),
    (26100000107, CURRENT_DATE - 20,  1800.00, '20260004', '123456789',  '0800', 'ZŠ Lipová',          'nove',      NULL, NULL,               NULL),
    (26100000108, CURRENT_DATE - 12,   150.00, NULL,       '555000111',  '2010', 'Jan Dvořák',         'nepatri',   NULL, NULL,               NULL);


-- Posunutí čítačů ID za ručně vložená ID, aby další INSERT bez ID nekolidoval
SELECT setval(pg_get_serial_sequence('zakaznici', 'zakaznik_id'), (SELECT MAX(zakaznik_id) FROM zakaznici));
SELECT setval(pg_get_serial_sequence('licence', 'licence_id'), (SELECT MAX(licence_id) FROM licence));
SELECT setval(pg_get_serial_sequence('aktivace', 'aktivace_id'), (SELECT MAX(aktivace_id) FROM aktivace));
SELECT setval(pg_get_serial_sequence('zakaznik_zaznamy', 'zaznam_id'), (SELECT MAX(zaznam_id) FROM zakaznik_zaznamy));
SELECT setval(pg_get_serial_sequence('faktury', 'faktura_id'), (SELECT MAX(faktura_id) FROM faktury));
SELECT setval(pg_get_serial_sequence('platby', 'platba_id'), (SELECT MAX(platba_id) FROM platby));
