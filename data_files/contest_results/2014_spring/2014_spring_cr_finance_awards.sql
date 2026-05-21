-- ============================================================
-- Finance awards: 2014_spring
-- Pool: 7 x 100 = 700
-- ============================================================

-- ------ Seasonal awards ------

-- Seasonal 1st – Ajax (2014_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', '561739d4-519e-11f1-a6f3-000017024a87', 1, 350);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', 13, -350, NOW(), 'Seasonal 1st – Ajax (2014_spring)');

-- Seasonal 2nd – Gunners_Fan (2014_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '10912e61-e385-11e8-a9e2-74852a015562', '561739d4-519e-11f1-a6f3-000017024a87', 2, 175);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '10912e61-e385-11e8-a9e2-74852a015562', 13, -175, NOW(), 'Seasonal 2nd – Gunners_Fan (2014_spring)');

-- Seasonal 3rd – AlegriA (2014_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', '561739d4-519e-11f1-a6f3-000017024a87', 3, 105);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', 13, -105, NOW(), 'Seasonal 3rd – AlegriA (2014_spring)');

-- ------ Winning streak award ------

-- Winning streak – Deagle (2014_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', '561739d4-519e-11f1-a6f3-000017024a87', 7, 35);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', 13, -35, NOW(), 'Winning streak – Deagle (2014_spring)');

-- ------ Biggest odds award ------

-- Biggest odds – Ajax (2014_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', '561739d4-519e-11f1-a6f3-000017024a87', 8, 35);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', 13, -35, NOW(), 'Biggest odds – Ajax (2014_spring)');
