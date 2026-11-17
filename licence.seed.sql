-- Vzorová data. Spouští se po licence.sql.
-- Datumy jsou relativní k CURRENT_DATE, aby vzorový dotaz dával stejný výsledek
-- v kterýkoliv den, kdy se databáze vytvoří.

INSERT INTO licence.zakaznici
    (zakaznik_id, nazev, ico, adresa, email, kontakt, telefon, stav, ozvat_se, vytvoreno)
VALUES
    (1, 'ZŠ Lipová, Ostrava', '71234501', 'Lipová 12, 708 00 Ostrava',
        'info@zslipova.example.cz', 'Petr Novák', '+420 601 111 001', 'plati', CURRENT_DATE + 5, now() - interval '360 days'),
    (2, 'Gymnázium Na Kopci, Opava', '71234502', 'Na Kopci 3, 746 01 Opava',
        'sekretariat@gnk.example.cz', 'Martin Svoboda', '+420 602 222 001', 'plati', NULL, now() - interval '700 days'),
    (3, 'SPŠ Havířov', '71234503', 'Technická 45, 736 01 Havířov',
        'spsh@spsh.example.cz', 'Tomáš Černý', '+420 603 333 001', 'plati', NULL, now() - interval '170 days'),
    (4, 'ZŠ Pod Lesem, Frýdek-Místek', '71234504', 'Pod Lesem 8, 738 01 Frýdek-Místek',
        'skola@zspodlesem.example.cz', 'Lucie Procházková', '+420 604 444 001', 'plati', NULL, now() - interval '320 days');

INSERT INTO licence.verze_programu (verze, odkaz, poznamky, vydano)
VALUES
    ('1.6.0', 'https://example.cz/stazeni/program-1.6.0.msi', 'Nový způsob aktivace licence.', now() - interval '300 days'),
    ('1.7.0', 'https://example.cz/stazeni/program-1.7.0.msi', 'Instalace přes MSI balíček.',    now() - interval '160 days'),
    ('1.7.6', 'https://example.cz/stazeni/program-1.7.6.msi', 'Opravy chyb a zrychlení.',       now() - interval '60 days'),
    ('1.7.8', 'https://example.cz/stazeni/program-1.7.8.msi', 'Nové funkce a opravy chyb.',     now() - interval '10 days');

INSERT INTO licence.licence
    (licence_id, zakaznik_id, kod, popisek, edice, max_stanic, plati_do, vytvoreno)
VALUES
    (1, 1, 'RSTR-7K4M-9XQP-2B8T', 'Budova A – 1',    'pro',   30, CURRENT_DATE + 25,  now() - interval '340 days'),
    (2, 1, 'RSTR-3HDR-W5NC-8FZA', 'Budova A – 2',    'pro',   30, CURRENT_DATE + 25,  now() - interval '340 days'),
    (3, 1, 'RSTR-Q6TJ-2MXE-H9VB', 'Budova B',        'basic', 20, CURRENT_DATE + 25,  now() - interval '340 days'),
    (4, 2, 'RSTR-K8PW-4RZN-7CDE', 'Pavilon B – 204', 'pro',   30, CURRENT_DATE + 40,  now() - interval '690 days'),
    (5, 2, 'RSTR-5GYT-M3QH-B2XK', 'Pavilon B – 205', 'pro',   30, CURRENT_DATE + 40,  now() - interval '690 days'),
    (6, 3, 'RSTR-W9CF-6NPA-T4RJ', 'Dílny 1',         'pro',   30, CURRENT_DATE + 200, now() - interval '165 days'),
    (7, 3, 'RSTR-H2VE-8KDM-Z5QG', 'Dílny 2',         'pro',   30, CURRENT_DATE + 200, now() - interval '165 days'),
    (8, 4, 'RSTR-T6RK-5WCN-J8VH', 'Hlavní budova',   'pro',   30, CURRENT_DATE + 55,  now() - interval '310 days'),
    (9, 4, 'RSTR-B3ZP-7EXQ-M4KF', 'Přístavba',       'basic', 20, CURRENT_DATE + 55,  now() - interval '310 days');

-- machine_id je otisk počítače (32 hex znaků); v ukázce md5 z popisu stroje.
-- Aktivace 4 je starý počítač, který škola vyměnila (vyrazeno).
-- Aktivace 8 nehlásí verzi (licence nahraná ze souboru, bez internetu).
INSERT INTO licence.aktivace
    (aktivace_id, licence_id, machine_id, poradi, prvni_vydani, posledni, vyrazeno, hlaseno, verze_konzole, hlasenych_stanic)
