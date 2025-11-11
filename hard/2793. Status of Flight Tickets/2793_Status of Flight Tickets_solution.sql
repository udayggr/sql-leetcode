with cte as (
    select
        p.*,
        f.capacity,
        row_number() over(
            partition by p.flight_id
            order by
                booking_time
        ) as rnk
    from
        passengers p
        left join flights f on p.flights = f.flight_id
)
select
    passenger_id,
    case
        rnk <= capacity then 'confirmed'
        else 'waitinglist'
    end as status
from
    cte
order by
    passenger_id;
