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
/*
using outer join
*/
select
    C.CustomerID,
    C.CustFirstName,
    C.CustLastName
from
    Customers C
left join
    (
    select
        O.CustomerID
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
        CC.CategoryDescription in ('Bikes', 'Tires')
    ) BT
    on BT.CustomerID = C.CustomerID
where
    BT.CustomerID is null;
/*
using not in
*/
select
    C.CustomerID,
    C.CustFirstName,
    C.CustLastName
from
    Customers C
where
    C.CustomerID not in (
    select
        O.CustomerID
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
        CC.CategoryDescription in ('Bikes', 'Tires')
    );
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
    not exists(
    select
        *
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
        CC.CategoryDescription in ('Bikes', 'Tires')
        and
        O.CustomerID = C.CustomerID
    );
-----------------------------------------------------------------
use EntertainmentAgencyExample;
-----------------------------------------------------------------
/*
“List the entertainers who played engagements for customers Berg
and Hallmark.”
*/
/*
using join
*/
select distinct
    EC1.EntertainerID,
    EC1.EntStageName
from
    (
        select
            E1.EntertainerID,
            E1.EntStageName
        from
            Entertainers E1
        inner join
            Engagements EN1
            on E1.EntertainerID = EN1.EntertainerID
        inner join
            Customers C1
            on C1.CustomerID = EN1.CustomerID
        where
            C1.CustLastName = 'Berg'
    ) EC1
inner join
    (
        select
            E2.EntertainerID,
            E2.EntStageName
        from
            Entertainers E2
        inner join
            Engagements EN2
            on E2.EntertainerID = EN2.EntertainerID
        inner join
            Customers C2
            on C2.CustomerID = EN2.CustomerID
        where
            C2.CustLastName = 'Hallmark'
    ) EC2
    on EC1.EntertainerID = EC2.EntertainerID;
/*
using exist
*/
select
    E.EntertainerID,
    E.EntStageName
from
    Entertainers E
where
    exists
    (
        select
            *
        from
            Engagements EN1
        inner join
            Customers C1
            on C1.CustomerID = EN1.CustomerID
        where
            C1.CustLastName = 'Berg'
            and
            EN1.EntertainerID = E.EntertainerID
    )
    and
    exists
    (
        select
            *
        from
            Engagements EN2
        inner join
            Customers C2
            on C2.CustomerID = EN2.CustomerID
        where
            C2.CustLastName = 'Hallmark'
            and
            EN2.EntertainerID = E.EntertainerID
    );
/*
using in
*/
select
    E.EntertainerID,
    E.EntStageName
from
    Entertainers E
where
    E.EntertainerID in
    (
        select
            EN1.EntertainerID
        from
            Engagements EN1
        inner join
            Customers C1
            on C1.CustomerID = EN1.CustomerID
        where
            C1.CustLastName = 'Berg'
    )
    and
    E.EntertainerID in
    (
        select
            EN2.EntertainerID
        from
            Engagements EN2
        inner join
            Customers C2
            on C2.CustomerID = EN2.CustomerID
        where
            C2.CustLastName = 'Hallmark'
    );
-----------------------------------------------------------------
/*
“Display agents who have never booked a Country or Country Rock
group.”
*/
/*
using join
*/
select
    A.AgentID,
    A.AgtFirstName,
    A.AgtLastName
from
    Agents A
left join
    (
        select
            E.AgentID
        from
            Engagements E
        inner join
            Entertainers EN
            on E.EntertainerID = EN.EntertainerID
        inner join
            Entertainer_Styles ES
            on ES.EntertainerID = EN.EntertainerID
        inner join
            Musical_Styles MS
            on MS.StyleID = ES.StyleID
        where
            MS.StyleName in ('Country', 'Country Rock')
    )CCR
    on CCR.AgentID = A.AgentID
where
    CCR.AgentID is null;
/*
using not in
*/
select
    A.AgentID,
    A.AgtFirstName,
    A.AgtLastName
from
    Agents A
