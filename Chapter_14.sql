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
-----------------------------------------------------------------
use SchoolSchedulingExample;
-----------------------------------------------------------------
/*
“For completed classes, list by category and student the category
name, the student name, and the student’s average grade of all
classes taken in that category for those students who have an
average higher than 90.”
*/
