/**
 * @Author: ADITYA KUMAR SINGH <the__martian>
 * @Email:  cr7.aditya.cs@gmail.com
 * @Filename: Chapter_12.sql
 * @Last modified by:   the__martian
 */

-----------------------------------------------------------------
                P R A C T I C E  P R O B L E M
-----------------------------------------------------------------
use SalesOrdersExample;
-----------------------------------------------------------------
select
    count(*) as "Number of Customers from California"
from
    Customers C
where
    C.CustState = 'CA';
-----------------------------------------------------------------
select distinct
    P.ProductNumber, P.ProductName
from
    Products P
inner join
    Order_Details OD
    on OD.ProductNumber = P.ProductNumber
where
    OD.QuotedPrice >=
    (
        select
            avg(p.RetailPrice)
        from
            Products p
    );
-----------------------------------------------------------------
use EntertainmentAgencyExample;
-----------------------------------------------------------------
select
    E.EngagementNumber, E.ContractPrice
from
    Engagements E
where
    E.StartDate <=
    (
        select
            min(e.StartDate)
        from
            Engagements e
    );
-----------------------------------------------------------------
select
    concat('$', sum(e.ContractPrice)) as "Total Value"
from
    Engagements e
where
    e.StartDate between '2017-10-01' and '2017-10-31';
-----------------------------------------------------------------
use SchoolSchedulingExample;
-----------------------------------------------------------------
select
    max(Salary) as "Maximum Salary"
from
    Staff;
-----------------------------------------------------------------
select
    sum(Salary) "Total Salary"
from
    Staff
where
    StfState = "CA";
-----------------------------------------------------------------
use BowlingLeagueExample;
-----------------------------------------------------------------
select
    count(TourneyID) as "Number of Tournaments"
from
    Tournaments
where
    TourneyLocation = "Red Rooster Lanes";
-----------------------------------------------------------------
select
    B.BowlerLastName as "Last name", B.BowlerFirstName as
    "First Name"
from
    Bowlers B
where
    (
        select
            avg(BS.RawScore)
        from
            Bowler_Scores BS
        where
            BS.BowlerID = B.BowlerID
    ) >=
    (
        select
            avg(bs.RawScore)
        from
            Bowler_Scores bs
    )
order by
    1, 2;
-----------------------------------------------------------------
use RecipesExample;
-----------------------------------------------------------------
select
    count(*) " Number of recipes containing Beef"
from
    Recipes R
where
    R.RecipeID in
    (
        select
            RI.RecipeID
        from
            Recipe_Ingredients RI
        inner join
            Ingredients I
        where
            RI.IngredientID = I.IngredientID
            and
            I.IngredientName like "%Beef%"
    );
-----------------------------------------------------------------
select
    count(*)
from
    Ingredients I
where
    I.MeasureAmountID in
    (
        select
            M.MeasureAmountID
        from
            Measurements M
        where
            M.MeasurementDescription = 'Cup'
    );
-----------------------------------------------------------------
                        P R O B L E M S
-----------------------------------------------------------------
use SalesOrdersExample;
-----------------------------------------------------------------
select
    avg(P.RetailPrice) as "average retail price"
from
    Products P
where
    P.ProductName like "%Mountain Bike%";
-----------------------------------------------------------------
select
    max(O.OrderDate) as "Recent orders"
from
    Orders O;
-----------------------------------------------------------------
select
    sum(OD.QuotedPrice*OD.QuantityOrdered) as "Total amount"
from
    Order_Details OD
where
    OD.OrderNumber = 8;
-----------------------------------------------------------------
use EntertainmentAgencyExample;
-----------------------------------------------------------------
select
    avg(A.Salary) as "Avg salary"
from
    Agents A;
-----------------------------------------------------------------
select
    E.EngagementNumber
from
    Engagements E
where
    E.ContractPrice >=
    (
        select
            avg(e.ContractPrice)
        from
            Engagements e
    );
-----------------------------------------------------------------
select
    count(*)
from
    Entertainers E
where
    E.EntCity = 'Bellevue';
-----------------------------------------------------------------
select
    E.EngagementNumber
from
    Engagements E
where
    E.StartDate =
    (
        select
            min(e.StartDate)
        from
            Engagements e
        where
            e.StartDate between cast('2017-10-01' as date)
            and cast('2017-10-31' as date)
    );
-----------------------------------------------------------------
use SchoolSchedulingExample;
-----------------------------------------------------------------
select
    avg(C.Duration) as "Average class duration"
from
    Classes C;
-----------------------------------------------------------------
select
    S.StfLastName as "Last Name", S.StfFirstName as "First Name",
    S.DateHired as "Hired Date"
from
    Staff S
where
    S.DateHired =
    (
        select
            min(s.DateHired)
        from
            Staff s
    );
-----------------------------------------------------------------
select
    count(*) as "Number of classes"
from
    Classes C
where
    C.ClassRoomID = 3346;
-----------------------------------------------------------------
use BowlingLeagueExample;
-----------------------------------------------------------------
???
-----------------------------------------------------------------
select
    T.TourneyLocation
from
    Tournaments T
where
    T.TourneyDate =
    (
        select
            min(t.TourneyDate)
        from
            Tournaments t
    );
-----------------------------------------------------------------
select
    max(T.TourneyDate)
from
    Tournaments T;
-----------------------------------------------------------------
use RecipesExample;
-----------------------------------------------------------------
select
    R.RecipeTitle
from
    Recipes R
where
    R.RecipeID =
    (
        select
            RI.RecipeID
        from
            Recipe_Ingredients RI
        inner join
            Ingredients I
            on I.IngredientID = RI.IngredientID
        where
            I.IngredientName like "%Garlic%"
            and
            RI.Amount >=
            (
                select
                    max(ri.Amount)
                from
                    Recipe_Ingredients ri
                inner join
                    Ingredients i
                    on i.IngredientID = ri.IngredientID
                where
                    i.IngredientName like "%Garlic%"
            )
    );
-----------------------------------------------------------------
select
    count(*)
from
    Recipes R
inner join
    Recipe_Classes RC
    on R.RecipeClassID = RC.RecipeClassID
where
    RC.RecipeClassDescription = "Main course";
-----------------------------------------------------------------
select
    sum(RI.Amount)
from
    Recipe_Ingredients RI
inner join
    Ingredients I
    on I.IngredientID = RI.IngredientID
where
    I.IngredientName like "%Salt%";
-----------------------------------------------------------------
                        T H E  E N D
-----------------------------------------------------------------
