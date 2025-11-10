with cte as (
    select
        'FAILED' as period_state,
        fail_date as dt
    from
        fail_date
    union
    'succeeded' as period_state,
    success_date as dt
    from
        Succeeded
),
cte2 as (
    select
        period_state,
        dt,
        date_sub(
            dt,
            interval row_number() over(
                partition by period_state
                order by
                    dt
            ),
            day
        ) as grp
    from
        cte
    where
        dt between '2019-01-01'
        and '2019-12-31'
)
select
    period_state,
    min(dt) as start_date,
    max(dt) as end_date
from
    cte2
group by
    grp,period_state
order by
    start_date