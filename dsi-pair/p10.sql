-- Break the users into 10 cohorts based on their number of friends
-- and get the average number of messages for each group

create table active_summary as
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
