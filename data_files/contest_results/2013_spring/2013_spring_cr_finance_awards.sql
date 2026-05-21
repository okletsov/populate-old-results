-- ============================================================
-- Finance awards: 2013_spring
-- Pool: 9 x 100 = 900
-- ============================================================

-- ------ Seasonal awards ------

-- Seasonal 1st – Ajax (2013_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', '56173925-519e-11f1-a6f3-000017024a87', 1, 450);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', 13, -450, NOW(), 'Seasonal 1st – Ajax (2013_spring)');

-- Seasonal 2nd – Stan87 (2013_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', '56173925-519e-11f1-a6f3-000017024a87', 2, 225);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', 13, -225, NOW(), 'Seasonal 2nd – Stan87 (2013_spring)');

-- Seasonal 3rd – zuzik (2013_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '10912e61-e385-11e8-a9e2-74852a015562', '56173925-519e-11f1-a6f3-000017024a87', 3, 135);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '10912e61-e385-11e8-a9e2-74852a015562', 13, -135, NOW(), 'Seasonal 3rd – zuzik (2013_spring)');

-- ------ Winning streak award ------

-- Winning streak – Cap4ik88 (2013_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', '56173925-519e-11f1-a6f3-000017024a87', 7, 45);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', 13, -45, NOW(), 'Winning streak – Cap4ik88 (2013_spring)');

-- ------ Biggest odds award ------

-- Biggest odds – DNIPRO (2013_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '1647bf56-c909-11e8-8022-74852a015562', '56173925-519e-11f1-a6f3-000017024a87', 8, 45);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '1647bf56-c909-11e8-8022-74852a015562', 13, -45, NOW(), 'Biggest odds – DNIPRO (2013_spring)');
