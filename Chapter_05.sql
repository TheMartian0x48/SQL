/**
 * @Author: ADITYA KUMAR SINGH <the__martian>
 * @Email:  cr7.aditya.cs@gmail.com
 * @Filename: Chapter_05.sql
 * @Last modified by:   the__martian
 */
--------------------------------------------------------------
-- Example
--------------------------------------------------------------
use SalesOrdersExample;
--------------------------------------------------------------
select ProductName as Product, RetailPrice * QuantityOnHand
as 'Inventory Price'
from
    Products;
--------------------------------------------------------------
select OrderNumber, OrderDate, ShipDate, cast(ShipDate -
OrderDate as Integer ) DaysElapsed
from
    Orders;
--------------------------------------------------------------
use EntertainmentAgencyExample;
--------------------------------------------------------------
select EngagementNumber, concat(cast(cast(EndDate - StartDate
as Integer) + 1 as character), ' day(s)') as DueToRun
from
    Engagements;
--------------------------------------------------------------
select EngagementNumber, concat( '$', cast(ContractPrice as
character)) as ContractPrice, concat('$', cast(ContractPrice
* 0.12 as character)) as OurFee, concat('$',
cast(ContractPrice * 0.88 as character))as 'Net Amount'
from
    Engagements;
--------------------------------------------------------------
use SchoolSchedulingExample;
--------------------------------------------------------------
select concat(StfLastname, ', ', StfFirstName) as Name,
DateHired, cast(cast(cast('2017-10-01' as date) - DateHired
as Integer)/365 as Integer) as YearsWithSchool
from
    Staff
order by
    StfLastname, StfFirstName;
--------------------------------------------------------------
select concat(StfLastname, ', ', StfFirstName) as Name,
concat('$', Salary) as Salary, concat('$', 0.07*Salary) as
Bonus
from
    Staff;
--------------------------------------------------------------
use BowlingLeagueExample;
--------------------------------------------------------------
select concat( BowlerFirstName, ' ', BowlerLastName) as 'Full
Name', BowlerAddress as Address, concat(BowlerCity, ', ',
BowlerState, ' ', BowlerZip) as CityStateZip, BowlerZip as Zip
from
    Bowlers
order by
    BowlerZip;
--------------------------------------------------------------
select BowlerID, MatchID, GameNumber, RawScore,
HandiCapScore, HandiCapScore - RawScore as PointDifference
from
    Bowler_Scores;
--------------------------------------------------------------
-- Problems
--------------------------------------------------------------
use SalesOrdersExample;
--------------------------------------------------------------
select ProductNumber, WholesalePrice, 0.95 * WholesalePrice
as NewPrice
from
    Product_Vendors;
--------------------------------------------------------------
select CustomerID, OrderDate, OrderNumber
from
    Orders
order by
    CustomerID, OrderDate desc;
--------------------------------------------------------------
select VendName, concat(VendStreetAddress, ' ', VendCity, '
', VendState, ' ', VendZipCode) as Address, VendPhoneNumber
from
    Vendors
order by
    VendName;
--------------------------------------------------------------
use EntertainmentAgencyExample;
--------------------------------------------------------------
select CustCity, concat(CustLastName, ', ', CustFirstName) as
Customer
from
    Customers
order by
    CustCity, CustLastName, CustFirstName;
--------------------------------------------------------------
select EntStageName as Name, EntWebPage as 'Website'
from
    Entertainers;
--------------------------------------------------------------
---select
--?????????????
--------------------------------------------------------------
use SchoolSchedulingExample;
--------------------------------------------------------------
select concat(StfLastname, ', ', StfFirstName) as Name, Salary
from
    Staff
order by
    Salary desc;
--------------------------------------------------------------
select concat(StfLastname, ', ', StfFirstName) as Name,
concat('(', StfAreaCode,') ', StfPhoneNumber) as 'Phone
Number'
from
    Staff;
--------------------------------------------------------------
select StudCity as City, concat(StudLastName, ', ',
StudFirstName) as Name
from
    Students
order by
    StudCity;
--------------------------------------------------------------
use BowlingLeagueExample;
--------------------------------------------------------------
--select TourneyLocation as Location, TourneyDate + 364 as
--'Tournament date'
--from Tournaments
--order by TourneyLocation;

--**** Look for how to add days to date in Mysql****--
--------------------------------------------------------------
select concat(BowlerLastName, ', ', BowlerFirstName) as
Name,BowlerPhoneNumber as 'Phone Number'
from
    Bowlers
order by
    BowlerLastName, BowlerFirstName;
--------------------------------------------------------------
select TeamID, concat(BowlerLastName, ', ', BowlerFirstName)
as Name
from
    Bowlers
order by
    TeamID;
--------------------------------------------------------------
