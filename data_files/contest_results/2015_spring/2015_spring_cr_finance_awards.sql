-- ============================================================
-- Finance awards: 2015_spring
-- Pool: 7 x 100 = 700
-- ============================================================

-- ------ Seasonal awards ------

-- Seasonal 1st – BeTeL (2015_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', '56173be7-519e-11f1-a6f3-000017024a87', 1, 350);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', 13, -350, NOW(), 'Seasonal 1st – BeTeL (2015_spring)');

-- Seasonal 2nd – stan507 (2015_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', '56173be7-519e-11f1-a6f3-000017024a87', 2, 175);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', 13, -175, NOW(), 'Seasonal 2nd – stan507 (2015_spring)');

-- Seasonal 3rd – AjaxSpring (2015_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', '56173be7-519e-11f1-a6f3-000017024a87', 3, 105);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', 13, -105, NOW(), 'Seasonal 3rd – AjaxSpring (2015_spring)');

-- ------ Winning streak award ------

-- Winning streak – ka1manua (2015_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '10cdadf5-c909-11e8-8022-74852a015562', '56173be7-519e-11f1-a6f3-000017024a87', 7, 35);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '10cdadf5-c909-11e8-8022-74852a015562', 13, -35, NOW(), 'Winning streak – ka1manua (2015_spring)');

-- ------ Biggest odds award ------

-- Biggest odds – AjaxSpring (2015_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', '56173be7-519e-11f1-a6f3-000017024a87', 8, 35);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', 13, -35, NOW(), 'Biggest odds – AjaxSpring (2015_spring)');
