CREATE DATABASE LA_Crimes_Data

DROP TABLE Crime_Data_from_2020_to_Present

SELECT TOP 10*
FROM Crime_Data_from_2020_to_Present

--DATA CLEANING
-- Replacing invalid LAT and LON zeros with NULL
UPDATE Crime_Data_from_2020_to_Present
SET LAT=NULL
WHERE LAT=0

UPDATE Crime_Data_from_2020_to_Present
SET LON=NULL
WHERE LON=0

--Replace invalid ages with NULL(negative ages and 0 ages)
UPDATE Crime_Data_from_2020_to_Present
SET Vict_Age=NULL
WHERE Vict_Age <=0

--Verifying changes
SELECT COUNT(*) AS Zero_Coordinates
FROM Crime_Data_from_2020_to_Present
WHERE LAT IS NULL OR LON IS NULL

--Checking ages
SELECT COUNT(*) AS Invalid_Ages
FROM Crime_Data_from_2020_to_Present
WHERE Vict_Age IS NULL

SELECT 
    MIN(Vict_Age) AS Min_Age,
    MAX(Vict_Age) AS Max_Age,
    AVG(Vict_Age) AS Avg_Age
FROM Crime_Data_from_2020_to_Present
WHERE Vict_Age IS NOT NULL

--Number of rows we have
SELECT COUNT(*) AS Total_Rows
FROM Crime_Data_from_2020_to_Present

--Top 10
SELECT TOP 10 *
FROM Crime_Data_from_2020_to_Present

--Checking for NULLS across all columns
SELECT
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN DR_NO IS NULL THEN 1 ELSE 0 END) AS DR_NO_Nulls,
    SUM(CASE WHEN Date_Rptd IS NULL THEN 1 ELSE 0 END) AS Date_Rptd_Nulls,
    SUM(CASE WHEN DATE_OCC IS NULL THEN 1 ELSE 0 END) AS DATE_OCC_Nulls,
    SUM(CASE WHEN TIME_OCC IS NULL THEN 1 ELSE 0 END) AS TIME_OCC_Nulls,
    SUM(CASE WHEN AREA IS NULL THEN 1 ELSE 0 END) AS AREA_Nulls,
    SUM(CASE WHEN AREA_NAME IS NULL THEN 1 ELSE 0 END) AS AREA_NAME_Nulls,
    SUM(CASE WHEN Crm_Cd IS NULL THEN 1 ELSE 0 END) AS Crm_Cd_Nulls,
    SUM(CASE WHEN Crm_Cd_Desc IS NULL THEN 1 ELSE 0 END) AS Crm_Cd_Desc_Nulls,
    SUM(CASE WHEN Vict_Age IS NULL THEN 1 ELSE 0 END) AS Vict_Age_Nulls,
    SUM(CASE WHEN Vict_Sex IS NULL THEN 1 ELSE 0 END) AS Vict_Sex_Nulls,
    SUM(CASE WHEN Vict_Descent IS NULL THEN 1 ELSE 0 END) AS Vict_Descent_Nulls,
    SUM(CASE WHEN Premis_Cd IS NULL THEN 1 ELSE 0 END) AS Premis_Cd_Nulls,
    SUM(CASE WHEN Premis_Desc IS NULL THEN 1 ELSE 0 END) AS Premis_Desc_Nulls,
    SUM(CASE WHEN Weapon_Used_Cd IS NULL THEN 1 ELSE 0 END) AS Weapon_Used_Cd_Nulls,
    SUM(CASE WHEN Weapon_Desc IS NULL THEN 1 ELSE 0 END) AS Weapon_Desc_Nulls,
    SUM(CASE WHEN Status IS NULL THEN 1 ELSE 0 END) AS Status_Nulls,
    SUM(CASE WHEN Status_Desc IS NULL THEN 1 ELSE 0 END) AS Status_Desc_Nulls,
    SUM(CASE WHEN LAT IS NULL THEN 1 ELSE 0 END) AS LAT_Nulls,
    SUM(CASE WHEN LON IS NULL THEN 1 ELSE 0 END) AS LON_Nulls
FROM Crime_Data_from_2020_to_Present;

-- Fixing weapon NULLS
UPDATE Crime_Data_from_2020_to_Present
SET 
    Weapon_Desc = 'NO WEAPON USED',
    Weapon_Used_Cd = 0
WHERE Weapon_Desc IS NULL;

--Checking single NULL in status
SELECT *
FROM Crime_Data_from_2020_to_Present
WHERE Status IS NULL;

-- Looking at NULL Premis_Cd and 588 NULL Premis_Desc
SELECT Premis_Cd, Premis_Desc, Crm_Cd_Desc, COUNT(*) AS Count
FROM Crime_Data_from_2020_to_Present
WHERE Premis_Cd IS NULL OR Premis_Desc IS NULL
GROUP BY Premis_Cd, Premis_Desc, Crm_Cd_Desc
ORDER BY Count DESC;

-- Finding matching descriptions for those codes elsewhere in the data
SELECT DISTINCT Premis_Cd, Premis_Desc
FROM Crime_Data_from_2020_to_Present
WHERE Premis_Cd IN (418, 256, 972, 973, 974, 975, 976)
AND Premis_Desc IS NOT NULL
ORDER BY Premis_Cd;

