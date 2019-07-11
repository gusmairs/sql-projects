-- For each user, determine the user they exchange the most messages
-- with, outgoing plus incoming

select user_id, othr_id
from (
   select
      userid as user_id,
      othr_id,
      rank() over (partition by userid order by count(othr_id) desc)
   from (
      select r.userid, m.recipient othr_id
      from registrations r
         join messages m on r.userid = m.sender
      union all
      select r.userid, m.sender othr_id
      from registrations r
         join messages m on r.userid = m.recipient
   ) m
   group by 1, 2 order by 1
) r
where rank = 1
;
