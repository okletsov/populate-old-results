-- main.annual_points definition

CREATE TABLE `annual_points` (
  `id` int(11) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- main.background_job definition

CREATE TABLE `background_job` (
  `id` varchar(36) NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- main.contest definition

CREATE TABLE `contest` (
  `id` varchar(36) NOT NULL,
  `type` varchar(8) NOT NULL,
  `year` varchar(4) NOT NULL,
  `month` varchar(9) DEFAULT NULL,
  `season` varchar(6) DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `is_active` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `entrance_fee` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- main.finance_actions definition

CREATE TABLE `finance_actions` (
  `id` int(11) NOT NULL,
  `description` text NOT NULL,
  `description_rus` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- main.prediction_duplicate definition

CREATE TABLE `prediction_duplicate` (
  `id` varchar(36) NOT NULL,
  `original_sport` varchar(45) NOT NULL,
  `original_market` varchar(10) NOT NULL,
  `original_option_name` varchar(10) NOT NULL,
  `original_option_value` varchar(10) NOT NULL,
  `candidate_sport` varchar(45) NOT NULL,
  `candidate_market` varchar(10) NOT NULL,
  `candidate_option_name` varchar(10) NOT NULL,
  `candidate_option_value` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- main.`user` definition

CREATE TABLE `user` (
  `id` varchar(36) NOT NULL,
  `username` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- main.validity_statuses definition

CREATE TABLE `validity_statuses` (
  `status` int(11) NOT NULL,
  `count_in_contest` tinyint(4) NOT NULL,
  `count_lost` tinyint(4) NOT NULL,
  `count_void` tinyint(4) NOT NULL,
  `description` text NOT NULL,
  `description_rus` text NOT NULL,
  PRIMARY KEY (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- main.warning_statuses definition

CREATE TABLE `warning_statuses` (
  `status` int(11) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- main.annual_x_seasonal_contest definition

CREATE TABLE `annual_x_seasonal_contest` (
  `id` varchar(36) NOT NULL,
  `annual_contest_id` varchar(36) NOT NULL,
  `seasonal_contest_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `annual_contest_id_x_contest_id_idx` (`annual_contest_id`),
  KEY `seasonal_contest_id_x_contest_id_idx` (`seasonal_contest_id`),
  CONSTRAINT `annual_contest_id_x_contest_id` FOREIGN KEY (`annual_contest_id`) REFERENCES `contest` (`id`),
  CONSTRAINT `seasonal_contest_id_x_contest_id` FOREIGN KEY (`seasonal_contest_id`) REFERENCES `contest` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- main.background_job_log definition

CREATE TABLE `background_job_log` (
  `id` varchar(36) NOT NULL,
  `background_job_id` varchar(36) NOT NULL,
  `finish_timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `KF_background_job_x_background_job_log_idx` (`background_job_id`),
  CONSTRAINT `KF_background_job_x_background_job_log` FOREIGN KEY (`background_job_id`) REFERENCES `background_job` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- main.cr_annual definition

CREATE TABLE `cr_annual` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `contest_id` varchar(36) NOT NULL,
  `place` int(11) NOT NULL,
  `sum_annual_points` int(11) NOT NULL,
  `best_place` int(11) NOT NULL,
  `best_place_count` int(11) NOT NULL,
  `second_best_place` int(11) DEFAULT NULL,
  `second_best_place_count` int(11) DEFAULT NULL,
  `third_best_place` int(11) DEFAULT NULL,
  `avg_roi` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_x_cr_annual_idx` (`user_id`),
  KEY `FK_contest_x_cr_annual_idx` (`contest_id`),
  CONSTRAINT `FK_contest_x_cr_annual` FOREIGN KEY (`contest_id`) REFERENCES `contest` (`id`),
  CONSTRAINT `FK_user_x_cr_annual` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- main.cr_biggest_odds definition

CREATE TABLE `cr_biggest_odds` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `contest_id` varchar(36) NOT NULL,
  `nickname` varchar(45) NOT NULL,
  `user_pick_value` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cr_biggest_odds_x_user_idx` (`user_id`),
  KEY `cr_biggest_odds_x_contest_idx` (`contest_id`),
  CONSTRAINT `cr_biggest_odds_x_contest` FOREIGN KEY (`contest_id`) REFERENCES `contest` (`id`),
  CONSTRAINT `cr_biggest_odds_x_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- main.cr_finance definition

CREATE TABLE `cr_finance` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `contest_id` varchar(36) NOT NULL,
  `finance_action_id` int(11) NOT NULL,
  `action_value` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cr_finance_x_user_idx` (`user_id`),
  KEY `cr_finance_x_contest_idx` (`contest_id`),
  KEY `cr_finance_x_finance_action_idx` (`finance_action_id`),
  CONSTRAINT `cr_finance_x_contest` FOREIGN KEY (`contest_id`) REFERENCES `contest` (`id`),
  CONSTRAINT `cr_finance_x_finance_action` FOREIGN KEY (`finance_action_id`) REFERENCES `finance_actions` (`id`),
  CONSTRAINT `cr_finance_x_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- main.cr_general definition

CREATE TABLE `cr_general` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `contest_id` varchar(36) NOT NULL,
  `annual_points` int(11) NOT NULL,
  `nickname` varchar(45) NOT NULL,
  `place` int(11) NOT NULL,
  `final_bets_count` int(11) NOT NULL,
  `orig_bets_count` int(11) DEFAULT NULL,
  `won` decimal(6,2) DEFAULT NULL,
  `lost` decimal(5,2) DEFAULT NULL,
  `units` decimal(5,2) NOT NULL,
  `roi` decimal(5,2) NOT NULL,
  `active_days` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_x_contest_results_idx` (`user_id`),
  KEY `FK_contest_x_contest_result_idx` (`contest_id`),
  KEY `FK_cr_general_x_annual_points_idx` (`annual_points`),
  CONSTRAINT `FK_contest_x_cr_general` FOREIGN KEY (`contest_id`) REFERENCES `contest` (`id`),
  CONSTRAINT `FK_user_x_cr_general` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- main.cr_winning_strick definition

CREATE TABLE `cr_winning_strick` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `contest_id` varchar(36) NOT NULL,
  `nickname` varchar(45) NOT NULL,
  `strick_length` int(11) NOT NULL,
  `strick_avg_odds` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cr_winning_strick_x_user_idx` (`user_id`),
  KEY `cr_winning_strick_x_contest_idx` (`contest_id`),
  CONSTRAINT `cr_winning_strick_x_contest` FOREIGN KEY (`contest_id`) REFERENCES `contest` (`id`),
  CONSTRAINT `cr_winning_strick_x_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- main.finance_offset definition

CREATE TABLE `finance_offset` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `finance_action_id` int(11) NOT NULL,
  `action_value` decimal(8,2) NOT NULL,
  `action_date` datetime NOT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `finance_offset_x_user_idx` (`user_id`),
  KEY `finance_offset_x_finance_actions_idx` (`finance_action_id`),
  CONSTRAINT `finance_offset_x_finance_actions` FOREIGN KEY (`finance_action_id`) REFERENCES `finance_actions` (`id`),
  CONSTRAINT `finance_offset_x_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- main.prediction definition

CREATE TABLE `prediction` (
  `id` varchar(36) NOT NULL,
  `seasonal_contest_id` varchar(36) NOT NULL,
  `monthly_contest_id` varchar(36) DEFAULT NULL,
  `seasonal_validity_status` int(11) DEFAULT NULL,
  `monthly_validity_status` int(11) DEFAULT NULL,
  `seasonal_validity_status_overruled` tinyint(4) NOT NULL DEFAULT 0,
  `monthly_validity_status_overruled` tinyint(4) NOT NULL DEFAULT 0,
  `user_id` varchar(36) NOT NULL,
  `event_identifier` varchar(100) DEFAULT NULL,
  `sport` varchar(45) NOT NULL,
  `region` varchar(45) NOT NULL,
  `tournament_name` varchar(100) NOT NULL,
  `main_score` varchar(45) DEFAULT NULL,
  `detailed_score` varchar(100) DEFAULT NULL,
  `result` varchar(10) DEFAULT NULL,
  `date_scheduled` datetime DEFAULT NULL,
  `date_predicted` datetime NOT NULL,
  `competitors` varchar(100) NOT NULL,
  `market` varchar(100) NOT NULL,
  `market_url` text DEFAULT NULL,
  `option1_name` varchar(45) NOT NULL,
  `option1_value` decimal(5,2) NOT NULL,
  `option2_name` varchar(45) DEFAULT NULL,
  `option2_value` decimal(5,2) DEFAULT NULL,
  `option3_name` varchar(45) DEFAULT NULL,
  `option3_value` decimal(5,2) DEFAULT NULL,
  `user_pick_name` varchar(45) NOT NULL,
  `user_pick_value` decimal(5,2) NOT NULL,
  `unit_outcome` decimal(5,2) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `seasonal_warning_status` int(11) DEFAULT NULL,
  `monthly_warning_status` int(11) DEFAULT NULL,
  `feed_url` text DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  `date_validated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_contest_x_prediction_seasonal_idx` (`seasonal_contest_id`),
  KEY `FK_contest_x_prediction_monthly_idx` (`monthly_contest_id`),
  KEY `FK_user_x_prediction_idx` (`user_id`),
  KEY `FK_validity_x_prediction_idx` (`seasonal_validity_status`),
  KEY `FK_validity_statuses_x_monthly_validity_status` (`monthly_validity_status`),
  CONSTRAINT `FK_contest_x_prediction_monthly` FOREIGN KEY (`monthly_contest_id`) REFERENCES `contest` (`id`),
  CONSTRAINT `FK_contest_x_prediction_seasonal` FOREIGN KEY (`seasonal_contest_id`) REFERENCES `contest` (`id`),
  CONSTRAINT `FK_user_x_prediction` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_validity_statuses_x_monthly_validity_status` FOREIGN KEY (`monthly_validity_status`) REFERENCES `validity_statuses` (`status`),
  CONSTRAINT `FK_validity_statuses_x_seasonal_validity_status` FOREIGN KEY (`seasonal_validity_status`) REFERENCES `validity_statuses` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- main.prediction_schedule_changes definition

CREATE TABLE `prediction_schedule_changes` (
  `id` varchar(36) NOT NULL,
  `prediction_id` varchar(36) NOT NULL,
  `previous_date_scheduled` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_prediction_x_prediction_schedule_changes_idx` (`prediction_id`),
  CONSTRAINT `FK_prediction_x_prediction_schedule_changes` FOREIGN KEY (`prediction_id`) REFERENCES `prediction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- main.user_nickname definition

CREATE TABLE `user_nickname` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `nickname` varchar(45) NOT NULL,
  `is_active` int(11) NOT NULL,
  `portal_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_id_idx` (`user_id`),
  CONSTRAINT `FK_user_x_user_nickname` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- main.user_seasonal_contest_participation definition

CREATE TABLE `user_seasonal_contest_participation` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `contest_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_idx` (`user_id`),
  KEY `FK_contest_idx` (`contest_id`),
  CONSTRAINT `FK_contest_x_user_seasonal_contest_participation` FOREIGN KEY (`contest_id`) REFERENCES `contest` (`id`),
  CONSTRAINT `FK_user_x_user_seasonal_contest_participation` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- main.comments definition

CREATE TABLE `comments` (
  `id` varchar(36) NOT NULL,
  `prediction_id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `comment` text NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_prediction_FK` (`prediction_id`),
  KEY `comments_user_FK` (`user_id`),
  CONSTRAINT `comments_prediction_FK` FOREIGN KEY (`prediction_id`) REFERENCES `prediction` (`id`),
  CONSTRAINT `comments_user_FK` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- main.seasonal_x_monthly_contest source

CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `seasonal_x_monthly_contest` AS
select
    `c`.`id` AS `seasonal_contest_id`,
    `c2`.`id` AS `monthly_contest_id`,
    `c2`.`month` AS `month`
from
    (`contest` `c`
join `contest` `c2` on
    (`c`.`year` = `c2`.`year` and `c`.`season` = `c2`.`season` and `c2`.`type` = 'monthly'))
where
    `c`.`type` = 'seasonal';