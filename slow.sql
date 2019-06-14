-- Uses subquery, takes 4 seconds but reads clearly
-- Hard to imagine using with big data

select campaign_id, userid, user_count
from tally
where user_count = (
   select max(user_count)
   from tally as t
   where t.campaign_id = tally.campaign_id
  )
;
