-- For every user, get the number of users who registered on
-- the same day as them

select r1.userid, date(r1.tmstmp), count(r2.userid)
from registrations r1
   join registrations r2 on date(r1.tmstmp) = date(r2.tmstmp)
group by 1, 2
;
