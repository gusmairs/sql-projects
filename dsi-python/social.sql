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
;

-- create temp table last_7 as (
--    select distinct
--       userid,
--       '2014-08-14' - date(tmstmp) log_days,
--       type log_type
--    from logins
--    where '2014-08-14' - date(tmstmp) < 7
--    order by 1, 2
-- )
-- ;

select
   userid,
   count(distinct log_days) seven,
   sum(case when log_type = 'mobile' then 1 else 0 end) mobile,
   sum(case when log_type = 'web' then 1 else 0 end) web
from last_7
group by 1 order by 1
;
