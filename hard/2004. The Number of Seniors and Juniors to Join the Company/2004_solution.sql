with CTE as (
    select
        experience,
        sum(salary) over(
            partition by experience
            order by
                salary asc
        ) as cum_sum
    from
        Candidates
),
with juniors as (
    select
        'Senior' as experience, IFNULL(count(*) as accepted_candidates, 0)
    from
        CTE
    where
        experience = 'senior'
        and cum_sum <= 70000
    union
    select
        'junior' as experience,
        IFNULL(count(*) as accepted_candidates, 0)
    from
        CTE
    where
        experience = 'junior'
        and cum_sum <= 70000 - ifnull((
            select max(cum_sum) 
            from cte 
            where  experience = 'senior' and cum_sum <= 70000
        ),0)