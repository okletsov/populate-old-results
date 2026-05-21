-- ============================================================
-- Finance awards: 2016_winter
-- Pool: 9 x 200 = 1800
-- ============================================================

-- ------ Seasonal awards ------

-- Seasonal 1st – stan507 (2016_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', '561794fc-519e-11f1-a6f3-000017024a87', 1, 450);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', 13, -450, NOW(), 'Seasonal 1st – stan507 (2016_winter)');

-- Seasonal 2nd – Ajax (2016_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', '561794fc-519e-11f1-a6f3-000017024a87', 2, 270);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', 13, -270, NOW(), 'Seasonal 2nd – Ajax (2016_winter)');

-- Seasonal 3rd – Gorg (2016_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '12b31bfb-c909-11e8-8022-74852a015562', '561794fc-519e-11f1-a6f3-000017024a87', 3, 180);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '12b31bfb-c909-11e8-8022-74852a015562', 13, -180, NOW(), 'Seasonal 3rd – Gorg (2016_winter)');

-- ------ Monthly 1 awards ------

-- Monthly 1 1st – Ajax (2016_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', '5617952e-519e-11f1-a6f3-000017024a87', 4, 180);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', 13, -180, NOW(), 'Monthly 1 1st – Ajax (2016_winter)');

-- Monthly 1 2nd – Cap4ik (2016_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', '5617952e-519e-11f1-a6f3-000017024a87', 5, 108);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', 13, -108, NOW(), 'Monthly 1 2nd – Cap4ik (2016_winter)');

-- Monthly 1 3rd – BeTeL (2016_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', '5617952e-519e-11f1-a6f3-000017024a87', 6, 72);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', 13, -72, NOW(), 'Monthly 1 3rd – BeTeL (2016_winter)');

-- ------ Monthly 2 awards ------

-- Monthly 2 1st – Dnepr (2016_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '1647bf56-c909-11e8-8022-74852a015562', '5617e87c-519e-11f1-a6f3-000017024a87', 4, 180);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '1647bf56-c909-11e8-8022-74852a015562', 13, -180, NOW(), 'Monthly 2 1st – Dnepr (2016_winter)');

-- Monthly 2 2nd – stan507 (2016_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', '5617e87c-519e-11f1-a6f3-000017024a87', 5, 108);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', 13, -108, NOW(), 'Monthly 2 2nd – stan507 (2016_winter)');

-- Monthly 2 3rd – Deagle (2016_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', '5617e87c-519e-11f1-a6f3-000017024a87', 6, 72);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', 13, -72, NOW(), 'Monthly 2 3rd – Deagle (2016_winter)');

-- ------ Winning streak award ------

-- Winning streak – Deagle (2016_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', '561794fc-519e-11f1-a6f3-000017024a87', 7, 90);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', 13, -90, NOW(), 'Winning streak – Deagle (2016_winter)');

-- ------ Biggest odds award ------

-- Biggest odds – Ajax (2016_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', '561794fc-519e-11f1-a6f3-000017024a87', 8, 30);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', 13, -30, NOW(), 'Biggest odds – Ajax (2016_winter)');

-- Biggest odds – BeTeL (2016_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', '561794fc-519e-11f1-a6f3-000017024a87', 8, 30);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', 13, -30, NOW(), 'Biggest odds – BeTeL (2016_winter)');

-- Biggest odds – stan507 (2016_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', '561794fc-519e-11f1-a6f3-000017024a87', 8, 30);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', 13, -30, NOW(), 'Biggest odds – stan507 (2016_winter)');
