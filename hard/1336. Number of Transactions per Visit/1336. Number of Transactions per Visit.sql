with recursive cte as(
v.visit_id,
v.visit_date,
sum(
    case
        when amount is null then o
        else 1
    end
) as num_tran
from
    visits v
    left join transactions t on v.user_id = t.user_id
    and v.visit_date = t.transaction_date
group by
    v.visit_id,
    v.visit_date

),
cte2 as(
    select 0 as num_tran
    union all
    select num_tran +1 
    from cte2
    where num_tran < (select max(num_tran) from cte)

)
select 
c2.num_tran as trancation_count,
count(c.user_id) as visits_count
from cte2 c2
left join cte c
left join 
on c2.num_tran =c.num_tran
group by c2.num_tran
order by trancation_count