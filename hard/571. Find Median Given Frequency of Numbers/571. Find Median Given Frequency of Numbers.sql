with recursive cte as(
    select
        1 as num
    union
    all
    select
        num + 1
    from
        cte
    where
        num < (
            select
                max(frequenct)
            from
                numbers
        )
) cte2 as(
    select
        n.number,
        row_number() over(
            order by
                n.num
        ) as rnk,
        count(*) over() as total_number
    from
        number n
        left join cte c on n.frequency >= c.num
),
cte3 as (
    select
        case
            when total_number % 2 = 0 then rnk in (total_number / 2, (total_number / 2) + 1)
            when total_number % 2 = 1 then rnk in (total_number / 2) as med
        end as median
    from
        cte2
)
select
    round(avg(med), 1)
from
    cte3
where
    med = 1