/**
 * @Author: ADITYA KUMAR SINGH <the__martian>
 * @Email:  cr7.aditya.cs@gmail.com
 * @Filename: Chapter_18.sql
 */

-----------------------------------------------------------------
              I N T E R N A L  P R O B L E M S
-----------------------------------------------------------------
use RecipesExample;
-----------------------------------------------------------------
/*
“List ingredients not used in any recipe yet.”
*/
select
    I.IngredientName
from
    Ingredients I
left join
    Recipe_Ingredients RI
    on I.IngredientID = RI.IngredientID
where
    RI.IngredientID is null;
-----------------------------------------------------------------
/*
“Find the recipes that have neither beef, nor onions, nor
carrots.”
*/
/*
Using outer join
*/

select
    R.RecipeTitle
from
    Recipes R
left join
    (
        select
            RI.RecipeID
        from
            Recipe_Ingredients RI
        inner join
            Ingredients I
            on I.IngredientID = RI.IngredientID
        where
            I.IngredientName in ('Beef', 'Carrot', 'Onion')
    ) as E
    on E.RecipeID = R.RecipeID
where
    E.RecipeID is null;

/*
Using not in
*/
select
    R.RecipeTitle
from
    Recipes R
where
    R.RecipeID not in
    (
        select
            RI.RecipeID
        from
            Recipe_Ingredients RI
        inner join
            Ingredients I
            on I.IngredientID = RI.IngredientID
        where
            I.IngredientName in ('Beef', 'Onion', 'Carrot')
    );

/*
Using not exists
*/
select
    R.RecipeTitle
from
    Recipes R
where
    not exists
    (
        select
            RI.RecipeID
        from
            Recipe_Ingredients RI
        inner join
            Ingredients I
            on I.IngredientID = RI.IngredientID
        where
            I.IngredientName in ('Beef', 'Onion', 'Carrot')
            and
            R.RecipeID = RI.RecipeID
    );
/*
Using group
*/
select
    R.RecipeID,
    R.RecipeTitle
from
    Recipes R
left join
    (
        select
            RI.RecipeID
        from
            Recipe_Ingredients RI
        inner join
            Ingredients I
            on I.IngredientID = RI.IngredientID
        where
            I.IngredientName in ('Beef', 'Onion', 'Carrot')
    ) as BOC
    on BOC.RecipeID = R.RecipeID
where
    BOC.RecipeID is null
group by
    R.RecipeID,
    R.RecipeTitle
having
    count(BOC.RecipeID) = 0;
-----------------------------------------------------------------
/*
“Find the recipes that have butter but have neither beef, nor
onions, nor carrots.”
*/
select
    R.RecipeID,
    R.RecipeTitle,
    I.IngredientName
from
    Recipes R
inner join
    Recipe_Ingredients RI
    on RI.RecipeID = R.RecipeID
inner join
    Ingredients I
    on I.IngredientID = RI.IngredientID
left join
    (
        select
            ri.RecipeID
        from
            Recipe_Ingredients ri
        inner join
            Ingredients i
            on i.IngredientID = ri.IngredientID
        where
            i.IngredientName in ('Beef', 'Onion', 'Carrot')
    ) BOC
    on BOC.RecipeID = R.RecipeID
where
    I.IngredientName = 'Butter'
    and
    BOC.RecipeID is null
group by
    R.RecipeID,
    R.RecipeTitle
having
    count(BOC.RecipeID) = 0;
-----------------------------------------------------------------
/*
“List the customers who have booked Carol Peacock Trio, Caroline
Coie Cuartet, and Jazz Persuasion.”
*/
/*
using inner join
*/
select distinct
    CPT.CustomerID,
    concat(CPT.CustFirstName, ' ', CPT.CustLastName) as Customer
from
    (
        select
            C1.CustomerID,
            C1.CustFirstName,
            C1.CustLastName
        from
            Customers C1
        inner join
            Engagements E1
            on C1.CustomerID = E1.CustomerID
        inner join
            Entertainers EN1
            on EN1.EntertainerID = E1.EntertainerID
        where
            EN1.EntStageName = 'Carol Peacock Trio'
    ) CPT
inner join
    (
        select
            C2.CustomerID,
            C2.CustFirstName,
            C2.CustLastName
        from
            Customers C2
        inner join
            Engagements E2
            on C2.CustomerID = E2.CustomerID
        inner join
            Entertainers EN2
            on EN2.EntertainerID = E2.EntertainerID
        where
            EN2.EntStageName = 'Caroline Coie Cuartet'
    ) CCC
    on CCC.CustomerID = CPT.CustomerID
inner join
    (
        select
            C3.CustomerID,
            C3.CustFirstName,
            C3.CustLastName
        from
            Customers C3
        inner join
            Engagements E3
            on C3.CustomerID = E3.CustomerID
        inner join
            Entertainers EN3
            on EN3.EntertainerID = E3.EntertainerID
        where
            EN3.EntStageName = 'Jazz Persuasion'
    ) JP
    on JP.CustomerID = CCC.CustomerID;
/*
using in
*/
select
    C.CustomerID,
    concat(C.CustFirstName, ' ', C.CustLastName) as Customer
from
    Customers C
where
    C.CustomerID in
    (
        select
            E1.CustomerID
        from
            Engagements E1
        inner join
            Entertainers EN1
            on E1.EntertainerID = EN1.EntertainerID
        where
            EN1.EntStageName = 'Carol Peacock Trio'
    )
    and
    C.CustomerID in
    (
        select
            E2.CustomerID
        from
            Engagements E2
        inner join
            Entertainers EN2
            on E2.EntertainerID = EN2.EntertainerID
        where
            EN2.EntStageName = 'Caroline Coie Cuartet'
    )
    and
    C.CustomerID in
    (
        select
            E3.CustomerID
        from
            Engagements E3
        inner join
            Entertainers EN3
            on E3.EntertainerID = EN3.EntertainerID
        where
            EN3.EntStageName = 'Jazz Persuasion'
    );
