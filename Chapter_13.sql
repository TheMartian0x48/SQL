/**
 * @Author: ADITYA KUMAR SINGH <the__martian>
 * @Email:  cr7.aditya.cs@gmail.com
 * @Filename: Chapter_13.sql
 * @Last modified by:   the__martian
 */
-----------------------------------------------------------------
        I N T E R N A L  P R O B L E M S
-----------------------------------------------------------------
use EntertainmentAgencyExample;
-----------------------------------------------------------------
/*“Show me for each entertainment group the group name,
the count of contracts for the group, the total price of
all the contracts, the lowest contract price, the highest
contract price, and the average price of all the contracts.”
*/
select
    E.EntStageName, count(*) as "Number of contracts",
    concat('$',sum(EN.ContractPrice)) as "Total price",
    concat('$',min(EN.ContractPrice)) as "Lowest price",
    concat('$',max(EN.ContractPrice)) as "Highest price",
    concat('$',avg(EN.ContractPrice)) as "Average price"
from
    Entertainers E
inner join
    Engagements EN
    on E.EntertainerID = EN.EntertainerID
group by
    E.EntStageName;
/*
Last query is wrong, because it is returning 12 row instead of 13
inner join left out Entertainers who has still no booking, left
join will include those Entertainers too. Also don't use count(*)
as it will count NULL values too.
Correct Answer
*/
select
    E.EntStageName, count(EN.EntertainerID) as
    "Number of contracts",
    concat('$',sum(EN.ContractPrice)) as "Total price",
    concat('$',min(EN.ContractPrice)) as "Lowest price",
    concat('$',max(EN.ContractPrice)) as "Highest price",
    concat('$',avg(EN.ContractPrice)) as "Average price"
from
    Entertainers E
left join
    Engagements EN
    on E.EntertainerID = EN.EntertainerID
group by
    E.EntStageName;
-----------------------------------------------------------------
/*
Show me for each customer the customer first and last names,
the count of contracts for the customer, the total price of
all the contracts, the lowest contract price, the highest
contract price, and the average price of all the contracts.”
*/

select
    C.CustLastName as "Last name", C.CustFirstName as
    "First name", count(EN.CustomerID) as "Number of contracts",
    concat('$',sum(EN.ContractPrice)) as "Total price",
    concat('$',min(EN.ContractPrice)) as "Lowest price",
    concat('$',max(EN.ContractPrice)) as "Highest price",
    concat('$',avg(EN.ContractPrice)) as "Average price"
from
    Customers C
left join
    Engagements EN
    on C.CustomerID = EN.CustomerID
group by
    C.CustLastName, C.CustFirstName;
-----------------------------------------------------------------
/*
“Show me for each customer the customer full name, the
customer full address, the latest contract date for the
customer, and the total price of all the contracts.”
*/
select
    concat(C.CustFirstName, ' ', C.CustLastName) as "Name",
    concat(C.CustStreetAddress, ' ', C.CustCity, ' ',
    C.CustState, ' ', C.CustZipCode) as "Address",
    max(E.StartDate) as "Latest Date",
    sum(E.ContractPrice)
from
    Customers C
left join
    Engagements E
    on C.CustomerID = E.CustomerID
group by
    C.CustFirstName, C.CustLastName, C.CustStreetAddress,
    C.CustCity, C.CustState, C.CustZipCode;
-----------------------------------------------------------------
/*
“Display the engagement contract whose price is greater than the
sum of all contracts for any other customer.”
*/
select
    C.CustFirstName, C.CustLastName, E.ContractPrice,
    E.StartDate
from
    Customers C
inner join
    Engagements E
    on C.CustomerID = E.CustomerID
where
    E.ContractPrice > all
    (
        select
            sum(e.ContractPrice)
        from
            Engagements e
        where
            e.CustomerID <> E.CustomerID
        group by
            e.CustomerID
    );
-----------------------------------------------------------------
/*
“Show me the unique city names from the customers table.”
*/
select distinct
    C.CustCity
