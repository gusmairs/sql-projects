-- Uses subquery, takes 4 seconds but reads clearly
-- Hard to imagine how slow using this with big data

select campaign_id, userid, user_count
from tally
where user_count = (
   select max(user_count)
   from tally t
   where t.campaign_id = tally.campaign_id
  )
;
