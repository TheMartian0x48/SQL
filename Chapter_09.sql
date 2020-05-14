/**
 * @Author: ADITYA KUMAR SINGH <the__martian>
 * @Email:  cr7.aditya.cs@gmail.com
 * @Filename: Chapter_9.sql
 * @Last modified by:   the__martian
 */



-----------------------------------------------------------
--EXAPMPLE
-----------------------------------------------------------
use SalesOrdersExample;
-----------------------------------------------------------
select distinct Products.ProductNumber, ProductName
from
    Products
left join
    Order_Details
    on Products.ProductNumber = Order_Details.ProductNumber
where Order_Details.OrderNumber is null;
-----------------------------------------------------------
select concat(C.CustFirstName, ' ', C.CustLastName) as Customers, bi.ProductName, bi.OrderDate, bi.QuotedPrice, bi.QuantityOrdered
from
    Customers C
left join
(
    select O.CustomerID, O.OrderDate, OD.QuotedPrice, OD.QuantityOrdered, P.ProductName
    from
        Orders O
    inner join
        Order_Details OD
        on OD.OrderNumber = O.OrderNumber
    inner join
        Products P
        on P.ProductNumber = OD.ProductNumber
    inner join
        Categories Ca
        on Ca.CategoryID = P.CategoryID
    where Ca.CategoryDescription = 'Bikes'
) as bi
    on C.CustomerID = bi.CustomerID;
-----------------------------------------------------------
use EntertainmentAgencyExample;
-----------------------------------------------------------
select EntStageName
from
    Entertainers
left join
    Engagements
    on Entertainers.EntertainerID = Engagements.EntertainerID
where Engagements.EntertainerID is NULL;
-----------------------------------------------------------
select Ct.Name, Ms.StyleName
from
    Musical_Styles as Ms
    left outer join
    (
        select concat(C.CustFirstName, ' ', C.CustLastName) as Name, MP.StyleID
        from
            Customers as C
        inner join
            Musical_Preferences as MP
            on MP.CustomerID = C.CustomerID
    ) as Ct
    on Ms.StyleID = Ct.StyleID;
----------------------------------------------------------
use SchoolSchedulingExample;
----------------------------------------------------------
select concat(S.StfFirstName, ' ', S.StfLastname) as Name
from
    Staff S
left join
    Faculty_Classes FC
    on FC.StaffID = S.StaffID
where FC.StaffID is null;
----------------------------------------------------------
select concat(s.StudFirstName, ' ', s.StudLastName) as Name
from
    Students as s
left join
    (
        select ss.StudentID
        from
            Student_Schedules as ss
        inner join
            Student_Class_Status as scs
            on ss.ClassStatus = scs.ClassStatus
        where scs.ClassStatusDescription = 'Withdrew'
    ) as wid
    on wid.StudentID = s.StudentID
where wid.StudentID is null;
----------------------------------------------------------
select sc.CategoryDescription, sc.SubjectName, Cl.ClassRoomID, Cl.StartDate, Cl.StartTime, Cl.Duration
from
    (
        select C.CategoryDescription, S.SubjectID, S.SubjectName
        from
            Categories as C
        left join
            Subjects as S
            on S.CategoryID = C.CategoryID
    ) as sc
left join
    Classes as Cl
    on Cl.SubjectID = sc.SubjectID;
----------------------------------------------------------
use BowlingLeagueExample;
----------------------------------------------------------
select T.TourneyID, T.TourneyDate, T.TourneyLocation
from
    Tournaments as T
    left join
    Tourney_Matches as TM
    on T.TourneyID = TM.TourneyID
where TM.TourneyID is null;
----------------------------------------------------------
select concat(B.BowlerFirstName, " ", B.BowlerLastName) as Bowlers, BB.TourneyLocation as 'Location',  BB.TourneyDate as 'Date', BB.MatchID as MatchID, BB.RawScore as "Raw Score"
from
    Bowlers B
left join
    (
        select BS.MatchID, BS.BowlerID, BS.RawScore, T.TourneyDate, T.TourneyLocation
        from
            Bowler_Scores as BS
        inner join
            Tourney_Matches as TM
            on TM.MatchID = BS.MatchID
        inner join
            Tournaments as T
            on T.TourneyID = TM.TourneyID
        where BS.RawScore > 180
    ) as BB
    on BB.BowlerID = B.BowlerID;
----------------------------------------------------------
use RecipesExample;
----------------------------------------------------------
select I.IngredientName
from
    Ingredients I
left join
    Recipe_Ingredients RI
    on I.IngredientID = RI.IngredientID
where RI.IngredientID is null;
----------------------------------------------------------
???????
----------------------------------------------------------
--PROBLEMS
----------------------------------------------------------
use SalesOrdersExample;
----------------------------------------------------------
select concat(C.CustFirstName, " ", C.CustLastName) as Customer
from
    Customers C
left outer join
    (
        select O.CustomerID
        from
            Orders O
        inner join
            Order_Details OD
            on OD.OrderNumber = O.OrderNumber
        inner join
            Products P
            on P.ProductNumber = OD.ProductNumber
        where P.ProductName like "%Helmet%"
    ) OH
    on OH.CustomerID = C.CustomerID