from
    Customers C;
/*
Different approach, using group by statement
*/
select
    C.CustCity
from
    Customers C
group by
    C.CustCity;
-----------------------------------------------------------------
/*
“Display the customer ID, customer full name, and the total of
all engagement contract prices.”
*/
select
    C.CustomerID, concat(C.CustFirstName, ' ', C.CustLastName)
    as "Name", sum(E.ContractPrice) as TotalPrice
from
    Customers C
inner join
    Engagements E
    on C.CustomerID = E.CustomerID
group by
    C.CustomerId;
/*
above one work on MySQL and PostgreSQL, but will fail on other
because SQL does not into account any knowledge that could be
implied by the design of your database tables - including
whether columns are primary keys. You must include all columns
in the select clause that are not in the an aggregate function.
*/
select
    C.CustomerID, concat(C.CustFirstName, ' ', C.CustLastName)
    as "Name", sum(E.ContractPrice) as TotalPrice
from
    Customers C
inner join
    Engagements E
    on C.CustomerID = E.CustomerID
group by
    C.CustomerId, C.CustFirstName, C.CustLastName;
-----------------------------------------------------------------
/*
“Show me for each customer in the state of Washington the
customer full name, the customer full address, the latest
contract date for the customer, and the total price of all
the contracts.”
*/
select
    concat(C.CustFirstName, ' ', C.CustLastName) as Name,
    concat(C.CustStreetAddress, ' ', C.CustCity, ' ',
    C.CustState, ' ', C.CustZipCode) as Address,
    max(E.StartDate) as LatestDate,
    sum(E.ContractPrice) as TotalPrice
from
    Customers C
inner join
    Engagements E
    on C.CustomerID = E.CustomerID
where
    C.CustState = "WA"
group by
    Name, Address;
/*
this is wrong way to do this. Some db will you go away with
this, but one that strictly adheres to the SQL Standard will
generate error. because you are mention the columns which
are from select clause(Name, Address will be generated after
from and where clause is executed) rather than from and where
clause.
corrected way to do this, mention all the colums use in select
clause from from daluse.
other way is to use subqueries.
*/
select
    concat(C.CustFirstName, ' ', C.CustLastName) as Name,
    concat(C.CustStreetAddress, ' ', C.CustCity, ' ',
    C.CustState, ' ', C.CustZipCode) as Address,
    max(E.StartDate) as LatestDate,
    sum(E.ContractPrice) as TotalPrice
from
    Customers C
inner join
    Engagements E
    on C.CustomerID = E.CustomerID
where
    C.CustState = "WA"
group by
    C.CustFirstName, C.CustLastName, C.CustStreetAddress,
    C.CustCity, C.CustState, C.CustZipCode;
/*
another correct way to do using subqueries
*/
select
    CWA.CName as Name, CWA.CAddress as Address,
    max(CWA.StartDate) as LatestDate,
    sum(CWA.ContractPrice) as TotalPrice
from
    (
    select
        concat(C.CustFirstName, ' ', C.CustLastName) as CName,
        concat(C.CustStreetAddress, ' ', C.CustCity, ' ',
        C.CustState, ' ', C.CustZipCode) as CAddress,
        E.StartDate, E.ContractPrice
    from
        Customers C
    inner join
        Engagements E
        on C.CustomerID = E.CustomerID
    where
        C.CustState = "WA"
    ) CWA
group by
    CWA.CName, CWA.CAddress;
-----------------------------------------------------------------
            P R A C T I C E  P R O B L E M
-----------------------------------------------------------------
use SalesOrdersExample;
-----------------------------------------------------------------
/*
“List for each customer and order date the customer full name
and the total cost of items ordered on each date.”
*/
select
    concat(C.CustFirstName,' ', C.CustLastName) as Name,
    O.OrderDate as OrderDate,
    sum(OD.QuotedPrice) as TotalPrice
from
    Customers as C
