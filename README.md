# Los Angeles Crime Data Analysis (2020-2025)

## 📊 Project Overview
This project analyzes over 1 million crime records from the City of Los Angeles spanning 2020 to early 2025. The analysis reveals crime patterns, hotspots, and trends that provide actionable insights for public safety planning.

## 🎯 Key Questions Explored
1. **Which areas have the highest crime rates?**
2. **What times of day see the most criminal activity?**
3. **What are the most common types of crimes?**
4. **Which weapons are most frequently used?**
5. **What percentage of cases result in arrests?**
6. **Where do most crimes occur? (Streets, homes, businesses?)**

## 📈 Key Findings

### Geographic Hotspots
- **Central LA** leads with 69,670 crimes (6.93% of all incidents)
- Top 3 areas (Central, 77th Street, Pacific) account for nearly 19% of all crime
- Clear concentration in downtown and south LA areas

### Time Patterns
- **Peak crime hour: 12 PM (noon)** with 67,813 incidents
- Afternoon/evening (12 PM - 11 PM) represents the highest-risk window
- Safest hours: 4 AM - 6 AM (early morning)
- Distinct "lunch rush" pattern in crime activity

### Crime Types
- **Vehicle theft dominates** at 115,190 cases (11.46%)
- Property crimes (theft, burglary, vandalism) comprise 40%+ of all incidents
- Violent crimes (assault, robbery) account for ~13%
- Identity theft emerged as a significant issue (62,537 cases)

### Weapons & Violence
- **67.4% of crimes involve NO weapon** (677,744 cases)
- Most crime is property-related, not violent confrontation
- When weapons are used, they vary widely based on crime type

### Case Resolution
- **ONLY 8.67% of cases result in adult arrests**
- 79.89% remain "Under Investigation" indefinitely
- Effective clearance rate is extremely low
- Highlights significant challenges in LA law enforcement resources

### Crime Locations
- **Streets are the most dangerous** (26% of all crime - 261,284 incidents)
- Residential areas (single + multi-family) combine for 28% of crimes
- Parking lots are major hotspots (6.88%)
- Public spaces are more vulnerable than secured buildings

### Trend Over Time
- Crime **increased 2020-2022** (COVID recovery period)
- Peaked at ~230,000 incidents in 2022
- **Significant decrease in 2024** to ~125,000 incidents
- Suggests policy changes or enforcement improvements

## 🛠️ Technologies Used

### Data Cleaning & Analysis
- **SQL (MS SQL Server)**: Primary data cleaning and transformation
  - Handled NULL values and invalid entries
  - Created calculated columns for time-based analysis
  - Aggregated data for summary statistics

- **Python**: Data processing and visualization
  - Libraries: pandas, matplotlib, seaborn, numpy
  - Automated cleaning pipeline
  - Generated statistical summaries

### Visualization
- **Python (matplotlib/seaborn)**: Statistical visualizations
- **Tableau Public**: Interactive dashboards *(coming soon)*

## 📂 Project Structure
```
├── data/
│   ├── Crime_Data_from_2020_to_Present.csv (raw)
│   ├── LA_Crime_Data_Cleaned.csv (cleaned)
│   └── summary_tables/ (7 aggregated CSV files)
├── sql/
│   ├── data_cleaning.sql
│   └── analysis_queries.sql
├── python/
│   └── crime_analysis.py
├── visualizations/
│   ├── 1_Crime_By_Area.png
│   ├── 3_Crime_Types.png
│   ├── 4_Weapons_Used.png
│   ├── 5_Case_Status.png
│   ├── 6_Crime_Locations.png
│   └── 7_Crime_Trend_Years.png
└── README.md
```

## 🔍 Data Cleaning Process

### Challenges Addressed
1. **Missing Weapon Data**: 677,744 NULL values replaced with "NO WEAPON USED"
2. **Invalid Coordinates**: Zero values in LAT/LON fields set to NULL
3. **Invalid Victim Ages**: Negative and zero ages cleaned to NULL
4. **Missing Premise Information**: 588 records with unknown locations standardized
5. **Date/Time Formatting**: Converted various formats to SQL datetime standards

### Data Quality Improvements
- Standardized categorical variables
- Created time-based helper columns (Hour, Day, Month, Year)
- Validated geographic coordinates
- Ensured referential integrity

## 💡 Insights & Recommendations

1. **Increase patrol presence during noon-evening hours** (12 PM - 8 PM)
2. **Focus resources on Central, 77th Street, and Pacific areas**
3. **Implement vehicle theft prevention programs** (biggest crime category)
4. **Improve street lighting and surveillance** (26% of crimes occur on streets)
5. **Address the low arrest rate** - only 8.67% clearance suggests resource constraints

## 📊 Data Source
**City of Los Angeles Open Data Portal**
- Dataset: Crime Data from 2020 to Present
- Last Updated: January 3, 2026
- Records: 1,004,991 incidents
- [Source Link](https://data.lacity.org/)

## 📝 License
This project uses publicly available data from the City of Los Angeles. Analysis and code are available for educational purposes.

---

*This analysis was conducted as part of a data analytics portfolio project showcasing SQL, Python, and data visualization skills.*
```
