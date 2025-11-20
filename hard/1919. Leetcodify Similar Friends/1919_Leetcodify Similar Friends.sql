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
    c.user1_id as user1_id,
    c.user2_id as user2_id
    from cte c 
    where (user1_id,user2_id) in (select * from friendship)
    and user1_id < user2_id
