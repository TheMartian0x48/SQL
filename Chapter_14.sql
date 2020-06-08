/**
 * @Author: ADITYA KUMAR SINGH <the__martian>
 * @Email:  cr7.aditya.cs@gmail.com
 * @Filename: Chapter_14.sql
 * @Last modified by:   the__martian
 */

-----------------------------------------------------------------
            I N T E R N A L  P R O B L E M S
-----------------------------------------------------------------
use EntertainmentAgencyExample;
-----------------------------------------------------------------
/*
“Show me the entertainer groups that play in a jazz style
and have more than three members.”
*/
select
    E.EntStageName,
    count(*)
from
    Entertainers E
inner join
    Entertainer_Styles ES
    on E.EntertainerID = ES.EntertainerID
inner join
    Musical_Styles MS
    on MS.StyleID = ES.StyleID
inner join
    Entertainer_Members EM
    on EM.EntertainerID = E.EntertainerID
where
    MS.StyleName = 'Jazz'
group by
    E.EntStageName
having
    count(EM.MemberID) > 3;
-----------------------------------------------------------------
use SalesOrdersExample;
-----------------------------------------------------------------
/*
“Show me the states on the west coast of the United States where
the total of the orders is greater than $1 million.”
*/
select
    C.CustState,
    sum(OD.QuotedPrice * OD.QuantityOrdered) as TotalOrders
from
    Customers C
inner join
    Orders O
    on O.CustomerID = C.CustomerID
inner join
    Order_Details OD
    on OD.OrderNumber = O.OrderNumber
where
    C.CustState in ('WA', 'OR', 'CA')
group by
    C.CustState
having
    sum(OD.QuotedPrice * OD.QuantityOrdered) > 1000000
-----------------------------------------------------------------
use SchoolSchedulingExample;
-----------------------------------------------------------------
/*
“Show me the subject categories that have fewer than three
full professors teaching that subject.”
*/
select
    C.CategoryDescription,
    count(FC.StaffID) as ProfCount
from
    Categories C
inner join
    Faculty_Categories FC
    on C.CategoryID = FC.CategoryID
inner join
    Faculty F
    on F.StaffID = FC.StaffID
where
    F.Title = "Professor"
group by
    C.CategoryDescription
Having
    count(FC.StaffID) < 3;
/*
Above query will not show result with o ProCount.
Following query will contain missing rows
*/
select
    C.CategoryDescription,
    (
        select
            count(f.StaffID)
        from
            Faculty f
        inner join
            Faculty_Categories fc
            on f.StaffID = fc.StaffID
        inner join
            Categories as c
            on c.CategoryID = fc.CategoryID
        where
            c.CategoryID = C.CategoryID
            and
            f.Title = 'Professor'
    ) as ProCount
from
    Categories C
where
    (
        select
            count(F.StaffID)
        from
            Faculty F
        inner join
            Faculty_Categories FC
            on F.StaffID = FC.StaffID
        inner join
            Categories Cat
            on Cat.CategoryID = FC.CategoryID
        where
            Cat.CategoryID = C.CategoryID
            and
            F.Title = 'Professor'
    ) < 3;
-----------------------------------------------------------------
                P R A C T I C E  P R O B L E M
-----------------------------------------------------------------
use SalesOrdersExample;
-----------------------------------------------------------------
/*
“List for each customer and order date the customer’s full name
and the total cost of items ordered that is greater than $1,000.”
*/
select
    concat(C.CustFirstName, ' ', C.CustLastName) as FullName,
    O.OrderDate,
    sum(OD.QuotedPrice * OD.QuantityOrdered) as TotalCost
from
    Customers C
inner join
    Orders O
    on O.CustomerID = C.CustomerID
inner join
    Order_Details OD
    on OD.OrderNumber = O.OrderNumber
group by
    C.CustFirstName,
    C.CustLastName,
    O.OrderDate
having
    sum(OD.QuotedPrice * OD.QuantityOrdered) > 1000;
-----------------------------------------------------------------
use EntertainmentAgencyExample;
-----------------------------------------------------------------
/*
“Which agents booked more than $3,000 worth of business in
December 2017?”
*/
select
    concat(A.AgtFirstName, ' ', A.AgtLastName) as FullName,
    sum(E.ContractPrice) as BookedPrice
from
    Agents A
inner join
    Engagements E
    on A.AgentID = E.AgentID
where
    E.StartDate between '2017-12-01' and '2017-12-31'
group by
    A.AgtFirstName,
    A.AgtLastName
having
    sum(E.ContractPrice) > 3000;
7
use SchoolSchedulingExample;
-----------------------------------------------------------------
/*
“For completed classes, list by category and student the category
name, the student name, and the student’s average grade of all
classes taken in that category for those students who have an
average higher than 90.”
*/
select
    C.CategoryDescription,
    concat(S.StudFirstName, ' ', S.StudLastName) as Student,
    avg(SS.Grade) as AvgGrade
from
    Students S
inner join
    Student_Schedules SS
    on S.StudentID = SS.StudentID
