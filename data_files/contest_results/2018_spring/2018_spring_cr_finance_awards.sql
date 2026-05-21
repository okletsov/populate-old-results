-- ============================================================
-- Finance awards: 2018_spring
-- Pool: 9 x 200 = 1800
-- ============================================================

-- ------ Seasonal awards ------

-- Seasonal 1st – Gorg (2018_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '12b31bfb-c909-11e8-8022-74852a015562', '5617eb85-519e-11f1-a6f3-000017024a87', 1, 450);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '12b31bfb-c909-11e8-8022-74852a015562', 13, -450, NOW(), 'Seasonal 1st – Gorg (2018_spring)');

-- Seasonal 2nd – Ajax (2018_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', '5617eb85-519e-11f1-a6f3-000017024a87', 2, 270);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', 13, -270, NOW(), 'Seasonal 2nd – Ajax (2018_spring)');

-- Seasonal 3rd – Dnepr (2018_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '1647bf56-c909-11e8-8022-74852a015562', '5617eb85-519e-11f1-a6f3-000017024a87', 3, 180);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '1647bf56-c909-11e8-8022-74852a015562', 13, -180, NOW(), 'Seasonal 3rd – Dnepr (2018_spring)');

-- ------ Monthly 1 awards ------

-- Monthly 1 1st – Gorg (2018_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '12b31bfb-c909-11e8-8022-74852a015562', '5617ebac-519e-11f1-a6f3-000017024a87', 4, 180);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '12b31bfb-c909-11e8-8022-74852a015562', 13, -180, NOW(), 'Monthly 1 1st – Gorg (2018_spring)');

-- Monthly 1 2nd – Deagle (2018_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', '5617ebac-519e-11f1-a6f3-000017024a87', 5, 108);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0e2ae8fd-c909-11e8-8022-74852a015562', 13, -108, NOW(), 'Monthly 1 2nd – Deagle (2018_spring)');

-- Monthly 1 3rd – BeTeL (2018_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', '5617ebac-519e-11f1-a6f3-000017024a87', 6, 72);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0ca7046d-c909-11e8-8022-74852a015562', 13, -72, NOW(), 'Monthly 1 3rd – BeTeL (2018_spring)');

-- ------ Monthly 2 awards ------

-- Monthly 2 1st – Gorg (2018_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '12b31bfb-c909-11e8-8022-74852a015562', '5617ebcf-519e-11f1-a6f3-000017024a87', 4, 180);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '12b31bfb-c909-11e8-8022-74852a015562', 13, -180, NOW(), 'Monthly 2 1st – Gorg (2018_spring)');

-- Monthly 2 2nd – Ajax (2018_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', '5617ebcf-519e-11f1-a6f3-000017024a87', 5, 108);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '11b6372c-c909-11e8-8022-74852a015562', 13, -108, NOW(), 'Monthly 2 2nd – Ajax (2018_spring)');

-- Monthly 2 3rd – Dnepr (2018_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '1647bf56-c909-11e8-8022-74852a015562', '5617ebcf-519e-11f1-a6f3-000017024a87', 6, 72);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '1647bf56-c909-11e8-8022-74852a015562', 13, -72, NOW(), 'Monthly 2 3rd – Dnepr (2018_spring)');

-- ------ Winning streak award ------

-- Winning streak – Stan (2018_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', '5617eb85-519e-11f1-a6f3-000017024a87', 7, 90);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '0f9994d6-c909-11e8-8022-74852a015562', 13, -90, NOW(), 'Winning streak – Stan (2018_spring)');

-- ------ Biggest odds award ------

-- Biggest odds – Gorg (2018_spring)
INSERT INTO `cr_finance` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '12b31bfb-c909-11e8-8022-74852a015562', '5617eb85-519e-11f1-a6f3-000017024a87', 8, 90);
INSERT INTO `finance_offset` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '12b31bfb-c909-11e8-8022-74852a015562', 13, -90, NOW(), 'Biggest odds – Gorg (2018_spring)');
