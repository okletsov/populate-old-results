-- ============================================================
-- Finance awards: 2017_winter
-- Pool: 8 x 200 = 1600
-- ============================================================

-- ------ Seasonal awards ------

-- Seasonal 1st – ka1manua (2017_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '10cdadf5-c909-11e8-8022-74852a015562', '5617eb16-519e-11f1-a6f3-000017024a87', 1, 400);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '10cdadf5-c909-11e8-8022-74852a015562', 13, -400, NOW(), 'Seasonal 1st – ka1manua (2017_winter)');

-- Seasonal 2nd – Ars (2017_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '15053f93-c909-11e8-8022-74852a015562', '5617eb16-519e-11f1-a6f3-000017024a87', 2, 240);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '15053f93-c909-11e8-8022-74852a015562', 13, -240, NOW(), 'Seasonal 2nd – Ars (2017_winter)');

-- Seasonal 3rd – Arsii (2017_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '10912e61-e385-11e8-a9e2-74852a015562', '5617eb16-519e-11f1-a6f3-000017024a87', 3, 160);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '10912e61-e385-11e8-a9e2-74852a015562', 13, -160, NOW(), 'Seasonal 3rd – Arsii (2017_winter)');

-- ------ Monthly 1 awards ------

-- Monthly 1 1st – Dnepr (2017_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '1647bf56-c909-11e8-8022-74852a015562', '5617eb3c-519e-11f1-a6f3-000017024a87', 4, 160);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '1647bf56-c909-11e8-8022-74852a015562', 13, -160, NOW(), 'Monthly 1 1st – Dnepr (2017_winter)');

-- Monthly 1 2nd – Cap4ik (2017_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', '5617eb3c-519e-11f1-a6f3-000017024a87', 5, 96);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', 13, -96, NOW(), 'Monthly 1 2nd – Cap4ik (2017_winter)');

-- Monthly 1 3rd – stan507 (2017_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', '5617eb3c-519e-11f1-a6f3-000017024a87', 6, 64);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', 13, -64, NOW(), 'Monthly 1 3rd – stan507 (2017_winter)');

-- ------ Monthly 2 awards ------

-- Monthly 2 1st – BeTeL (2017_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', '5617eb5f-519e-11f1-a6f3-000017024a87', 4, 160);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', 13, -160, NOW(), 'Monthly 2 1st – BeTeL (2017_winter)');

-- Monthly 2 2nd – Ars (2017_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '15053f93-c909-11e8-8022-74852a015562', '5617eb5f-519e-11f1-a6f3-000017024a87', 5, 96);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '15053f93-c909-11e8-8022-74852a015562', 13, -96, NOW(), 'Monthly 2 2nd – Ars (2017_winter)');

-- Monthly 2 3rd – Arsii (2017_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '10912e61-e385-11e8-a9e2-74852a015562', '5617eb5f-519e-11f1-a6f3-000017024a87', 6, 64);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '10912e61-e385-11e8-a9e2-74852a015562', 13, -64, NOW(), 'Monthly 2 3rd – Arsii (2017_winter)');

-- ------ Winning streak award ------

-- Winning streak – ka1manua (2017_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '10cdadf5-c909-11e8-8022-74852a015562', '5617eb16-519e-11f1-a6f3-000017024a87', 7, 80);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '10cdadf5-c909-11e8-8022-74852a015562', 13, -80, NOW(), 'Winning streak – ka1manua (2017_winter)');

-- ------ Biggest odds award ------

-- Biggest odds – Arsii (2017_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '10912e61-e385-11e8-a9e2-74852a015562', '5617eb16-519e-11f1-a6f3-000017024a87', 8, 80);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '10912e61-e385-11e8-a9e2-74852a015562', 13, -80, NOW(), 'Biggest odds – Arsii (2017_winter)');
