/**
 * @Author: ADITYA KUMAR SINGH <the__martian>
 * @Email:  cr7.aditya.cs@gmail.com
 * @Filename: Chapter_08.sql
 * @Last modified by:   the__martian
 */

-----------------------------------------------------------------
--EXAMPLE
-----------------------------------------------------------------
use SalesOrdersExample;
-----------------------------------------------------------------
select p.ProductName, c.CategoryDescription
from
    Products p
inner join
    Categories c
on p.CategoryID = c.CategoryID;
-----------------------------------------------------------------
use EntertainmentAgencyExample;
-----------------------------------------------------------------
select et.EntStageName as Name, eg.StartDate as 'Start Date', eg.EndDate as 'End Date', concat('$', eg.ContractPrice) as 'Contract Price'
from
    Entertainers as et
inner join
    Engagements as eg
on et.EntertainerID  = eg.EntertainerID;
-----------------------------------------------------------------
use SchoolSchedulingExample;
-----------------------------------------------------------------
select s.SubjectName
from
    Subjects as s
inner join
    Classes as c
on s.SubjectID = c.SubjectID
where WednesdaySchedule = -1;
-----------------------------------------------------------------
use BowlingLeagueExample;
-----------------------------------------------------------------
select t.TeamName as 'Team Name', concat(b.BowlerLastName, ', ', b.BowlerFirstName) as 'Captain Name'
from
    Teams as t
inner join
    Bowlers as b
on t.CaptainID = b.BowlerID;
-----------------------------------------------------------------
use RecipesExample;
-----------------------------------------------------------------
SELECT DISTINCT Recipes.RecipeTitle
FROM Recipes
INNER JOIN Recipe_Ingredients
  ON Recipes.RecipeID =
Recipe_Ingredients.RecipeID
WHERE Recipe_Ingredients.IngredientID IN (1, 9)
-----------------------------------------------------------------
use SalesOrdersExample;
-----------------------------------------------------------------
select DISTINCT concat(c.CustLastName, ', ', c.CustFirstName) as ' Customer'
from Customers as c
inner join
    Orders as O
on c.CustomerID = O.CustomerID
inner join
    Order_Details as od
on O.OrderNumber = od.OrderNumber
inner join
    Products as p
on od.ProductNumber = p.ProductNumber
where p.ProductName like '%Helmet%'
order by  c.CustFirstName, c.CustLastName;
-----------------------------------------------------------------
use EntertainmentAgencyExample;
-----------------------------------------------------------------
select DISTINCT ent.EntStageName
from Entertainers as ent
inner join
    Engagements as eg
on ent.EntertainerID = eg.EntertainerID
inner join
    Customers as c
on c.CustomerID = eg.CustomerID
where c.CustFirstName like "%Berg%" or c.CustFirstName like "%Hallmark" or c.CustLastName like "%Berg%" or c.CustLastName like "%Hallmark%";
-----------------------------------------------------------------
use BowlingLeagueExample;
-----------------------------------------------------------------
select T.TourneyID as Tournament,  T.TourneyLocation as Location, TM.Lanes, TE.TeamName as 'Odd Lane Team', TEA.TeamName as 'Even Lane Team', winner.TeamName as 'Winning Team'
from
    Tournaments as T
inner join
    Tourney_Matches as TM
on T.TourneyID = TM.TourneyID
inner join
    Teams as TE
on TE.TeamID = TM.OddLaneTeamID
inner join
    Teams as TEA
on TEA.TeamID = TM.EvenLaneTeamID
inner join
    Match_Games as MG
on TM.MatchID = MG.MatchID
inner join
    Teams as winner
on winner.TeamID  = MG.WinningTeamID
order by T.TourneyID;
-----------------------------------------------------------------
use RecipesExample;
-----------------------------------------------------------------
select R.RecipeTitle as 'Recipe Title', I.IngredientName as 'Ingredient', RI.Amount as  'Amount', M.MeasurementDescription as Measurement
from
Recipes as R
inner join
Recipe_Ingredients as RI
on R.RecipeID = RI.RecipeID
inner join
Ingredients as I
on RI.IngredientID = I.IngredientID
inner join
Measurements as M
on M.MeasureAmountID = RI.MeasureAmountID;
-----------------------------------------------------------------
use SalesOrdersExample;
-----------------------------------------------------------------
(select C.CustFirstName as 'First Name', C.CustLastName as 'Last Name'
from Customers as C
inner join
Orders as O
on O.CustomerID = C.CustomerID
inner join
Order_Details as OD
on OD.OrderNumber = O.OrderNumber
inner join
Products as P
on P.ProductNumber = OD.ProductNumber
where P.ProductName like '%Bike')
intersect
(select c.CustFirstName as 'First Name', c.CustLastName as 'Last Name'
from Customers as c
inner join
Orders as o
on o.CustomerID = c.CustomerID
inner join
Order_Details as od
on od.OrderNumber = o.OrderNumber
inner join
Products as p
on p.ProductNumber = od.ProductNumber
where p.ProductName like '%Helmet')
-----------------------------------------------------------------
use EntertainmentAgencyExample;
-----------------------------------------------------------------
(select DISTINCT Ent.EntStageName as 'Entertainer'
from
    Entertainers as Ent
    inner join
    Engagements as Eg
    on Ent.EntertainerID = Eg.EntertainerID
    inner join
    Customers as C
    on C.CustomerID = Eg.CustomerID
where C.CustLastName = 'Berg')
intersect
(select DISTINCT ent.EntStageName as 'Entertainer'
from
    Entertainers as ent
    inner join
    Engagements as eg
    on ent.EntertainerID = eg.EntertainerID
    inner join
    Customers as c
    on c.CustomerID = eg.CustomerID
where c.CustLastName = 'Hallmark')
-----------------------------------------------------------------
use SchoolSchedulingExample;
-----------------------------------------------------------------
select concat(StudFirstName, ' ', StudLastName) as 'Student', concat(StfFirstName, ' ', StfLastname) as 'Teacher'
from
    Students
    inner join
    Staff
    on StudFirstName = StfFirstName;
