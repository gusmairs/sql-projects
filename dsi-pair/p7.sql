-- For each user, determine the user they exchange the most messages
-- with, outgoing plus incoming, using message length not count

select user_id, othr_id
from (
   select
      userid user_id,
      othr_id,
      sum(len),
      rank() over(partition by userid order by sum(len) desc)
   from (
      select r.userid, m.recipient othr_id, length(m.message) len
      from registrations r
         join messages m on r.userid = m.sender
      union all
      select r.userid, m.sender othr_id, length(m.message) len
      from registrations r
         join messages m on r.userid = m.recipient
   ) m
   group by 1, 2 order by 1
) r
where rank = 1
;
