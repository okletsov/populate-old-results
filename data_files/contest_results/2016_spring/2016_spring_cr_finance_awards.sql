-- ============================================================
-- Finance awards: 2016_spring
-- Pool: 13 x 200 = 2600
-- ============================================================

-- ------ Seasonal awards ------

-- Seasonal 1st – ka1manua (2016_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '10cdadf5-c909-11e8-8022-74852a015562', '56173d2a-519e-11f1-a6f3-000017024a87', 1, 650);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '10cdadf5-c909-11e8-8022-74852a015562', 13, -650, NOW(), 'Seasonal 1st – ka1manua (2016_spring)');

-- Seasonal 2nd – BeTeL (2016_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', '56173d2a-519e-11f1-a6f3-000017024a87', 2, 390);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', 13, -390, NOW(), 'Seasonal 2nd – BeTeL (2016_spring)');

-- Seasonal 3rd – Ars (2016_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '15053f93-c909-11e8-8022-74852a015562', '56173d2a-519e-11f1-a6f3-000017024a87', 3, 260);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '15053f93-c909-11e8-8022-74852a015562', 13, -260, NOW(), 'Seasonal 3rd – Ars (2016_spring)');

-- ------ Monthly 1 awards ------

-- Monthly 1 1st – Ajax (2016_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', '56173d51-519e-11f1-a6f3-000017024a87', 4, 260);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', 13, -260, NOW(), 'Monthly 1 1st – Ajax (2016_spring)');

-- Monthly 1 2nd – BeTeL (2016_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', '56173d51-519e-11f1-a6f3-000017024a87', 5, 156);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', 13, -156, NOW(), 'Monthly 1 2nd – BeTeL (2016_spring)');

-- Monthly 1 3rd – Gorg (2016_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '12b31bfb-c909-11e8-8022-74852a015562', '56173d51-519e-11f1-a6f3-000017024a87', 6, 104);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '12b31bfb-c909-11e8-8022-74852a015562', 13, -104, NOW(), 'Monthly 1 3rd – Gorg (2016_spring)');

-- ------ Monthly 2 awards ------

-- Monthly 2 1st – Dnepr (2016_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '1647bf56-c909-11e8-8022-74852a015562', '56173d77-519e-11f1-a6f3-000017024a87', 4, 260);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '1647bf56-c909-11e8-8022-74852a015562', 13, -260, NOW(), 'Monthly 2 1st – Dnepr (2016_spring)');

-- Monthly 2 2nd – NewHorizons (2016_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', '56173d77-519e-11f1-a6f3-000017024a87', 5, 156);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', 13, -156, NOW(), 'Monthly 2 2nd – NewHorizons (2016_spring)');

-- Monthly 2 3rd – Ars (2016_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '15053f93-c909-11e8-8022-74852a015562', '56173d77-519e-11f1-a6f3-000017024a87', 6, 104);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '15053f93-c909-11e8-8022-74852a015562', 13, -104, NOW(), 'Monthly 2 3rd – Ars (2016_spring)');

-- ------ Winning streak award ------

-- Winning streak – BeTeL (2016_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', '56173d2a-519e-11f1-a6f3-000017024a87', 7, 130);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', 13, -130, NOW(), 'Winning streak – BeTeL (2016_spring)');

-- ------ Biggest odds award ------

-- Biggest odds – Ajax (2016_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', '56173d2a-519e-11f1-a6f3-000017024a87', 8, 130);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', 13, -130, NOW(), 'Biggest odds – Ajax (2016_spring)');
