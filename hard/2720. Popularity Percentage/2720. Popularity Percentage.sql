
with cte as(
    select
        *
    from
    from
        friends
    union
    user2,
    user1
    from
        friends
),
select
    user1,
    round(
        count(distinct user2) / (
            select
                count(distinct user1)
            from
                cte
        ) * 100,
        2
    ) as percentage_popularity
from
    cte
group by
    user1
order by
    user1