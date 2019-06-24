create table logins_7d as (
   select
      lg.userid,
      reg.tmstmp as reg_date,
      max(lg.tmstmp) as last_login
   from registrations reg join logins lg on reg.userid = lg.userid
   group by 1, 2
)
;
