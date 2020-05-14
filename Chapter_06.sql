/**
 * @Author: ADITYA KUMAR SINGH <the__martian>
 * @Email:  cr7.aditya.cs@gmail.com
 * @Filename: Chapter_06.sql
 * @Last modified by:   the__martian
 */



-----------------------------------------------------------
--EXAMPLES--
-----------------------------------------------------------
use SalesOrdersExample;
-----------------------------------------------------------
select OrderNumber as 'Order Number for CustomerID 1001'
from Orders
where CustomerID = 1001;
-----------------------------------------------------------
select ProductName
from Products
where ProductName like 'Dog%'
order by ProductName;
-----------------------------------------------------------
use EntertainmentAgencyExample;
-----------------------------------------------------------
select EntStageName as "Name", EntCity as 'City'
from Entertainers
where EntCity in ('Bellevue', 'Redmond', 'Woodinville')
order by EntStageName;
-----------------------------------------------------------
select EngagementNumber, StartDate, EndDate
from Engagements
where cast(EndDate - StartDate as integer) = 3;
-----------------------------------------------------------
use SchoolSchedulingExample;
-----------------------------------------------------------
select concat(StfLastname, ', ', StfFirstName) as Name, concat('$', cast(Salary as character)) as Salary
from Staff
where Salary >= 40000 and Salary <= 50000
Order by StfLastname, StfFirstName;
-----------------------------------------------------------
select concat(StudLastName, ', ', StudFirstName) as Name, StudCity as City
from Students
where StudLastName = 'Kennedy' or StudCity = 'Seattle';
-----------------------------------------------------------
use BowlingLeagueExample;
-----------------------------------------------------------
select WinningTeamID, GameNumber, MatchID
from Match_Games
where GameNumber = 3 and MatchID between 1 and 10;
-----------------------------------------------------------
select concat(BowlerLastName, ', ', BowlerFirstName) as Name, TeamID
from Bowlers
where TeamID in (3,4,5) and BowlerLastName like 'H%';
-----------------------------------------------------------
use RecipesExample;
-----------------------------------------------------------
select RecipeTitle
from Recipes
where Notes is NULL;
-----------------------------------------------------------
select IngredientName
from Ingredients
where IngredientClassID = 2 and IngredientName not like '%chicken%';
-----------------------------------------------------------
--PROBLEMS--
-----------------------------------------------------------
use SalesOrdersExample;
-----------------------------------------------------------
select VendName as 'Vendor Name', VendCity as 'City'
from Vendors
where VendCity in ('Ballard', 'Bellevue', 'Redmond')
order by VendCity;
-----------------------------------------------------------
select ProductName as 'Product Name',  concat('$', cast(RetailPrice as character)) as ' Retail Price'
from Products
where RetailPrice >= 125.00
order by ProductName;
-----------------------------------------------------------
select VendName as 'Vendor Name'
from Vendors
where VendWebPage is NULL
order by VendName;
-----------------------------------------------------------
use EntertainmentAgencyExample;
-----------------------------------------------------------
select EngagementNumber, StartDate, EndDate
from Engagements
where (StartDate between '2017-10-01' and '2017-10-31') or (EndDate between '2017-10-01' and '2017-10-31');
-----------------------------------------------------------
select EngagementNumber, StartDate, EndDate, StartTime
from Engagements
where ((StartDate between '2017-10-01' and '2017-10-31') or (EndDate between '2017-10-01' and '2017-10-31')) and (StartTime between '12:00:00' and '17:00:00');
-----------------------------------------------------------
select EngagementNumber, StartDate, EndDate
from Engagements
where cast(StartDate - EndDate as integer) = 0;
-----------------------------------------------------------
use SchoolSchedulingExample;
-----------------------------------------------------------
--??????
-----------------------------------------------------------
--???????? what is Pacific Northwest
-----------------------------------------------------------
select SubjectName, SubjectCode
from Subjects
where SubjectCode like 'MUS%';
-----------------------------------------------------------
select StaffID
from Faculty
where Title = 'Associate Professor' and Status = 'Full Time';
-----------------------------------------------------------
use BowlingLeagueExample;
-----------------------------------------------------------
select *
from Tournaments
where TourneyDate between '2017-09-01' and '2017-09-30';
-----------------------------------------------------------
select TourneyLocation, TourneyDate
from Tournaments
where TourneyLocation like 'Bolero%' or TourneyLocation like 'Red Rooster%' or TourneyLocation like 'Thunderbird Lanes'
order by TourneyLocation;
-----------------------------------------------------------
select concat(BowlerLastName, ', ', BowlerFirstName) as Name, TeamID, BowlerCity
from Bowlers
where TeamID between 5 and 8 and BowlerCity in ('Bellevue', 'Bothell', 'Duvall', 'Redmond', 'Woodinville');
-----------------------------------------------------------
use RecipesExample;
-----------------------------------------------------------
select RecipeTitle
from Recipes
where RecipeClassID = 1 and Notes is not NULL;
-----------------------------------------------------------
select *
from Recipes
where RecipeID between 1 and 5;
-----------------------------------------------------------
------ THE END ------
