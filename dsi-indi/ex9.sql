-- Find all the users who bought a meal before liking or sharing a meal.

-- select distinct e1.userid, e1.meal_id, e1.dt, e1.event, e2.dt, e2.event
-- from events e1 join events e2 on
--    e1.userid = e2.userid and
--    e1.meal_id = e2.meal_id and
--    e1.dt < e2.dt
-- where e1.event = 'bought' and e2.event in ('like', 'share')
-- order by 1, 3
-- ;
