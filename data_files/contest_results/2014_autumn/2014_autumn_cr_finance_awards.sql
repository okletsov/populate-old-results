-- ============================================================
-- Finance awards: 2014_autumn
-- Pool: 5 x 100 = 500
-- ============================================================

-- ------ Seasonal awards ------

-- Seasonal 1st – Dortmund (2014_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '10cdadf5-c909-11e8-8022-74852a015562', '56173a48-519e-11f1-a6f3-000017024a87', 1, 250);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '10cdadf5-c909-11e8-8022-74852a015562', 13, -250, NOW(), 'Seasonal 1st – Dortmund (2014_autumn)');

-- Seasonal 2nd – CapUA (2014_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', '56173a48-519e-11f1-a6f3-000017024a87', 2, 125);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', 13, -125, NOW(), 'Seasonal 2nd – CapUA (2014_autumn)');

-- Seasonal 3rd – stan507 (2014_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', '56173a48-519e-11f1-a6f3-000017024a87', 3, 75);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', 13, -75, NOW(), 'Seasonal 3rd – stan507 (2014_autumn)');

-- ------ Winning streak award ------

-- Winning streak – CapUA (2014_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', '56173a48-519e-11f1-a6f3-000017024a87', 7, 25);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '09d7d5d1-c909-11e8-8022-74852a015562', 13, -25, NOW(), 'Winning streak – CapUA (2014_autumn)');

-- ------ Biggest odds award ------

-- Biggest odds – BeTeLCRiMea (2014_autumn)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', '56173a48-519e-11f1-a6f3-000017024a87', 8, 25);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', 13, -25, NOW(), 'Biggest odds – BeTeLCRiMea (2014_autumn)');
