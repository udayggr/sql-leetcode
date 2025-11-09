with RECURSIVE cte as (
    select
        task_id,
        subtasks_count
    from
        Tasks
    union
    select
        task_id,
        subtasks_count -1
    from
        cte
    where
        subtasks_count > 1
)
select
    task_id,
        subtasks_count as subtaskid
from
    cte
where
    (task_id, subtaskid) not in (
        select
            task_id,
            subtaskid
        from
            Executed
    )