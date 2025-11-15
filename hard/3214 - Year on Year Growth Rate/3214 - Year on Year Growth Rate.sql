with cte as (
    select
        product_id,
        year(transaction_date) as year,
        sum(spend) as curr_year_spend,
    from
        user_transactions
    group by
        product_id,
        year(transaction_date)
) cte2 as(
    select
        year,
        product_id,
        curr_year_spend,
        lag(curr_year_spend, 1) over (
            partition by product_id
            order by
                year
        ) as prev_year_spend
    from
        cte
)
select
    year,
    product_id,
    curr_year_spend,
    prev_year_spend,
    round(
        (curr_year_spend, prev_year_spend) / prev_year_spend * 100,
        2
    ) as yoy_rate
from
    cte2
order by
    product_id,
    year