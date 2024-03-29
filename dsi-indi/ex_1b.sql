-- Creates tally table to run complex query on, then
-- creates table of the 4 max counts, then joins back to the tally table,
-- matching on the max tally and the campaign_id, works fast

with tally as (
   select x.userid, users.campaign_id, x.user_count
   from (
      select u.userid, count(e.userid) as user_count
      from users u
         join events e on u.userid = e.userid and e.event = 'bought'
      group by u.userid
   ) x
      join users on users.userid = x.userid
)

select t.campaign_id, t.userid, t.user_count
from (
   select campaign_id, max(user_count) as max_bought
   from tally group by campaign_id
) as x
   join tally as t on t.campaign_id = x.campaign_id and t.user_count = x.max_bought
;
