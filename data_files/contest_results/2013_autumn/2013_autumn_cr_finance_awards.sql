-- ============================================================
-- Finance awards: 2013_autumn
-- Pool: 8 x 100 = 800
-- ============================================================

-- ------ Seasonal awards ------

-- Seasonal 1st – Ka1man (2013_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '10cdadf5-c909-11e8-8022-74852a015562', '5617396c-519e-11f1-a6f3-000017024a87', 1, 400);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '10cdadf5-c909-11e8-8022-74852a015562', 13, -400, NOW(), 'Seasonal 1st – Ka1man (2013_autumn)');

-- Seasonal 2nd – BeTeLGeuSe (2013_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', '5617396c-519e-11f1-a6f3-000017024a87', 2, 200);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', 13, -200, NOW(), 'Seasonal 2nd – BeTeLGeuSe (2013_autumn)');

-- Seasonal 3rd – Stan507 (2013_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', '5617396c-519e-11f1-a6f3-000017024a87', 3, 120);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', 13, -120, NOW(), 'Seasonal 3rd – Stan507 (2013_autumn)');

-- ------ Winning streak award ------

-- Winning streak – BeTeLGeuSe (2013_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', '5617396c-519e-11f1-a6f3-000017024a87', 7, 40);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', 13, -40, NOW(), 'Winning streak – BeTeLGeuSe (2013_autumn)');

-- ------ Biggest odds award ------

-- Biggest odds – Cap4ik (2013_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', '5617396c-519e-11f1-a6f3-000017024a87', 8, 40);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', 13, -40, NOW(), 'Biggest odds – Cap4ik (2013_autumn)');
