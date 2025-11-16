with cte as (
    select
        country,
        winery,
        sum(points) as points,
        row_number() over(
            partition by country
            order by
                sum(points) desc
        ) as rnk
    from
        wineres
    group by
        country,
        winery
),
cte2 as(
select
*,
concat(winery,' (', points,')' ) as wwe
from cte)

select country,
case max(when rnk=1 then wwe else null end) as top_winery,
case ifnull(max(when rnk=2 then wwe else null end),'No second winery') as second_winery,
case ifnull(max(when rnk=3 then wwe else null end),'No third winery') as third_winery,
from cte2
group by country
order by country


