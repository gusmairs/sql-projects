-- HackerRank problem that most solved either with rediculous
-- variable creation and looping or using a 'pivot' command
-- that may be built into Oracle SQL (Postgres has it in a
-- separate tables package).

create temp table if not exists food as (
   select
      meal_id as meal,
      type
   from meals
   where type in ('italian', 'french', 'chinese') and meal_id <= 20
)
;

-- My working solution based on the readychef data

-- with pivt as (
--    select
--       meal,
--       type,
--       rank() over (partition by type order by meal) as rw
--    from food
--    order by 2, 3
-- )
-- select i.meal ita, f.meal fra, c.meal chi
-- from (select * from pivt where type = 'italian') i
--    left join pivt f on f.rw = i.rw and f.type = 'french'
--    left join pivt c on c.rw = f.rw and c.type = 'chinese'
-- ;

-- Other HackerRank solution worth understanding

-- The case statements bring categories to columns
-- The 'min(italian)' are a trick to use grouping just grab items
-- in order of rank
-- Avoids having to manually choose the most populated category
-- first, then next, then next

select min(french) fre, min(italian) ita, min(chinese) chi
from (
   select
      rank() over (partition by type order by meal) rank,
      case type when 'chinese' then meal end chinese,
      case type when 'french' then meal end french,
      case type when 'italian' then meal end italian
   from food
) x
group by rank
order by rank
;

-- My HackerRank correct, had to make each subtable due to
-- Oracle code adjustment struggles
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
