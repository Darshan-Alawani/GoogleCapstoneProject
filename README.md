# GoogleCapstoneProject
This project is a part of the Google Data Analytics certification. I opted for Case Study - 1 which involved helping a bike share company named Cyclist increase the number of memberships.

This project involves studying the monthly trip data of Cyclist and analyzing the same by identifying any visible trends and arriving at a general inference with the trends thereby, suggesting the company with 
data-driven decisions to achieve their business objective.

Cyclist has 2 types of users - casual riders who prefer a single-ride pass or a daily pass while customers who purchase annual memberships are Cyclist members. The goal of this case study was to convert more casual users
to Cyclist members.

#BUSINESS TASK
To understand how casual users use Cyclist Bikes differently from members

#DATA
Data was publicly available in the following data repository: https://divvy-tripdata.s3.amazonaws.com/index.html
The data was segregated into monthly data from previous years. The data taken for this project was for all of 2022.
On initial examination, the datasets had the following data: Ride ID (unique for every ride), bike type (electric, docked, classic), the start date-time & end date-time for each ride ID, start station with each station
having a unique station ID and the end station with its unique station ID, the start & end latitudes and longitudes and finally the user type (casual & member).

#DATA PROCESSING AND CLEANING
The datasets for individual months were downloaded into Microsoft Excel and the data was examined. Initially, the irrelevant columns were deleted.
Next, the start date-time and end date-time were separated into individual columns showing the start date and start time. The same was carried out for end date-time.
Created new columns and calculated the ride duration in mins and the day of the week based on the start date. The start station and end station columns were cleaned with trimming.
The distance travelled was determined based on the start & end latitudes and longitudes.

-Import into SQL
The cleaned datasets were then individually added to the MS SQL server and the first operation performed was merging each dataset to create a large dataset with approximately 4 million rows using UNION ALL operator.
The data was again filtered to a CTE & included ride durations of more than a minute and distances of more than 500m to reflect real-world usage.
Then using some queries performed Exploratory Data Analysis(EDA) on the CTE to observe any trends in ridership based on average distance, average ride duration, days of the week seeing most rides, all by filtering
the membership status to casual and member.

#ANALYSIS & VISUALIZATIONS
The CTE created in SQL with rides of durations more than 1 minute and a distance of more than 500m with 3.8 million rows was later saved in an Excel workbook.
The dataset was then uploaded in Tableau for further analysis and creating visualizations based on the analysis.

### Total ride share ###
![image](https://github.com/Darshan-Alawani/GoogleCapstoneProject/assets/139307108/26239018-101b-4032-99e8-ee63fd65b5c1)

*INSIGHTS*
-> 60.60% of total rides (3.8 million) were completed by users with Annual members in 2022.
-> 39.40% of the total rides were completed by casual users.
-> Annual members are key to the business model given that they formed a majority of the rideshare and the focus should be on maximizing this number.


### Rides per Week ###
![image](https://github.com/Darshan-Alawani/GoogleCapstoneProject/assets/139307108/64ff3a55-a122-4e61-8ddc-553977c5eeb5)

*INSIGHTS*
-> There is a clear trend that casual users prefer to ride on weekends than on weekdays, whereas we see a contradictory trend for members.
-> Members prefer to take rides more on weekdays for commuting to offices, schools, gyms, etc.
-> It is clear that casual users prefer to use bikes more on weekends for leisure purposes rather than commuting on weekdays.


### Average Ride Duration per Day ###
![image](https://github.com/Darshan-Alawani/GoogleCapstoneProject/assets/139307108/f4c7316f-bf5b-42f5-83c1-6f093ca489e4)

*INSIGHTS*
-> The average duration of rides for casual riders is nearly twice that of active users.
-> The average ride duration for both users decreases throughout the week and increases on weekends.
-> But the average ride duration on weekends of casual users is nearly twice that of active users, thereby emphasizing that casual users prefer to use the bikes on weekends for leisure purposes.



