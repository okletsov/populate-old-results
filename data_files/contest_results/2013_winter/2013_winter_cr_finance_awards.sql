-- ============================================================
-- Finance awards: 2013_winter
-- Pool: 6 x 100 = 600
-- ============================================================

-- ------ Seasonal awards ------

-- Seasonal 1st – BeTeLGeuSe (2013_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', '561739a3-519e-11f1-a6f3-000017024a87', 1, 300);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', 13, -300, NOW(), 'Seasonal 1st – BeTeLGeuSe (2013_winter)');

-- Seasonal 2nd – Ajax (2013_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', '561739a3-519e-11f1-a6f3-000017024a87', 2, 150);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', 13, -150, NOW(), 'Seasonal 2nd – Ajax (2013_winter)');

-- Seasonal 3rd – Stan87 (2013_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', '561739a3-519e-11f1-a6f3-000017024a87', 3, 90);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', 13, -90, NOW(), 'Seasonal 3rd – Stan87 (2013_winter)');

-- ------ Winning streak award ------

-- Winning streak – Stan87 (2013_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', '561739a3-519e-11f1-a6f3-000017024a87', 7, 30);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', 13, -30, NOW(), 'Winning streak – Stan87 (2013_winter)');

-- ------ Biggest odds award ------

-- Biggest odds – Ajax (2013_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', '561739a3-519e-11f1-a6f3-000017024a87', 8, 30);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', 13, -30, NOW(), 'Biggest odds – Ajax (2013_winter)');
