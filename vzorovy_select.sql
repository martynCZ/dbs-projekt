-- ============================================================
-- Vzorový dotaz
-- Zadání: Pro školy, kterým v následujících 60 dnech končí placená
--         licence, vypište kontakt, počet končících licencí, kolik
--         dní zbývá do konce té nejbližší, kolik počítačů běží na
--         starší než nejnovější verzi programu, dluh po splatnosti
--         a počet nevyřešených požadavků.
-- Otázka uživatele: Komu mám volat kvůli obnově licence a co s ním
--                   musím vyřešit?
-- ============================================================

SET search_path TO licence;

SELECT z.nazev AS skola,
       z.kontakt,
       z.telefon,
       COUNT(DISTINCT l.licence_id) AS koncicich_licenci,
       MIN(l.plati_do) - CURRENT_DATE AS zbyva_dni,
       SUM(CASE WHEN v.vydano < (SELECT MAX(vydano) FROM verze_programu)
                THEN 1 ELSE 0 END) AS na_stare_verzi,
       (
           SELECT COALESCE(SUM(f.celkem), 0)
           FROM faktury f
           WHERE f.zakaznik_id = z.zakaznik_id
             AND f.stav = 'vystavena'
             AND f.splatnost < CURRENT_DATE
       ) AS dluh_kc,
       (
           SELECT COUNT(*)
           FROM zakaznik_zaznamy zz
           WHERE zz.zakaznik_id = z.zakaznik_id
             AND zz.druh = 'pozadavek'
             AND zz.vyreseno IS NULL
       ) AS otevrene_pozadavky
FROM zakaznici z
JOIN licence l ON l.zakaznik_id = z.zakaznik_id
LEFT JOIN aktivace a ON a.licence_id = l.licence_id AND a.vyrazeno IS NULL
LEFT JOIN verze_programu v ON v.verze = a.verze_konzole
WHERE l.zruseno = FALSE
  AND l.archivovano IS NULL
  AND l.edice <> 'trial'
  AND l.plati_do BETWEEN CURRENT_DATE AND CURRENT_DATE + 60
GROUP BY z.zakaznik_id, z.nazev, z.kontakt, z.telefon
ORDER BY zbyva_dni;