where
    A.AgentID not in
    (
        select
            E.AgentID
        from
            Engagements E
        inner join
            Entertainers EN
            on E.EntertainerID = EN.EntertainerID
        inner join
            Entertainer_Styles ES
            on ES.EntertainerID = EN.EntertainerID
        inner join
            Musical_Styles MS
            on MS.StyleID = ES.StyleID
        where
            MS.StyleName in ('Country', 'Country Rock')
    );
/*
Using exist
*/
select
    A.AgentID,
    A.AgtFirstName,
    A.AgtLastName
from
    Agents A
where
    not exists
    (
        select
            *
        from
            Engagements E
        inner join
            Entertainers EN
            on E.EntertainerID = EN.EntertainerID
        inner join
            Entertainer_Styles ES
            on ES.EntertainerID = EN.EntertainerID
        inner join
            Musical_Styles MS
            on MS.StyleID = ES.StyleID
        where
            MS.StyleName in ('Country', 'Country Rock')
            and
            E.AgentID = A.AgentID
    );
-----------------------------------------------------------------
use SchoolSchedulingExample;
-----------------------------------------------------------------
/*
“List students who have a grade of 85 or better in both art and
computer science.”
*/
/*
using join
*/
select
    A.StudentID,
    A.StudFirstName,
    A.StudLastName
from
    (
        select
            S1.StudentID,
            S1.StudFirstName,
            S1.StudLastName
        from
            Students S1
        inner join
            Student_Schedules SS1
            on SS1.StudentID = S1.StudentID
        inner join
            Classes C1
            on C1.ClassID = SS1.ClassID
        inner join
            Subjects SU1
            on SU1.SubjectID = C1.SubjectID
        inner join
            Categories CA1
            on CA1.CategoryID = SU1.CategoryID
        where
            CA1.CategoryDescription = 'Art'
            and
            SS1.Grade >= 85
    ) A
    inner join
    (
        select
            S2.StudentID,
            S2.StudFirstName,
            S2.StudLastName
        from
            Students S2
        inner join
            Student_Schedules SS2
            on SS2.StudentID = S2.StudentID
        inner join
            Classes C2
            on C2.ClassID = SS2.ClassID
        inner join
            Subjects SU2
            on SU2.SubjectID = C2.SubjectID
        inner join
            Categories CA2
            on CA2.CategoryID = SU2.CategoryID
        where
            CA2.CategoryDescription like '%Computer%'
            and
            SS2.Grade >= 85
    ) C
    on C.StudentID = A.StudentID;
/*
using in
*/
select
    S.StudentID,
    S.StudFirstName,
    S.StudLastName
from
    Students S
where
    S.StudentID in (
        select
            SS1.StudentID
        from
            Student_Schedules SS1
        inner join
            Classes C1
            on C1.ClassID = SS1.ClassID
        inner join
            Subjects S1
            on S1.SubjectID = C1.SubjectID
        inner join
            Categories CA1
            on CA1.CategoryID = S1.CategoryID
        where
            CA1.CategoryDescription = 'Art'
            and
            SS1.Grade >= 85
    )
    and
    S.StudentID in (
    select
        SS2.StudentID
    from
        Student_Schedules SS2
    inner join
        Classes C2
        on C2.ClassID = SS2.ClassID
    inner join
        Subjects S2
        on S2.SubjectID = C2.SubjectID
    inner join
        Categories CA2
        on CA2.CategoryID = S2.CategoryID
    where
        CA2.CategoryDescription like '%Computer%'
        and
        SS2.Grade >= 85
    );
/*
using exists
*/
select
    S.StudentID,
    S.StudFirstName,
    S.StudLastName
from
    Students S
where
    exists (
        select
            *
        from
            Student_Schedules SS1
        inner join
            Classes C1
            on C1.ClassID = SS1.ClassID
        inner join
            Subjects S1
            on S1.SubjectID = C1.SubjectID
        inner join
            Categories CA1
            on CA1.CategoryID = S1.CategoryID
        where
            CA1.CategoryDescription = 'Art'
            and
            SS1.Grade >= 85
            and
            S.StudentID = SS1.StudentID
    )
    and
    exists (
    select
        *
    from
        Student_Schedules SS2
    inner join
        Classes C2
        on C2.ClassID = SS2.ClassID
    inner join
        Subjects S2
        on S2.SubjectID = C2.SubjectID
    inner join
        Categories CA2
        on CA2.CategoryID = S2.CategoryID
    where
        CA2.CategoryDescription like '%Computer%'
        and
        SS2.Grade >= 85
        and
        SS2.StudentID = S.StudentID
    );
