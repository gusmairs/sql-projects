-- Break the users into 10 cohorts based on their number of friends
-- and get the average number of messages for each group

drop table activity
;
create temp table activity as
   select id, fds, count(message) msgs
   from (
      select f.userid1 id, count(f.userid2) fds
      from (
         select * from friends
         except
         select userid2, userid1 from friends
      ) f
      group by 1 order by 1
   ) t
   join messages m on t.id = m.recipient
   group by 1, 2 order by 1
;

select grp, round(avg(msgs)) m_sum, round(sum(msgs) / sum(fds)) m_rte from (
   select *, cume::int / 100 grp from (
      select
         fds,
         msgs,
         count(id) hist,
         sum(count(id)) over (order by fds) cume
      from activity
      group by 1, 2
   ) x
) y
group by 1 order by 1
;

grp | m_sum | m_rte
----+-------+-------
  0 |   276 |    79
  1 |   353 |    64
  2 |   390 |    56
  3 |   421 |    53
  4 |   481 |    53
  5 |   506 |    51
  6 |   553 |    50
  7 |   612 |    51
  8 |   629 |    47
  9 |   697 |    42
(10 rows)