VALUES
    (1,  1, md5('lipova-a1'),      1, now() - interval '340 days', now() - interval '1 day',   NULL,                       now() - interval '1 day', '1.7.0', 24),
    (2,  2, md5('lipova-a2'),      1, now() - interval '340 days', now() - interval '1 day',   NULL,                       now() - interval '1 day', '1.7.0', 20),
    (3,  3, md5('lipova-b'),       1, now() - interval '340 days', now() - interval '2 days',  NULL,                       now() - interval '2 days', '1.7.8', 16),
    (4,  4, md5('kopec-204-stary'),1, now() - interval '690 days', now() - interval '120 days', now() - interval '120 days', now() - interval '120 days', '1.6.0', 30),
    (5,  4, md5('kopec-204-novy'), 2, now() - interval '120 days', now() - interval '1 day',   NULL,                       now() - interval '1 day', '1.7.8', 30),
    (6,  5, md5('kopec-205'),      1, now() - interval '690 days', now() - interval '1 day',   NULL,                       now() - interval '1 day', '1.7.8', 28),
    (7,  6, md5('spsh-dilny-1'),   1, now() - interval '165 days', now() - interval '1 day',   NULL,                       now() - interval '1 day', '1.7.6', 18),
    (8,  7, md5('spsh-dilny-2'),   1, now() - interval '165 days', now() - interval '30 days', NULL,                       NULL,                     NULL,    NULL),
    (9,  8, md5('podlesem-hlavni'),1, now() - interval '310 days', now() - interval '1 day',   NULL,                       now() - interval '1 day', '1.6.0', 25),
    (10, 9, md5('podlesem-pristavba'),1, now() - interval '310 days', now() - interval '1 day', NULL,                      now() - interval '1 day', '1.7.8', 15);

INSERT INTO licence.zakaznik_zaznamy (zaznam_id, zakaznik_id, kdy, druh, text, vyreseno)
VALUES
    (1, 1, now() - interval '30 days', 'poznamka',  'Ředitelka chce nabídku na čtvrtou licenci.', NULL),
    (2, 1, now() - interval '6 days',  'pozadavek', 'Po aktualizaci Windows program na 3 počítačích nenaběhne.', NULL),
    (3, 1, now() - interval '2 days',  'pozadavek', 'Program po nastavení proxy nevidí licenční server.', NULL),
    (4, 2, now() - interval '20 days', 'pozadavek', 'Jak převést vlastní nastavení při přechodu na 1.7.8?', now() - interval '13 days'),
    (5, 4, now() - interval '1 day',   'pozadavek', 'Po výměně počítače nejde aktivovat licenci.', NULL);

INSERT INTO licence.faktury
    (faktura_id, cislo, zakaznik_id, odb_nazev, odb_ico, popis, vystaveno, splatnost, celkem, stav, zaplaceno, stornovano)
VALUES
    (1, '20250002', 2, 'Gymnázium Na Kopci, Opava',   '71234502', 'Licence – 2 instalace, 1 rok',
        CURRENT_DATE - 690, CURRENT_DATE - 676, 5976, 'zaplacena', CURRENT_DATE - 680, NULL),
    (2, '20250029', 2, 'Gymnázium Na Kopci, Opava',   '71234502', 'Prodloužení licence – 2 instalace, 1 rok',
        CURRENT_DATE - 325, CURRENT_DATE - 311, 5976, 'zaplacena', CURRENT_DATE - 315, NULL),
    (3, '20250031', 1, 'ZŠ Lipová, Ostrava',          '71234501', 'Licence – 3 instalace, 1 rok',
        CURRENT_DATE - 340, CURRENT_DATE - 326, 8964, 'zaplacena', CURRENT_DATE - 330, NULL),
    (4, '20250035', 4, 'ZŠ Pod Lesem, Frýdek-Místek', '71234504', 'Licence – 2 instalace, 1 rok',
        CURRENT_DATE - 310, CURRENT_DATE - 296, 5976, 'zaplacena', CURRENT_DATE - 290, NULL),
    (5, '20260012', 3, 'SPŠ Havířov',                 '71234503', 'Licence – 2 instalace, 1 rok',
        CURRENT_DATE - 165, CURRENT_DATE - 151, 5976, 'zaplacena', CURRENT_DATE - 150, NULL),
    (6, '20260038', 4, 'ZŠ Pod Lesem, Frýdek-Místek', '71234504', 'Školení obsluhy (2 h)',
        CURRENT_DATE - 50,  CURRENT_DATE - 36,  2400, 'vystavena', NULL, NULL),
    (7, '20260040', 1, 'ZŠ Lipová, Ostrava',          '71234501', 'Servisní zásah na místě',
        CURRENT_DATE - 40,  CURRENT_DATE - 26,  1800, 'vystavena', NULL, NULL),
    (8, '20260041', 3, 'SPŠ Havířov',                 '71234503', 'Servisní zásah (chybně vystaveno)',
        CURRENT_DATE - 100, CURRENT_DATE - 86,  1500, 'stornovana', NULL, now() - interval '95 days');

-- Předpisy plateb: každá licence a každé období má svůj řádek.
-- Licence 4 a 5 mají dva předpisy (založení a prodloužení) na dvou fakturách.
INSERT INTO licence.platby
    (platba_id, licence_id, faktura_id, vznik, duvod, plati_do, castka, stav, zaplaceno)
