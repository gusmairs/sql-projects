select
   s.state,
   case when count(f.fmid) = 0 then 0 else s.pop2010 / count(f.fmid) end
from statepopulations s
   left join farmersmarkets f on s.state = f.state
group by 1, s.pop2010
;
