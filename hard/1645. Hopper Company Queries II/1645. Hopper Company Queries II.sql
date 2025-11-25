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
cte2 as(
    select
    from
        rides r
        inner join accepeted_rides using (ride_id)
)
select
    c.month,
    round(
        ifnull(
            count(distinct c2.driver_id) / count(distinct d.driver_id) * 100,
            0
        ),
        2
    ) as working_percentage
from
    cte c
    left join drivers d on last_day(concat(year, '-', month, '-', 01)) >= d.join_date
    left join cte2 on last_day(concat(year, '-', month, '-', 01)) = last_day(c2.requested_at)
    and d.driver_id = cte2.driver_id
group by
    c.month
order by
    c.month