-- Checking data
select *
from dbo.CovidDeaths
where continent is not null

-- Select data for reviewing
Select location, date, total_cases, New_cases, total_deaths, Population
from dbo.CovidDeaths
where continent is not null
order by 1,2

-- Total Cases vs Total Death
-- show likelihod for dying if you contract covid in your country
Select location, date, total_cases, total_deaths, 
	(total_deaths/total_cases)*100 As DeathPercentage
from dbo.CovidDeaths
Where Location like '%state%'
where continent is not null
order by 1,2

-- Looking at Total Cases Vs Population
-- show what percentage of population got covid
Select location, date,Population, total_cases, 
	(total_cases/population)*100 As InfectivePercentage
from dbo.CovidDeaths
--Where Location like '%state%'
where continent is not null
order by 1,2

--Looking at the country with highest Infection Rate Compare to Population
Select location, population, 
	max(total_cases) as TotalInfectionCount, 
	Max((total_cases/population))*100 As PercentagePopulationInfected
from dbo.CovidDeaths
where continent is not null
Group by location, population
order by PercentagePopulationInfected Desc

--showing the country with highest Death Count for population
Select location, population, 
	max(total_deaths) as TotalDeathCount, 
	Max((total_deaths/population))*100 As PercentagePopulationDeath
from dbo.CovidDeaths
where continent is not null
Group by location, population
order by TotalDeathCount Desc


-- Breaking things down by continent
-- Showing the continent with the highest Deathcount
Select continent,
	max(total_deaths) as TotalDeathCount
from dbo.CovidDeaths
where continent is not null
Group by continent
order by TotalDeathCount Desc

-- Global numbers 
Select sum(new_cases) As TotalNewCase, sum(new_deaths) As TotalNewDeath,
	(sum(new_deaths)/sum(new_cases))*100 AS DeathPercentage
	--total_deaths, 
	--(total_deaths/total_cases)*100 As DeathPercentage
from dbo.CovidDeaths
--Where Location like '%state%' 
where continent is not null
--Group by date
order by 1,2

select *
from dbo.CovidVaccinations

-- Looking at Total Population vs Vaccinations
--join Vacinate Data into Death data

-- Use CTE 
with PopvsVac (Continent, Location,Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as(

select cd.continent, cd.location,cd.date,  cd.population,
	cv.new_vaccinations,
	sum(cv.new_vaccinations) OVER (PARTITION BY cd.location Order by cd.date) as RollingPeopleVaccinated
from dbo.CovidDeaths As cd
	join dbo.CovidVaccinations as cv
	on cd.location = cv.location and cd.date = cv.date
where cd.continent is not null
--order by 2,3
)
select *, 
	(RollingPeopleVaccinated/Population)*100
from PopvsVac




DROP TABLE IF EXISTS #PercentPopupationVaccinated;
--TEMP TABLE 
create table #PercentPopupationVaccinated 
(
Continent nvarchar(255),
Location nvarchar(255),
[date] datetime,
Population float,
New_vaccinations float,
RollingPeopleVaccinated float
)

insert into #PercentPopupationVaccinated 
select cd.continent, cd.location,cd.date, cd.population,
	cv.new_vaccinations,
	sum(cv.new_vaccinations) OVER (PARTITION BY cd.location Order by cd.date) as RollingPeopleVaccinated
from dbo.CovidDeaths As cd
	join dbo.CovidVaccinations as cv
	on cd.location = cv.location and cd.date = cv.date
--where cd.continent is not null
-- order by  2,3

select *, 
	(RollingPeopleVaccinated/Population)*100 As PercentVaccinated
	Max(
from #PercentPopupationVaccinated 


-- creating view to store data for later visualizations 

create view PercentPopupationVaccinated as
select cd.continent, cd.location,cd.date, cd.population,
	cv.new_vaccinations,
	sum(cv.new_vaccinations) OVER (PARTITION BY cd.location Order by cd.date) as RollingPeopleVaccinated
from dbo.CovidDeaths As cd
	join dbo.CovidVaccinations as cv
	on cd.location = cv.location and cd.date = cv.date
where cd.continent is not null
-- order by  2,3

--
select *
from PercentPopupationVaccinated