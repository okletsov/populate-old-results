DROP TEMPORARY TABLE IF EXISTS tmp_missing_contest_participants_resolved;
DROP TEMPORARY TABLE IF EXISTS tmp_missing_contest_participants_nickname_map;
DROP TEMPORARY TABLE IF EXISTS tmp_missing_contest_participants_source;

CREATE TEMPORARY TABLE tmp_missing_contest_participants_source AS
    SELECT '2012' AS contest_year, 'Autumn' AS season, 'Stan' AS nickname, 50 AS entrance_fee
    UNION ALL SELECT '2012', 'Autumn', 'BeTeLGeuSe', 50
    UNION ALL SELECT '2012', 'Autumn', 'Deagle', 50
    UNION ALL SELECT '2012', 'Autumn', 'Mavri_Petalouda', 50
    UNION ALL SELECT '2013', 'Spring', 'Ajax', 100
    UNION ALL SELECT '2013', 'Spring', 'Stan87', 100
    UNION ALL SELECT '2013', 'Spring', 'zuzik', 100
    UNION ALL SELECT '2013', 'Spring', 'Ka1man', 100
    UNION ALL SELECT '2013', 'Spring', 'Cap4ik88', 100
    UNION ALL SELECT '2013', 'Spring', 'Deagle', 100
    UNION ALL SELECT '2013', 'Spring', 'BeTeLGeuSe1366', 100
    UNION ALL SELECT '2013', 'Spring', 'DNIPRO', 100
    UNION ALL SELECT '2013', 'Spring', 'arabijoni', 100
    UNION ALL SELECT '2013', 'Autumn', 'Ka1man', 100
    UNION ALL SELECT '2013', 'Autumn', 'BeTeLGeuSe', 100
    UNION ALL SELECT '2013', 'Autumn', 'Stan507', 100
    UNION ALL SELECT '2013', 'Autumn', 'Cap4ik', 100
    UNION ALL SELECT '2013', 'Autumn', 'Deagle', 100
    UNION ALL SELECT '2013', 'Autumn', 'Arsenal4ik', 100
    UNION ALL SELECT '2013', 'Autumn', 'Ajax', 100
    UNION ALL SELECT '2013', 'Autumn', 'Dnepr', 100
    UNION ALL SELECT '2013', 'Winter', 'BeTeLGeuSe', 100
    UNION ALL SELECT '2013', 'Winter', 'Ajax', 100
    UNION ALL SELECT '2013', 'Winter', 'Stan87', 100
    UNION ALL SELECT '2013', 'Winter', 'Kanonier', 100
    UNION ALL SELECT '2013', 'Winter', 'Deagle', 100
    UNION ALL SELECT '2013', 'Winter', 'Ka2man', 100
    UNION ALL SELECT '2014', 'Spring', 'Ajax', 100
    UNION ALL SELECT '2014', 'Spring', 'Gunners_Fan', 100
    UNION ALL SELECT '2014', 'Spring', 'AlegriA', 100
    UNION ALL SELECT '2014', 'Spring', 'BeTeLGeuSeWinner', 100
    UNION ALL SELECT '2014', 'Spring', 'Deagle', 100
    UNION ALL SELECT '2014', 'Spring', 'stan507', 100
    UNION ALL SELECT '2014', 'Spring', 'Gorg', 100
    UNION ALL SELECT '2014', 'Summer', 'Ajax-II', 100
    UNION ALL SELECT '2014', 'Summer', 'Ciklum', 100
    UNION ALL SELECT '2014', 'Summer', 'BetTennis', 100
    UNION ALL SELECT '2014', 'Summer', 'OrionLTD', 100
    UNION ALL SELECT '2014', 'Autumn', 'Dortmund', 100
    UNION ALL SELECT '2014', 'Autumn', 'CapUA', 100
    UNION ALL SELECT '2014', 'Autumn', 'stan507', 100
    UNION ALL SELECT '2014', 'Autumn', 'Ajax-II', 100
    UNION ALL SELECT '2014', 'Autumn', 'BeTeLCRiMea', 100
    UNION ALL SELECT '2014', 'Winter', 'Cap', 100
    UNION ALL SELECT '2014', 'Winter', 'Deagle', 100
    UNION ALL SELECT '2014', 'Winter', 'Stan', 100
    UNION ALL SELECT '2014', 'Winter', 'Vetan', 100
    UNION ALL SELECT '2014', 'Winter', 'BeTeLGeuSe', 100
    UNION ALL SELECT '2014', 'Winter', 'Vokoua', 100
    UNION ALL SELECT '2014', 'Winter', 'Ajax', 100
    UNION ALL SELECT '2015', 'Spring', 'BeTeL', 100
    UNION ALL SELECT '2015', 'Spring', 'stan507', 100
    UNION ALL SELECT '2015', 'Spring', 'AjaxSpring', 100
    UNION ALL SELECT '2015', 'Spring', 'ka1manua', 100
    UNION ALL SELECT '2015', 'Spring', 'CaPoNe', 100
    UNION ALL SELECT '2015', 'Spring', 'BasDost', 100
    UNION ALL SELECT '2015', 'Spring', 'Deagle', 100
    UNION ALL SELECT '2015', 'Summer', 'dimka300688', 100
    UNION ALL SELECT '2015', 'Summer', 'Deagle', 100
    UNION ALL SELECT '2015', 'Summer', 'stan507', 100
    UNION ALL SELECT '2015', 'Summer', 'AjaxSpring', 100
    UNION ALL SELECT '2015', 'Summer', 'ka1manua', 100
    UNION ALL SELECT '2015', 'Summer', 'BeTeL', 100
    UNION ALL SELECT '2015', 'Autumn', 'Arsii', 200
    UNION ALL SELECT '2015', 'Autumn', 'Gorg', 200
    UNION ALL SELECT '2015', 'Autumn', 'Deagle', 200
    UNION ALL SELECT '2015', 'Autumn', 'stan507', 200
    UNION ALL SELECT '2015', 'Autumn', 'ka1manua', 200
    UNION ALL SELECT '2015', 'Autumn', 'Ajax', 200
    UNION ALL SELECT '2015', 'Autumn', 'BeTeL', 200
    UNION ALL SELECT '2015', 'Winter', 'Deagle', 200
    UNION ALL SELECT '2015', 'Winter', 'Ajax', 200
    UNION ALL SELECT '2015', 'Winter', 'stan507', 200
    UNION ALL SELECT '2015', 'Winter', 'NewHorizons', 200
    UNION ALL SELECT '2015', 'Winter', 'BeTeL', 200
    UNION ALL SELECT '2015', 'Winter', 'Arsii', 200
    UNION ALL SELECT '2015', 'Winter', 'Gorg', 200
    UNION ALL SELECT '2015', 'Winter', 'ka1manua', 200
    UNION ALL SELECT '2016', 'Spring', 'ka1manua', 200
    UNION ALL SELECT '2016', 'Spring', 'BeTeL', 200
    UNION ALL SELECT '2016', 'Spring', 'Ars', 200
    UNION ALL SELECT '2016', 'Spring', 'Deagle', 200
    UNION ALL SELECT '2016', 'Spring', 'Ajax', 200
    UNION ALL SELECT '2016', 'Spring', 'Gorg', 200
    UNION ALL SELECT '2016', 'Spring', 'NewHorizons', 200
    UNION ALL SELECT '2016', 'Spring', 'Dnepr', 200
    UNION ALL SELECT '2016', 'Spring', 'Arsii', 200
    UNION ALL SELECT '2016', 'Spring', 'stan507', 200
    UNION ALL SELECT '2016', 'Spring', 'mkokorovets', 200
    UNION ALL SELECT '2016', 'Spring', 'Leicester', 200
    UNION ALL SELECT '2016', 'Spring', 'midlan', 200
    UNION ALL SELECT '2016', 'Autumn', 'Dnepr', 200
    UNION ALL SELECT '2016', 'Autumn', 'Arsii', 200
    UNION ALL SELECT '2016', 'Autumn', 'BeTeL', 200
    UNION ALL SELECT '2016', 'Autumn', 'Gorg', 200
    UNION ALL SELECT '2016', 'Autumn', 'Deagle', 200
    UNION ALL SELECT '2016', 'Autumn', 'stan507', 200
    UNION ALL SELECT '2016', 'Autumn', 'Ajax', 200
    UNION ALL SELECT '2016', 'Autumn', 'ka1manua', 200
    UNION ALL SELECT '2016', 'Autumn', 'NewHorizons', 200
    UNION ALL SELECT '2016', 'Winter', 'stan507', 200
    UNION ALL SELECT '2016', 'Winter', 'Ajax', 200
    UNION ALL SELECT '2016', 'Winter', 'Gorg', 200
    UNION ALL SELECT '2016', 'Winter', 'Arsii', 200
    UNION ALL SELECT '2016', 'Winter', 'BeTeL', 200
    UNION ALL SELECT '2016', 'Winter', 'Cap4ik', 200
    UNION ALL SELECT '2016', 'Winter', 'Deagle', 200
    UNION ALL SELECT '2016', 'Winter', 'Dnepr', 200
    UNION ALL SELECT '2016', 'Winter', 'Ars', 200
    UNION ALL SELECT '2017', 'Spring', 'Arsii', 200
    UNION ALL SELECT '2017', 'Spring', 'Cap4ik', 200
    UNION ALL SELECT '2017', 'Spring', 'Ars', 200
    UNION ALL SELECT '2017', 'Spring', 'stan507', 200
    UNION ALL SELECT '2017', 'Spring', 'BeTeL', 200
    UNION ALL SELECT '2017', 'Spring', 'Ajax', 200
    UNION ALL SELECT '2017', 'Spring', 'Dnepr', 200
    UNION ALL SELECT '2017', 'Spring', 'Gorg', 200
    UNION ALL SELECT '2017', 'Spring', 'Deagle', 200
    UNION ALL SELECT '2017', 'Spring', 'ka1manua', 200
    UNION ALL SELECT '2017', 'Autumn', 'Ars', 200
    UNION ALL SELECT '2017', 'Autumn', 'Ajax', 200
    UNION ALL SELECT '2017', 'Autumn', 'Dnepr', 200
    UNION ALL SELECT '2017', 'Autumn', 'ka1manua', 200
    UNION ALL SELECT '2017', 'Autumn', 'Arsii', 200
    UNION ALL SELECT '2017', 'Autumn', 'BeTeL', 200
    UNION ALL SELECT '2017', 'Autumn', 'stan507', 200
    UNION ALL SELECT '2017', 'Autumn', 'CapUA', 200
    UNION ALL SELECT '2017', 'Autumn', 'gorgUA', 200
    UNION ALL SELECT '2017', 'Autumn', 'Deagle', 200
    UNION ALL SELECT '2017', 'Winter', 'ka1manua', 200
    UNION ALL SELECT '2017', 'Winter', 'Ars', 200
    UNION ALL SELECT '2017', 'Winter', 'Arsii', 200
    UNION ALL SELECT '2017', 'Winter', 'Cap4ik', 200
    UNION ALL SELECT '2017', 'Winter', 'BeTeL', 200
    UNION ALL SELECT '2017', 'Winter', 'stan507', 200
    UNION ALL SELECT '2017', 'Winter', 'Dnepr', 200
    UNION ALL SELECT '2017', 'Winter', 'Ajax', 200
    UNION ALL SELECT '2018', 'Spring', 'Gorg', 200
    UNION ALL SELECT '2018', 'Spring', 'Ajax', 200
    UNION ALL SELECT '2018', 'Spring', 'Dnepr', 200
    UNION ALL SELECT '2018', 'Spring', 'BeTeL', 200
    UNION ALL SELECT '2018', 'Spring', 'Zaur', 200
    UNION ALL SELECT '2018', 'Spring', 'Ka1man', 200
    UNION ALL SELECT '2018', 'Spring', 'Deagle', 200
    UNION ALL SELECT '2018', 'Spring', 'Ars', 200
    UNION ALL SELECT '2018', 'Spring', 'Stan', 200;