-- Fixing the single Status NULL
UPDATE Crime_Data_from_2020_to_Present
SET Status = 'UNK'
WHERE Status IS NULL;

--Checking dates
-- Check current format first
SELECT TOP 5 Date_Rptd, DATE_OCC
FROM Crime_Data_from_2020_to_Present;

SELECT TOP 10*
FROM Crime_Data_from_2020_to_Present;

-- Checking current format first
SELECT TOP 5 Date_Rptd, DATE_OCC
FROM Crime_Data_from_2020_to_Present;

-- Checking current format
SELECT TOP 5 TIME_OCC
FROM Crime_Data_from_2020_to_Present;

--Adding Helper Columns for time analysis
ALTER TABLE Crime_Data_from_2020_to_Present
ADD
	Hour_OCC AS DATEPART (HOUR, TIME_OCC),
	DayOfWeek_OCC AS DATENAME (WEEKDAY, DATE_OCC),
	Month_OCC AS DATENAME (MONTH, DATE_OCC),
	Year_OCC AS YEAR (DATE_OCC),
	Date_Only_OCC AS CAST (DATE_OCC AS DATE);

-- Checking weapon fix
SELECT Weapon_Desc, COUNT(*) AS Count
FROM Crime_Data_from_2020_to_Present
GROUP BY Weapon_Desc
ORDER BY Count DESC;

-- Checking new time columns
-- Check new time columns
SELECT TOP 10
    DATE_OCC,
    TIME_OCC,
    Hour_OCC,
    DayOfWeek_OCC,
    Month_OCC,
    Year_OCC
FROM Crime_Data_from_2020_to_Present;

-- Checking for any remaining NULLs in critical columns
SELECT
    SUM(CASE WHEN Status IS NULL THEN 1 ELSE 0 END) AS Status_Nulls,
    SUM(CASE WHEN Premis_Desc IS NULL THEN 1 ELSE 0 END) AS Premis_Desc_Nulls,
    SUM(CASE WHEN Weapon_Desc IS NULL THEN 1 ELSE 0 END) AS Weapon_Desc_Nulls
FROM Crime_Data_from_2020_to_Present;

--ANALYSIS
--Top 10 Areas By Crime Count
SELECT TOP 10
	AREA_NAME,
	COUNT(*) AS Total_Crimes,
	CAST(COUNT(*) *100.0/(SELECT COUNT(*) FROM Crime_Data_from_2020_to_Present) AS DECIMAL (5,2)) AS Percentage_of_Total
FROM Crime_Data_from_2020_to_Present
GROUP BY AREA_NAME
ORDER BY Total_Crimes DESC;

-- Time Crime is Highest(Hourly Patterns)
-- Crime by Hour of Day
SELECT Hour_OCC, COUNT(*) AS Total_Crimes,
	CAST (COUNT(*) *100.0 / (SELECT COUNT(*) FROM Crime_Data_from_2020_to_Present) AS DECIMAL(5,2)) AS Percentage_of_Total
FROM Crime_Data_from_2020_to_Present
GROUP BY Hour_OCC
ORDER BY Percentage_of_Total DESC;

-- Peak Hours Summary
-- Top 5 Most Dangerous Hours
SELECT TOP 5 Hour_OCC,
	COUNT(*) AS Total_Crimes,
	CASE
		WHEN Hour_OCC BETWEEN 6 AND 11 THEN 'Morning (6AM - 11AM)'
		WHEN Hour_OCC BETWEEN 12 AND 17 THEN 'Afternoon (12PM - 5PM)'
		WHEN Hour_OCC BETWEEN 18 AND 23 THEN 'Evening (18PM - 23PM)'
		ELSE 'Night (12AM - 5AM)'
	END AS Time_Period
FROM Crime_Data_from_2020_to_Present
GROUP BY Hour_OCC
ORDER BY Total_Crimes DESC;

--Most Common Type of Crime
-- Top 15 Crime Types
SELECT TOP 15 Crm_Cd_Desc,
   COUNT(*) AS Total_Incidents,
   CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Crime_Data_from_2020_to_Present) AS DECIMAL(5,2)) AS Percentage_of_Total
FROM Crime_Data_from_2020_to_Present
GROUP BY Crm_Cd_Desc
ORDER BY Total_Incidents DESC;

--Status Description(Were Most Cases Solved?)
-- Case Resolution Status
SELECT Status_Desc, COUNT(*) AS Total_Cases,
	CAST (COUNT(*) *100.0 /(SELECT COUNT(*) FROM Crime_Data_from_2020_to_Present) AS DECIMAL (5,2)) AS Percentage_of_Total
FROM Crime_Data_from_2020_to_Present
GROUP BY Status_Desc
ORDER BY Total_Cases DESC;

-- Where Most Crimes Happen(Premises)
-- Top 15 Crime Locations/Premises
SELECT TOP 15 Premis_Desc,COUNT(*) AS Total_Crimes,
	CAST(COUNT(*) *100.0 /(SELECT COUNT(*) FROM Crime_Data_from_2020_to_Present) AS DECIMAL (5,2)) AS Percentage_of_Total
FROM Crime_Data_from_2020_to_Present
GROUP BY Premis_Desc
ORDER BY Total_Crimes DESC;

