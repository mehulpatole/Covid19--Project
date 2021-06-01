

use [covid 19 project];

----select * from ['covid-data$']
--select * from ['covid-vaccine$']
--select * from ['covid-data$']

--select * from ['covid-data$']
--u
use [covid 19 project]


select * from covid_data
--total deaths and cases by country
--select sum("total_cases") from covid_data group by "location"
--select location,sum("total_cases") from covid_data group by "location"
--select location, sum("total_cases") as "totalcases" ,sum("total_deaths") as "totaldeaths" from covid_data group by "location" order by "total_cases"

select location , sum(new_cases) as totalcases,sum(new_deaths) as totaldeaths from covid_data where continent is not null group by location order by 2 desc

--total cases in the world :169529795
--total deaths in the world :3533606
--Asia has most number of cases while europe has mosth deaths
--United states has highest number of cases and deaths followed by India and Brazil


--Percentage of people getting infected in countries
select location,max(population) as population,(sum(new_cases)/max(population))*100 as ratio from covid_data group by location order by ratio desc 
--Andorra and Montenegro have most infections based on population to total cases ratio

--Percentage of deaths in countries
select location,max(population) as population,(sum(new_deaths)/max(population))*100 as death_ratio from covid_data where continent is not null group by location order by death_ratio desc 

--Hungary and Czechia have highest death to population ratio

--drill down by continent
select location , sum(new_cases) as totalcases,sum(new_deaths) as totaldeaths from covid_data where continent is null group by location order by 2 desc

--Percentage of people getting infected in continents

select location,max(population) as population,(sum(new_cases)/max(population))*100 as ratio from covid_data where continent is null group by location order by ratio desc

--global numbers
select date,sum(new_cases) as total_cases,sum(new_deaths) as total_deaths from covid_data where continent is not null group by date order by 1


select * from covid_vaccine

-- total population and vaccination

select da.continent,da.location,da.date,da.population,va.new_vaccinations, (new_vaccinations/population)*100 as percent_vaccinations
from covid_data da join covid_vaccine va on da.location = va.location 
and da.date= va.date where da.continent is not null order by 2,3


--creating view
create view percentvaccinations as 
select da.continent,da.location,da.date,da.population,va.new_vaccinations, (new_vaccinations/population)*100 as percent_vaccinations
from covid_data da join covid_vaccine va on da.location = va.location 
and da.date= va.date where da.continent is not null
--order by 2,3