CREATE TEMPORARY TABLE tmp_missing_contest_participants_nickname_map AS
SELECT
    nickname,
    MIN(user_id) AS user_id,
    COUNT(DISTINCT user_id) AS user_count
FROM user_nickname
GROUP BY nickname;

CREATE TEMPORARY TABLE tmp_missing_contest_participants_resolved AS
SELECT DISTINCT
    src.contest_year,
    src.season,
    src.nickname,
    src.entrance_fee,
    nm.user_id,
    c.id AS contest_id,
    CONCAT('Historical contest participation fee offset: ', src.contest_year, ' ', src.season) AS offset_notes
FROM tmp_missing_contest_participants_source src
JOIN tmp_missing_contest_participants_nickname_map nm
    ON nm.nickname = src.nickname
    AND nm.user_count = 1
JOIN contest c
    ON c.`type` = 'seasonal'
    AND c.`year` = src.contest_year
    AND c.season = src.season
    AND c.`month` IS NULL;

WITH contest_list AS (
    SELECT DISTINCT
        src.contest_year,
        src.season,
        c.id AS contest_id,
        CONCAT('Historical contest participation fee offset: ', src.contest_year, ' ', src.season) AS offset_notes
    FROM tmp_missing_contest_participants_source src
    JOIN contest c
        ON c.`type` = 'seasonal'
        AND c.`year` = src.contest_year
        AND c.season = src.season
        AND c.`month` IS NULL
),
source_counts AS (
    SELECT contest_year, season, COUNT(*) AS expected_source_rows
    FROM tmp_missing_contest_participants_source
    GROUP BY contest_year, season
),
resolution_counts AS (
    SELECT contest_year, season, COUNT(DISTINCT user_id) AS resolved_participants
    FROM tmp_missing_contest_participants_resolved
    GROUP BY contest_year, season
),
mapping_counts AS (
    SELECT
        src.contest_year,
        src.season,
        SUM(CASE WHEN nm.nickname IS NULL THEN 1 ELSE 0 END) AS missing_nickname_rows,
        SUM(CASE WHEN nm.user_count > 1 THEN 1 ELSE 0 END) AS ambiguous_nickname_rows
    FROM tmp_missing_contest_participants_source src
    LEFT JOIN tmp_missing_contest_participants_nickname_map nm
        ON nm.nickname = src.nickname
    GROUP BY src.contest_year, src.season
),
participation_counts AS (
    SELECT cl.contest_year, cl.season, COUNT(uscp.id) AS inserted_participation_rows
    FROM contest_list cl
    LEFT JOIN user_seasonal_contest_participation uscp
        ON uscp.contest_id = cl.contest_id
    GROUP BY cl.contest_year, cl.season
),
fee_counts AS (
    SELECT
        cl.contest_year,
        cl.season,
        COUNT(cf.id) AS entrance_fee_rows,
        COALESCE(SUM(cf.action_value), 0) AS entrance_fee_sum
    FROM contest_list cl
    LEFT JOIN cr_finance cf
        ON cf.contest_id = cl.contest_id
        AND cf.finance_action_id = 12
    GROUP BY cl.contest_year, cl.season
),
offset_counts AS (
    SELECT
        r.contest_year,
        r.season,
        COUNT(fo.id) AS offset_rows,
        COALESCE(SUM(fo.action_value), 0) AS offset_sum
    FROM tmp_missing_contest_participants_resolved r
    LEFT JOIN finance_offset fo
        ON fo.user_id = r.user_id
        AND fo.finance_action_id = 14
        AND fo.action_value = r.entrance_fee
        AND fo.notes = r.offset_notes
    GROUP BY r.contest_year, r.season
)
SELECT
    sc.contest_year,
    sc.season,
    sc.expected_source_rows,
    COALESCE(rc.resolved_participants, 0) AS resolved_participants,
    COALESCE(pc.inserted_participation_rows, 0) AS inserted_participation_rows,
    COALESCE(fc.entrance_fee_rows, 0) AS entrance_fee_rows,
    COALESCE(fc.entrance_fee_sum, 0) AS entrance_fee_sum,
    COALESCE(oc.offset_rows, 0) AS offset_rows,
    COALESCE(oc.offset_sum, 0) AS offset_sum,
    COALESCE(mc.missing_nickname_rows, 0) AS missing_nickname_rows,
    COALESCE(mc.ambiguous_nickname_rows, 0) AS ambiguous_nickname_rows
