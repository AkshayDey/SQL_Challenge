--select * from mountain_huts;
--select * from trails;

with cte_trails_1 as (
    select 
		h.id as starting_hut
	   ,h.name as starting_hut_name
	   ,h.altitude as starting_hut_altitude
	   ,t.hut2 as ending_hut_id
	   from mountain_huts h
	join trails t on h.id = t.hut1
),

cte_trails_2 as
(
select 
	   starting_hut	
	  ,starting_hut_name
	  ,starting_hut_altitude
	  ,ending_hut_id
	  ,h2.name as ending_hut_name
	  ,h2.altitude as ending_hut_alt
	  ,case
	     when starting_hut_altitude > h2.altitude then 1 else 0
	   end as comparison
	  from cte_trails_1 t1
	  
join mountain_huts h2 on t1.ending_hut_id = h2.id
),

--select * from cte_trails_2

final_cte as 
(
select case when t2.comparison = 1 then starting_hut else ending_hut_id end as starting_hut_id,
       case when t2.comparison = 1 then starting_hut_name else ending_hut_name end as starting_hut_name,
	   case when t2.comparison = 1 then ending_hut_id else starting_hut end as ending_hut_id,
	   case when t2.comparison = 1 then ending_hut_name else starting_hut_name end as ending_hut_name
from cte_trails_2 t2
)

select * from 
final_cte as c1
join final_cte c2 on c1.ending_hut_id = c2.starting_hut_id

-- 1,3,5
-- 2,3,5
-- 3,5,4
-- 1,5,4






