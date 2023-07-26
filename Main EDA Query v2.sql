--We shall now combine all the 12 datasets to get a combined dataset showing all the data for the year 2022.

DROP TABLE IF EXISTS combined_data
CREATE TABLE combined_data
(
ride_id nvarchar(255),
rideable_type nvarchar(255),
start_date date,
start_time time(0),
end_date date,
end_time time(0),
ride_duration decimal(38,2),
day_week int,
distance_km decimal(38,2),
start_station_name varchar(255),
end_station_name varchar(255),
membership varchar(255)
)


INSERT INTO combined_data (ride_id, rideable_type, start_date, start_time, end_date, end_time, ride_duration, day_week, distance_km, start_station_name, end_station_name, membership)
(
SELECT * FROM jan_2022_data
UNION ALL
SELECT * FROM feb_2022_data
UNION ALL
SELECT * FROM march_2022_data
UNION ALL
SELECT * FROM april_2022_data
UNION ALL
SELECT * FROM may_2022_data
UNION ALL
SELECT * FROM june_2022_data
UNION ALL
SELECT * FROM july_2022_data
UNION ALL
SELECT * FROM aug_2022_data
UNION ALL
SELECT * FROM sept_2022_data
UNION ALL
SELECT * FROM oct_2022_data
UNION ALL
SELECT * FROM nov_2022_data
UNION ALL
SELECT * FROM dec_2022_data
)

SELECT * from combined_data

--We shall now try to display the day of the week in names instead of numbers.

Select *,
CASE
WHEN day_week = 1 THEN 'Sunday'
WHEN day_week = 2 THEN 'Monday'
WHEN day_week = 3 THEN 'Tuesday'
WHEN day_week = 4 THEN 'Wednesday'
WHEN day_week = 5 THEN 'Thursday'
WHEN day_week = 6 THEN 'Friday'
ELSE 'Saturday' 
END AS DAY_OF_WEEK
FROM combined_data

--We shall now get the data where the ride duration is more than 1 min. Rides equal to or less than 1 minute can be considered redundant as they can be erroneously booked
--Also we shall find for rides more than 0.5km or 500m as that would indicate more of a real-world usage of the cycles.

WITH CTE_2022_Data AS 
(Select *, 
CASE
WHEN day_week = 1 THEN 'Sunday'
WHEN day_week = 2 THEN 'Monday'
WHEN day_week = 3 THEN 'Tuesday'
WHEN day_week = 4 THEN 'Wednesday'
WHEN day_week = 5 THEN 'Thursday'
WHEN day_week = 6 THEN 'Friday'
ELSE 'Saturday' 
END AS DAY_OF_WEEK
from 
combined_data
WHERE ride_duration > 1 AND distance_km > 0.5
)

SELECT * from CTE_2022_data

--We shall now check the number of rides on each day by casual users.


SELECT COUNT(ride_id) AS number_rides, day_week,
CASE
WHEN day_week = 1 THEN 'Sunday'
WHEN day_week = 2 THEN 'Monday'
WHEN day_week = 3 THEN 'Tuesday'
WHEN day_week = 4 THEN 'Wednesday'
WHEN day_week = 5 THEN 'Thursday'
WHEN day_week = 6 THEN 'Friday'
ELSE 'Saturday' 
END AS DAY_OF_WEEK
FROM combined_data
WHERE membership = 'casual'
GROUP by day_week
ORDER by number_rides DESC;


--We see that 330010 rides were completed by casual users on Saturdays and 266410 rides on Sundays. This clearly indicates that casual users preferred to use the cycles
--on weekends for leisure purposes and lesser use cases of using the cycles on weekdays for commute purposes. Let us now determine the number of rides on each day by 
--member users with an annual membership.



SELECT COUNT(ride_id) AS number_rides, day_week,
CASE
WHEN day_week = 1 THEN 'Sunday'
WHEN day_week = 2 THEN 'Monday'
WHEN day_week = 3 THEN 'Tuesday'
WHEN day_week = 4 THEN 'Wednesday'
WHEN day_week = 5 THEN 'Thursday'
WHEN day_week = 6 THEN 'Friday'
ELSE 'Saturday' 
END AS DAY_OF_WEEK
FROM combined_data
WHERE membership = 'member'
GROUP by day_week
ORDER by number_rides DESC;


