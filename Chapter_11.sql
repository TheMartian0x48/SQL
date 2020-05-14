/**
 * @Author: ADITYA KUMAR SINGH <the__martian>
 * @Email:  cr7.aditya.cs@gmail.com
 * @Filename: Chapter_11.sql
 * @Last modified by:   the__martian
 */

-----------------------------------------------------------------
                    --Internal problems--
-----------------------------------------------------------------
use SalesOrdersExample;
-----------------------------------------------------------------
select OrderNumber, ShipDate, CustLastName
from
    Orders
inner join
    Customers
    on Orders.CustomerID = Customers.CustomerID
where ShipDate = '2017-10-03';
-----------------------------------------------------------------
select concat(CustLastName, ', ', CustFirstName) as Customer,
(
    select count(*)
    from
        Orders
    where
        Customers.CustomerID = Orders.CustomerID
) as Count
from
    Customers;
-----------------------------------------------------------------
select concat(CustLastName, ', ', CustFirstName) as Customer,
(
    select max(OrderDate)
    from
        Orders
    where
        Customers.CustomerID = Orders.CustomerID
) as Count
from
    Customers;
-----------------------------------------------------------------
select concat(CustLastName, ', ', CustFirstName) as Customer,
Orders.OrderNumber, OrderDate, QuotedPrice,
QuantityOrdered, ProductName
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
    OrderDate =
    (
        select max(OrderDate)
        from
            Orders as O
        where
            O.CustomerID = Customers.CustomerID
    );
-----------------------------------------------------------------
use RecipesExample;
-----------------------------------------------------------------
select RecipeTitle
from
    Recipes
where
    Recipes.RecipeID in
    (
        select RI.RecipeID
        from
            Recipe_Ingredients as RI
        inner join
            Ingredients as I
            on I.IngredientID = RI.IngredientID
        inner join
            Ingredient_Classes as IC
            on IC.IngredientClassID = I.IngredientClassID
        where
            IC.IngredientClassDescription = 'Seafood'
    );
-----------------------------------------------------------------
select R.RecipeTitle, I.IngredientName
from
    Recipes R
inner join
    Recipe_Ingredients RI
    on R.RecipeID = RI.RecipeID
inner join
    Ingredients I
    on I.IngredientID = RI.IngredientID
where R.RecipeID in
    (
        select ri.RecipeID
        from
            Recipe_Ingredients ri
        inner join
            Ingredients i
            on i.IngredientID = ri.IngredientID
        inner join
            Ingredient_Classes as ic
            on ic.IngredientClassID = i.IngredientClassID
        where
            ic.IngredientClassDescription = 'Seafood'
    );
-----------------------------------------------------------------
--using  = any
select R.RecipeTitle
from
    Recipes R
where
    R.RecipeID in
    (
        select RI.RecipeID
        from
            Recipe_Ingredients RI
        where
            RI.IngredientID = any
            (
                select I.IngredientID
                from
                    Ingredients I
                where
                    I.IngredientName in ('Garlic', 'Beef')
            )
    );
-- without using = any
select R.RecipeTitle
from
    Recipes R
where
    R.RecipeID in
    (
        select RI.RecipeID
        from
            Recipe_Ingredients RI
        inner join
            Ingredients I
            on I.IngredientID = RI.IngredientID
        where
            I.IngredientName in ('Garlic', 'Beef')
    );
-----------------------------------------------------------------
use SalesOrdersExample;
-----------------------------------------------------------------
select P.ProductName, P.RetailPrice
from
    Products P
inner join
    Categories C
    on P.CategoryID = C.CategoryID
where
    C.CategoryDescription = 'Accessories' and
    P.RetailPrice > all
    (
        select p.RetailPrice
        from
            Products p
        inner join
            Categories c
            on p.CategoryID = c.CategoryID
        where
            c.CategoryDescription = 'Clothing'
    );
-----------------------------------------------------------------
select C.CustomerID, C.CustLastName, C.CustFirstName
from
    Customers C
where
    exists
    (
        select O.CustomerID
        from
            Orders O
        inner join
            Order_Details OD
            on O.OrderNumber = OD.OrderNumber
        inner join
            Products P
            on OD.ProductNumber = P.ProductNumber
        where
            P.CategoryID = 2 and C.CustomerID = O.CustomerID
    );
--join version
select distinct C.CustomerID, C.CustLastName, C.CustFirstName
from
    Customers C
inner join
    Orders O
    on O.CustomerID = C.CustomerID
inner join
    Order_Details OD
    on O.OrderNumber = OD.OrderNumber
inner join
    Products P
    on OD.ProductNumber = P.ProductNumber
where
    P.CategoryID = 2;
-----------------------------------------------------------------
--  P R A C T I C E  P R O B L E M
-----------------------------------------------------------------
use SalesOrdersExample;
-----------------------------------------------------------------
select V.VendName, (
    select count(*)
    from
        Product_Vendors P
    where
        V.VendorID = P.VendorID
) as "Number"
from
    Vendors V;
-----------------------------------------------------------------
use EntertainmentAgencyExample;
-----------------------------------------------------------------
select C.CustLastName,  C.CustFirstName,
(
    select max(E.StartDate)
    from
        Engagements E
    where
        E.CustomerID = C.CustomerID
) as LastBooking
from
    Customers C;
