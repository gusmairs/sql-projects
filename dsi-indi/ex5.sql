-- Find all the meals that are above the average price of the previous 7 days

select m1.meal_id, m1.price, round(avg(m2.price), 2)
from meals m1 join meals m2
   on m2.dt between m1.dt - 7 and m1.dt - 1
group by m1.meal_id, m1.price
having m1.price > avg(m2.price)
;