VALUES
    (1,  1, 3, now() - interval '340 days', 'zalozeni',    CURRENT_DATE + 25,  2988, 'zaplaceno', CURRENT_DATE - 330),
    (2,  2, 3, now() - interval '340 days', 'zalozeni',    CURRENT_DATE + 25,  2988, 'zaplaceno', CURRENT_DATE - 330),
    (3,  3, 3, now() - interval '340 days', 'zalozeni',    CURRENT_DATE + 25,  2988, 'zaplaceno', CURRENT_DATE - 330),
    (4,  4, 1, now() - interval '690 days', 'zalozeni',    CURRENT_DATE - 325, 2988, 'zaplaceno', CURRENT_DATE - 680),
    (5,  5, 1, now() - interval '690 days', 'zalozeni',    CURRENT_DATE - 325, 2988, 'zaplaceno', CURRENT_DATE - 680),
    (6,  4, 2, now() - interval '325 days', 'prodlouzeni', CURRENT_DATE + 40,  2988, 'zaplaceno', CURRENT_DATE - 315),
    (7,  5, 2, now() - interval '325 days', 'prodlouzeni', CURRENT_DATE + 40,  2988, 'zaplaceno', CURRENT_DATE - 315),
    (8,  6, 5, now() - interval '165 days', 'zalozeni',    CURRENT_DATE + 200, 2988, 'zaplaceno', CURRENT_DATE - 150),
    (9,  7, 5, now() - interval '165 days', 'zalozeni',    CURRENT_DATE + 200, 2988, 'zaplaceno', CURRENT_DATE - 150),
    (10, 8, 4, now() - interval '310 days', 'zalozeni',    CURRENT_DATE + 55,  2988, 'zaplaceno', CURRENT_DATE - 290),
    (11, 9, 4, now() - interval '310 days', 'zalozeni',    CURRENT_DATE + 55,  2988, 'zaplaceno', CURRENT_DATE - 290);

-- Pohyby z banky. 105 přišel bez VS a byl spárován ručně.
-- 107 je platba faktury 20260040 se špatným VS – zatím nespárovaná.
-- 108 se systému netýká (soukromá platba).
INSERT INTO licence.pohyby
    (pohyb_id, stazeno, datum, castka, vs, protiucet, kod_banky, nazev_protiuctu, stav, faktura_id, sparovano, samo)
VALUES
    (26100000102, now() - interval '680 days', CURRENT_DATE - 680, 5976.00, '20250002', '2200112233', '2010', 'Gymnázium Na Kopci', 'sparovano', 1, now() - interval '680 days', true),
    (26100000103, now() - interval '315 days', CURRENT_DATE - 315, 5976.00, '20250029', '2200112233', '2010', 'Gymnázium Na Kopci', 'sparovano', 2, now() - interval '315 days', true),
    (26100000104, now() - interval '330 days', CURRENT_DATE - 330, 8964.00, '20250031', '123456789',  '0800', 'ZŠ Lipová',          'sparovano', 3, now() - interval '330 days', true),
    (26100000105, now() - interval '290 days', CURRENT_DATE - 290, 5976.00, NULL,       '987654321',  '0100', 'ZŠ Pod Lesem',       'sparovano', 4, now() - interval '289 days', false),
    (26100000106, now() - interval '150 days', CURRENT_DATE - 150, 5976.00, '20260012', '192000145',  '0800', 'SPŠ Havířov',        'sparovano', 5, now() - interval '150 days', true),
    (26100000107, now() - interval '20 days',  CURRENT_DATE - 20,  1800.00, '20260004', '123456789',  '0800', 'ZŠ Lipová',          'nove',      NULL, NULL, NULL),
    (26100000108, now() - interval '12 days',  CURRENT_DATE - 12,   150.00, NULL,       '555000111',  '2010', 'Jan Dvořák',         'nepatri',   NULL, NULL, NULL);

-- Posune identity sekvence za explicitně vložená ID, aby další INSERT bez ID nekolidoval.
SELECT setval(pg_get_serial_sequence('licence.zakaznici', 'zakaznik_id'),
              (SELECT max(zakaznik_id) FROM licence.zakaznici));
SELECT setval(pg_get_serial_sequence('licence.licence', 'licence_id'),
              (SELECT max(licence_id) FROM licence.licence));
SELECT setval(pg_get_serial_sequence('licence.aktivace', 'aktivace_id'),
              (SELECT max(aktivace_id) FROM licence.aktivace));
SELECT setval(pg_get_serial_sequence('licence.zakaznik_zaznamy', 'zaznam_id'),
              (SELECT max(zaznam_id) FROM licence.zakaznik_zaznamy));
SELECT setval(pg_get_serial_sequence('licence.faktury', 'faktura_id'),
              (SELECT max(faktura_id) FROM licence.faktury));
SELECT setval(pg_get_serial_sequence('licence.platby', 'platba_id'),
              (SELECT max(platba_id) FROM licence.platby));
