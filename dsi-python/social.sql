-- create table logins_7d as (
   -- select
   --    lg.userid,
   --    date(reg.tmstmp) as reg_date,
   --    '2014-08-14' - date(max(lg.tmstmp)) as latest,
   --    count(distinct '2014-08-14' - date(lg.tmstmp)) last_7
   -- from registrations reg join logins lg
   --    on reg.userid = lg.userid and '2014-08-14' - date(lg.tmstmp) < 7
   -- group by 1, 2
   -- order by 1
-- )
-- ;

-- select
--    lg.userid,
--    date(reg.tmstmp) as reg_date,
--    '2014-08-14' - date(max(lg.tmstmp)) as latest
-- from registrations reg join logins lg on reg.userid = lg.userid
-- group by 1, 2 order by 1
-- ;

drop table if exists last_7
;

create temp table last_7 as (
   select distinct
      userid,
      '2014-08-14' - date(tmstmp) log_days,
      type log_type
   from logins
   where '2014-08-14' - date(tmstmp) < 7
   order by 1, 2
)
;

with tally as (
   select
      userid,
      count(distinct log_days) svn,
      sum(case when log_type = 'mobile' then 1 else 0 end) phn,
      sum(case when log_type = 'web' then 1 else 0 end) web
   from last_7
   group by 1 order by 1
)

select
   r.userid id,
   date(r.tmstmp) reg,
   '2014-08-14' - date(max(g.tmstmp)) lst,
   t.svn,
   t.phn,
   t.web,
   case when r.userid in (select userid from optout)
      then 'out' else ' . ' end as out
from registrations r
   left join tally t on t.userid = r.userid
   left join logins g on g.userid = r.userid
group by 1, 2, 4, 5, 6 order by 1
;
