-- ============================================================
-- Finance awards: 2014_summer
-- Pool: 4 x 100 = 400
-- ============================================================

-- ------ Seasonal awards ------

-- Seasonal 1st – Ajax-II (2014_summer)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', '56173a1e-519e-11f1-a6f3-000017024a87', 1, 200);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', 13, -200, NOW(), 'Seasonal 1st – Ajax-II (2014_summer)');

-- Seasonal 2nd – Ciklum (2014_summer)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '10cdadf5-c909-11e8-8022-74852a015562', '56173a1e-519e-11f1-a6f3-000017024a87', 2, 100);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '10cdadf5-c909-11e8-8022-74852a015562', 13, -100, NOW(), 'Seasonal 2nd – Ciklum (2014_summer)');

-- Seasonal 3rd – BetTennis (2014_summer)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', '56173a1e-519e-11f1-a6f3-000017024a87', 3, 60);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', 13, -60, NOW(), 'Seasonal 3rd – BetTennis (2014_summer)');

-- ------ Winning streak award ------

-- Winning streak – BetTennis (2014_summer)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', '56173a1e-519e-11f1-a6f3-000017024a87', 7, 20);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', 13, -20, NOW(), 'Winning streak – BetTennis (2014_summer)');

-- ------ Biggest odds award ------

-- Biggest odds – OrionLTD (2014_summer)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', '56173a1e-519e-11f1-a6f3-000017024a87', 8, 20);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', 13, -20, NOW(), 'Biggest odds – OrionLTD (2014_summer)');
