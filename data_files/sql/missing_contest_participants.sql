DROP TEMPORARY TABLE IF EXISTS tmp_missing_contest_participants_resolved;
DROP TEMPORARY TABLE IF EXISTS tmp_missing_contest_participants_source;

START TRANSACTION;

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
JOIN (
    SELECT
        nickname,
        MIN(user_id) AS user_id,
        COUNT(DISTINCT user_id) AS user_count
    FROM user_nickname
    GROUP BY nickname
) nm
    ON nm.nickname = src.nickname
    AND nm.user_count = 1
JOIN contest c
    ON c.`type` = 'seasonal'
    AND c.`year` = src.contest_year
    AND c.season = src.season
    AND c.`month` IS NULL;

INSERT INTO cr_finance
    (id, user_id, contest_id, finance_action_id, action_value)
SELECT
    UUID(),
    r.user_id,
    r.contest_id,
    12,
    -r.entrance_fee
FROM (
    SELECT DISTINCT user_id, contest_id, entrance_fee
    FROM tmp_missing_contest_participants_resolved
) r
WHERE NOT EXISTS (
    SELECT 1
    FROM cr_finance cf
    WHERE cf.user_id = r.user_id
        AND cf.contest_id = r.contest_id
        AND cf.finance_action_id = 12
);

INSERT INTO finance_offset
    (id, user_id, finance_action_id, action_value, action_date, notes)
SELECT
    UUID(),
    r.user_id,
    14,
    r.entrance_fee,
    NOW(),
    r.offset_notes
FROM (
    SELECT DISTINCT user_id, entrance_fee, offset_notes
    FROM tmp_missing_contest_participants_resolved
) r
WHERE NOT EXISTS (
    SELECT 1
    FROM finance_offset fo
    WHERE fo.user_id = r.user_id
        AND fo.finance_action_id = 14
        AND fo.action_value = r.entrance_fee
        AND fo.notes = r.offset_notes
);

INSERT INTO user_seasonal_contest_participation
    (id, user_id, contest_id)
SELECT
    UUID(),
    r.user_id,
    r.contest_id
FROM (
    SELECT DISTINCT user_id, contest_id
    FROM tmp_missing_contest_participants_resolved
) r
WHERE NOT EXISTS (
    SELECT 1
    FROM user_seasonal_contest_participation uscp
    WHERE uscp.user_id = r.user_id
        AND uscp.contest_id = r.contest_id
);

DROP TEMPORARY TABLE tmp_missing_contest_participants_resolved;
DROP TEMPORARY TABLE tmp_missing_contest_participants_source;

COMMIT;
