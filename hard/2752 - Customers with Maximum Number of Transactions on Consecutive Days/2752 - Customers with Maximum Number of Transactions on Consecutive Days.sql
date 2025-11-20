with cte as (
    select
        *,
        dense_rank() over(
            partition by customer id
            order by
                transaction_date asc
        ) as rnk
    from
        Transactions
),
cte2 as(
    select
        cutomer_id,
        count(transaction_date)
) as purchase
group by
    cutomer_id,
    date_sub(transaction_date, INTERVAL rnk day)
), cte3(
    select
        *,
        dense_rank() over(
            order by
                purcase desc
        ) as purchase
    from
        cte2
)
select
    cutomer_id
from
    cte3
where
    rnk = 1
    order by customer_id