/**
 * @Author: ADITYA KUMAR SINGH <the__martian>
 * @Email:  cr7.aditya.cs@gmail.com
 * @Filename: Chapter_10.sql
 * @Last modified by:   the__martian
 */

------------------------------------------------------------------
            P R A C T I C E  P R O B L E M
------------------------------------------------------------------
use SalesOrdersExample;
------------------------------------------------------------------
select CustFirstName as "First Name",CustLastName as "Last Name",
CustStreetAddress as Addresss, CustCity as City, CustState as
State, CustZipCode as "Zip Code"
from
    Customers
union all
select EmpFirstName, EmpLastName, EmpStreetAddress, EmpCity,
EmpState, EmpZipCode
from
    Employees
order by 6;
------------------------------------------------------------------
select CustFirstName, CustLastName, "Bike" as ProductType
from
    Customers
inner join
    Orders
    on Customers.CustomerID = Orders.CustomerID
inner join
    Order_Details
    on Order_Details.OrderNumber = Orders.OrderNumber
inner join
    Products
    on Products.ProductNumber = Order_Details.ProductNumber
where ProductName like "%Bike%"
union
select CustFirstName, CustLastName, "Helmet"  as ProductType
from
    Customers
inner join
    Orders
    on Customers.CustomerID = Orders.CustomerID
inner join
    Order_Details
    on Order_Details.OrderNumber = Orders.OrderNumber
inner join
    Products
    on Products.ProductNumber = Order_Details.ProductNumber
where ProductName like "%Helmet%";
------------------------------------------------------------------
use EntertainmentAgencyExample;
------------------------------------------------------------------
select concat(AgtFirstName, ' ', AgtLastName) as Name, "Agent"
as Type
from
    Agents
union
select EntStageName, "Entertainer" as Type
from
    Entertainers;
------------------------------------------------------------------
use SchoolSchedulingExample;
------------------------------------------------------------------
select S.StudFirstName as "First Name", S.StudLastName as "Last
Name", SS.Grade as "Score", "Student" as Type
from
    Students as S
inner join
    Student_Schedules as SS
    on S.StudentID = SS.StudentID
inner join
    Classes as C
    on C.ClassID = SS.ClassID
inner join
    Subjects as SB
    on SB.SubjectID = C.SubjectID
inner join
    Student_Class_Status as SCS
    on SCS.ClassStatus = SS.ClassStatus
where SS.Grade>= 85 and SB.CategoryID = 'ART' and
SCS.ClassStatusDescription = 'Completed'
union
select s.StfFirstName, s.StfLastname, fs.ProficiencyRating,
"Teacher" as Type
from
    Staff as s
inner join
    Faculty as f
    on f.StaffID = s.StaffID
inner join
    Faculty_Subjects fs
    on fs.StaffID = f.StaffID
inner join
    Subjects as sb
    on sb.SubjectID = fs.SubjectID
where fs.ProficiencyRating >= 9 and sb.CategoryID = 'ART';
------------------------------------------------------------------
use BowlingLeagueExample;
------------------------------------------------------------------
select Tournaments.TourneyLocation, Tournaments.TourneyDate,
Tourney_Matches.MatchID, Teams.TeamName, concat(BowlerFirstName,
' ', BowlerLastName) as Name, "Odd Lane" as Lane
from
    Tournaments
inner join
    Tourney_Matches
    on Tournaments.TourneyID = Tourney_Matches.TourneyID
inner join
    Teams
    on Tourney_Matches.OddLaneTeamID = Teams.TeamID
inner join
    Bowlers
    on Bowlers.BowlerID = Teams.CaptainID
union all
select Tournaments.TourneyLocation, Tournaments.TourneyDate,
Tourney_Matches.MatchID, Teams.TeamName, concat(BowlerFirstName,
' ', BowlerLastName) as Name, "Even Lane" as Lane
from
    Tournaments
inner join
    Tourney_Matches
    on Tournaments.TourneyID = Tourney_Matches.TourneyID
inner join
    Teams
    on Tourney_Matches.EvenLaneTeamID = Teams.TeamID
inner join
    Bowlers
    on Bowlers.BowlerID = Teams.CaptainID
order by 2,3;
------------------------------------------------------------------
use RecipesExample;
------------------------------------------------------------------
select Recipe_Classes.RecipeClassDescription as IndexName,
'Recipe Class' as type
from
    Recipe_Classes
union
select Recipes.RecipeTitle, 'Recipe' as type
from
    Recipes
union
select Ingredients.IngredientName, 'Ingredient' as Type
from
    Ingredients
order by 2, 1;
------------------------------------------------------------------
use SalesOrdersExample;
------------------------------------------------------------------
select distinct concat(CustFirstName, ' ', CustLastName) as Name,
Products.ProductName, "Customer" as type
from
    Customers
