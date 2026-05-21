-- ============================================================
-- Finance awards: 2015_autumn
-- Pool: 7 x 200 = 1400
-- ============================================================

-- ------ Seasonal awards ------

-- Seasonal 1st – Arsii (2015_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '10912e61-e385-11e8-a9e2-74852a015562', '56173c8c-519e-11f1-a6f3-000017024a87', 1, 700);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '10912e61-e385-11e8-a9e2-74852a015562', 13, -700, NOW(), 'Seasonal 1st – Arsii (2015_autumn)');

-- Seasonal 2nd – Gorg (2015_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '12b31bfb-c909-11e8-8022-74852a015562', '56173c8c-519e-11f1-a6f3-000017024a87', 2, 350);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '12b31bfb-c909-11e8-8022-74852a015562', 13, -350, NOW(), 'Seasonal 2nd – Gorg (2015_autumn)');

-- Seasonal 3rd – Deagle (2015_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', '56173c8c-519e-11f1-a6f3-000017024a87', 3, 210);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', 13, -210, NOW(), 'Seasonal 3rd – Deagle (2015_autumn)');

-- ------ Winning streak award ------

-- Winning streak – ka1manua (2015_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '10cdadf5-c909-11e8-8022-74852a015562', '56173c8c-519e-11f1-a6f3-000017024a87', 7, 70);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '10cdadf5-c909-11e8-8022-74852a015562', 13, -70, NOW(), 'Winning streak – ka1manua (2015_autumn)');

-- ------ Biggest odds award ------

-- Biggest odds – Ajax (2015_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', '56173c8c-519e-11f1-a6f3-000017024a87', 8, 70);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', 13, -70, NOW(), 'Biggest odds – Ajax (2015_autumn)');