-----------------------------------------------------------------
use BowlingLeagueExample;
-----------------------------------------------------------------
select DISTINCT pla.Bowler
from
(select concat(B.BowlerFirstName, ' ', B.BowlerLastName) as 'Bowler', BS.MatchID as MatchID, BS.RawScore as score
from
    Bowlers as B
    inner join
    Bowler_Scores as BS
    on B.BowlerID = BS.BowlerID
where
    BS.RawScore >= 170
) pla
inner join
(select TM.MatchID as MatchID, T.TourneyLocation as location
from
    Tournaments as T
    inner join
    Tourney_Matches as TM
    on T.TourneyID = TM.TourneyID
where
    T.TourneyLocation in ('Thunderbird Lanes', 'Bolero Lanes')
) mat
on mat.MatchID = pla.MatchID
order by pla.Bowler;
-----------------------------------------------------------------
select BowLan.Name as 'Full Name'
from
(
    select distinct concat(BowlerLastName, ' ', BowlerFirstName) as Name
    from Bowlers
    inner join
    Bowler_Scores
    on Bowlers.BowlerID = Bowler_Scores.BowlerID
    inner join
    Tourney_Matches
    on Tourney_Matches.MatchID = Bowler_Scores.MatchID
    inner join
    Tournaments
    on Tourney_Matches.TourneyID = Tournaments.TourneyID
    where RawScore >= 170 and Tournaments.TourneyLocation = 'Thunderbird Lanes'
) as BowThu
inner join
(
    select distinct concat(BowlerLastName, ' ', BowlerFirstName) as Name
    from Bowlers
    inner join
    Bowler_Scores
    on Bowlers.BowlerID = Bowler_Scores.BowlerID
    inner join
    Tourney_Matches
    on Tourney_Matches.MatchID = Bowler_Scores.MatchID
    inner join
    Tournaments
    on Tourney_Matches.TourneyID = Tournaments.TourneyID
    where RawScore >= 170 and Tournaments.TourneyLocation = 'Bolero Lanes'
) as BowLan
on BowLan.Name = BowThu.Name;
-----------------------------------------------------------------
use RecipesExample;
-----------------------------------------------------------------
select Re.RecipeID, Re.RecipeTitle, I.IngredientName
from
(
select Recipes.RecipeID as RecipeID, Recipes.RecipeTitle
from Recipes
inner join
Recipe_Ingredients
on Recipes.RecipeID = Recipe_Ingredients.RecipeID
inner join
Ingredients
on Ingredients.IngredientID = Recipe_Ingredients.IngredientID
where IngredientName = 'Carrot'
) as Re
inner join
Recipe_Ingredients as RI
on RI.RecipeID = Re.RecipeID
inner join
Ingredients as I
on I.IngredientID = RI.IngredientID;
-----------------------------------------------------------------
--PROBLEMS
-----------------------------------------------------------------
use SalesOrdersExample;
-----------------------------------------------------------------
select concat(Customers.CustFirstName, ' ', Customers.CustLastName) as Customer, Orders.OrderDate as 'Order Date'
from
Customers
inner join
Orders
on Orders.CustomerID = Customers.CustomerID
order by Orders.OrderDate;
-----------------------------------------------------------------
select distinct concat(Customers.CustFirstName, ' ', Customers.CustLastName) as Customer, concat(Employees.EmpFirstName, ' ', Employees.EmpLastName) as Employee
from
Customers
inner join
Orders
on Orders.CustomerID = Customers.CustomerID
inner join
Employees
on Employees.EmployeeID = Orders.EmployeeID;

