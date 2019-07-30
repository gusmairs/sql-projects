-- dsi indi
-- readychef postgres db examples

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

--
-- sorting

-- 1-3. average per type
select type, avg(price) avg_price from meals
group by type order by avg_price desc
;

-- 4-5. all meals in order
select type, price from meals
order by 1, 2 desc
;

--
-- joins

-- 1. simple join
select u.userid, u.campaign_id, e.meal_id, e.event
from users u natural join events e
;

-- 2. two joins, filter in join clause
select u.userid, u.campaign_id, e.meal_id, m.type, m.price
from users u
   natural join events e
   join meals m on e.meal_id = m.meal_id and e.event = 'bought'
;

-- 3. group totals, filter clause
select m.type, count(m.meal_id)
from meals m
   join events e on m.meal_id = e.meal_id and e.event = 'bought'
group by 1 order by 2 desc
;
