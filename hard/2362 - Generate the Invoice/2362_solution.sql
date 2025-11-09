swith cte as (
    select
        invoice_id,
        sum(quantity * price) as total
    from
        Purchases pu
        left join products pr on pu.product_id = pr.product_id
    group by
        invoice_id
    order by
        total desc,
        invoice_id
    limit
        1
)
select
    product_id,
    quantity,
(quantity * price) as price
from
    Purchases pu
    left join products pr on pu.product_id = pr.product_id
where
    pu.invoice_id in (
        select
            invoice_id
        from
            cte
    )


    //****************************//
    WITH
    P AS (
        SELECT *
        FROM
            Purchases
            JOIN Products USING (product_id)
    ),
    T AS (
        SELECT invoice_id, sum(price * quantity) AS amount
        FROM P
        GROUP BY invoice_id
        ORDER BY 2 DESC, 1
        LIMIT 1
    )
SELECT product_id, quantity, (quantity * price) AS price
FROM
    P
    JOIN T USING (invoice_id);