# CarSharing-Report-with-SQL-Queries

### OBJECTIVE 
This project aims to uncover insights in data from a car sharing company to answer business questions for marketing purposes. The dataset contains information about the customers’ demand rate between January 2017 and August 2018. The data were collected on an hourly basis and included the time data such as date, hour, and season as well as weather data such as the weather condition, temperature, humidity, and wind speed. The ‘demand’ column represents the customer’s willingness for renting a car for a specific time. Higher demand rates show that customers are more willing to rent a car and vice versa. 

### DATA PREPARATION AND MANIPULATION 
For preparation, the dataset was firstly imported into Google Sheets and then manipulated using various Sheet Functions. 

### MISSING VALUES
Missing values under the temp and temp_feel columns were filled up with their respective averages and rounded to the appropriate decimal places. This was carried out using the ISBLANK(), AVERAGE(), and ROUND() functions. 

### FEATURE ENGINEERING
- Column “temp_category” was created to classify the temperature feel (temp_feel) into Cold (<10), Mild (<=25), and Hot (>25) using the IFS function.
  
- Column “temp_code” was created to act as a relationship between the temperature table and carsharing_df table by concatenating the values of the temp, temp_feel, and temp_category columns using the CONCATENATE function with a hyphen as a delimiter.
  
- Column “weather_code” was created to classify the distinct values of the weather column into numerical values ranging from 1-4 using the IFS function. This column would also act as a relationship between the weather table and carsharing_df table.
  
- Columns “months”, “weekday”, and “hour” was created from the “timestamp” column using MONTHS(), WEEKDAY(), and HOUR() functions respectively for each column. 

### TABLE CREATION
- Weather: A new sheet titled “weather” was created to include all columns related to the weather (i.e. “weather” and “weather code”). Then the “weather” column was dropped from the original carsharing_df sheet.
  
- Temperature: A new sheet titled “temperature” was created to include all columns related to the temperature (i.e. “temp”, “temp_feel”, “temp_category” and “temp code”). Then the “temp”, “temp_feel”, and “temp_category” columns was dropped from the original carsharing_df sheet.
  
- Time: A new sheet titled “time” was created to include all columns related to the time (i.e. “id”, “timsestamp”, “season”, “hour”, “weekday”, and “months”). Then the “timsestamp”, “season”, “hour”, “weekday”, and “months” columns was dropped from the original carsharing_df sheet. The “id” column would serve as a connecting column between the original carsharing_df table and the time table.
  
- Carsharing: Thus, the original sheet contains the columns: “id”, “workingday”, “holiday”, “humidity”, “windspeed”, “demand”, “temp_code”, and “weather_code” in it. 

### DATA VALIDATION 
Duplicate entries were removed from the temperature sheet. 

### CONCLUSION
The four sheets (carsharing, temperature, weather, time) were downloaded as csv files to serve as tables for the carsharing database. 
