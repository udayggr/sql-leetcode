with cte as (
    select
        customer_id,
        year(order_date) as year,
        sum(price) as price,
        max(year(order_date) over (partition by customer_id)) - min(year(order_date) over (partition by customer_id)) + 1 as nbr_yrs dense_rank() over(
            partition by customer_id
            order by
                year(order_date)
        ) as yr_rnk,
        dense_rank() over(
            partition by customer_id
            order by
                sum(price)
        ) as pr_rnk
    from
        orders
    group by
        customer_id,
        year(order_date)
)
select
    customer_id
from
    cte
group by
    customer_id
having
    sum(
        case
            when yr_rnk = pr_rnk then 1
            else 0
        end
    ) = max(nbr_yrs)