FROM source_counts sc
LEFT JOIN resolution_counts rc
    ON rc.contest_year = sc.contest_year
    AND rc.season = sc.season
LEFT JOIN participation_counts pc
    ON pc.contest_year = sc.contest_year
    AND pc.season = sc.season
LEFT JOIN fee_counts fc
    ON fc.contest_year = sc.contest_year
    AND fc.season = sc.season
LEFT JOIN offset_counts oc
    ON oc.contest_year = sc.contest_year
    AND oc.season = sc.season
LEFT JOIN mapping_counts mc
    ON mc.contest_year = sc.contest_year
    AND mc.season = sc.season
ORDER BY sc.contest_year, FIELD(sc.season, 'Spring', 'Summer', 'Autumn', 'Winter');

SELECT
    src.contest_year,
    src.season,
    src.nickname,
    CASE
        WHEN nm.nickname IS NULL THEN 'missing'
        WHEN nm.user_count > 1 THEN 'ambiguous'
        ELSE 'resolved'
    END AS mapping_status,
    nm.user_count
FROM tmp_missing_contest_participants_source src
LEFT JOIN tmp_missing_contest_participants_nickname_map nm
    ON nm.nickname = src.nickname
WHERE nm.nickname IS NULL
    OR nm.user_count > 1
ORDER BY src.contest_year, FIELD(src.season, 'Spring', 'Summer', 'Autumn', 'Winter'), src.nickname;

