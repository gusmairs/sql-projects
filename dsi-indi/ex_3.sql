-- Day of week with most buys
-- Could interpret as day meal introduced (from meals) or purchased (from events)

-- For day actually purchased

-- select
--    date_part('dow', dt) as day_of_purch,
--    count(case when event = 'bought' then 1 end) as sold
-- from events
-- group by 1 order by 2 desc
-- limit 1
;

-- For day the meal was introduced

select
   date_part('dow', meals.dt) as day_of_intro,
   count(1) as sold
from meals
   join events on meals.meal_id = events.meal_id and event = 'bought'
group by 1 order by sold desc
;
