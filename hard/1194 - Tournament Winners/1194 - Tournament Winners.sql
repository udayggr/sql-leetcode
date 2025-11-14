
with cte as (
    select
        p.player_id,
        p.group_id,
        SUM(
            case
                when p.player_id = m.first_player then first_score
                when p.player_id = m.second_player then second_score
            end
        ) AS points
    from
        players p
        left join matches m on p.player_id = m.first_player
        or p.player_id = m.second_player
    group by
        p.player_id,
        p.group_id
),
cte2 as (
    select
        player_id,
        group_id,
        dense_rank() over(
            partition by group_id
            order by
                points desc,
                player_id
        ) as rnk
    from
        cte
)
select
    group_id,
    player_id
from
    cte2
where
    rnk = 1