-- Not logged in 7 days and not yet opted out

select userid, max(date(tmstmp)) as last_login
from logins
where userid not in (
   select userid from optout
)
group by userid
having '2014-08-14' - max(date(tmstmp)) >= 7
order by 2 desc
;