inner join
    Student_Class_Status SCS
    on SCS.ClassStatus = SS.ClassStatus
inner join
    Classes CL
    on CL.ClassID = SS.ClassID
inner join
    Subjects SB
    on SB.SubjectID = CL.SubjectID
inner join
    Categories C
    on C.CategoryID = SB.CategoryID
where
    SCS.ClassStatusDescription = "Completed"
group by
    C.CategoryDescription,
    S.StudFirstName,
    S.StudLastName
having
    avg(SS.Grade) > 90;
-----------------------------------------------------------------
/*
“List each staff member and the count of classes each is scheduled
to teach for those staff members who teach at least one but fewer
than three classes.”
*/
select
    concat(S.StfFirstName, ' ', S.StfLastname) as Staff,
    count(FC.ClassID) as NumberOfClass
from
    Staff S
inner join
    Faculty_Classes FC
    on S.StaffID = FC.StaffID
group by
    S.StfFirstName,
    S.StfLastname
having
    count(FC.ClassID) < 3;
-----------------------------------------------------------------
use BowlingLeagueExample;
-----------------------------------------------------------------
/*
“List the bowlers whose highest raw scores are more than 20 pins
higher than their current averages.”
*/
select
    concat(B.BowlerFirstName, ' ', B.BowlerLastName) as Bowler,
    round(avg(BS.RawScore), 0) as CurrentAverage,
    max(BS.RawScore) as MaxRowScore
from
    Bowlers B
inner join
    Bowler_Scores BS
    on B.BowlerID = BS.BowlerID
group by
    B.BowlerFirstName,
    B.BowlerLastName
having
    max(BS.RawScore) > (round(avg(BS.RawScore), 0) + 20)
order by
    B.BowlerFirstName,
    B.BowlerLastName;
-----------------------------------------------------------------
use RecipesExample;
-----------------------------------------------------------------
/*
“List the recipes that contain both beef and garlic.”
*/
select
    R.RecipeTitle
from
    Recipes R
where
    R.RecipeID in (
        select
            RI.RecipeID
        from
            Recipe_Ingredients RI
        inner join
            Ingredients I
            on I.IngredientID = RI.IngredientID
        where
            I.IngredientName = 'Beef'
    )
    and
    R.RecipeID in (
        select
            RI.RecipeID
        from
            Recipe_Ingredients RI
        inner join
            Ingredients I
            on I.IngredientID = RI.IngredientID
        where
            I.IngredientName = 'Garlic'
    );
-----------------------------------------------------------------
EXCERCISE QUESTION
-----------------------------------------------------------------
use SalesOrdersExample;
-----------------------------------------------------------------
/*
“Show me each vendor and the average by vendor of the number of
days to deliver products that are greater than the average
delivery days for all vendors.”
*/
select
    V.VendName,
    avg(PV.DaysToDeliver) as AvgDayToDeliverProducts
from
    Vendors V
inner join
    Product_Vendors PV
    on V.VendorID = PV.VendorID
group by
    V.VendName
having
    avg(PV.DaysToDeliver) > (
        select
            avg(pv.DaysToDeliver)
        from
            Product_Vendors pv
    );
-----------------------------------------------------------------
/*
“Display for each product the product name and the total sales
that is greater than the average of sales for all products in
that category.”
*/
????
-----------------------------------------------------------------
/*
“How many orders are for only one product?”
*/
select
    count(res.OrderNumber)
from
    (
    select
        OD.OrderNumber
    from
        Order_Details OD
    group by
        OD.OrderNumber
    having
        count(*) = 1;
    ) as res;
-----------------------------------------------------------------
use EntertainmentAgencyExample;
-----------------------------------------------------------------
/*
“Show me the entertainers who have more than two overlapped
bookings.”
*/
select
    Ent.EntertainerID,
    Ent.EntStageName
from
    Entertainers Ent
where
    Ent.EntertainerID in
    (
        select
            E1.EntertainerID
        from
            Engagements E1
        inner join
            Engagements E2
            on E1.EntertainerID = E2.EntertainerID
        where
            E1.EngagementNumber <> E2.EngagementNumber
            and
            E1.StartDate <= E2.EndDate
            and
            E2.Startdate <= E1.EndDate
        group by
            E1.EntertainerID
        order by
            count(*) >= 2
    );
-----------------------------------------------------------------
/*
“Show each agent’s name, the sum of the contract price for the
engagements booked, and the agent’s total commission for agents
whose total commission is more than $1,000.”
*/
select
    concat(A.AgtFirstName, ' ', A.AgtLastName) as Agent,
    sum(E.ContractPrice) as TotalContractPrice,
    sum(E.ContractPrice * A.CommissionRate) as TotalCommission
from
    Agents A
inner join
    Engagements E
    on A.AgentID = E.AgentID
group by
    A.AgtFirstName,
    A.AgtLastName
having
    sum(E.ContractPrice * A.CommissionRate) > 1000;
-----------------------------------------------------------------
use SchoolSchedulingExample;
-----------------------------------------------------------------
/*
“Display by category the category name and the count of classes
offered for those categories that have three or more classes.”
*/
select
    C.CategoryDescription,
    count(*) TotalClasses
