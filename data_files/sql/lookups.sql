SET @nickname = 'example_nickname';
SET @year = 'YYYY';
SET @season = 'example_season';
SET @month = 1;

-- user_id lookup
select user_id
from user_nickname  
where nickname = @nickname;

-- contest_id lookup
select id
from contest
where `year` = @year
	and season = @season
	and `type` = 'seasonal';

-- mon_X contest_id lookup
select sxmc.monthly_contest_id 
from seasonal_x_monthly_contest sxmc 
where sxmc.seasonal_contest_id = (
		select
			id
		from contest
		where year = '2015'
			and season = 'winter'
			and `type` = 'seasonal'
	)
	and sxmc.`month` = @month;