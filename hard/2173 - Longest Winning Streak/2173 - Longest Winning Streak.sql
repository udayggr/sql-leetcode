
with cte as (
    select
        *,
        row_numer() over(
            partition by player_id
            order by
                match_day
        ) as player_rnk,
        row_number() over(
            partition by player_id,
            result
            order by
                match_day
        ) as res_rnk
    from
        matches
),
 cte2 as(
    select
        player_id,
        player_rnk - res_rnk as diff,
        count(*) as streek row_number() over(
            partition by player_id
            order by
                streek desc
        ) as rnk
    from
        cte
    where
        result = 'win'
    group by
        player_id,
        player_rnk - res_rnk
),
select
    distinct m.player_id,
    ifnull(streek, 0) as longest_streak
from
    matches m
    left join (
        select
            * cte2
        where
            rnk = 1
    ) T on m.player - id = t.player_id
