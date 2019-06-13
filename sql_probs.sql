-- ReadyChef DB Examples

-- Simple where clause
SELECT userid, dt FROM users WHERE campaign_id = 'TW';

-- Simple aggregation
select count(*) from users
where campaign_id = 'FB';

-- Aggregation by groups
SELECT campaign_id, COUNT(*)
FROM users
GROUP BY campaign_id;

-- Using DISTINCT, inside parens
SELECT COUNT (DISTINCT dt)
FROM users;

-- Using min and max
SELECT MIN(dt), MAX(dt)
FROM users;

-- Multiple aggregates within groups
SELECT type, AVG(price), MIN(price), MAX(price)
FROM meals
GROUP BY type;

-- Using date functions
SELECT type, AVG(price), MIN(price), MAX(price)
FROM meals
WHERE DATE_PART('month', dt) <= 3 AND DATE_PART('year', dt) = 2013
GROUP BY type;

-- Grouping by more than one column
SELECT type, DATE_PART('month', dt) AS month, AVG(price), MIN(price), MAX(price)
FROM meals
WHERE DATE_PART('month', dt) <= 3 AND DATE_PART('year', dt) = 2013
GROUP BY type, month;


-- Two joins, filter clause
select us.userid, us.campaign_id, ev.meal_id, me.type, me.price, ev.event
from events as ev
join users as us on us.userid = ev.userid
join meals as me on ev.meal_id = me.meal_id and ev.event = 'bought'

-- Group, filter clause
select me.type, count(*)
from meals as me
join events as ev on me.meal_id = ev.meal_id and ev.event = 'bought'
group by me.type;

-- 100 DS Problems 1
SELECT users.name
FROM users
LEFT JOIN checkouts ON users.user_id = checkouts.user_id
GROUP BY users.user_id
HAVING CURRENT_DATE - MAX(checkouts.checkout_time) <= 30;

-- 100 DS Problems 2
SELECT users.name AND CURRENT_DATE - MAX(checkouts.checkout_time) AS len
FROM users
LEFT JOIN checkouts ON users.user_id = checkouts.user_id
GROUP BY users.user_id
HAVING len > 30 AND checkouts.return_time IS NULL
ORDER BY len DESC;
