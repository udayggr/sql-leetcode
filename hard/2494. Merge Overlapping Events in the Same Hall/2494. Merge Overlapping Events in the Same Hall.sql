


with cte as (
    select
        *,
        max(end_day) over(
            partition by hall_id
            order by
                start_day unbounded preceding
                and 1 preceding
        ) AS end_date
    from
        HallEvents
),
cte2 as(
    select
        case
            when start_day > end_date then 1
            else 0
        end as val
    from
        cte
),
cte3 as (
    select
        *,
        sum(val) over(
            partition by hall_id
            order by
                start_day unbounded preceding
                and current row
        ) as grp
    from
        cte2
)
select
    hall_id,
    min(start_day) as start_day,
    max(end_day) as end_day
from
    cte3
group by
    hall_id,
    grp
order by
    hall_id