
with cte as (
    select
        *,
        sum(salary) over (
            partition by experience
            order by
                salary asc
        ) as cum_sum
),
cte2 as(
    select
        *,
        sum(salary) over(
            order by
                experience,
                salary
        ) as cum_sum2
    from
        cte
    where
        cum_sum < 70000
)
select
    employee_id
from
    cte2
where
    cum_sum2 < 70000

