

select
    post_id,
    ifNULL(
        group_concat(
            distinct topic_id
            order by
                topic_id
        ),
        "Ambiguous!"
    ) as topic
from
    Posts
    left join Keywords on concat(" " + lower(contemt) + " ") like concat("% " + lower(word) + " %")
group by
    post_id

/********/

SELECT
    post_id,
    ifnull(group_concat(DISTINCT topic_id), 'Ambiguous!') AS topic
from
    Posts
    left join Keywords on 
    instr(concat(' ',content,' '),concat(' ',word, ' '))> 0
    group by 
    post_id