-----------------------------------------------------------------
/*
“Show me students registered for classes for which they have not
completed the prerequisite course.”
*/
???
-----------------------------------------------------------------
use BowlingLeagueExample;
-----------------------------------------------------------------
/*
“List the bowlers, the match number, the game number, the
handicap score, the tournament date, and the tournament location
for bowlers who won a game with a handicap score of 190 or less
at Thunderbird Lanes, Totem Lanes, and Bolero Lanes.”
*/
select
    B.BowlerID,
    B.BowlerFirstName,
    B.BowlerLastName,
    BS.MatchID,
    BS.GameNumber,
    BS.HandiCapScore,
    T.TourneyDate,
    T.TourneyLocation
from
    Bowlers B
inner join
    Bowler_Scores BS
    on B.BowlerID = BS.BowlerID
inner join
    Tourney_Matches TM
    on TM.MatchID = BS.MatchID
inner join
    Tournaments T
    on T.TourneyID = TM.TourneyID
where
    BS.HandiCapScore <= 190
    and
    BS.WonGame = 1
    and
    T.TourneyLocation in ('Thunderbird Lanes', 'Totem Lanes',
    'Bolero Lanes')
    and
    B.BowlerID in (
        select
            BS1.BowlerID
        from
            Bowler_Scores BS1
        inner join
            Tourney_Matches TM1
            on TM1.MatchID = BS1.MatchID
        inner join
            Tournaments T1
            on T1.TourneyID = TM1.TourneyID
        where
            T1.TourneyLocation = 'Thunderbird Lanes'
            and
            BS1.WonGame = 1
            and
            BS1.HandiCapScore <= 190
    )
    and
    B.BowlerID in (
        select
            BS2.BowlerID
        from
            Bowler_Scores BS2
        inner join
            Tourney_Matches TM2
            on TM2.MatchID = BS2.MatchID
        inner join
            Tournaments T2
            on T2.TourneyID = TM2.TourneyID
        where
            T2.TourneyLocation = 'Totem Lanes'
            and
            BS2.WonGame = 1
            and
            BS2.HandiCapScore <= 190
    )
    and
    B.BowlerID in (
        select
            BS3.BowlerID
        from
            Bowler_Scores BS3
        inner join
            Tourney_Matches TM3
            on TM3.MatchID = BS3.MatchID
        inner join
            Tournaments T3
            on T3.TourneyID = TM3.TourneyID
        where
            T3.TourneyLocation = 'Bolero Lanes'
            and
            BS3.WonGame = 1
            and
            BS3.HandiCapScore <= 190
    );
-----------------------------------------------------------------
/*
“Show me the bowlers who have not bowled a raw score better than
165 at Thunderbird Lanes and Bolero Lanes.”
*/
select
    B.BowlerID,
    B.BowlerFirstName,
    B.BowlerLastName
from
    Bowlers B
where
    B.BowlerID not in (
        select
            BS1.BowlerID
        from
            Bowler_Scores BS1
        inner join
            Tourney_Matches TM1
            on TM1.MatchID = BS1.MatchID
        inner join
            Tournaments T1
            on T1.TourneyID = TM1.TourneyID
        where
            BS1.RawScore > 165
            and
            T1.TourneyLocation = 'Thunderbird Lanes'
    )
    and
    B.BowlerID not in (
        select
            BS2.BowlerID
        from
            Bowler_Scores BS2
        inner join
            Tourney_Matches TM2
            on TM2.MatchID = BS2.MatchID
        inner join
            Tournaments T2
            on T2.TourneyID = TM2.TourneyID
        where
            BS2.RawScore > 165
            and
            T2.TourneyLocation = 'Bolero Lanes'
    );
-----------------------------------------------------------------
use RecipesExample;
-----------------------------------------------------------------
/*
“Display the ingredients that are not used in the recipes for
Irish Stew, Pollo Picoso, and Roast Beef.”
*/
select
    I.IngredientID,
    I.IngredientName