inner join
    Orders O
    on O.CustomerID = C.CustomerID
inner join
    Order_Details as OD
    on OD.OrderNumber = O.OrderNumber
group by
    C.CustFirstName, C.CustLastName, O.OrderDate;
-----------------------------------------------------------------
use EntertainmentAgencyExample;
-----------------------------------------------------------------
/*
“Display each entertainment group ID, entertainment group member,
and the amount of pay for each member based on the total
contract price divided by the number of members in the group.”
*/
select
    E.EntertainerID as EntertainerID,
    M.MbrFirstName,
    M.MbrLastName,
    (sum(EN.ContractPrice)/
    (
        select
            count(em.EntertainerID)
        from
            Entertainer_Members em
        where
            em.Status <> 3
            and
            em.EntertainerID =  E.EntertainerID
    )) as Pay
from
    Entertainers E
inner join
    Entertainer_Members EM
    on EM.EntertainerID = E.EntertainerID
inner join
    Members M
    on M.MemberID = EM.MemberID
inner join
    Engagements EN
    on EN.EntertainerID = E.EntertainerID
where
    EM.Status <> 3
group by
    E.EntertainerID , M.MbrFirstName, M.MbrLastName
order by
    M.MbrLastName;
-----------------------------------------------------------------
use SchoolSchedulingExample;
-----------------------------------------------------------------
/*
“For completed classes, list by category and student the
category name, the student name, and the student’s average
grade of all classes taken in that category.”
*/
select
    C.CategoryDescription,
    S.StudFirstName,
    S.StudLastName,
    avg(SS.Grade) as AvgGrade
from
    Categories C
inner join
    Subjects SU
    on C.CategoryID = SU.CategoryID
inner join
    Classes CL
    on CL.SubjectID = SU.SubjectID
inner join
    Student_Schedules SS
    on SS.ClassID = CL.ClassID
inner join
    Students S
    on S.StudentID = SS.StudentID
inner join
    Student_Class_Status SCS
    on SCS.ClassStatus = SS.ClassStatus
where
    SCS.ClassStatusDescription = "completed"
group by
    C.CategoryID,
    S.StudFirstName,
    S.StudLastName
order by
    C.CategoryID,
    S.StudFirstName,
    S.StudLastName;
-----------------------------------------------------------------
use BowlingLeagueExample;
-----------------------------------------------------------------
/*
Show me for each tournament and match the tournament ID, the
tournament location, the match number, the name of each team,
and the total of the handicap score for each team.”
*/
select
    T.TourneyID as TournamentID,
    T.TourneyLocation as TournamentLocation,
    TM.MatchID as MatchNumber,
    TE.TeamName,
    sum(BS.HandiCapScore)
from
    Tournaments T
inner join
    Tourney_Matches TM
    on T.TourneyID = TM.TourneyID
inner join
    Match_Games MG
    on TM.MatchID = MG.MatchID
inner join
    Bowler_Scores BS
    on BS.MatchID =  MG.MatchID and MG.GameNumber = BS.GameNumber
inner join
    Bowlers B
    on B.BowlerID = BS.BowlerID
inner join
    Teams TE
    on TE.TeamID = B.TeamID
group by
    T.TourneyID,
    T.TourneyLocation,
    TM.MatchID,
    TE.TeamName
order by
    T.TourneyID,
    T.TourneyLocation,
    TM.MatchID,
    TE.TeamName;
-----------------------------------------------------------------
/*
“Display the highest raw score for each bowler.”
*/
select
    B.BowlerFirstName,
    B.BowlerLastName,
    max(BS.RawScore) as "HighScore"
from
    Bowlers B
inner join
    Bowler_Scores BS
    on B.BowlerID = BS.BowlerID
group by
    B.BowlerFirstName,
    B.BowlerLastName
order by
    B.BowlerFirstName,
    B.BowlerLastName;
