with cte as (
p.employee_id
project_id
name as employee_name
workload as project_workload
avg(workload) over(partition by team ) as avg_wrk_load

from 
Project  p
left join
Employees e
 on 
p.employee_id=e.employee_id 
)

select
    employee_id,
    project_id,
    employee_name,
    project_id
from
    cte
where
    project_workload > avg_wrk_load
order by
    project_id,
    employee_id