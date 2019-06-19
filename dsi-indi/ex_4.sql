-- Which month had the highest percent of users who visited the site purchase a meal?

select mth, round(ate_count::numeric/visit_count, 4) as pct
from (
   select
      date_part('month', v.dt) as mth,
      count((case when e.event = 'bought' then 1 end)) as ate_count,
      count(v.userid) as visit_count
   from visits v join events e on v.userid = e.userid
   group by 1
) as x
order by 2 desc
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
