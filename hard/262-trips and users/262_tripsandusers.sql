# Write your MySQL query statement below
with cte as(
    select
        t.*
    from
        trips t
        left join users u on t.client_id = u.users_id
        left join users d on t.driver_id = d.users_id
    where
        u.banned = 'No'
        and d.banned = 'No'
        and t.request_at between '2013-10-01'
        and '2013-10-03'
)
select
    request_at as day,
    Round(
        sum(
            case
                when status != 'completed' then 1
                else 0
            end
        ) / count(*),
        2
    ) as 'Cancellation Rate'
from
    cte
group by
    request_at