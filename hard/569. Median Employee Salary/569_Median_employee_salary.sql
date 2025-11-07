with cte as (
    select
        *,
        rown_number() over( partition by company order by salary asc ) as rnk,
        count(*) over(partition by Company) as cnt
    from
        Employee
    order by
        salary
)
select
    Id,
    company,
    salary
from
    cte
where
    rnk between cnt/2
    and (Cnt/2)+1
