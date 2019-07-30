-- Fast version creates daily count table first then sums with self-join

with day_count as (
   select dt, count(userid) as registered
   from users
   group by dt
)

select a.dt, sum(b.registered)
from day_count a
   join day_count b on b.dt <= a.dt
group by a.dt order by a.dt
;
