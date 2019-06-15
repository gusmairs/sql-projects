-- Fast version creates daily count table first then sums
--
with day_count as (
   select dt, count(userid) as registered
   from users
   group by dt
)
select a.dt, sum(b.registered)
from day_count a join day_count b on b.dt <= a.dt
group by a.dt order by a.dt
;

-- Slow because self-join traverses whole list over and over
--
-- select ua.dt, count(distinct ub.userid) as cnt
-- from users ua join users ub on ub.dt <= ua.dt
-- group by ua.dt order by ua.dt
-- ;
