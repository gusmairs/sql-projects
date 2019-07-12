-- readychef db examples
--
-- aggregates

-- 1. simple aggregation
select count(*) from users
where campaign_id = 'fb'
;

-- 2. aggregation by groups
select campaign_id, count(*)
from users
group by campaign_id
;

-- 3. using distinct, inside parens
select count (distinct dt)
from users
;

-- 4. using min and max
select min(dt), max(dt)
from users
;

-- 5. avg price
select avg(price) from meals
;

-- 6-7. multiple aggregates within groups
select type, avg(price) avg_price, min(price) min_price, max(price) max_price
from meals
group by type
;

-- 8. using date functions
select type, avg(price), min(price), max(price)
from meals
where date_part('month', dt) <= 3 and date_part('year', dt) = 2013
group by type
;

-- 9. grouping by more than one column
select type, date_part('month', dt) as month, avg(price), min(price), max(price)
from meals
where date_part('month', dt) <= 3 and date_part('year', dt) = 2013
group by type, month
;

-- 10. conditional totals by group
select
   meal_id,
   sum(case when event = 'bought' then 1 end) buys,
   sum(case when event = 'like' then 1 end) likes,
   sum(case when event = 'share' then 1 end) shares
from events
group by meal_id
;

-- sorting

-- 1-2. average per type
select type, avg(price) from meals
group by type order by type
;

-- two joins, filter clause
select us.userid, us.campaign_id, ev.meal_id, me.type, me.price, ev.event
from events as ev
join users as us on us.userid = ev.userid
join meals as me on ev.meal_id = me.meal_id and ev.event = 'bought'

-- group, filter clause
select me.type, count(*)
from meals as me
join events as ev on me.meal_id = ev.meal_id and ev.event = 'bought'
group by me.type;




-- 100 ds problems 1
select users.name
from users
left join checkouts on users.user_id = checkouts.user_id
group by users.user_id
having current_date - max(checkouts.checkout_time) <= 30;

-- 100 ds problems 2
select users.name and current_date - max(checkouts.checkout_time) as len
from users
left join checkouts on users.user_id = checkouts.user_id
group by users.user_id
having len > 30 and checkouts.return_time is null
order by len desc;
