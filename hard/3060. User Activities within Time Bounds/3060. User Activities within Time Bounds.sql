
select
    distinct s1.user_id as user_id
from
    Sessions s1
    inner join Sessions s2 on s1.user_id = s2.user_id
    and s1.session_type = s2.session_type
where
    s1.session_start < s2.session_start
    and timestampdiff(second, s1.s1.session_end, s2.session_start) / 3600 between 0
    and 12
order by
    user_id



#############################

WITH
    cte AS (
        SELECT
            user_id,
            session_start,
            LAG(session_end) OVER (
                PARTITION BY user_id, session_type
                ORDER BY session_end
            ) AS prev_session_end
        FROM Sessions
    )
SELECT DISTINCT
    user_id
FROM cte
WHERE TIMESTAMPDIFF(HOUR, prev_session_end, session_start) <= 12;