-----------------------------------------------------------------
use RecipesExample;
-----------------------------------------------------------------
/*
“Show me how many recipes exist for each class of ingredient.”
*/
select
    I.IngredientClassID,
    IC.IngredientClassDescription,
    count(*) as "Number of recipes"
from
    Recipe_Ingredients RI
inner join
    Recipes R
    on R.RecipeID = RI.RecipeID
inner join
    Ingredients I
    on I.IngredientID = RI.IngredientID
inner join
    Ingredient_Classes IC
    on I.IngredientClassID = IC.IngredientClassID
group by
    I.IngredientClassID,
    IC.IngredientClassDescription
order by
    IC.IngredientClassDescription,
    I.IngredientClassID;
-----------------------------------------------------------------
                        P R O B L E M S
-----------------------------------------------------------------
use SalesOrdersExample;
-----------------------------------------------------------------
/*
“Show me each vendor and the average by vendor of the number
of days to deliver products.”
*/
select
    V.VendName,
    avg(PV.DaysToDeliver) as "AvgDay"
from
    Vendors V
inner join
    Product_Vendors PV
    on PV.VendorID = V.VendorID
group by
    V.VendName;
-----------------------------------------------------------------
/*
“Display for each product the product name and the total sales.”
*/
select
    P.ProductName,
    sum(OD.QuotedPrice*OD.QuantityOrdered) "TotalSales"
from
    Products P
inner join
    Order_Details OD
    on P.ProductNumber = OD.ProductNumber
group by
    P.ProductName;
-----------------------------------------------------------------
/*
“List all vendors and the count of products sold by each.”
*/
select
    V.VendName,
    count(*) as "Numebr of Products"
from
    Vendors V
inner join
    Product_Vendors PV
    on V.VendorID = PV.VendorID
group by
    V.VendorID;
-----------------------------------------------------------------
/*
“List all vendors and the count of products sold by each.”
using a subquery
*/
select
    V.VendName,
    (
        select
            count(*)
        from
            Product_Vendors PV
        where
            PV.VendorID = V.VendorID
    ) as "Number of Products"
from
    Vendors V;
-----------------------------------------------------------------
use EntertainmentAgencyExample;
-----------------------------------------------------------------
/*
“Show each agent’s name, the sum of the contract price for the
engagements booked, and the agent’s total commission.”
*/
select
    A.AgtLastName,
    A.AgtFirstName,
    sum(E.ContractPrice) as "TotalContractPrice",
    sum(E.ContractPrice*A.CommissionRate) as
    "AgentTotalCommission"
from
    Agents A
inner join
    Engagements E
    on A.AgentID = E.AgentID
group by
    A.AgtLastName,
    A.AgtFirstName
order by
    A.AgtLastName,
    A.AgtFirstName;
-----------------------------------------------------------------
use SchoolSchedulingExample;
-----------------------------------------------------------------
/*
“Display by category the category name and the count of classes
offered.”
*/
select
    C.CategoryDescription,
    count(*) "NumberOfClasses"
from
    Categories C
inner join
    Subjects S
    on C.CategoryID = S.CategoryID
inner join
    Classes CL
    on CL.SubjectID = S.SubjectID
group by
    C.CategoryDescription;
-----------------------------------------------------------------
/*
“List each staff member and the count of classes each
is scheduled to teach.”
*/
select
    S.StfFirstName,
    S.StfLastname,
    count(FC.ClassID) as "NumberOfClasses"
from
    Staff S
inner join
    Faculty_Classes FC
    on S.StaffID = FC.StaffID
group by
    S.StfFirstName,
    S.StfLastname;
-----------------------------------------------------------------
/*
“List each staff member and the count of classes each is
scheduled to teach.” using a subquery
*/
select
    S.StfFirstName,
    S.StfLastname,
    (
        select
            count(FC.ClassID)
        from
            Faculty_Classes FC
        where
            FC.StaffID = S.StaffID

    ) as "NumberOfClasses"
from
    Staff S
order by
    S.StfFirstName,
    S.StfLastname;
