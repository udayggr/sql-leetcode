WITH recursive cte AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY continent
            ORDER BY
                name
        ) AS rnk
    FROM
        Student
),
cte2 as (
    select
        1 as rnk
    union
    all
    select
        rnk + 1
    from
        cte2
    where
        rnk < (
            select
                max(rnk)
            from
                cte
        )
)

select
    c.name as America,
    c2.name as Asia,
    c3.name as Europe
from
    cte2
    left join (
        select
            rnk,
            name
        from
            cte
        where
            continent = 'America'
    ) as c1 on cte2.rnk = c1.rnk
    left join (
        select
            rnk,
            name
        from
            cte
        where
            continent = 'Asia'
    ) as c2 on cte2.rnk = c2.rnk
    left join (
        select
            rnk,
            name
        from
            cte
        where
            continent = 'Europe'
    ) as c3 on cte2.rnk = c3.rnk
order by
    cte2.rnk

###########################################

WITH
    CTE AS (
        SELECT
            *,
            ROW_NUMBER() OVER (
                PARTITION BY continent
                ORDER BY name
            ) AS rk
        FROM Student
    )
SELECT
    MAX(IF(continent = 'America', name, NULL)) AS 'America',
    MAX(IF(continent = 'Asia', name, NULL)) AS 'Asia',
    MAX(IF(continent = 'Europe', name, NULL)) AS 'Europe'
FROM CTE
GROUP BY rk;