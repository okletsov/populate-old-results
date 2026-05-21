-- ============================================================
-- Finance awards: 2017_spring
-- Pool: 10 x 200 = 2000
-- ============================================================

-- ------ Seasonal awards ------

-- Seasonal 1st – Arsii (2017_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '10912e61-e385-11e8-a9e2-74852a015562', '5617ea23-519e-11f1-a6f3-000017024a87', 1, 500);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '10912e61-e385-11e8-a9e2-74852a015562', 13, -500, NOW(), 'Seasonal 1st – Arsii (2017_spring)');

-- Seasonal 2nd – Cap4ik (2017_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', '5617ea23-519e-11f1-a6f3-000017024a87', 2, 300);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', 13, -300, NOW(), 'Seasonal 2nd – Cap4ik (2017_spring)');

-- Seasonal 3rd – Ars (2017_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '15053f93-c909-11e8-8022-74852a015562', '5617ea23-519e-11f1-a6f3-000017024a87', 3, 200);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '15053f93-c909-11e8-8022-74852a015562', 13, -200, NOW(), 'Seasonal 3rd – Ars (2017_spring)');

-- ------ Monthly 1 awards ------

-- Monthly 1 1st – Arsii (2017_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '10912e61-e385-11e8-a9e2-74852a015562', '5617ea58-519e-11f1-a6f3-000017024a87', 4, 200);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '10912e61-e385-11e8-a9e2-74852a015562', 13, -200, NOW(), 'Monthly 1 1st – Arsii (2017_spring)');

-- Monthly 1 2nd – Ajax (2017_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', '5617ea58-519e-11f1-a6f3-000017024a87', 5, 120);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', 13, -120, NOW(), 'Monthly 1 2nd – Ajax (2017_spring)');

-- Monthly 1 3rd – Ars (2017_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '15053f93-c909-11e8-8022-74852a015562', '5617ea58-519e-11f1-a6f3-000017024a87', 6, 80);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '15053f93-c909-11e8-8022-74852a015562', 13, -80, NOW(), 'Monthly 1 3rd – Ars (2017_spring)');

-- ------ Monthly 2 awards ------

-- Monthly 2 1st – stan507 (2017_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', '5617ea81-519e-11f1-a6f3-000017024a87', 4, 200);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', 13, -200, NOW(), 'Monthly 2 1st – stan507 (2017_spring)');

-- Monthly 2 2nd – Cap4ik (2017_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', '5617ea81-519e-11f1-a6f3-000017024a87', 5, 120);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', 13, -120, NOW(), 'Monthly 2 2nd – Cap4ik (2017_spring)');

-- Monthly 2 3rd – Arsii (2017_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '10912e61-e385-11e8-a9e2-74852a015562', '5617ea81-519e-11f1-a6f3-000017024a87', 6, 80);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '10912e61-e385-11e8-a9e2-74852a015562', 13, -80, NOW(), 'Monthly 2 3rd – Arsii (2017_spring)');

-- ------ Winning streak award ------

-- Winning streak – BeTeL (2017_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', '5617ea23-519e-11f1-a6f3-000017024a87', 7, 100);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', 13, -100, NOW(), 'Winning streak – BeTeL (2017_spring)');

-- ------ Biggest odds award ------

-- Biggest odds – Arsii (2017_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '10912e61-e385-11e8-a9e2-74852a015562', '5617ea23-519e-11f1-a6f3-000017024a87', 8, 100);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '10912e61-e385-11e8-a9e2-74852a015562', 13, -100, NOW(), 'Biggest odds – Arsii (2017_spring)');
