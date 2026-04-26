/* (a) DATE AND TIME WITH HIGHEST DEMAND RATE IN 2017 */
SELECT timestamp, months, weekday, hour, demand
FROM carsharing.carshare 
RIGHT JOIN carsharing.time ON time.id = carshare.id
WHERE timestamp like '%2017%' /* INCLUDE ONLY INFO FROM 2017 */
ORDER BY demand desc
LIMIT 1; /* OUTPUTS ONLY ONE ROW OF DATA */
/* WE CAN SEE THAT ON THURSDAY, 15TH OF JUNE, 2017 AT 5PM, CARS ARE HIGHLY DEMANDED OR RENTED */


/* (b) WEEKDAY, MONTHS, AND SEASONS WITH THE HIGHEST AND LOWEST AVERAGE DEMAND IN 2017 */
(SELECT 'Highest' as category, weekday, months, season, AVG(demand) avg_demand
FROM carsharing.carshare
JOIN carsharing.time ON time.id = carshare.id
WHERE timestamp like '%2017%'
GROUP BY 1,2,3,4
ORDER BY 5 desc
LIMIT 1)
union all
(SELECT 'Lowest' as category, weekday, months, season, AVG(demand) avg_demand
FROM carsharing.carshare
JOIN carsharing.time ON time.id = carshare.id
WHERE timestamp like '%2017%'
GROUP BY 1,2,3,4
ORDER BY 5 asc
LIMIT 1);
/* THE HIGHEST AVERAGE DEMAND IN 2017 HAPPENED DURING THE FALL SEASON ON A SUNDAY OF JULY AND YIELDED 4.99. WHILST THE LOWEST 
AVERAGE DEMAND OCCURRED DURING THE SPRING SEASON ON A MONDAY OF JANUARY AND YIELDED 3.05 */


/* (c) AVERAGE DEMAND AT DIFFERENT HOURS OF SUNDAY AND MONDAY THROUGHOUT 2017 */
WITH demand_hours AS(
SELECT weekday, hour, demand
FROM carsharing.carshare
JOIN carsharing.time ON time.id = carshare.id
WHERE timestamp like '%2017%' and weekday = 'Sunday' 
),
peak_day AS(
SELECT distinct(weekday), demand
FROM demand_hours
GROUP BY weekday, demand
ORDER BY demand desc
LIMIT 1)
(SELECT weekday, hour as hour_of_day, ROUND(AVG(demand),2) as average_demand
FROM demand_hours
WHERE weekday = (
SELECT weekday
FROM peak_day)
GROUP BY weekday, hour
ORDER BY average_demand desc
)
UNION ALL
(WITH demand_hours AS(
SELECT weekday, hour, demand
FROM carsharing.carshare
JOIN carsharing.time ON time.id = carshare.id
WHERE timestamp like '%2017%' and weekday = 'Monday' 
),
peak_day AS(
SELECT distinct(weekday), demand
FROM demand_hours
GROUP BY weekday, demand
ORDER BY demand desc
LIMIT 1)
SELECT weekday, hour as hour_of_day, ROUND(AVG(demand),2) as average_demand
FROM demand_hours
WHERE weekday = (
SELECT weekday
FROM peak_day)
GROUP BY weekday, hour
ORDER BY average_demand desc
);
/* WE CAN DEDUCE FROM THE TABLE THAT THERE IS A HIGH AVERAGE DEMAND RANGING FROM 5.2-5.6 DURING AFTERNOON HOURS TILL LATE EVENING AROUND 11AM TO 6PM ON SUNDAYS AND MONDAYS. WHILST THERE IS A LOW AVERAGE DEMAND BETWEEN THE EARLY HOURS OF THE DAY (1AM-6AM) AND LATE HOURS IN THE NIGHT (10PM-12AM) */