-----------------------------------------------------------------
/*
Can you explain why the subquery solution returns five more
rows? Is it possible to modify the query in question 2 to
return 27 rows? If so, how would you do it?
*/
/*
Because in question 2 we are taking inner join, which will
include any staff which have any classes, it will not include
any staff which has no classes, but subquery will show that
staff too, using outer left join, we will get 27 rows.
*/
select
    S.StfFirstName,
    S.StfLastname,
    count(FC.ClassID) as "NumberOfClasses"
from
    Staff S
left join
    Faculty_Classes FC
    on S.StaffID = FC.StaffID
group by
    S.StfFirstName,
    S.StfLastname;
-----------------------------------------------------------------
use BowlingLeagueExample;
-----------------------------------------------------------------
/*
“Display for each bowler the bowler name and the average of the
bowler’s raw game scores.”
*/
select
    B.BowlerFirstName,
    B.BowlerLastName,
    avg(BS.RawScore) as AvgRawScore
from
    Bowlers B
inner join
    Bowler_Scores BS
    on B.BowlerID = BS.BowlerID
group by
    B.BowlerFirstName,
    B.BowlerLastName;
-----------------------------------------------------------------
/*
“Calculate the current average and handicap for each bowler.”
*/
--??? what is current average
-----------------------------------------------------------------
/*
Challenge: “Display the highest raw score for each bowler,”
but solve it by using a subquery.
*/
select
    B.BowlerFirstName,
    B.BowlerLastName,
    (
        select
            max(BS.RawScore)
        from
            Bowler_Scores BS
        where
            BS.BowlerID = B.BowlerID
    ) as MaxRawScore
from
    Bowlers B;
-----------------------------------------------------------------
use RecipesExample;
-----------------------------------------------------------------
/*
“If I want to cook all the recipes in my cookbook, how much of
each ingredient must I have on hand?”
*/
select
    I.IngredientName,
    M.MeasurementDescription,
    sum(RI.Amount) as "Amount"
from
    Ingredients I
inner join
    Recipe_Ingredients RI
    on RI.IngredientID = I.IngredientID
inner join
    Measurements M
    on M.MeasureAmountID = RI.MeasureAmountID
group by
    I.IngredientName,
    M.MeasurementDescription;
-----------------------------------------------------------------
/*
“List all meat ingredients and the count of recipes that
include each one.”
*/
select
    I.IngredientName,
    count(RecipeID) as "NoOfRecipes"
from
    Ingredients I
inner join
    Ingredient_Classes IC
    on I.IngredientClassID = IC.IngredientClassID
inner join
    Recipe_Ingredients RI
    on RI.IngredientID = I.IngredientID
where
    IC.IngredientClassDescription = "Meat"
group by
    I.IngredientName;
-----------------------------------------------------------------
/*
 Challenge: Now solve problem 2 by using a subquery.
*/
select
    I.IngredientName,
    (
        select
            count(RI.RecipeID)
        from
            Recipe_Ingredients RI
        where
            RI.IngredientID = I.IngredientID
    ) as "NoOfRecipes"
from
    Ingredients I
inner join
    Ingredient_Classes IC
    on I.IngredientClassID = IC.IngredientClassID
where
    IC.IngredientClassDescription = "Meat";
-----------------------------------------------------------------
/*
Can you explain why the subquery solution returns seven more
rows? Is it possible to modify the query in question 2 to
return 11 rows? If so, how would you do it?
*/
select
    I.IngredientName,
    count(RecipeID) as "NoOfRecipes"
from
    Ingredients I
inner join
    Ingredient_Classes IC
    on I.IngredientClassID = IC.IngredientClassID
left join
    Recipe_Ingredients RI
    on RI.IngredientID = I.IngredientID
where
    IC.IngredientClassDescription = "Meat"
group by
    I.IngredientName;
-----------------------------------------------------------------
                    T H E  E N D
-----------------------------------------------------------------
