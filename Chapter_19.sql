/**
 * @Author: ADITYA KUMAR SINGH <the__martian>
 * @Email:  cr7.aditya.cs@gmail.com
 * @Filename: Chapter-19.sql
 */

-----------------------------------------------------------------
              I N T E R N A L  P R O B L E M S
-----------------------------------------------------------------
use SchoolSchedulingExample;
-----------------------------------------------------------------
/*
“Prepare a list of IDs, student names, and the gender of the
student spelled out.”
*/
select
    S.StudentID,
    concat(S.StudFirstName, ' ', S.StudLastName) Name,
    case S.StudGender
        when 'M'
            then "Male"
        when 'F'
            then "Female"
        else
            "Unspecified"
    end as Gender
from
    Students S;
-----------------------------------------------------------------
/*
“Modify the students table by setting the grade point average to
the sum of the credits times the grade divided by the sum of the
credits.”
*/
update Students
set
    S.StudGPA = (
        select
            round(sum(C.Credits * SS.Grade)/sum(C.Credits), 3)
        from
            Classes C
        inner join
            Student_Schedules SS
            on C.ClassID = SS.ClassID
        where
            SS.ClassStatus = 2
            and
            SS.StudentID = S.StudentID
    );
-----------------------------------------------------------------
/*
“Display for all students the Student ID, first name, last name,
the number of classes completed, the total credits, and the grade
point average for classes that were completed with a grade of 67
or better.”
*/
select
    S.StudentID,
    S.StudFirstName,
    S.StudLastName,
    count(SClasses.StudentID) as NumberOfClasses,
    sum(SClasses.credits) as TotalCredits,
    case count(SClasses.StudentID)
        when 0
            then 0
        else
            round(sum(SClasses.Credits * SClasses.Grade) /
            sum(SClasses.Grade), 3)
    end as GPA
from
    Students S
inner join
    (
        select
            SS.StudentID,
            SS.Grade,
            C.Credits
        from
            Student_Schedules SS
        inner join
            Classes C
            on C.ClassID = SS.ClassID
        inner join
            Student_Class_Status SCS
            on SCS.ClassStatus = SS.ClassStatus
        where
            SCS.ClassStatusDescription = 'Completed'
            and
            SS.Grade >= 65
    ) as SClasses
    on S.StudentID = SClasses.StudentID
group by
    S.StudentID,
    S.StudFirstName,
    S.StudLastName;
-----------------------------------------------------------------
/*
“For all staff members, list staff ID, first name, last name,
date hired, and length of service in complete years as of October
1, 2017, sorted by last name and first name.”
*/
select
    S.StaffID,
    S.StfFirstName,
    S.StfLastname,
    year(cast('2017-10-01' as date)) - year(S.DateHired) -
        case
            when month(S.DateHired) < 10
                then 0
            when month(S.DateHired) > 10
                then 1
            when day(S.DateHired) > 1
                then 1
            else
                0
        end as LenghtOfService
from
    Staff S
order by
    S.StaffID,
    S.StfFirstName,
    S.StfLastname;
-----------------------------------------------------------------
/*
“Create a student mailing list that includes a generated
salutation, first name and last name, the street address, and a
city, state, and ZIP code field.”
*/
select
    concat(
    case
        when S.StudGender = 'M'
            then 'Mr. '
        when S.StudMaritalStatus = 'S'
            then 'Ms. '
        else
            'Mrs. '
    end, S.StudFirstName, S.StudLastName) as Name,
    S.StudStreetAddress,
    S.StudCity,
    S.StudState,
    S.StudZipCode
from
    Students S;
-----------------------------------------------------------------
/*
“List all students who are ‘Male’.”
*/
select
    S.StudentID,
    S.StudFirstName,
    S.StudLastName,
    "Male" as Gender
from
    Students S
where
    "Male" = case S.StudGender
                when 'M'
                    then "Male"
                else
                    "Nomatch"
                end;
-----------------------------------------------------------------
                    P R A T I C E - Q U E S T I O N
-----------------------------------------------------------------
use SalesOrdersExample;
-----------------------------------------------------------------
/*
“List all products and display whether the product was sold in
December 2017.”
*/
select
    P.ProductNumber,
    P.ProductName,
    case
        when P.ProductNumber in (
            select
                OD.ProductNumber
            from
                Order_Details OD
            inner join
                Orders O
                on O.OrderNumber = OD.OrderNumber
            where
                O.OrderDate between cast('2017-12-01' as date)
                and cast('2017-12-31' as date)
        )
            then "Ordered"
        else
            "Not Ordered"
    end as "Sells"
from
    Products P;
-----------------------------------------------------------------
/*
“Display products and a sale rating based on number sold (poor
<= 200 sales, Average > 200 and <= 500, Good > 500 and <= 1000,
Excellent > 1000).”
*/
select
    P.ProductNumber,
    P.ProductName,
    case
        when sum(OD.QuantityOrdered) > 1000
            then "Excellent"
        when sum(OD.QuantityOrdered) > 500
            then "Good"
        when sum(OD.QuantityOrdered) > 200
            then "Average"
        else
            "Poor"
    end as Rating
from
    Products P
left join
    Order_Details OD
    on P.ProductNumber = OD.ProductNumber
group by
    P.ProductNumber,
    P.ProductName;
-----------------------------------------------------------------
use EntertainmentAgencyExample;
-----------------------------------------------------------------
/*
“List entertainers and display whether the entertainer was
booked on Christmas 2017 (December 25).”
*/
select
    E.EntertainerID,
    E.EntStageName,
    case
        when E.EntertainerID in (
            select
                EN.EntertainerID
            from
                Engagements EN
            where
                EN.StartDate <= cast('2017-12-25' as date)
                and
                EN.EndDate >= cast('2017-12-25' as date)
        )
            then "Booked"
        else
            "Not booked"
        end as "Is booked on 2017-12-25"
from
    Entertainers E;
-----------------------------------------------------------------
/*
“Find customers who like Jazz but not Standards (using Searched
CASE in the WHERE clause).”
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