from
    Ingredients I
where
    I.IngredientID not in
    (
        select
            RI.IngredientID
        from
            Recipe_Ingredients RI
        inner join
            Recipes R
            on R.RecipeID = RI.RecipeID
        where
            R.RecipeTitle in ('Irish Stew', 'Pollo Picoso',
            'Roast Beef')
    );
-----------------------------------------------------------------
/*
“List the pairs of recipes where both recipes have at least the
same three ingredients.”
*/
select distinct
    R1.RecipeID as "Recipe1-ID",
    R1.RecipeTitle as "Recipe1",
    R2.RecipeID as "Recipe2-ID",
    R2.RecipeTitle as "Recipe2"
from
    Recipes R1
inner join
    Recipe_Ingredients RI1
    on R1.RecipeID = RI1.RecipeID
inner join
    Recipe_Ingredients RI2
    on RI1.IngredientID = RI2.IngredientID
inner join
    Recipes R2
    on R2.RecipeID = RI2.RecipeID
where
    RI2.RecipeID > R1.RecipeID
group by
    R1.RecipeID,
    R1.RecipeTitle,
    R2.RecipeID,
    R2.RecipeTitle
having
    count(RI1.RecipeID) >= 3;
-----------------------------------------------------------------
                    P R A T I C E - Q U E S T I O N
-----------------------------------------------------------------
use SalesOrdersExample;
-----------------------------------------------------------------
 /*
 “Display the customers who have never ordered bikes or tires.”
 */
select
    C.CustomerID,
    C.CustFirstName,
    C.CustLastName
from
    Customers C
left join
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
            Categories CC
            on CC.CategoryID = P.CategoryID
        where
            CC.CategoryDescription in ('Bikes', 'Tires')
    ) BT
    on BT.CustomerID = C.CustomerID
where
    BT.CustomerID is null;
-----------------------------------------------------------------
/*
“List the customers who have purchased a bike but not a helmet.”
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
            Orders O
        inner join
            Order_Details OD
            on O.OrderNumber = OD.OrderNumber
        inner join
            Products P
            on P.ProductNumber = OD.ProductNumber
        inner join
            Categories CC
            on CC.CategoryID = P.CategoryID
        where
            CC.CategoryDescription = "Bikes"
        and
            O.CustomerID = C.CustomerID
    )
    and
    not exists (
        select
            *
        from
            Orders O
        inner join
            Order_Details OD
            on O.OrderNumber = OD.OrderNumber
        inner join
            Products P
            on P.ProductNumber = OD.ProductNumber
        where
            P.ProductName like "%Helmet"
            and
            C.CustomerID = O.CustomerID
    );
/*
using in
*/
select
    C.CustomerID,
    C.CustFirstName,
    C.CustLastName
from
    Customers C
where
    C.CustomerID in (
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
            Categories CC
            on CC.CategoryID = P.CategoryID
        where
            CC.CategoryDescription = "Bikes"
    )
    and
    C.CustomerID not in(
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
        where
            P.ProductName like "%Helmet"
    );
-----------------------------------------------------------------
/*
“Show me the customer orders that have a bike but do not have a
helmet.”
*/
select
    C.CustomerID,
    C.CustFirstName,
    C.CustLastName,
    O.OrderNumber,
    O.OrderDate
from
    Orders O
inner join
    Customers C
    on C.CustomerID = O.CustomerID
where
    exists (
        select
            *
        from
            Order_Details OD1
        inner join
            Products P1
            on P1.ProductNumber = OD1.ProductNumber
        inner join
            Categories C1
            on C1.CategoryID = P1.CategoryID
        where
            OD1.OrderNumber = O.OrderNumber
            and
            C1.CategoryDescription = 'Bikes'
    )
    and
    not exists (
        select
            *
        from
            Order_Details OD2
        inner join
            Products P2
            on P2.ProductNumber = OD2.ProductNumber
        where
            OD2.OrderNumber = O.OrderNumber
            and
            P2.ProductName like "%Helmet"
    );
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
-----------------------------------------------------------------
-----------------------------------------------------------------
