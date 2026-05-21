-- ============================================================
-- Finance awards: 2015_winter
-- Pool: 8 x 200 = 1600
-- ============================================================

-- ------ Seasonal awards ------

-- Seasonal 1st – Deagle (2015_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', '56173cb2-519e-11f1-a6f3-000017024a87', 1, 400);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', 13, -400, NOW(), 'Seasonal 1st – Deagle (2015_winter)');

-- Seasonal 2nd – Ajax (2015_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', '56173cb2-519e-11f1-a6f3-000017024a87', 2, 240);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', 13, -240, NOW(), 'Seasonal 2nd – Ajax (2015_winter)');

-- Seasonal 3rd – stan507 (2015_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', '56173cb2-519e-11f1-a6f3-000017024a87', 3, 160);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', 13, -160, NOW(), 'Seasonal 3rd – stan507 (2015_winter)');

-- ------ Monthly 1 awards ------

-- Monthly 1 1st – NewHorizons (2015_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', '56173cd6-519e-11f1-a6f3-000017024a87', 4, 160);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', 13, -160, NOW(), 'Monthly 1 1st – NewHorizons (2015_winter)');

-- Monthly 1 2nd – BeTeL (2015_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', '56173cd6-519e-11f1-a6f3-000017024a87', 5, 96);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', 13, -96, NOW(), 'Monthly 1 2nd – BeTeL (2015_winter)');

-- Monthly 1 3rd – stan507 (2015_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', '56173cd6-519e-11f1-a6f3-000017024a87', 6, 64);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', 13, -64, NOW(), 'Monthly 1 3rd – stan507 (2015_winter)');

-- ------ Monthly 2 awards ------

-- Monthly 2 1st – Ajax (2015_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', '56173d02-519e-11f1-a6f3-000017024a87', 4, 160);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', 13, -160, NOW(), 'Monthly 2 1st – Ajax (2015_winter)');

-- Monthly 2 2nd – NewHorizons (2015_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', '56173d02-519e-11f1-a6f3-000017024a87', 5, 96);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', 13, -96, NOW(), 'Monthly 2 2nd – NewHorizons (2015_winter)');

-- Monthly 2 3rd – Deagle (2015_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', '56173d02-519e-11f1-a6f3-000017024a87', 6, 64);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', 13, -64, NOW(), 'Monthly 2 3rd – Deagle (2015_winter)');

-- ------ Winning streak award ------

-- Winning streak – Deagle (2015_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', '56173cb2-519e-11f1-a6f3-000017024a87', 7, 80);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', 13, -80, NOW(), 'Winning streak – Deagle (2015_winter)');

-- ------ Biggest odds award ------

-- Biggest odds – Ajax (2015_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', '56173cb2-519e-11f1-a6f3-000017024a87', 8, 80);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', 13, -80, NOW(), 'Biggest odds – Ajax (2015_winter)');
