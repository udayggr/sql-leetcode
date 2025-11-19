with cte as (
    select
    user1_id,
    user2_id
from
    Friendship
union
select
    user2_id,
    user1_id
from
    Friendship
   
),
cte2 as (
    select
    user1_id as user_id,
    page_id,
    count(user1_id) as friends_likes
from
    cte c
    left join likes l on c.user2_id = l.user_id
group by
    user1_id,
    page_id
)
select
    cte2.*
from
    cte2
    left join likes on cte2.user_id = likes.user_id
    and cte2.page_id = likes.page_id
where
    likes.page_id is null