-- Users who have logged in on mobile more times than web,
-- only target users in test group A

select userid from (
   select
      lg.userid,
      count(case when lg.type = 'mobile' then 1 end) mobile,
      count(case when lg.type = 'web' then 1 end) web
   from logins lg join test_group g on lg.userid = g.userid and g.grp = 'A'
   group by 1
) mw
where mobile > web
;