WITH expected_saldo AS (
    SELECT 'BeTeLGeuSe' AS nickname, 1203.09 AS expected_saldo
    UNION ALL SELECT 'Zidan98', 520.00
    UNION ALL SELECT 'Mishazakopajlo', 442.00
    UNION ALL SELECT 'DavidsKV', 83.09
    UNION ALL SELECT 'ka1manua', 0.00
    UNION ALL SELECT 'stan507', 0.00
    UNION ALL SELECT 'gorgEuro', -8.00
    UNION ALL SELECT 'Gerrard8080', -8.00
    UNION ALL SELECT 'Dnepr', -118.91
    UNION ALL SELECT 'JovtoBlakutni', -233.45
    UNION ALL SELECT 'Deagle', -387.00
    UNION ALL SELECT 'mkokorovets', -415.00
    UNION ALL SELECT 'Sayda', -466.91
    UNION ALL SELECT 'Ars', -466.91
    UNION ALL SELECT 'Cap4ik', -872.00
    UNION ALL SELECT 'Ajax', -872.00
    UNION ALL SELECT 'arabijoni', 0.00
    UNION ALL SELECT 'dimka300688', 0.00
    UNION ALL SELECT 'Leicester', 0.00
    UNION ALL SELECT 'midlan', 0.00
),
actual_saldo AS (
    SELECT
        t1.nickname,
        t1.contest_profit AS profit,
        COALESCE(t1.offset, 0) AS `offset`,
        t1.contest_profit + COALESCE(t1.offset, 0) AS saldo
    FROM (
        SELECT
            cf.user_id,
            un.nickname,
            SUM(cf.action_value) AS contest_profit,
            (
                SELECT SUM(fo.action_value)
                FROM finance_offset fo
                WHERE fo.user_id = cf.user_id
                GROUP BY fo.user_id
            ) AS `offset`
        FROM cr_finance cf
        JOIN user_nickname un
            ON un.user_id = cf.user_id
        WHERE un.is_active = 1
            AND cf.contest_id NOT IN (
                SELECT id
                FROM contest c
                WHERE c.`type` = 'seasonal'
                    AND c.is_active = 1
            )
            AND cf.contest_id NOT IN (
                SELECT sxmc.monthly_contest_id
                FROM seasonal_x_monthly_contest sxmc
                JOIN contest c2
                    ON c2.id = sxmc.seasonal_contest_id
                WHERE c2.`type` = 'seasonal'
                    AND c2.is_active = 1
            )
        GROUP BY cf.user_id, un.nickname
    ) t1
)
SELECT
    e.nickname,
    a.profit,
    a.`offset`,
    COALESCE(a.saldo, 0) AS actual_saldo,
    e.expected_saldo,
    COALESCE(a.saldo, 0) - e.expected_saldo AS saldo_delta,
    CASE WHEN a.nickname IS NULL THEN 1 ELSE 0 END AS assumed_zero_from_missing_saldo_sql
FROM expected_saldo e
LEFT JOIN actual_saldo a
    ON a.nickname = e.nickname
ORDER BY e.expected_saldo DESC, e.nickname;

DROP TEMPORARY TABLE tmp_missing_contest_participants_resolved;
DROP TEMPORARY TABLE tmp_missing_contest_participants_nickname_map;
DROP TEMPORARY TABLE tmp_missing_contest_participants_source;
