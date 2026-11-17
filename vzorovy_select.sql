-- Komu mám volat kvůli obnově licence a co s ním musím vyřešit?
-- Pro školy, kterým v nejbližších N dnech končí placená licence, vypíše
-- kontakt, počet končících licencí, počet aktivních počítačů na starší
-- verzi, dluh po splatnosti a nevyřešené požadavky.
-- Pro jiné období změňte hodnotu dni v CTE obdobi.
WITH obdobi AS (
    SELECT 60::integer AS dni
),
nejnovejsi AS (
    SELECT verze
    FROM licence.verze_programu
    ORDER BY vydano DESC
    LIMIT 1
),
koncici AS (
    SELECT
        lic.zakaznik_id,
        count(*) AS koncicich_licenci,
        min(lic.plati_do) AS nejblizsi_konec
    FROM licence.licence AS lic
    CROSS JOIN obdobi AS o
    WHERE NOT lic.zruseno
      AND lic.archivovano IS NULL
      AND lic.edice <> 'trial'
      AND lic.plati_do BETWEEN CURRENT_DATE AND CURRENT_DATE + o.dni
    GROUP BY lic.zakaznik_id
),
stare_verze AS (
    SELECT
        lic.zakaznik_id,
        count(*) AS na_stare_verzi
    FROM licence.aktivace AS akt
    JOIN licence.licence AS lic ON lic.licence_id = akt.licence_id
    JOIN licence.verze_programu AS ver ON ver.verze = akt.verze_konzole
    CROSS JOIN nejnovejsi AS n
    WHERE akt.vyrazeno IS NULL
      AND NOT lic.zruseno
      AND lic.archivovano IS NULL
      AND ver.verze <> n.verze
    GROUP BY lic.zakaznik_id
),
dluh AS (
    SELECT
        fak.zakaznik_id,
        sum(fak.celkem) AS dluh_kc
    FROM licence.faktury AS fak
    WHERE fak.stav = 'vystavena'
      AND fak.splatnost < CURRENT_DATE
    GROUP BY fak.zakaznik_id
),
pozadavky AS (
    SELECT
        zaz.zakaznik_id,
        count(*) AS otevrene
    FROM licence.zakaznik_zaznamy AS zaz
    WHERE zaz.druh = 'pozadavek'
      AND zaz.vyreseno IS NULL
    GROUP BY zaz.zakaznik_id
)
SELECT
    zak.nazev AS skola,
    zak.kontakt,
    zak.telefon,
    k.koncicich_licenci,
    k.nejblizsi_konec,
    k.nejblizsi_konec - CURRENT_DATE AS zbyva_dni,
    coalesce(sv.na_stare_verzi, 0) AS na_stare_verzi,
    coalesce(d.dluh_kc, 0) AS dluh_kc,
    coalesce(p.otevrene, 0) AS otevrene_pozadavky
FROM koncici AS k
JOIN licence.zakaznici AS zak ON zak.zakaznik_id = k.zakaznik_id
LEFT JOIN stare_verze AS sv ON sv.zakaznik_id = zak.zakaznik_id
LEFT JOIN dluh AS d ON d.zakaznik_id = zak.zakaznik_id
LEFT JOIN pozadavky AS p ON p.zakaznik_id = zak.zakaznik_id
ORDER BY zbyva_dni;
