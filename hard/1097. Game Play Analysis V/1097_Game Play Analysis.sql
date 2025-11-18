with cte as (
    select
        *,
        dense_rank() over(
            partiton by player_id
            order by
                event_date asc
        ) dense_rank,
        lead(event_date, 1) over(
            partiton by player_id
            order by
                event_date asc
        ) next_date
    from
        activity
)
select
    event_date as install_dt,
    count(*) as installs,
    round(
        sum(
            case
                when date_diff(next_date, event_date) = 1 then 1
                else 0
            end
        ) / count(*),
        2
    ) as Day1_retention
from
    cte
where
    rnk = 1
group by
    event_date