/* (d) WEATHER INFORMATION */
/* (di) MOST PREVALENT WEATHER */
SELECT temp, count(temp) frequency, temp_category
FROM carsharing.temperature tem
JOIN carsharing.carshare
JOIN carsharing.time ON time.id = carshare.id AND carshare.temp_code = tem.temp_code
WHERE timestamp like '%2017%'
GROUP BY temp, temp_feel, temp_category
ORDER BY 2 desc
LIMIT 1;
/* A MILD WEATHER IS THE MOST COMMON WEATHER IN 2017 */


/* (dii) AVERAGE, MAXIMUM AND MINIMUM WINDSPEED PER MONTH */ 
SELECT months, AVG(windspeed), MAX(windspeed), MIN(windspeed)
FROM carsharing.carshare
JOIN carsharing.time ON carshare.id = time.id
WHERE timestamp like '%2017%' and windspeed <> 0 /* WHERE WINDSPEED IS GREATER THAN ZERO */
GROUP BY months
ORDER BY 1;
/* EXCLUDING 0 VALUES AS A WINDSPEED OF 0 IS METEOROLOGICALLY IMPROBABLE, WE OBSERVED THE HIGHEST WINDSPEED TO RANGE
FROM 35-57 ACROSS EACH MONTHS, THE LOWEST WINDSPEED TO BE 6 ACROSS ALL MONTHS, AND THE AVERAGE TO RANGE FROM 13.01 - 17.87 */


/* AVERAGE, MAXIMUM AND MINIMUM HUMIDITY PER MONTH */ 
SELECT months, AVG(humidity), MAX(humidity), MIN(humidity)
FROM carsharing.carshare
JOIN carsharing.time ON carshare.id = time.id
WHERE timestamp like '%2017%' and humidity <> 0 /* INCLUDE ONLY VALUES GREATER THAN ZERO */
GROUP BY months
ORDER BY 1;
/* AGAIN, EXCLUDING 0 VALUES AS A HUMIDITY OF 0 IS METEOROLOGICALLY IMPROBABLE, WE OBSERVED THE HIGHEST HUMIDITY TO RANGE
FROM 94-100 ACROSS EACH MONTHS, THE LOWEST HUMIDITY TO RANGE BETWEEN 8-42 ACROSS ALL MONTHS, AND AVERAGE HUMIDITY 
TO RANGE FROM 53.58 - 74.78 */


/* (diii) AVERAGE DEMAND FOR EACH WEATHER CONDITION IN 2017 */
SELECT temp_category, ROUND(AVG(demand),2) AS avg_demand
FROM carsharing.carshare
JOIN carsharing.time ON time.id = carshare.id
JOIN carsharing.temperature ON carshare.temp_code = temperature.temp_code
WHERE timestamp like '%2017%'
GROUP BY temp_category
ORDER BY 2 desc;
/* THE AVERAGE DEMAND DURING HOT WEATHER YIELDED 4.8, AND 4.02 FOR A MILD WEATHER. AS FOR DURING COLD WEATHER,
THE AVERAGE DEMAND IS AT 3.19 */ 


/* (e) MONTH WITH HIGHEST AVERAGE DEMAND ACCORDING TO WEATHER DIFFERENT WEATHER CONDITIONS */
SELECT months, temp_category, ROUND(AVG(demand),2) avg_demand, ROUND(AVG(windspeed),2) avg_windspeed,
ROUND(AVG(humidity),2) avg_humidity, ROUND(AVG(temp),2) avg_temperature
FROM carsharing.carshare
JOIN carsharing.time ON time.id = carshare.id
JOIN carsharing.temperature ON carshare.temp_code = temperature.temp_code
WHERE timestamp like '%2017%' and months = "Jul"
GROUP BY 1,2
ORDER BY avg(demand) desc;
/* THE WEATHER CONDITION FOR THE MONTH OF JULY, 2017 WAS MOSTLY MILD WITH AN AVERAGE TEMPERATURE, HUMIDITY AND WINDSPEED OF 30.34, 64, AND 11.71 RESPECTIVELY. IT HAD AVERAGE DEMAND OF 4.81 DURING THESE CONDITIONS.  */