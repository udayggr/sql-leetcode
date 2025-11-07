with cte as(
    select
        username,
        activity,
        startdate,
        end_date
    from
        UserActivity
),
cte2 as(
    select
        *,
        count(activity) over(
            partition by username
            order by
                startdate
        ) as cnt,
        row_number() over(
            partition by username
            order by
                startdate
        ) as rnk
    from
        cte
)
select
    username,
    activity,
    startdate,
    end_date
from
    cte2
where
    rnk = 2
    or cnt = 1