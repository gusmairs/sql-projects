-- Combine 6 and 7 to compare ranking methods

select sum(same), count(user_id), sum(same)::real/count(user_id)
from (
   select
      user_id,
      othr_id,
      case when by_cnt = by_len then 1 else 0 end same
   from (
      select
         userid user_id,
         othr_id,
         rank() over(
            partition by userid order by count(othr_id) desc
         ) by_cnt,
         rank() over(
            partition by userid order by sum(len) desc
         ) by_len
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
   where by_len = 1
) c
;