where OH.CustomerID is null;
----------------------------------------------------------
----output 27 rows, but book say there is 18 rows.
select distinct C.CustomerID, C.Customer, C.CustZipCode
from
    (
        select concat(CC.CustFirstName, " ", CC.CustLastName) as Customer, O.EmployeeID, CC.CustomerID, CC.CustZipCode
        from
            Customers CC
        inner join
            Orders O
            on O.CustomerID = CC.CustomerID
    ) C
left join
    Employees E
    on E.EmployeeID = C.EmployeeID
where
    E.EmpZipCode <> C.CustZipCode;
----------------------------------------------------------
-- OUTPUT 3973 rows, but books says 2681 rows
select PO.ProductNumber, PO.ProductName, O.OrderDate
from
    Orders O
left join
    (
        select P.ProductName, P.ProductNumber, OD.OrderNumber
        from
            Products P
        inner join
            Order_Details OD
            on OD.ProductNumber = P.ProductNumber
    ) PO
    on PO.OrderNumber = O.OrderNumber
where PO.OrderNumber is not null
order by PO.ProductNumber, PO.ProductName, O.OrderDate;
----------------------------------------------------------
use EntertainmentAgencyExample;
----------------------------------------------------------
select A.AgtLastName, A.AgtFirstName
from
    Agents A
left join
    Engagements EA
    on A.AgentID = EA.AgentID
where EA.AgentID is null;
----------------------------------------------------------
select C.CustLastName, C.CustFirstName
from
    Customers C
left join
    Engagements E
    on E.CustomerID = C.CustomerID
where
    E.CustomerID is null;
----------------------------------------------------------
select EntStageName, Engagements.EngagementNumber
from
    Entertainers
left join
    Engagements
    on Entertainers.EntertainerID = Engagements.EntertainerID;
----------------------------------------------------------
use SchoolSchedulingExample;
----------------------------------------------------------
select SC.SubjectName, SC.ClassRoomID, SC.StartTime, SC.Duration
from
    (
        select Su.SubjectName, S.ClassRoomID, S.StartTime, S.Duration, S.ClassID
        from
            Subjects Su
        inner join
            Classes S
            on Su.SubjectID = S.SubjectID
    ) SC
left join
    (
        select SS.ClassID
        from
            Student_Schedules SS
        inner join
            Student_Class_Status SCS
            on SS.ClassStatus = SCS.ClassStatus
        where SCS.ClassStatus = 1
    ) as SE
    on SE.ClassID = SC.ClassID
where SE.ClassID is null;
------------------------------------------------------------
select distinct SC.SubjectName
from
    (
        select C.ClassID, S.SubjectName
        from
            Subjects S
        inner join
            Classes C
            on S.SubjectID = C.SubjectID
    ) SC
left join
    Faculty_Classes FC
    on FC.ClassID = SC.ClassID
where FC.ClassID is null;
------------------------------------------------------------
select S.StudLastName, S.StudFirstName
from
    Students S
left join
    (
        select ST.StudentID
        from
            Students ST
        left join
            Student_Schedules SS
            on SS.StudentID = ST.StudentID
        left join
            Student_Class_Status SCS
            on SS.ClassStatus = SCS.ClassStatus
        where SCS.ClassStatus = 1
    ) SSS
    on S.StudentID = SSS.StudentID
where
    SSS.StudentID is null;
------------------------------------------------------------
select S.StaffID, S.StfFirstName, S.StfLastname, CFC.ClassID
from
    Staff S
left join
    (
        select FC.StaffID, C.ClassID
        from
            Faculty_Classes FC
        inner join
            Classes C
            on C.ClassID = FC.ClassID
    )  CFC
    on S.StaffID = CFC.StaffID;
------------------------------------------------------------
use BowlingLeagueExample;
------------------------------------------------------------
???
--------------------------------------------------------------
--Getting 169 rows, but book says 176 rows
select  TM.TourneyID, T.TourneyDate, T.TourneyLocation, MG.MatchID, MG.GameNumber, MG.WinningTeamID
from
    Tourney_Matches TM
left join
    Tournaments T
    on T.TourneyID = TM.TourneyID
left join
    Match_Games MG
    on TM.MatchID = MG.MatchID;
------------------------------------------------------------
use RecipesExample;
------------------------------------------------------------
???
------------------------------------------------------------
select I.IngredientName, RR.RecipeTitle
from
    Ingredients I
left join
    (
        select R.RecipeTitle, R.RecipeID, RI.IngredientID
        from
            Recipes R
        inner join
            Recipe_Ingredients RI
            on R.RecipeID = RI.RecipeID
    ) RR
    on I.IngredientID = RR.IngredientID;
------------------------------------------------------------
select RC.RecipeClassDescription, R.RecipeTitle
from
    Recipe_Classes RC
left join
    Recipes R
    on R.RecipeClassID = RC.RecipeClassID
where RC.RecipeClassID in (1,4,7);
------------------------------------------------------------
select RC.RecipeClassDescription, R.RecipeTitle
from
    Recipe_Classes RC
left join
    Recipes R
    on R.RecipeClassID = RC.RecipeClassID;
------------------------------------------------------------