from
    Categories C
inner join
    Subjects S
    on C.CategoryID = S.CategoryID
inner join
    Classes CL
    on CL.SubjectID = S.SubjectID
group by
    C.CategoryDescription
having
    count(*) >= 3;
-----------------------------------------------------------------
/*
“List each staff member and the count of classes each is
scheduled to teach for those staff members who teach fewer than
three classes.”
*/
select
    concat(S.StfFirstName, ' ', S.StfLastname) as Staff,
    count(FC.ClassID) TotalClasses
from
    Staff S
left join
    Faculty_Classes as FC
    on FC.StaffID = S.StaffID
group by
    S.StfFirstName,
    S.StfLastname
having
    count(FC.ClassID) < 3;
-----------------------------------------------------------------
/*
“Show me the subject categories that have fewer than three full
professors teaching that subject.”
*/
select
    C.CategoryDescription,
    count(FCF.StaffID) as ProfCount
from
    Categories C
left join
    (
        select
            FC.CategoryID,
            FC.StaffID
        from
            Faculty_Categories FC
        inner join
            Faculty F
            on F.StaffID = FC.StaffID
        where
            F.Title = "Professor"
    ) as FCF
    on FCF.CategoryID = C.CategoryID
group by
    C.CategoryDescription
having
    count(FCF.StaffID) < 3;
-----------------------------------------------------------------
/*
“Count the classes taught by every staff member.”
*/
select
    concat(S.stfFirstName, ' ', S.stfLastName) as Staff,
    count(FC.ClassID) as ClassCount
from
    Staff S
left join
    Faculty_Classes FC
    on S.StaffID = FC.StaffID
group by
    S.stfFirstName,
    S.StfLastname;
-----------------------------------------------------------------
use BowlingLeagueExample;
-----------------------------------------------------------------
/*
“Do any team captains have a raw score that is higher than any
other member of the team?”
*/
select
    T.TeamID,
    B.BowlerID,
    concat(B.BowlerFirstName, ' ', B.BowlerLastName) as Captain,
    max(BS.RawScore) as HighestRawScore
from
    Bowlers B
inner join
    Teams T
    on B.BowlerID = T.CaptainID
inner join
    Bowler_Scores BS
    on BS.BowlerID = B.BowlerID
group by
    T.TeamID,
    B.BowlerID,
    B.BowlerFirstName,
    B.BowlerLastName
having
    max(BS.RawScore) > (
        select
            max(bs.RawScore)
        from
            Bowler_Scores bs
        inner join
            Bowlers b
            on b.BowlerID = bs.BowlerID
        where
            bs.BowlerID <> B.BowlerID
            and
            b.TeamID = T.TeamID
    );
-----------------------------------------------------------------
/*
“Display for each bowler the bowler name and the average of the
bowler’s raw game scores for bowlers whose average is greater
than 155.”
*/
select
    concat(B.BowlerFirstName, ' ', B.BowlerLastName) as Bowler,
    avg(BS.RawScore) as AvgRawScore
from
    Bowlers B
inner join
    Bowler_Scores BS
    on BS.BowlerID = B.BowlerID
group by
    B.BowlerFirstName,
    B.BowlerLastName
having
    avg(BS.RawScore) > 155;
-----------------------------------------------------------------
/*
“List the last name and first name of every bowler whose average
raw score is greater than or equal to the overall average score.”
*/
select
    B.BowlerLastName,
    B.BowlerFirstName,
    avg(BS.RawScore) as AvgRawScore
from
    Bowlers B
inner join
    Bowler_Scores BS
    on BS.BowlerID = B.BowlerID
group by
    B.BowlerFirstName,
    B.BowlerLastName
having
    avg(BS.RawScore) >= (
        select
            avg(bs.RawScore)
        from
            Bowler_Scores bs
    );
-----------------------------------------------------------------
use RecipesExample;
-----------------------------------------------------------------
/*
“Sum the amount of salt by recipe class, and display those
recipe classes that require more than three teaspoons.”
*/
select
    RC.RecipeClassDescription,
    sum(RI.Amount)
from
    Recipe_Classes RC
inner join
    Recipes R
    on RC.RecipeClassID = R.RecipeClassID
inner join
    Recipe_Ingredients as RI
    on RI.RecipeID = R.RecipeID
inner join
    Ingredients I
    on I.IngredientID = RI.IngredientID
where
    I.IngredientName = 'Salt'
group by
    RC.RecipeClassDescription
having
    sum(RI.Amount) > 3;
-----------------------------------------------------------------
/*
“For what class of recipe do I have two or more recipes?”
*/
select
    RC.RecipeClassDescription,
    count(R.RecipeID)
from
    Recipe_Classes RC
inner join
    Recipes R
    on RC.RecipeClassID = R.RecipeClassID
group by
    RC.RecipeClassDescription
having
    count(R.RecipeID) >= 2;
-----------------------------------------------------------------
                        T H E - E N D
-----------------------------------------------------------------
