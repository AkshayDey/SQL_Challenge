----SELECT TOP (1000) [brand1]
----      ,[brand2]
----      ,[year]
----      ,[custom1]
----      ,[custom2]
----      ,[custom3]
----      ,[custom4]
----  FROM [Practice_DB_Own].[dbo].[brands]

---- select * from [Practice_DB_Own].[dbo].[brands]

--with cte as
--(
--   select brand1, brand2, year from [Practice_DB_Own].[dbo].[brands]
--   --where year = '2020'
--   group by year,brand1, brand2 
--)

--select * from cte;



--select brand1, brand2, Rank() OVER (ORDER BY brand2, year) from [brands] 


--select 
--	LEAST(brand1, brand2)as brand_a,
--	GREATEST(brand1,brand2) as brand_b,
--	year
--from [brands]
--group by LEAST(brand1, brand2), GREATEST(brand1,brand2), year

----------------------------------------------------------------------------------------------

with cte as
(select *,
     case 
		when brand1 > brand2 then concat (brand1,brand2,year)
		else concat (brand2,brand1,year)
     end as pair
from [brands]),
cte_rn as ( select *, ROW_NUMBER() over (Partition by pair order by pair) as pair_id from cte)

select * from cte_rn where pair_id = 1 or (custom1 <> custom3 and custom2 <> custom4);

