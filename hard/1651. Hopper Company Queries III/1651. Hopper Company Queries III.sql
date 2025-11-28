with recursive cte as(
    select
        1 as month
    union
    all
    select
        month + 1
    from
        cte
    where
        month < 12
),
with cte2 as (
    select
        r.*,
        a.ride_distance,
        a.ride_duration
    from
        rides r
        inner join accesptedrides a r.ride_id = a.ride_id
    where
        year(r.requested_at) = 2020
) cte3 as(
    from
        cte c
        left join cte2 c2 on month(c2.requested_at) between month
        and month + 2
)
select
    month,
    ifnull(round(sum(ride_distance) / 3, 2), 0) as average_ride_distance,
    ifnull(round(sum(ride_duration / 3), 2), 0) as average_ride_duration
from
    cte3
group by
    month
order by
    month