inner join
    Orders
    on Customers.CustomerID = Orders.CustomerID
inner join
    Order_Details
    on Order_Details.OrderNumber = Orders.OrderNumber
inner join
    Products
    on Products.ProductNumber = Order_Details.ProductNumber
where
    ProductName like "%Helmet%"
union all
select distinct VendName, Products.ProductName, "Vendor" as type
from
    Vendors
inner join
    Product_Vendors
    on Vendors.VendorID = Product_Vendors.VendorID
inner join
    Products
    on Products.ProductNumber = Product_Vendors.ProductNumber
where
    ProductName like "%Helmet%";
------------------------------------------------------------------
use EntertainmentAgencyExample;
------------------------------------------------------------------
select concat(CustFirstName, ' ', CustLastName) as Name,
"Customer" as role
from
    Customers
union all
select EntStageName, "Entertainer" as role
from
    Entertainers;
----------------------------------------------------------------
select concat(CustFirstName, ' ', CustLastName) as Name,
"Customer" as role
from
    Customers
inner join
    Musical_Preferences
    on Customers.CustomerID = Musical_Preferences.CustomerID
inner join
    Musical_Styles
    on Musical_Styles.StyleID = Musical_Preferences.StyleID
where
    StyleName = "Contemporary"
union all
select EntStageName, "Entertainer" as role
from
    Entertainers
inner join
    Entertainer_Styles
    on Entertainers.EntertainerID =
    Entertainer_Styles.EntertainerID
inner join
    Musical_Styles
    on Musical_Styles.StyleID = Entertainer_Styles.StyleID
where
    StyleName = "Contemporary";
------------------------------------------------------------------
use SchoolSchedulingExample;
------------------------------------------------------------------
select "Student" as Type, concat(StudFirstName, ' ',StudLastName)
as Name, StudStreetAddress as "Street Addres", StudCity as City,
StudState as State, StudZipCode as "Zip Code"
from
    Students
union
select "Staff" as Type, concat(StfFirstName, ' ', StfLastname),
StfStreetAddress, StfCity, StfState, StfZipCode
from
    Staff
order by 6;
------------------------------------------------------------------
use BowlingLeagueExample;
------------------------------------------------------------------
--using join
select concat(BowlerFirstName, ' ', BowlerLastName) as Bowler,
RawScore, TourneyLocation
from
    Bowlers
inner join
    Bowler_Scores
    on Bowlers.BowlerID = Bowler_Scores.BowlerID
inner join
    Tourney_Matches
    on Tourney_Matches.MatchID = Bowler_Scores.MatchID
inner join
    Tournaments
    on Tournaments.TourneyID = Tourney_Matches.TourneyID
where
    TourneyLocation = "Thunderbird Lanes" and RawScore >= 165
union all
select concat(BowlerFirstName, ' ', BowlerLastName) as Bowler,
RawScore, TourneyLocation
from
    Bowlers
inner join
    Bowler_Scores
    on Bowlers.BowlerID = Bowler_Scores.BowlerID
inner join
    Tourney_Matches
    on Tourney_Matches.MatchID = Bowler_Scores.MatchID
inner join
    Tournaments
    on Tournaments.TourneyID = Tourney_Matches.TourneyID
where
    TourneyLocation = "Bolero Lanes" and RawScore >= 150;
-- using complex where clause
select concat(BowlerFirstName, ' ', BowlerLastName) as Bowler,
RawScore, TourneyLocation
from
    Bowlers
inner join
    Bowler_Scores
    on Bowlers.BowlerID = Bowler_Scores.BowlerID
inner join
    Tourney_Matches
    on Tourney_Matches.MatchID = Bowler_Scores.MatchID
inner join
    Tournaments
    on Tournaments.TourneyID = Tourney_Matches.TourneyID
where
    (TourneyLocation = "Bolero Lanes" and RawScore >= 150) or
    (TourneyLocation = "Thunderbird Lanes" and RawScore >= 165);
------------------------------------------------------------------
use RecipesExample;
------------------------------------------------------------------
select IngredientName, MeasurementDescription, "Ingredient" as
Type
from
    Ingredients
inner join
    Measurements
    on Ingredients.MeasureAmountID = Measurements.MeasureAmountID
union
select IngredientName, MeasurementDescription, "Recipe" as Type
from
    Recipes
inner join
    Recipe_Ingredients
    on Recipes.RecipeID = Recipe_Ingredients.RecipeID
inner join
    Ingredients
    on Ingredients.IngredientID = Recipe_Ingredients.IngredientID
inner join
    Measurements
    on Measurements.MeasureAmountID = Ingredients.MeasureAmountID;
------------------------------------------------------------------
                        T H E  E N D
------------------------------------------------------------------
