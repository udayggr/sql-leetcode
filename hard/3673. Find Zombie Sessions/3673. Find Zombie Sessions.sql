# Write your MySQL query statement below
with cte as (
    select
        user_id,
        session_id,
        timestampdiff(
            minute,
            min(event_timestamp),
            max(event_timestamp)
        ) as session_duration,
        sum(
            case
                when event_type = 'scroll' then 1
                else 0
            end
        ) as num_scrols,
        sum(
            case
                when event_type = 'click' then 1
                else 0
            end
        ) / sum(
            case
                when event_type = 'scroll' then 1
                else 0
            end
        ) as click_to_scrol,
        sum(
            case
                when event_type = 'purchase' then 1
                else 0
            end
        ) as num_pur
    from
        app_events
    group by
        user_id,
        session_id
)
select
    session_id,
    user_id,
    session_duration as session_duration_minutes,
    num_scrols as scroll_count
from
    cte
where
    session_duration >= 30
    and num_scrols >= 5
    and click_to_scrol < 0.20
    and num_pur = 0
order by
    scroll_count desc,
    session_id