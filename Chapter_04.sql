/**
 * @Author: ADITYA KUMAR SINGH <the__martian>
 * @Email:  cr7.aditya.cs@gmail.com
 * @Filename: Chapter_04.sql
 * @Last modified by:   the__martian
 */



-- Example

--
use SalesOrdersExample;
--
select VendName
from Vendors;

--
select ProductName, RetailPrice
from Products;

--
select Distinct CustState
from Customers;

--
use EntertainmentAgencyExample;

--
select EntStageName, EntCity
from Entertainers
order by 2, 1;

--
select Distinct StartDate
from Engagements;

--
use SchoolSchedulingExample;

--
select *
from Classes;

--
select BuildingName, NumberOfFloors
from Buildings
order by 1;

--
use BowlingLeagueExample;

--
select Distinct TourneyLocation
from Tournaments;

--
select TourneyDate, TourneyLocation
from Tournaments
order by 1 desc, 2 ;

--
use RecipesExample;

--
select RecipeClassID, RecipeTitle
from Recipes
order by 1, 2;

--
select Distinct RecipeClassID
from Recipes;


-- Problems

--
use SalesOrdersExample;

--
select *
from Employees;

--
select VendCity, VendName
from Vendors
order by 1;


--
use EntertainmentAgencyExample;

--
select AgtLastName, AgtFirstName, AgtPhoneNumber
from Agents;

--
select *
from Engagements;

--
select StartDate, EngagementNumber
from Engagements
order by 1 desc, 2;

--
use SchoolSchedulingExample

--
select Distinct SubjectName
from Subjects;

--
select Distinct Title
from Faculty;

--
select StfLastname, StfFirstName, StfPhoneNumber
from Staff
order by 1, 2;

--
use BowlingLeagueExample;

--
select Distinct TeamName
from Teams;

--
select *
from Bowler_Scores;

--
select BowlerLastName, BowlerMiddleInit, BowlerFirstName, BowlerAddress, BowlerCity, BowlerState, BowlerZip
from Bowlers
order by 1, 2, 3;

--
use RecipesExample;

--
select Distinct IngredientName
from Ingredients;


--
select * from Recipes
order by 2;
