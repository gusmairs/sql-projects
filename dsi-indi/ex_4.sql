-- Which month had the highest percent of users who visited the site purchase a meal?

select mon, round(bought_count::numeric/visit_count, 3) as pct
from (
   select
      date_part('month', v.dt) as mon,
      count((case when e.event = 'bought' then 1 end)) as bought_count,
      count(v.userid) as visit_count
   from visits v join events e on v.userid = e.userid and v.dt = e.dt
   group by 1
) as x
order by pct desc
;

-- select mth, count(ate), count(usr)
-- from (
--    select
--       date_part('month', v.dt) as mth,
--       v.userid as usr,
--       case when e.event = 'bought' then 1 end as ate
--    from visits v join events e on v.userid = e.userid
--    ) as x
-- group by 1
-- ;
