-- ============================================================
-- Finance awards: 2017_autumn
-- Pool: 10 x 200 = 2000
-- ============================================================

-- ------ Seasonal awards ------

-- Seasonal 1st – Ars (2017_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '15053f93-c909-11e8-8022-74852a015562', '5617eaa5-519e-11f1-a6f3-000017024a87', 1, 500);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '15053f93-c909-11e8-8022-74852a015562', 13, -500, NOW(), 'Seasonal 1st – Ars (2017_autumn)');

-- Seasonal 2nd – Ajax (2017_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', '5617eaa5-519e-11f1-a6f3-000017024a87', 2, 300);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', 13, -300, NOW(), 'Seasonal 2nd – Ajax (2017_autumn)');

-- Seasonal 3rd – Dnepr (2017_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '1647bf56-c909-11e8-8022-74852a015562', '5617eaa5-519e-11f1-a6f3-000017024a87', 3, 200);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '1647bf56-c909-11e8-8022-74852a015562', 13, -200, NOW(), 'Seasonal 3rd – Dnepr (2017_autumn)');

-- ------ Monthly 1 awards ------

-- Monthly 1 1st – Ars (2017_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '15053f93-c909-11e8-8022-74852a015562', '5617eacc-519e-11f1-a6f3-000017024a87', 4, 200);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '15053f93-c909-11e8-8022-74852a015562', 13, -200, NOW(), 'Monthly 1 1st – Ars (2017_autumn)');

-- Monthly 1 2nd – Arsii (2017_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '10912e61-e385-11e8-a9e2-74852a015562', '5617eacc-519e-11f1-a6f3-000017024a87', 5, 120);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '10912e61-e385-11e8-a9e2-74852a015562', 13, -120, NOW(), 'Monthly 1 2nd – Arsii (2017_autumn)');

-- Monthly 1 3rd – CapUA (2017_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', '5617eacc-519e-11f1-a6f3-000017024a87', 6, 80);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', 13, -80, NOW(), 'Monthly 1 3rd – CapUA (2017_autumn)');

-- ------ Monthly 2 awards ------

-- Monthly 2 1st – Ajax (2017_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', '5617eaee-519e-11f1-a6f3-000017024a87', 4, 200);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', 13, -200, NOW(), 'Monthly 2 1st – Ajax (2017_autumn)');

-- Monthly 2 2nd – BeTeL (2017_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', '5617eaee-519e-11f1-a6f3-000017024a87', 5, 120);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', 13, -120, NOW(), 'Monthly 2 2nd – BeTeL (2017_autumn)');

-- Monthly 2 3rd – Ars (2017_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '15053f93-c909-11e8-8022-74852a015562', '5617eaee-519e-11f1-a6f3-000017024a87', 6, 80);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '15053f93-c909-11e8-8022-74852a015562', 13, -80, NOW(), 'Monthly 2 3rd – Ars (2017_autumn)');

-- ------ Winning streak award ------

-- Winning streak – Ars (2017_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '15053f93-c909-11e8-8022-74852a015562', '5617eaa5-519e-11f1-a6f3-000017024a87', 7, 100);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '15053f93-c909-11e8-8022-74852a015562', 13, -100, NOW(), 'Winning streak – Ars (2017_autumn)');

-- ------ Biggest odds award ------

-- Biggest odds – Ajax (2017_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', '5617eaa5-519e-11f1-a6f3-000017024a87', 8, 100);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', 13, -100, NOW(), 'Biggest odds – Ajax (2017_autumn)');
