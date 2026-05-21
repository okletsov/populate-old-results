-- ============================================================
-- Finance awards: 2012_autumn
-- Pool: 4 x 50 = 200
-- ============================================================

-- ------ Seasonal awards ------

-- Seasonal 1st – Stan (2012_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', '561736ac-519e-11f1-a6f3-000017024a87', 1, 100);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', 13, -100, NOW(), 'Seasonal 1st – Stan (2012_autumn)');

-- Seasonal 2nd – BeTeLGeuSe (2012_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', '561736ac-519e-11f1-a6f3-000017024a87', 2, 60);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', 13, -60, NOW(), 'Seasonal 2nd – BeTeLGeuSe (2012_autumn)');

-- ------ Winning streak award ------

-- Winning streak – BeTeLGeuSe (2012_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', '561736ac-519e-11f1-a6f3-000017024a87', 7, 20);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', 13, -20, NOW(), 'Winning streak – BeTeLGeuSe (2012_autumn)');

-- ------ Biggest odds award ------

-- Biggest odds – Mavri_Petalouda (2012_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', '561736ac-519e-11f1-a6f3-000017024a87', 8, 20);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', 13, -20, NOW(), 'Biggest odds – Mavri_Petalouda (2012_autumn)');