--We see that a total of 398444 rides were completed by active users on Thursdays and the least number of rides were on Saturdays & Sundays. This shows a contrasting
--inference when compared with the number of rides by casual users on weekdays. We see that active users prefer to use the cycles more on weekdays for commute purposes
--such as commute to offices, schools, gyms, etc.

--Let us now check the average distance travelled by casual & active users on different days of the week to see if the distance travelled supports our hypothesis of
--the pre-determined use cases of the users.

SELECT AVG(distance_km) AS avg_distance, day_week,
CASE
WHEN day_week = 1 THEN 'Sunday'
WHEN day_week = 2 THEN 'Monday'
WHEN day_week = 3 THEN 'Tuesday'
WHEN day_week = 4 THEN 'Wednesday'
WHEN day_week = 5 THEN 'Thursday'
WHEN day_week = 6 THEN 'Friday'
ELSE 'Saturday' 
END AS DAY_OF_WEEK
FROM combined_data
WHERE membership = 'casual'
GROUP by day_week
ORDER by avg_distance DESC;

--We can see that on Saturdays, casual users rode an average of 2.52 kms, while on Wednesday, they rode an average of 2.2kms.
--Let us check the same for users who had an active membership


SELECT AVG(distance_km) AS avg_distance, day_week,
CASE
WHEN day_week = 1 THEN 'Sunday'
WHEN day_week = 2 THEN 'Monday'
WHEN day_week = 3 THEN 'Tuesday'
WHEN day_week = 4 THEN 'Wednesday'
WHEN day_week = 5 THEN 'Thursday'
WHEN day_week = 6 THEN 'Friday'
ELSE 'Saturday' 
END AS DAY_OF_WEEK
FROM combined_data
WHERE membership = 'member'
GROUP by day_week
ORDER by avg_distance DESC;


--Here we see that Saturdays saw the highest average distance of 2.25kms by active users, while Monday saw the lowest average distance of 2.09kms. 
--While active users did ride for longer distances on Saturdays, it also means that since they completed more rides on weekdays, the use case was strictly commute on weekdays
--to nearby locations such as offices, schools, gyms, etc. as we saw above.

--Let us check the average duration of rides by casual members on all days of the week

SELECT AVG(ride_duration) AS avg_duration, day_week,
CASE
WHEN day_week = 1 THEN 'Sunday'
WHEN day_week = 2 THEN 'Monday'
WHEN day_week = 3 THEN 'Tuesday'
WHEN day_week = 4 THEN 'Wednesday'
WHEN day_week = 5 THEN 'Thursday'
WHEN day_week = 6 THEN 'Friday'
ELSE 'Saturday' 
END AS DAY_OF_WEEK
FROM combined_data
WHERE membership = 'casual'
GROUP by day_week
ORDER by avg_duration DESC;


--We see that casual users rode for an average of 25 mins on Saturdays and Sundays, while rode lesser on weekdays, with lesser than 20 mins during mid-week.
--Let us find the same for users with an active membership.


SELECT AVG(ride_duration) AS avg_duration, day_week,
CASE
WHEN day_week = 1 THEN 'Sunday'
WHEN day_week = 2 THEN 'Monday'
WHEN day_week = 3 THEN 'Tuesday'
WHEN day_week = 4 THEN 'Wednesday'
WHEN day_week = 5 THEN 'Thursday'
WHEN day_week = 6 THEN 'Friday'
ELSE 'Saturday' 
END AS DAY_OF_WEEK
FROM combined_data
WHERE membership = 'member'
GROUP by day_week
ORDER by avg_duration DESC;


--We see that active users rode for lesser durations on weekdays, especially mid-week. But one reason for that could be short and only commutes to offices, schools,
gyms, etc. but, with more number of rides.
--Let us now check the average ride duration for both user types.

SELECT AVG(ride_duration), membership
from combined_data
WHERE membership = 'casual'
GROUP by membership;


--We see that, on an average, casual users ride for 23 mins. Let us find the same for users with active memberships.


SELECT AVG(ride_duration), membership
from combined_data
WHERE membership = 'member'
GROUP by membership;

--We see that users with an active membership tend to ride for a shorter duration. But, as we saw earlier, users with active memberships also tend to have more rides 
--compared to users with no active memberships as members tend to use more on weekdays for commute purposes.

Finally, after the EDA process, the CTE_2022 table was saved in a CSV file and the file was then uploaded to Tableau Desktop for visualization.

