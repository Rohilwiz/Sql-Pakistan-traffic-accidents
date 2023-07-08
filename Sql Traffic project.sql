Use traff_acc_pk;

-- 1. Find total number of accidents in pakistan over all the years combined?
-- Ans. Overall accidents in pakistan is 96303 (2012-2021 )

		Select Sum(total_accidents)  as overall_accidents
		from total_accidents;

-- 2.show the total accidents of all the provinces ?
-- Ans: Punjab tops the list with 41763 accidents.


    SELECT
           SUM(CASE WHEN Province = 'Islamabad' THEN total_accidents ELSE 0 END) AS Islamabad,
		   SUM(CASE WHEN Province = 'Punjab' THEN total_accidents ELSE 0 END) AS Punjab,
		   SUM(CASE WHEN Province = 'Sindh' THEN total_accidents ELSE 0 END) AS Sindh,
		   SUM(CASE WHEN Province = 'Khyber Pakhtunkhwa' THEN total_accidents ELSE 0 END) AS Khyber_Pakhtunkhwa,
		   SUM(CASE WHEN Province = 'Balochistan' THEN total_accidents ELSE 0 END) AS Balochistan
    FROM   
		   statewise_accidents;


-- 3. province wise data of 2021?

	Select * 
	from statewise_accidents
	where year = 2021;


-- 4. % share of total accidents of every province against total pakistan acc?

-- Ans: Punjab(43.3600) and Khyber pakhtunkhwa(40.7060) together consists of 83% accidents occured in pakistan(2012-2021).


		SELECT
		  SUM(CASE WHEN Province = 'Islamabad' THEN (total_accidents/ Overall_accidents)  END)*100 AS Islamabad,
		  SUM(CASE WHEN Province = 'Punjab' THEN (total_accidents/ Overall_accidents) END)*100 AS Punjab,
		  SUM(CASE WHEN Province = 'Sindh' THEN (total_accidents/ Overall_accidents)  END)*100 AS Sindh,
		  SUM(CASE WHEN Province = 'Khyber Pakhtunkhwa' THEN (total_accidents/ Overall_accidents)*100  END) AS Khyber_Pakhtunkhwa,
		  SUM(CASE WHEN Province = 'Balochistan' THEN (total_accidents/ Overall_accidents)*100 END) AS Balochistan
		FROM 
			statewise_accidents 
			CROSS JOIN (
			  SELECT SUM(total_accidents) AS overall_accidents
			  FROM total_accidents 
			) AS overall
			GROUP BY Province
			 ;

                        
                        
                        
-- 5. Province with max. total fatal accidents?
-- Ans: Punjab - 22161

		Select a.province, MAX(a.total_fatal_acc) as Province_with_Max_fatal_accidents
		from
		(Select province, sum(accident_fatal) as total_fatal_acc
		from statewise_accidents
		group by province) as a
		Group by a.province
		order by Province_with_Max_fatal_accidents desc
		LIMIT 1
		 ;
 
 
 -- 6. Province wise max. person injured in which year?
-- ANS.               Persons Injured     Year
--  Balochistan	        640	              2019 
-- Islamabad	        209	              2015
-- Khyber Pakhtunkhwa	6093	          2017
-- Punjab	            6772	          2017
-- Sindh	             970	          2016

			SELECT a.province, a.max_injured, a.year
			FROM
			(Select province, Max(persons_injured) as max_injured, year, rank() Over( Partition by (province) order by Max(persons_injured) desc) as rnk
			from statewise_accidents
			group by province, year
			order by  province, max_injured desc) as a 
			WHERE a.rnk = 1;



-- 7. top 3 Years data of max. people killed in pakistan?


				Select year, persons_killed
				from total_accidents
				order by persons_killed desc
				limit 3 ;


-- 8. % growth of total accidents in pakistan yoy?
-- ANS. Highest % growth occured in 2015(13.57%) and 2017(13.83%)
				
                
                SELECT  year, 
						total_accidents, 
						((total_accidents - lag(total_accidents) OVER (ORDER BY year))/total_accidents)*100 AS percent_growth_in_accidents
				FROM total_accidents;



-- 9. % growth of total people killed in pakistan yoy?
-- Ans. 2015, 2016 and 2017 have been drastic years.


				SELECT  year, 
						persons_killed, 
						((persons_killed - lag(persons_killed) OVER (ORDER BY year))/persons_killed)*100 AS percent_growth_in_people_killed
				FROM total_accidents;
                
                
                
                
                
                
-- 10. Average Persons Killed and Injured per Accident?

				SELECT         Year, 
                               (Persons_Killed) / (total_Accidents) AS Avg_Persons_Killed,
							   (Persons_Injured) / (total_Accidents) AS Avg_Persons_Injured
			    FROM 
                                total_accidents
			    ;
                





-- 11. Percentage of Fatal Accidents compared to Total Accidents by Year:                
    -- Ans: fatal accidents revolves around 39% - 45% .            
			
            
				Select Year,
					   ((accident_fatal)/(total_accidents))*100 as perccentage_of_fatal_accidents
				
				From
					   total_accidents;
					   
					   
					   select * from total_accidents;
                
                


