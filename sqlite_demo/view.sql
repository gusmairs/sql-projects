-- Uses the dsi demo database 'markets.db'
-- Quick demo of view code, sql read from sqlite prompt

drop view if exists large_pop
;

create view large_pop as
   select state, pop2010 from statepopulations
   order by pop2010 desc
   limit 10
;
