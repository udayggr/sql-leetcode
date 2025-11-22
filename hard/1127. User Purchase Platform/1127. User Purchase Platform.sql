with cte as (
    select
,
        spend_date,
        user_id,
        group_concat(
            distinct user_id
            order by
                user_id
        ) as platform,
        sum(amount) as amount
    from
        spending
    group by
        spend_date,
        user_id
),
cte2 as(
    select
        spend_date,
        if(platform = 'mobile,desktop', 'both', platform) as platform,
        sum(spending) as amount,
        count(distinct user_id) as total_users
    from
        cte
    group by
        spend_date,
        if(platform = 'mobile,desktop', 'both', platform)
),
cte3 as (
    select
        distinct s.spend_date,
        j.platform
    from
        spending s
        cross join (
            select
                'mobile' as platform
            union
            all
            select
                'desktop' as platform
            union
            all
            select
                'both' as platform
        ) j
)
select
    *
from
    cte2
union
all
select
    *,
    0,
    0
from
    cte3
where
    concat(spend_date, platform) not in (
        select
            concat(spend_date, platform)
        from
            cte2
    )