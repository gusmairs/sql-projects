-- create temp table pivt as (
--    select
--       meal_id as meal,
--       type,
--       rank() over (partition by type order by meal_id) as alph
--    from meals
--    where type in ('italian', 'french', 'chinese') and meal_id <= 20
--    order by 3, 2
-- )
-- ;

select
   distinct alph,
   type,
   meal
from pivt
;
