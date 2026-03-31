# 🦠 COVID-19 Data Analysis using SQL

## 📊 Overview
This project analyzes global COVID-19 data using SQL to uncover insights about infection rates, death rates, and vaccination progress across different countries and regions.

The goal is to transform raw data into meaningful insights that can support data-driven decision-making.

---

## 🎯 Objectives
- Analyze total cases, deaths, and death percentage
- Identify countries with highest infection rate relative to population
- Compare death rates across continents
- Track vaccination progress over time

---

## 🛠️ Tools & Skills Used
- SQL Server
- Data Cleaning
- JOIN operations
- Aggregate Functions (SUM, COUNT, MAX)
- Window Functions (OVER, PARTITION BY)
- CTE (Common Table Expressions)

---

## 📂 Dataset
- Source: Our World in Data (COVID-19 dataset)
- Tables used:
  - CovidDeaths
  - CovidVaccinations

---

## 🔍 Key Analysis

### 1. Total Cases vs Total Deaths
- Calculated likelihood of death if infected
- Identified trends over time

### 2. Infection Rate by Country
- Compared infection rates relative to population
- Highlighted most impacted countries

### 3. Death Count by Continent
- Aggregated total deaths across continents
- Compared regional impact

### 4. Vaccination Progress
- Used window functions to calculate rolling vaccinations
- Tracked vaccination rate over time

---

## 📈 Key Insights
- A small number of countries contributed to a large proportion of total cases
- Death rates varied significantly between regions
- Vaccination rollout showed strong upward trends after initial phases
- Some countries had high infection rates but relatively lower death rates

---

## 📸 Sample Query

```sql
-- Calculate rolling vaccination count
SELECT 
    location, 
    date, 
    new_vaccinations,
    SUM(new_vaccinations) OVER (PARTITION BY location ORDER BY date) AS rolling_vaccinations
FROM CovidVaccinations;
