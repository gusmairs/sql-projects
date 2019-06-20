-- Write a query which gets each user, the number of friends and
-- the number of messages received

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
