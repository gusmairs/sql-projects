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
   array_agg (case when type = 'french' then meal end) as chi
   -- array_agg (case when type = 'french' then meal end) as fre,
   -- array_agg (case when type = 'italian' then meal end) as ita
from pivt
;
