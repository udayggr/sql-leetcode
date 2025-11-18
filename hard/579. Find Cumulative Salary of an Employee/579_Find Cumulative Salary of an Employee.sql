with cte as(
    select
        *,
        row_number() over(
            partition by id
            order by
                month desc
        ) as rnk
)
select
    id,
    month,
    sum(salary) over(
        partition by id
        order by
            month Range between 2 preceding
            and current row
    ) as salary
from
    cte
where
    rnk != 1
    order by id, month 