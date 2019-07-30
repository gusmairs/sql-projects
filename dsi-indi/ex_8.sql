-- Find all the days with a greater than average number of meals.

select dt, count(meal_id) as ct
from meals
group by dt
having count(meal_id) > (
   select count(meal_id) / count(distinct dt)::real
   from meals
)
order by 1 limit 10
;
