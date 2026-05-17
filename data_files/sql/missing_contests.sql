INSERT INTO main.contest
    (id, type, year, month, season, start_date, end_date, is_active, date_created, entrance_fee)
VALUES
    -- 2012 Autumn
    (UUID(), 'seasonal', '2012', NULL, 'Autumn', '2012-08-31 21:00:01', '2012-11-30 22:00:00', 0, NOW(), 50),
    -- 2013 Spring
    (UUID(), 'seasonal', '2013', NULL, 'Spring', '2013-02-28 22:00:01', '2013-05-31 21:00:00', 0, NOW(), 100),
    -- 2013 Autumn
    (UUID(), 'seasonal', '2013', NULL, 'Autumn', '2013-08-31 21:00:01', '2013-11-30 22:00:00', 0, NOW(), 100),
    -- 2013 Winter
    (UUID(), 'seasonal', '2013', NULL, 'Winter', '2013-11-30 22:00:01', '2014-02-28 22:00:00', 0, NOW(), 100),
    -- 2014 Spring
    (UUID(), 'seasonal', '2014', NULL, 'Spring', '2014-02-28 22:00:01', '2014-05-31 21:00:00', 0, NOW(), 100),
    -- 2014 Summer
    (UUID(), 'seasonal', '2014', NULL, 'Summer', '2014-05-31 21:00:01', '2014-08-31 21:00:00', 0, NOW(), 100),
    -- 2014 Autumn
    (UUID(), 'seasonal', '2014', NULL, 'Autumn', '2014-08-31 21:00:01', '2014-11-30 22:00:00', 0, NOW(), 100),
    -- 2014 Winter
    (UUID(), 'seasonal', '2014', NULL, 'Winter', '2014-11-30 22:00:01', '2015-02-28 22:00:00', 0, NOW(), 100),
    -- 2015 Spring
    (UUID(), 'seasonal', '2015', NULL, 'Spring', '2015-02-28 22:00:01', '2015-05-31 21:00:00', 0, NOW(), 100),
    -- 2015 Summer
    (UUID(), 'seasonal', '2015', NULL, 'Summer', '2015-05-31 21:00:01', '2015-08-31 21:00:00', 0, NOW(), 100),
    -- 2015 Autumn
    (UUID(), 'seasonal', '2015', NULL, 'Autumn', '2015-08-31 21:00:01', '2015-11-30 22:00:00', 0, NOW(), 200),
    -- 2015 Winter
    (UUID(), 'seasonal', '2015', NULL, 'Winter', '2015-11-30 22:00:01', '2016-02-29 22:00:00', 0, NOW(), 200),
    -- 2015 Winter Month 1
    (UUID(), 'monthly', '2015', '1', 'Winter', '2015-11-30 22:00:01', '2015-12-31 21:59:59', 0, NOW(), 0),
    -- 2015 Winter Month 2
    (UUID(), 'monthly', '2015', '2', 'Winter', '2015-12-31 22:00:00', '2016-01-31 21:59:59', 0, NOW(), 0),
    -- 2016 Spring
    (UUID(), 'seasonal', '2016', NULL, 'Spring', '2016-02-28 22:00:01', '2016-05-31 21:00:00', 0, NOW(), 200),
    -- 2016 Spring Month 1
    (UUID(), 'monthly', '2016', '1', 'Spring', '2016-02-28 22:00:01', '2016-03-31 20:59:59', 0, NOW(), 0),
    -- 2016 Spring Month 2
    (UUID(), 'monthly', '2016', '2', 'Spring', '2016-03-31 21:00:00', '2016-04-30 20:59:59', 0, NOW(), 0),
    -- 2016 Autumn
    (UUID(), 'seasonal', '2016', NULL, 'Autumn', '2016-08-31 21:00:01', '2016-11-30 22:00:00', 0, NOW(), 200),
    -- 2016 Autumn Month 1
    (UUID(), 'monthly', '2016', '1', 'Autumn', '2016-08-31 21:00:01', '2016-09-30 20:59:59', 0, NOW(), 0),
    -- 2016 Autumn Month 2
    (UUID(), 'monthly', '2016', '2', 'Autumn', '2016-09-30 21:00:00', '2016-10-31 21:59:59', 0, NOW(), 0),
    -- 2016 Winter
    (UUID(), 'seasonal', '2016', NULL, 'Winter', '2016-11-30 22:00:01', '2017-02-28 22:00:00', 0, NOW(), 200),
    -- 2016 Winter Month 1
    (UUID(), 'monthly', '2016', '1', 'Winter', '2016-11-30 22:00:01', '2016-12-31 21:59:59', 0, NOW(), 0),
    -- 2016 Winter Month 2
    (UUID(), 'monthly', '2016', '2', 'Winter', '2016-12-31 22:00:00', '2017-01-31 21:59:59', 0, NOW(), 0),
    -- 2017 Spring
    (UUID(), 'seasonal', '2017', NULL, 'Spring', '2017-02-28 22:00:01', '2017-05-31 21:00:00', 0, NOW(), 200),
    -- 2017 Spring Month 1
    (UUID(), 'monthly', '2017', '1', 'Spring', '2017-02-28 22:00:01', '2017-03-31 20:59:59', 0, NOW(), 0),
    -- 2017 Spring Month 2
    (UUID(), 'monthly', '2017', '2', 'Spring', '2017-03-31 21:00:00', '2017-04-30 20:59:59', 0, NOW(), 0),
    -- 2017 Autumn
    (UUID(), 'seasonal', '2017', NULL, 'Autumn', '2017-08-31 21:00:01', '2017-11-30 22:00:00', 0, NOW(), 200),
    -- 2017 Autumn Month 1
    (UUID(), 'monthly', '2017', '1', 'Autumn', '2017-08-31 21:00:01', '2017-09-30 20:59:59', 0, NOW(), 0),
    -- 2017 Autumn Month 2
    (UUID(), 'monthly', '2017', '2', 'Autumn', '2017-09-30 21:00:00', '2017-10-31 21:59:59', 0, NOW(), 0),
    -- 2017 Winter
    (UUID(), 'seasonal', '2017', NULL, 'Winter', '2017-11-30 22:00:01', '2018-02-28 22:00:00', 0, NOW(), 200),
    -- 2017 Winter Month 1
    (UUID(), 'monthly', '2017', '1', 'Winter', '2017-11-30 22:00:01', '2017-12-31 21:59:59', 0, NOW(), 0),
    -- 2017 Winter Month 2
    (UUID(), 'monthly', '2017', '2', 'Winter', '2017-12-31 22:00:00', '2018-01-31 21:59:59', 0, NOW(), 0),
    -- 2018 Spring
    (UUID(), 'seasonal', '2018', NULL, 'Spring', '2018-02-28 22:00:01', '2018-05-31 21:00:00', 0, NOW(), 200),
    -- 2018 Spring Month 1
    (UUID(), 'monthly', '2018', '1', 'Spring', '2018-02-28 22:00:01', '2018-03-31 20:59:59', 0, NOW(), 0),
    -- 2018 Spring Month 2
    (UUID(), 'monthly', '2018', '2', 'Spring', '2018-03-31 21:00:00', '2018-04-30 20:59:59', 0, NOW(), 0);
