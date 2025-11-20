with cte as(
    *,
    row_number() over(
        partiton by user_id
        order by
            session_start
    ) as rnk
    from
        Sessions
)
select
    user_id,
    count(*) as sessions_count
from
    cte
where
    session_type = 'Streamer'
    and user_id in (
        select
            user_id
        from
            cte
        where
            rnk = 1
            and session_type = 'Viewer'
    )
group by
    user_id
order by
    sessions_count desc,
    user_id desc