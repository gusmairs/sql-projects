-- Creates tally table to run complex query on, then
-- uses the rank() window function to get a ranked table
-- by group, then selects rank = 1 from that table

with tally as (
   select x.userid id, users.campaign_id grp, x.user_count cnt
   from (
      select u.userid, count(e.userid) as user_count
      from users u join events e on u.userid = e.userid and e.event = 'bought'
      group by u.userid
   ) as x
   join users on users.userid = x.userid
)
select grp, id, rank, cnt from (
   select
      id,
      grp,
      cnt,
      rank() over (partition by grp order by cnt desc)
   from tally
) group_rankings
where rank = 1
order by cnt desc
;
