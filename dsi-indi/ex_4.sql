-- Which month had the highest percent of users who visited the site purchase a meal?
-- Could check each visit for a buy, then tally

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

-- Or tally all visits and buys, then calculate average

-- select v.mon, e.cnt::real / v.cnt avg
-- from (
--    select date_part('month', dt) mon, count(1) cnt
--    from visits
--    group by 1
-- ) v
-- join (
--    select date_part('month', dt) mon, count(1) cnt
--    from events
--    where event='bought'
--    group by 1
-- ) e
-- on v.mon = e.mon
-- order by avg desc
-- limit 1
-- ;
