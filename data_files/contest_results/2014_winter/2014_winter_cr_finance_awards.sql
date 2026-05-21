-- ============================================================
-- Finance awards: 2014_winter
-- Pool: 7 x 100 = 700
-- ============================================================

-- ------ Seasonal awards ------

-- Seasonal 1st – Cap (2014_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', '56173a6f-519e-11f1-a6f3-000017024a87', 1, 350);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', 13, -350, NOW(), 'Seasonal 1st – Cap (2014_winter)');

-- Seasonal 2nd – Deagle (2014_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', '56173a6f-519e-11f1-a6f3-000017024a87', 2, 175);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', 13, -175, NOW(), 'Seasonal 2nd – Deagle (2014_winter)');

-- Seasonal 3rd – Stan (2014_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', '56173a6f-519e-11f1-a6f3-000017024a87', 3, 105);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', 13, -105, NOW(), 'Seasonal 3rd – Stan (2014_winter)');

-- ------ Winning streak award ------

-- Winning streak – Stan (2014_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', '56173a6f-519e-11f1-a6f3-000017024a87', 7, 35);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', 13, -35, NOW(), 'Winning streak – Stan (2014_winter)');

-- ------ Biggest odds award ------

-- Biggest odds – Ajax (2014_winter)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', '56173a6f-519e-11f1-a6f3-000017024a87', 8, 35);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', 13, -35, NOW(), 'Biggest odds – Ajax (2014_winter)');
