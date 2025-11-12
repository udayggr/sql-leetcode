with cte as(
    select
        userid,
        favorite_brand,
        order_date,
        item_brand,
        dense_rank() over (
            partition by userid
            order by
                order_date asc
        ) as rnk,
        count(*) over(partition by userid) as cnt
    from
        Users
        left join Orders on user_id = seller_id
        left join items on orders.item_id = items.item_id
)
cte2 as (
    select
        userid as seller_id,
        case
            when cnt < 2 then 'no'
            when rnk = 2 and favorite_brand = item_brand then 'yes'
            when rnk = 2 and favorite_brand <> item_brand then 'no'
            else null
        end as 2nd_item_fav_brand
    from
        cte
)
select * from cte2 where 2nd_item_fav_brand is not null