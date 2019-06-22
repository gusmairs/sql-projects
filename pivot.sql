-- create temp table pivt as (
--    select
--       'm-' || meal_id as meal,
--       type,
--       rank() over (partition by type order by meal_id) as rw
--    from meals
--    where type in ('italian', 'french', 'chinese') and meal_id <= 20
--    order by 2, 3
-- )
-- ;
-- select
--    row_number() over (partition by null) as idx,
--    *
-- from pivt
-- ;

-- create temp table ital as (
--    select rw, meal from pivt where type = 'italian'
-- )
-- ;
-- create temp table french as (
--    select rw, meal from pivt where type = 'french'
-- )
-- ;
-- create temp table chinese as (
--    select rw, meal from pivt where type = 'chinese'
-- )
-- ;

select distinct * from (
   select
      ital.meal ita,
      french.meal fre
      -- chinese.meal chi
   from ital cross join french cross join chinese
) x
order by 1, 2
;
