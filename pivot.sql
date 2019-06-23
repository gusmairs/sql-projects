create temp table food as (
   select
      meal_id as meal,
      type
   from meals
   where type in ('italian', 'french', 'chinese') and meal_id <= 20
)
;
with pivt as (
   select
      meal,
      type,
      rank() over (partition by type order by meal) as rw
   from food
   order by 2, 3
)
select i.meal ita, f.meal fra, c.meal chi
from (select * from pivt where type = 'italian') i
   left join pivt f on f.rw = i.rw and f.type = 'french'
   left join pivt c on c.rw = f.rw and c.type = 'chinese'
;

-- Other HackerRank worth understanding
--
-- with pivt as (
--    select
--       meal_id as meal,
--       type
--    from meals
--    where type in ('italian', 'french', 'chinese') and meal_id <= 20
-- )
-- select min(italian), min(french), min(chinese)
-- from (
--    select
--       rank() over (partition by type order by meal) rank,
--       case type when 'italian' then meal end italian,
--       case type when 'french' then meal end french,
--       case type when 'chinese' then meal end chinese
--    from pivt
-- ) x
-- group by rank
-- order by rank
-- ;


--
-- select i.meal ita, f.meal fra, c.meal chi
-- from (select * from pivt where type = 'italian') i
--    left join (select * from pivt where type = 'french') f on i.rw = f.rw
--    left join (select * from pivt where type = 'chinese') c on i.rw = c.rw
-- ;



-- My HackerRank correct
--
-- with pivt as (
--    select
--       name,
--       occupation,
--       rank() over (partition by occupation order by name) as rw
--    from occupations
--    order by 2, 3
-- )
-- select d.name Doctor, p.name Professor, s.name Singer, a.name Actor
-- from (select * from pivt where occupation = 'Professor') p
--    left join (select * from pivt where occupation = 'Singer') s
--       on s.rw = p.rw
--    left join (select * from pivt where occupation = 'Actor') a
--       on a.rw = s.rw
--    left join (select * from pivt where occupation = 'Doctor') d
--       on d.rw = a.rw
-- order by p.rw
-- ;
