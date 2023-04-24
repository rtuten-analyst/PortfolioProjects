-- **********************************************************************************************************************************
-- Robert Tuten
-- 2023.04.23
-- DataSource: https://ourworldindata.org/covid-deaths

USE PortfolioProject


-- *** EXPLORATION ***

--Checking Data:
--SELECT * FROM PortfolioProject..covid_deaths
--ORDER BY 3,4;

--SELECT * FROM PortfolioProject..covid_vaccinations
--ORDER BY 3,4;


SELECT 
	location, 
	date, 
	total_cases, 
	new_cases, 
	total_deaths, 
	population 
FROM PortfolioProject..covid_deaths
ORDER BY 1,2;




-- Looking at Total Cases vs. Total Deaths
-- Shows the likelihood of dying if a person contracts Covid-19 in that country
SELECT 
	location, 
	date, 
	total_cases, 
	total_deaths, 
	(CAST(total_deaths AS FLOAT) / CAST(total_cases AS FLOAT))*100 AS DeathPercentage 
FROM PortfolioProject..covid_deaths
WHERE location like '%states' AND continent IS NOT NULL
ORDER BY 1,2;




-- Looking at Total Cases vs Population
-- Shows what percentage of the population that caught Covid-19.
SELECT 
	location, 
	date, 
	population, 
	total_cases, 
	(CAST(total_cases AS FLOAT) / CAST(population AS FLOAT))*100 AS perfcentPopulationInfected 
FROM PortfolioProject..covid_deaths
WHERE continent IS NOT NULL
ORDER BY 1,2;




-- What countries have the highest infection rates compared to the population?
SELECT 
	location, 
	population, 
	MAX(total_cases) AS highest_infection_count, 
	MAX(CAST(total_cases AS FLOAT) / CAST(population AS FLOAT))*100 AS perfcentPopulationInfected 
FROM PortfolioProject..covid_deaths
WHERE continent IS NOT NULL
GROUP BY population, location
ORDER BY perfcentPopulationInfected DESC;




-- Breakdown by CONTINENT
SELECT location, MAX(total_deaths) AS totalDeathCount
FROM PortfolioProject..covid_deaths
WHERE continent IS NULL AND location NOT LIKE ('%income%')
GROUP BY location
ORDER BY totalDeathCount DESC;
-- Dataset contains 'Income Levels High, Upper, and Low as 'location' metrics'.




-- Showing Countries with Highest Death Count per Population
SELECT location, MAX(total_deaths) AS totalDeathCount
FROM PortfolioProject..covid_deaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY totalDeathCount DESC;


-- **********************************************************************************************************************************
-- *** GLOBAL NUMBERS ***

-- Showing continents with the highest death count per population
SELECT location, MAX(total_deaths) AS totalDeathCount
FROM PortfolioProject..covid_deaths
WHERE continent IS NULL AND location NOT LIKE ('%income%')
GROUP BY location
ORDER BY totalDeathCount DESC;



-- GLOBAL: The number of recorded cases and deaths as of 2023.04.23
SELECT  
	SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, 
	(SUM(CAST(new_deaths AS FLOAT))/SUM(CAST(new_cases AS FLOAT)))*100 AS globalDeathPercentage
FROM PortfolioProject..covid_deaths
WHERE continent IS NOT NULL AND new_deaths > 0
-- GROUP BY date
ORDER BY 1,2;


-- **********************************************************************************************************************************
-- Total Population vs Vaccinations
-- SMASH our tables together - Testing JOINs
SELECT *
FROM PortfolioProject..covid_vaccinations AS dea
JOIN PortfolioProject..covid_deaths AS vac
	ON dea.location = vac.location
	AND dea.date = vac.date


SELECT 
	dea.continent, 
	dea.location, 
	dea.date, 
	dea.population, 
	vac.new_vaccinations, 
	SUM(CAST(vac.new_vaccinations AS FLOAT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rollingPeopleVaccinated
	--MAX(rollingPeopleVaccinated / dea.population)*100
FROM PortfolioProject..covid_vaccinations AS vac
JOIN PortfolioProject..covid_deaths AS dea
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3

-- **********************************************************************************************************************************
-- USING CTE to create a column that displays the MAX(rollingPeopleVaccinated)
WITH PopvsVac (continent, location, date, population, new_vaccinations, rollingPeopleVaccinated)
AS
(
SELECT 
	dea.continent, 
	dea.location, 
	dea.date, 
	dea.population, 
	vac.new_vaccinations, 
	SUM(CAST(vac.new_vaccinations AS FLOAT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rollingPeopleVaccinated
	--MAX(rollingPeopleVaccinated / dea.population)*100
FROM PortfolioProject..covid_vaccinations AS vac
JOIN PortfolioProject..covid_deaths AS dea
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
)
SELECT *, (RollingPeopleVaccinated/Population)*100 FROM PopvsVac


-- **********************************************************************************************************************************
-- TEMP Tables
DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
	(continent NVARCHAR(255),
	location NVARCHAR(255),
	DATE DATETIME,
	Population NUMERIC,
	New_vaccinations NUMERIC,
	RollingPeopleVaccinated NUMERIC)

INSERT INTO #PercentPopulationVaccinated
SELECT 
	dea.continent, 
	dea.location, 
	dea.date, 
	dea.population, 
	vac.new_vaccinations, 
	SUM(CAST(vac.new_vaccinations AS FLOAT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rollingPeopleVaccinated
FROM PortfolioProject..covid_vaccinations AS vac
JOIN PortfolioProject..covid_deaths AS dea
	ON dea.location = vac.location
	AND dea.date = vac.date


-- Testing TEMP Table #PercentPopulationVaccinated
SELECT *, (RollingPeopleVaccinated/Population)*100 AS percentPopulationVaccinated FROM #PercentPopulationVaccinated


-- **********************************************************************************************************************************
-- Creating VIEW to store data for later visualizations
CREATE VIEW PercentPopulationVaccinated AS 
SELECT 
	dea.continent, 
	dea.location, 
	dea.date, 
	dea.population, 
	vac.new_vaccinations, 
	SUM(CAST(vac.new_vaccinations AS FLOAT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rollingPeopleVaccinated
FROM PortfolioProject..covid_vaccinations AS vac
JOIN PortfolioProject..covid_deaths AS dea
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL



-- Testing VIEW
SELECT * FROM PercentPopulationVaccinated
