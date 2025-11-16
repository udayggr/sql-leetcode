with cte (
    select
        item_type,
        sum(square_footage) as area,
        count(item_id) as items,
        floor(500000 / sum(square_footage)) as max_combo
    from
        inventory
    group by
        item_type
)
select
    item_type,
    case
        item_type = 'prime_eligible' then items * max_combo
        else floor(
            (
                500000 - (
                    select
                        max_combo * area
                    from
                        cte
                    where
                        item_type = 'prime_eligible'
                ) /
                select
                    area
                from
                    cte
                where
                    item_type = 'not_prime'
            ) * items
        )
    end as item_count
from
    cte
order by
    item_count desc;




