# [CarSharing-Report-with-SQL-Queries](https://docs.google.com/document/d/13C5y4ILBZXyZK-r4xyWCN69fNmnw3LmKnSUc9L3M5Gw/edit?usp=drivesdk)

### OBJECTIVE 
This project aims to uncover insights in data from a car sharing company to answer business questions for marketing purposes. The dataset contains information about the customers’ demand rate between January 2017 and August 2018. The data were collected on an hourly basis and included the time data such as date, hour, and season as well as weather data such as the weather condition, temperature, humidity, and wind speed. The ‘demand’ column represents the customer’s willingness for renting a car for a specific time. Higher demand rates show that customers are more willing to rent a car and vice versa. 

### DATA PREPARATION AND MANIPULATION 
For preparation, the dataset was firstly imported into Google Sheets and then manipulated using various Sheet Functions. 

### MISSING VALUES
Missing values under the temp and temp_feel columns were filled up with their respective averages and rounded to the appropriate decimal places. This was carried out by filtering out the empty rows and using the AVERAGE(), and ROUND() functions to fill them up. 

### FEATURE ENGINEERING
Column “temp_category” was created to classify the temperature feel (temp_feel) into Cold (<10), Mild (<=25), and Hot (>25) using the IFS function. 
Column “temp_code” was created to act as a relationship between the temperature table and carsharing_df table by concatenating the values of the temp, temp_feel, and temp_category columns using the CONCATENATE function with a hyphen as a delimiter. 
Column “weather_code” was created to classify the distinct values of the weather column into numerical values ranging from 1-4 using the IFS function. This column would also act as a relationship between the weather table and carsharing_df table. 
Columns “months”, “weekday”, and “hour” was created from the “timestamp” column using MONTHS(), WEEKDAY(), and HOUR() functions respectively for each column. 

### TABLE CREATION
- [weather](https://drive.google.com/open?id=1wkYlnKFD8dcajt7B7QMUr5CHp7wacc2Z): A new sheet titled “weather” was created to include all columns related to the weather (i.e. “weather” and “weather code”). Then the “weather” column was dropped from the original carsharing_df sheet. 

- [temperature](https://drive.google.com/open?id=16Z0uhw2UgX0RGYg8hwTGPCMVLBtJm59K): A new sheet titled “temperature” was created to include all columns related to the temperature (i.e. “temp”, “temp_feel”, “temp_category” and “temp code”). Then the “temp”, “temp_feel”, and “temp_category” columns was dropped from the original carsharing_df sheet.

- [time](https://drive.google.com/open?id=1QUyM-RAvGNgjDFdHlbxX0XJOAUFSszYm): A new sheet titled “time” was created to include all columns related to the time (i.e. “id”, “timsestamp”, “season”, “hour”, “weekday”, and “months”). Then the “timsestamp”, “season”, “hour”, “weekday”, and “months” columns was dropped from the original carsharing_df sheet. The “id” column would serve as a connecting column between the original carsharing_df table and the time table.

- [carsharing](https://drive.google.com/open?id=18Gwuy4ToxGLb5nEiRCjDJvCi4NKQTKpY): Thus, the original sheet contains the columns: “id”, “workingday”, “holiday”, “humidity”, “windspeed”, “demand”, “temp_code”, and “weather_code” in it. 

### DATA VALIDATION 
Duplicate entries were removed from the temperature sheet. 

### CONCLUSION
The four sheets (carsharing, temperature, weather, time) were downloaded as csv files to serve as tables for the carsharing database. 


## BUSINESS QUESTIONS 
(a) Please tell me which date and time we had the highest demand rate in 2017.

**— 5PM, 15TH JUNE, 2017**

(b) Give me a table containing the name of the weekday, month, and season in which we had the highest and lowest average demand throughout 2017. Please include the calculated average demand values as well.

**— HIGHEST (4.99): SUNDAY, JULY, FALL**
**— LOWEST (3.05): MONDAY, JANUARY, SPRING**

(c) For the weekday(s) selected in (b), please give me a table showing the average demand we had at different hours of that weekday throughout 2017. Please sort the results in descending order based on the average demand.

**— THERE IS A HIGH AVERAGE DEMAND RANGING FROM 5.2 - 5.6 DURING AFTERNOON HOURS TILL LATE EVENING AROUND 11AM TO 6PM ON SUNDAYS AND MONDAYS. WHILST THERE IS A LOW AVERAGE DEMAND OF 1.6 - 4.4 BETWEEN THE EARLY HOURS OF THE DAY (1AM-6AM) AND LATE HOURS IN THE NIGHT (10PM-12AM)**
**— (RUN QUERY TO VIEW FULL TABLE)**


(di) Please tell me what the weather was like in 2017. Was it mostly cold, mild, or hot? which weather condition (shown in the weather column) was the most prevalent in 2017?

**— THE WEATHER WAS MOSTLY MILD.** 

(dii) What was the average, highest, and lowest wind speed and humidity for each month in 2017? Please organize this information in two tables for the wind speed and humidity.

**— (RUN QUERY TO SEE FULL TABLES)**

(diii) Please also give me a table showing the average demand for each cold, mild, and hot weather in 2017 sorted in descending order based on their average demand.

**— (RUN QUERY TO SEE FULL TABLE)**
**— HOT: 4.8, MILD: 4.02, COLD: 3.19**

(e) Give me another table showing the information requested in (d) for the month we had the highest average demand in 2017 so that I can compare it with other months.

**— JULY HAD AN AVERAGE DEMAND OF 4.81 DURING MILD WEATHER WITH AN AVERAGE TEMPERATURE, HUMIDITY AND WINDSPEED OF 30.34, 64, AND 11.71 RESPECTIVELY.**
**— (RUN QUERY TO SEE FULL TABLE)**

