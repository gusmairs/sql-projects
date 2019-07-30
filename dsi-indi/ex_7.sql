-- For every day, count the number of users who have visited the site
-- and done no action
--
select v.dt, count(v.dt)
from visits v
   left join events e on v.userid = e.userid and v.dt = e.dt
where e.event is null
group by 1 order by 1
;
