-- ============================================================
-- Finance awards: 2015_summer
-- Pool: 6 x 100 = 600
-- ============================================================

-- ------ Seasonal awards ------

-- Seasonal 1st – dimka300688 (2015_summer)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '54bf4e42-5199-11f1-a6f3-000017024a87', '56173c63-519e-11f1-a6f3-000017024a87', 1, 300);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '54bf4e42-5199-11f1-a6f3-000017024a87', 13, -300, NOW(), 'Seasonal 1st – dimka300688 (2015_summer)');

-- Seasonal 2nd – Deagle (2015_summer)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', '56173c63-519e-11f1-a6f3-000017024a87', 2, 150);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', 13, -150, NOW(), 'Seasonal 2nd – Deagle (2015_summer)');

-- Seasonal 3rd – stan507 (2015_summer)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', '56173c63-519e-11f1-a6f3-000017024a87', 3, 90);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', 13, -90, NOW(), 'Seasonal 3rd – stan507 (2015_summer)');

-- ------ Winning streak award ------

-- Winning streak – Deagle (2015_summer)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', '56173c63-519e-11f1-a6f3-000017024a87', 7, 30);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', 13, -30, NOW(), 'Winning streak – Deagle (2015_summer)');

-- ------ Biggest odds award ------

-- Biggest odds – AjaxSpring (2015_summer)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', '56173c63-519e-11f1-a6f3-000017024a87', 8, 10);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', 13, -10, NOW(), 'Biggest odds – AjaxSpring (2015_summer)');

-- Biggest odds – ka1manua (2015_summer)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '10cdadf5-c909-11e8-8022-74852a015562', '56173c63-519e-11f1-a6f3-000017024a87', 8, 10);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '10cdadf5-c909-11e8-8022-74852a015562', 13, -10, NOW(), 'Biggest odds – ka1manua (2015_summer)');

-- Biggest odds – Deagle (2015_summer)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', '56173c63-519e-11f1-a6f3-000017024a87', 8, 10);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', 13, -10, NOW(), 'Biggest odds – Deagle (2015_summer)');
