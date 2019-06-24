-- Break the users into 10 cohorts based on their number of friends
-- and get the average number of messages for each group

create temp table if not exists activity as
   select user_id, frnds, count(message) msgs
   from (
      select f.userid1 user_id, count(f.userid2) frnds
      from (
         select * from friends
         except
         select userid2, userid1 from friends
      ) f
      group by 1 order by 1
   ) t
   join messages m on t.user_id = m.recipient
   group by 1, 2 order by 1
;

-- select
--    user_id,
--    frnds,
--    ntile(10) over (partition by frnds order by frnds) bucket
-- from activity
-- order by 3, 2
-- ;

with tmp as (
   select
      frnds fr,
      count(user_id) ct,
      sum(count(user_id)) over (order by frnds) sm,
      ntile(10) over (order by 1) nt
   from activity
   group by frnds
)
select *, sm::int / 100 bucket from tmp
;