-----------------------------------------------------------------
use SchoolSchedulingExample;
-----------------------------------------------------------------
select S.SubjectName,
(
    select count(*)
    from
        Classes C
    where
        C.SubjectID = S.SubjectID and C.MondaySchedule = 1
) as "Number of Classes on Monday"
from
    Subjects S;
-----------------------------------------------------------------
use BowlingLeagueExample;
-----------------------------------------------------------------
select BowlerFirstName, BowlerLastName,
(
    select max(RawScore)
    from
        Bowler_Scores
    where
        Bowlers.BowlerID = Bowler_Scores.BowlerID
) as MaxScore
from
    Bowlers;
-----------------------------------------------------------------
use RecipesExample;
-----------------------------------------------------------------
select I.IngredientName,
(
    select count(*)
    from
        Recipe_Ingredients RI
    where
        RI.IngredientID = I.IngredientID
) as count
from
    Ingredients I
inner join
    Ingredient_Classes IC
    on I.IngredientClassID = IC.IngredientClassID
where
    IC.IngredientClassDescription = 'Meat';
-----------------------------------------------------------------
use SalesOrdersExample;
-----------------------------------------------------------------
select concat(C.CustFirstName, ' ', C.CustLastName) as Customer
from
    Customers C
where
    C.CustomerID in
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
        inner join
            Categories CC
            on CC.CategoryID = P.CategoryID
        where
            CategoryDescription in ('Clothing', 'Accessories')
    );
-----------------------------------------------------------------
use EntertainmentAgencyExample;
-----------------------------------------------------------------
select E.EntStageName
from
    Entertainers E
where E.EntertainerID in
    (
        select EE.EntertainerID
        from
            Engagements EE
        inner join
            Customers C
            on C.CustomerID = EE.CustomerID
        where
            C.CustLastName = "Berg"
    );
-----------------------------------------------------------------
use SchoolSchedulingExample;
-----------------------------------------------------------------
select distinct concat(S.StudFirstName, ' ', S.StudLastName) as
Student
from
    Students S
where S.StudentID not in
    (
        select SS.StudentID
        from
            Student_Schedules SS
        inner join
            Student_Class_Status SCS
            on SCS.ClassStatus = SS.ClassStatus
        where
            SCS.ClassStatusDescription = "Withdrew"
    );
-----------------------------------------------------------------
use BowlingLeagueExample;
-----------------------------------------------------------------
select concat(B.BowlerFirstName, ' ', B.BowlerLastName) as
Captain, T.TeamID
from
    Bowlers B
inner join
    Teams T
    on B.BowlerID = T.CaptainID
inner join
    Bowler_Scores BS
    on B.BowlerID = BS.BowlerID
where
    BS.HandiCapScore >
    (
        select max(bs.HandiCapScore)
        from
            Bowlers b
        inner join
            Bowler_Scores bs
            on b.BowlerID = bs.BowlerID
        where
            b.TeamID = B.TeamID and b.BowlerID <> B.BowlerID
    );
-----------------------------------------------------------------
use RecipesExample;
-----------------------------------------------------------------
select R.RecipeTitle, i.IngredientName
from
    Recipes R
inner join
    Recipe_Ingredients RI
    on R.RecipeID = RI.RecipeID
inner join
    Ingredients i
    on i.IngredientID = RI.IngredientID
where
    RI.RecipeID in
    (
        select ri.RecipeID
        from
            Recipe_Ingredients ri
        inner join
            Ingredients I
            on I.IngredientID = ri.IngredientID
        where
            I.IngredientName = 'Carrot'
    );
-----------------------------------------------------------------
-- E X C E R C I S E
-----------------------------------------------------------------
use SalesOrdersExample;
-----------------------------------------------------------------
--???
-----------------------------------------------------------------
select distinct
    concat(C.CustFirstName, " ", C.CustLastName) as Customer
from
    Customers C
where
    C.CustomerID in
    (
        select
            O.CustomerID
        from
            Orders O
        inner join
            Order_Details OD
            on O.OrderNumber = OD.OrderNumber
        inner join
            Products P
            on P.ProductNumber = OD.ProductNumber
        inner join
            Categories C
            on C.CategoryID = P.CategoryID
        where
            C.CategoryDescription = 'Bikes'
    );
----------------------------------------------------------------
select
    P.ProductName
from
    Products P
where
    P.ProductNumber not in
    (
        select
            OD.ProductNumber
        from
            Order_Details OD
    );
-----------------------------------------------------------------
use EntertainmentAgencyExample;
----------------------------------------------------------------
select
    E.EntStageName,
    (
        select
            count(*)
        from
            Engagements En
        where
            En.EntertainerID = E.EntertainerID
    ) as Count
from
    Entertainers E;
-----------------------------------------------------------------
select distinct
    concat(C.CustFirstName, ' ', C.CustLastName) as Customer
from
    Customers C
inner join
    Engagements E
    on C.CustomerID = E.CustomerID
where
    E.EntertainerID in
    (
        select
            En.EntertainerID
        from
            Entertainers En
        inner join
            Entertainer_Styles ES
            on ES.EntertainerID = En.EntertainerID
        inner join
            Musical_Styles MS
            on MS.StyleID = ES.StyleID
        where
            MS.StyleName in ('Country', 'Country Rock')
    );
-----------------------------------------------------------------
select
    E.EntStageName
from
    Entertainers E
where
    E.EntertainerID some
