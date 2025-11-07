with cte as (
    O.*,
    C.item_category,
    dayofweek(order_date) as dow
    from
        Category C
        left join order O on C.item_id = O.item_id
)
select
    item_category as Category,
     sum( case when dow = 2 then quantity else 0 end ) as "Monday",
     sum( case when dow = 3 then quantity else 0 end ) as "Tuesday", 
     sum( case when dow = 4 then quantity else 0 end ) as "Wednesday", 
     sum( case when dow = 5 then quantity else 0 end ) as "Thursday", 
     sum( case when dow = 6 then quantity else 0 end ) as "Friday",
     sum( case when dow = 7 then quantity else 0 end ) as "Saturday",
     sum( case when dow = 1 then quantity else 0 end ) as "Sunday"
from
    cte
group by
    item_category
order by
    Category