-----------------------------------------------------------------
select Orders.OrderNumber as 'Order Number', Orders.OrderDate as  'Order Date', P.ProductNumber as 'Product Number', P.ProductName as 'Name', OD.QuotedPrice as 'Price', OD.QuantityOrdered as 'Quantity', OD.QuotedPrice * OD.QuantityOrdered as 'Amount owed'
from Orders
inner join
Order_Details as OD
on Orders.OrderNumber = OD.OrderNumber
inner join
Products as P
on P.ProductNumber = OD.ProductNumber;
-----------------------------------------------------------------
select Vendors.VendName, P.ProductName as Product, PV.WholesalePrice as 'Whole Sale Price'
from Vendors
inner join
Product_Vendors as PV
on PV.VendorID = Vendors.VendorID
inner join
Products as P
on P.ProductNumber = PV.ProductNumber
where PV.WholesalePrice < 100;
-----------------------------------------------------------------
select Customers.CustFirstName, Customers.CustLastName, Employees.EmpFirstName, Employees.EmpLastName
from
    Customers
inner join
    Employees
on Customers.CustLastName = Employees.EmpLastName;
-----------------------------------------------------------------
select Customers.CustFirstName, Customers.CustLastName, Employees.EmpFirstName, Employees.EmpLastName, Customers.CustCity as City
from
    Customers
inner join
    Employees
on Customers.CustCity = Employees.EmpCity;
-----------------------------------------------------------------
use EntertainmentAgencyExample;
-----------------------------------------------------------------
select concat(A.AgtFirstName, ' ', A.AgtLastName) as Agent, Eg.StartDate as 'Start Date', Eg.EndDate as 'End Date'
from Agents as A
inner join
Engagements as Eg
on A.AgentID = Eg.AgentID
order by Eg.StartDate;
-----------------------------------------------------------------
select distinct concat(Customers.CustFirstName, ' ', Customers.CustLastName) as Customer, Entertainers.EntStageName as Entertainer
from Customers
inner join
Engagements
on Customers.CustomerID = Engagements.CustomerID
inner join
Entertainers
on Entertainers.EntertainerID = Engagements.EntertainerID;
-----------------------------------------------------------------
select concat(A.AgtFirstName, ' ', A.AgtLastName) as Agent, EntStageName as Entertainer, A.AgtZipCode as 'Zip Code'
from
Agents as A
inner join
Entertainers
on Entertainers.EntZipCode = A.AgtZipCode;
-----------------------------------------------------------------
use SchoolSchedulingExample;
-----------------------------------------------------------------
select B.BuildingName as 'Building', C.ClassRoomID
from Buildings as B
inner join
Class_Rooms as C
on C.BuildingCode = B.BuildingCode;
-----------------------------------------------------------------
select distinct concat(S.StudFirstName, ' ', S.StudLastName) as Student, C.ClassID as Class, su.SubjectName as Subject
from Students S
inner join
Student_Schedules ss
on ss.StudentID = S.StudentID
inner join
Classes C
on C.ClassID = ss.ClassID
inner join
Subjects su
on C.SubjectID = su.SubjectID;
--??-- No of rows difffer
-----------------------------------------------------------------
select concat(S.StfLastname, ' ', S.StfFirstName) as Staff, Sub.SubjectName as Subject
from Staff S
inner join
Faculty F
on F.StaffID = S.StaffID
inner join
Faculty_Subjects FS
on FS.StaffID = F.StaffID
inner join
Subjects Sub
on Sub.SubjectID = FS.SubjectID;
-----------------------------------------------------------------
select distinct art.student
from
(select concat(st.StudLastName, ' ', st.StudFirstName) as student
from Students st
inner join
Student_Schedules ss
on ss.StudentID = st.StudentID
inner join
Classes c
on c.ClassID = ss.ClassID
inner join
Subjects s
on s.SubjectID = c.SubjectID
where SubjectName like '%Art%' and ss.Grade >= 85
) art
inner join
(select concat(St.StudLastName, ' ', St.StudFirstName) as student
from Students St
inner join
Student_Schedules SS
on SS.StudentID = St.StudentID
inner join
Classes C
on C.ClassID = SS.ClassID
inner join
Subjects S
on S.SubjectID = C.SubjectID
where SubjectName like '%Computer%' and SS.Grade >= 85
) comp
on art.student = comp.student;
-----------------------------------------------------------------
use BowlingLeagueExample;
-----------------------------------------------------------------
select Teams.TeamName as Team, concat(B.BowlerLastName, ', ', B.BowlerFirstName) as Bowler
from Teams
inner join
Bowlers B
on B.TeamID = Teams.TeamID;
-----------------------------------------------------------------
???
-----------------------------------------------------------------
select concat(B.BowlerLastName, ', ', B.BowlerFirstName) as Bowler1, concat(b.BowlerLastName, ', ', b.BowlerFirstName) as Bowler2
from Bowlers B
inner join
Bowlers b
on b.BowlerZip =  B.BowlerZip
where b.BowlerID <> B.BowlerID;
-----------------------------------------------------------------
use RecipesExample;
-----------------------------------------------------------------
select RecipeTitle
from Recipes
where RecipeTitle like '%Salad%';
-----------------------------------------------------------------
???
-----------------------------------------------------------------
???
-----------------------------------------------------------------
???
-----------------------------------------------------------------