/*
Using Exists
*/
select
    C.CustomerID,
    concat(C.CustFirstName, ' ', C.CustLastName) as Customer
from
    Customers C
where
    exists
    (
        select
            E1.CustomerID
        from
            Engagements E1
        inner join
            Entertainers EN1
            on E1.EntertainerID = EN1.EntertainerID
        where
            EN1.EntStageName = 'Carol Peacock Trio'
            and
            E1.CustomerID = C.CustomerID
    )
    and
    exists
    (
        select
            E2.CustomerID
        from
            Engagements E2
        inner join
            Entertainers EN2
            on E2.EntertainerID = EN2.EntertainerID
        where
            EN2.EntStageName = 'Caroline Coie Cuartet'
            and
            E2.CustomerID = C.CustomerID
    )
    and
    exists
    (
        select
            E3.CustomerID
        from
            Engagements E3
        inner join
            Entertainers EN3
            on E3.EntertainerID = EN3.EntertainerID
        where
            EN3.EntStageName = 'Jazz Persuasion'
            and
            E3.CustomerID = C.CustomerID
    );
-----------------------------------------------------------------
/*
“Display customers and groups where the musical styles of the
group match all of the musical styles preferred by the customer.”
*/
select
    C.CustomerID,
    C.CustFirstName,
    C.CustLastName,
    E.EntertainerID,
    E.EntStageName,
    count(MP.StyleID) as CountOfStyleID
from
    Customers C
inner join
    Musical_Preferences MP
    on MP.CustomerID = C.CustomerID
inner join
    Entertainer_Styles ES
    on ES.StyleID = MP.StyleID
inner join
    Entertainers E
    on E.EntertainerID = ES.EntertainerID
group by
    C.CustomerID,
    C.CustFirstName,
    C.CustLastName,
    E.EntertainerID,
    E.EntStageName
having
    count(MP.StyleID) = (
        select
            count(*)
        from
            Musical_Preferences mp
        where
            mp.CustomerID = C.CustomerID
    );
-----------------------------------------------------------------
                    P R A T I C E - Q U E S T I O N S
-----------------------------------------------------------------
use SalesOrdersExample;
-----------------------------------------------------------------
/*
“Find all the customers who ordered a bicycle and also ordered a
helmet.”
*/
/*
using exists
*/
select
    C.CustomerID,
    C.CustFirstName,
    C.CustLastName
from
    Customers C
where
    exists (
        select
            *
        from
            Orders O1
        inner join
            Order_Details OD1
            on O1.OrderNumber = OD1.OrderNumber
        inner join
            Products P1
            on P1.ProductNumber = OD1.ProductNumber
        where
            P1.ProductName like '%Helmet'
            and
            O1.CustomerID = C.CustomerID
    )
    and
    exists (
        select
            *
        from
            Orders O2
        inner join
            Order_Details OD2
            on O2.OrderNumber = OD2.OrderNumber
        inner join
            Products P2
            on P2.ProductNumber = OD2.ProductNumber
        where
            P2.ProductName like '%Bike'
            and
            O2.CustomerID = C.CustomerID
    );
/*
using inner join
*/
select distinct
    B.CustomerID,
    B.CustFirstName,
    B.CustLastName
from
    (
    select
        C1.CustomerID,
        C1.CustFirstName,
        C1.CustLastName
    from
        Customers C1
    inner join
        Orders O1
        on O1.CustomerID = C1.CustomerID
    inner join
        Order_Details OD1
        on O1.OrderNumber = OD1.OrderNumber
    inner join
        Products P1
        on P1.ProductNumber = OD1.ProductNumber
    where
        P1.ProductName like '%Helmet'
    ) H
inner join
    (
    select
        C2.CustomerID,
        C2.CustFirstName,
        C2.CustLastName
    from
        Customers C2
    inner join
        Orders O2
        on O2.CustomerID = C2.CustomerID
    inner join
        Order_Details OD2
        on O2.OrderNumber = OD2.OrderNumber
    inner join
        Products P2
        on P2.ProductNumber = OD2.ProductNumber
    where
        P2.ProductName like '%Bike'
    ) B
    on H.CustomerID = B.CustomerID;
/*
using in
*/
select distinct
    C.CustomerID,
    C.CustFirstName,
    C.CustLastName
from
    Customers C
where
    C.CustomerID in
    (
    select
        O1.CustomerID
    from
        Orders O1
    inner join
        Order_Details OD1
        on O1.OrderNumber = OD1.OrderNumber
    inner join
        Products P1
        on P1.ProductNumber = OD1.ProductNumber
    where
        P1.ProductName like '%Helmet'
    )
    and
    C.CustomerID in
    (
    select
        O2.CustomerID
    from
        Orders O2
    inner join
        Order_Details OD2
        on O2.OrderNumber = OD2.OrderNumber
    inner join
        Products P2
        on P2.ProductNumber = OD2.ProductNumber
    where
        P2.ProductName like '%Bike'
    );
-----------------------------------------------------------------
/*
“Find all the customers who have not ordered either bikes or
tires.”
*/

-----------------------------------------------------------------

-----------------------------------------------------------------

-----------------------------------------------------------------

-----------------------------------------------------------------

-----------------------------------------------------------------

-----------------------------------------------------------------

-----------------------------------------------------------------

-----------------------------------------------------------------

-----------------------------------------------------------------

-----------------------------------------------------------------

-----------------------------------------------------------------

-----------------------------------------------------------------

-----------------------------------------------------------------
