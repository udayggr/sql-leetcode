with recurrsive cte as (
    select
        *,
        0 as hierarchy_level
    from
        Employees
    where
        manager_id is null
    union
    all
    select
        e.*,
        hierarchy_level + 1
    from
        Employees e
        inner join cte c e.manager_id = c.employee_id
)
select
    employee_id as subordinate_id,
    employee_name as subordinate_name,
    salary -(
        select
            salary
        from
            Employees
        where
            manager_id is null
    ) as salaray_diff
from
    cte
where
    hierarchy_level != 0