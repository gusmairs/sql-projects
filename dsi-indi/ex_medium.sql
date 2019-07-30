-- dsi indi subquery extra credit

-- 1. meals above avg price
select meal_id, price from meals
where price > (
   select avg(price) from meals
)
;

-- 2. meals above avg for that type
select m.meal_id, m.type, m.price, a.average from meals m
   join (
      select type, avg(price) average from meals
      group by 1
   ) a on m.type = a.type and m.price > a.average
;

-- 3. count of meals above avg for that type
select m.type, count(m.meal_id)
from meals m
   join (
      select type, avg(price) average from meals
      group by 1
   ) a
   on m.type = a.type and m.price > a.average
group by 1
;

-- 4. percent of users that come from each service
select
   campaign_id,
   count(userid),
   count(userid)::real / (
      select count(userid) from users
   ) pct
from users
group by 1
;
