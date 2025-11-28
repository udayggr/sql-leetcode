with recursive cte as (
    select
        date_add(
            '2023-11-01',
            interval (6 - dayofweek('2023-11-01') + 7) % 7 day
        ) as frinday_dt
    union
    all
    select
        date_add(frinday_dt, interval 7 day)
    from
        cte
    where
        date_add(frinday_dt, interval 7 day) <= '2023-11-30'
),
cte2 as (
    select
        frinday_dt,
        ifnull(sum(p.amount), 0) as total_amount
    from
        cte
        left join Purchases p on frinday_dt = p.purchase_date
    group by
        frinday_dt
)
select
    week(frinday_dt) - week('2023-11-01') + 1 as week_of_month,
    frinday_dt,
    total_amount
from
    cte2
order by
    week_of_month
