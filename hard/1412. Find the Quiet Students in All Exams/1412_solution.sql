with cte as (
    select
        student_id,
        min(score) over (partition by exam_id) as min_score,
        max(score) over (partition by exam_id) as max_score
    from
        Exam
        left join Student on student_id = student_id
),
cte1 as(
    select
        *
    from
        cte
    where
        score = min_score
        or score = max_score
)
select distinct
    student_id,
    student_name
from
    cte
where
    score <> min_score
    or score <> max_score
    and student_id not in (
        select
            student_id
        from
            cte1
    )
order by
    student_id
