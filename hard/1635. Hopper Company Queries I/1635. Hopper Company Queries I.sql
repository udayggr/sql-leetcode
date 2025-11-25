WITH recursive Months AS (
    SELECT
        '2020' as year,
        1 AS month
    UNION
    ALL
    SELECT
        year,
        month + 1
    FROM
        Months
    WHERE
        month < 12
),
cte2 as (
    SELECT
        m.month,
        COUNT(driver_id) AS active_drivers
    FROM
        Months AS m
        LEFT JOIN Drivers AS d on last_day(concat(year, '-', month, '-', '01'))
    GROUP BY
        month
) cte3 as (
    select
        month(r.requested_at) as month count(r.ride_id) as accepeted_rides
    from
        rides r
        inner join AcceptedRides AS a using(ride_id)
    where
        year = 2020
    group by
        month(r.requested_at)
)
select
    cte2.*,
    ifnull(cte3.accepeted_rides, 0) as accepeted_rides
from
    cte2
    left join cte3 using (month)
order by
    month