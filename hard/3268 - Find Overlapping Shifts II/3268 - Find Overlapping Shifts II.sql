with cte as(
    select
        e1.employee_id,
        e2.start_time,
        count(*) as cnt,
        sum(
            case
                when e1.start_time <> e2.start_time then timestampdiff(minutue, e1.start_time, e2.end_time)
                else 0
            end
        ) as duration
    from
        EmployeeShifts e1
        left join e2 on e1.employee_id = e2.employee_id
        and e1.start_time between e2.start_time
        and e2.end_time
    group by
        e1.employee_id e2.start_time
)
select
    employee_id,
    max(cnt) as max_overlapping_shifts,
    sum(duration)
from
    cte
group by
    employee_id
order by
    employee_id