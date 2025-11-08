with cte as (
    select
        s.employee_id,
        s.amount,
        date_format(s.pay_date, '%Y-%m') as pay_month,
        department_id
    from
        salary s
        left join Employee e on s.employee_id = e.employee_id
),
cte1 as (
    select
        pay_month,
        department_id,
        avg(amount) over(partition by pay_month, department_id) as avg_sal_dept,
        avg(amount) over(partition by pay_month) as avg_sal_comp
    from
        cte
)
select distinct
    pay_month,
    department_id,
    case
        when avg_sal_dept = avg_sal_comp then "same"
        when avg_sal_dept > avg_sal_comp then "higher"
        when avg_sal_dept < avg_sal_comp then "hilower"
    end as comparison
from
    cte1 