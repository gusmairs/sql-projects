-- What percent of users have shared more meals than they have liked?

select count(case when shared > liked then 1 end)::real
   / (select count(userid) from users)
from (
   select
      userid,
      count(case when event = 'share' then 1 end) shared,
      count(case when event = 'like' then 1 end) liked
   from events
   group by userid
) x
;
