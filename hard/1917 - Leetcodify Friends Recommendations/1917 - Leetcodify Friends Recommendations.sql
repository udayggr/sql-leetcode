with cte as(
    select
        l1.user_id as user1_id,
        l2.user_id as user2_id
    from
        Listens l1
        left join listens l2 on l1.song_id = l2.song_id
        and l1.day = l2.day
    group by
        l.day,
        l.user_id,
        l2.user_id
    having
        count(distinct l2.song_id > 2)
)
select
    distinct c.user1_id as user_id,
    c.user2_id as recommended_id
from
    cte c
    left join Friendship f on (
        (
            c.user1_id = f.user1_id
            and c.user2_id = f.user2_id
        )
        or (
            c.user1_id = f.user2_id
            and c.user2_id = f.user1_id
        )
    )
where
    f.user1_id is null
