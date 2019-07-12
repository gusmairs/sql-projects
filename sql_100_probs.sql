-- Is this from dsi stuff or elsewhere

-- 100 ds problems 1
select users.name
from users
left join checkouts on users.user_id = checkouts.user_id
group by users.user_id
having current_date - max(checkouts.checkout_time) <= 30;

-- 100 ds problems 2
select users.name and current_date - max(checkouts.checkout_time) as len
from users
left join checkouts on users.user_id = checkouts.user_id
group by users.user_id
having len > 30 and checkouts.return_time is null
order by len desc;
