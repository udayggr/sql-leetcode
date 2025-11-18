with cte as(
    select
        *,
        id - row_number() over(
            order by
                id
        ) as diff
    from
        Stadium
    where
        people >= 100
)
select id,
visit_date,
people
from
    cte
where
    diff in (
        select
            diff
        from
            cte
        group by
            diff
        having
            count(*) >= 3
    )

