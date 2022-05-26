#Looking for total cases vs deaths percentage in the world (Death percentage per country in the world)
SELECT location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 AS DeathsPercentage 
FROM portfolio.`copy of coviddeaths` 
WHERE continent is not null
ORDER BY location ASC;

#Looking for total cases vs deaths percentage in the United States (Death percentage in the United States )
SELECT location, date, total_deaths,total_cases,(total_deaths/total_cases)*100 AS DeathPercentage
FROM portfolio.`copy of coviddeaths` 
WHERE location like  '%States%' 
ORDER BY total_cases ASC;

#Looking for percentage of the population affected in the United States ( Percentage of United States Population that has gotten covid)
SELECT location, date ,total_cases, population,(total_cases/population) *100 AS PercentageofPopulationInfected 
FROM portfolio.`copy of coviddeaths` 
WHERE location like  '%States%' 
ORDER BY total_cases ASC;

#Looking for countries with highest infection related to covid
SELECT location, population, MAX(total_cases) AS MaxInfection, MAX(total_cases/population) *100 AS PercentageofPopulationInfected 
FROM portfolio.`copy of coviddeaths` 
WHERE continent is not null
GROUP BY location, population 
ORDER BY PercentageofPopulationInfected DESC;

#Looking for countries with highest death count related to covid (need to change data into integer because of issue with dataset)
SELECT location, MAX(CAST(total_deaths AS INT) AS MaxDeath
FROM portfolio.`copy of coviddeaths`
WHERE continent is not null 
GROUP BY location 
ORDER BY MaxDeath DESC;

#Looking for continent with highest death count related to covid 
SELECT continent, MAX(total_deaths) AS MaxDeath
FROM portfolio.`copy of coviddeaths`
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY MaxDeath DESC;

#Showing the continent with the highest Covid death count
SELECT continent, MAX(total_deaths) AS TotalDeath
FROM portfolio.`copy of coviddeaths`
GROUP BY continent
ORDER BY TotalDeath DESC;

# Total numbers worlwide
SELECT date, location, SUM(new_cases) AS Sumnewcases, SUM(new_deaths) AS Sumnewdeath, (SUM(new_deaths)/ SUM(new_cases)) *100 AS Newdeathpercentage
FROM portfolio.`copy of coviddeaths` 
WHERE continent IS NOT NULL
GROUP BY date, location
ORDER BY date;

#Total numbers in the United States 
SELECT date, location, SUM(new_cases) AS Sumnewcases, SUM(new_deaths) AS Sumnewdeath, (SUM(new_deaths)/ SUM(new_cases)) *100 AS Newdeathpercentage
FROM portfolio.`copy of coviddeaths` 
WHERE location like '%states%'
GROUP BY date, location
ORDER BY date DESC;

#Let's join both table
SELECT *
FROM portfolio.`copy of coviddeaths` AS dea
JOIN portfolio.`copy of covidvaccinations` AS vac
ON dea.location = vac.location
AND dea.date = vac.date;

#Looking for total population vs total vaccination
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(vac.new_vaccinations) OVER (Partition by dea.location ORDER BY dea.date) AS Peoplevaccinated
FROM portfolio.`copy of coviddeaths` AS dea
JOIN portfolio.`copy of covidvaccinations` AS vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY date ASC;
#
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,Peoplevaccinated
FROM portfolio.`copy of coviddeaths` AS dea
JOIN portfolio.`copy of covidvaccinations` AS vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY date ASC;









