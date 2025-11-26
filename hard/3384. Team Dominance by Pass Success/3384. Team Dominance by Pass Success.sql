
with cte as(
    select p.*,t1.team_name ,
    case when t1.team_name =t2.team_name =1 else -1 end as points,
    case when t1.p.time_stamp <='45:00' then 1 else 2 end as half_number

 FROM   Passes p
 left JOIN Teams t1 ON p.pass_from = t1.player_id
 left JOIN Teams t2 ON p.pass_to = t2.player_id )

select team_name,half_number, sum(points) as dominance
from cte
group by team_name,half_number
order by team_name,half_number
