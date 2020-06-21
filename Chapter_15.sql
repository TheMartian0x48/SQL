/**
 * @Author: ADITYA KUMAR SINGH <the__martian>
 * @Email:  cr7.aditya.cs@gmail.com
 * @Filename: Chapter_15.sql
 */

-----------------------------------------------------------------
              I N T E R N A L  P R O B L E M S
-----------------------------------------------------------------
/*
“Change products by increasing the retail price by 10 percent.”
*/
update
    Products
set
    price = price + (price + 0.1 * price);
-----------------------------------------------------------------
/*
“Modify products by increasing the retail price by 4 percent for
products that are clothing (category 3).”
*/
update
    Products
set
    RetailPrice = RetailPrice * 1.04
where
    CategoryID = 3;
-----------------------------------------------------------------
/*
“Modify classes by changing the classroom to 1635 and the
schedule dates from Monday-Wednesday-Friday to Tuesday-Thursday-
Saturday for all drawing classes (subject ID 13).”
*/
UPDATE
    Classes
SET
    ClassRoomID = 1635,
    MondaySchedule = 0,
    WednesdaySchedule = 0,
    FridaySchedule = 0,
    TuesdaySchedule = 1,
    ThursdaySchedule = 1,
    SaturdaySchedule = 1
WHERE
    SubjectID = 13;
-----------------------------------------------------------------
/*
“Modify products by increasing the retail price by 4 percent for
products that are clothing.”
*/
UPDATE
    Products
SET
    RetailPrice = RetailPrice * 1.04
WHERE
    CategoryID =
    (
        SELECT
            CategoryID
        FROM
            Categories
        WHERE
            CategoryDescription = 'Clothing'
    );
-----------------------------------------------------------------
/*“Modify classes by changing the classroom to 1635 and the
schedule dates from Monday-Wednesday-Friday to Tuesday-Thursday-
Saturday for all drawing classes.”
*/
update
    Classes
set
    ClassRoomID = 1635,
    MondaySchedule = 0,
    WednesdaySchedule = 0,
    FridaySchedule = 0,
    TuesdaySchedule = 1,
    ThursdaySchedule =1,
    SaturdaySchedule = 1
where
    SubjectID in (
        select
            SubjectID
        from
            Subjects
        where
            SubjectName = 'Drawing'
    );
-----------------------------------------------------------------
/*
“Change the classes table by setting the start time to 2:00 PM
for all classes taught by Kathryn Patterson.”
*/
update
    Classes
set
    StartTime = '14:00:00'
where
    ClassID in (
        select
            ClassID
        from
            Staff S
        inner join
            Faculty_Classes FC
            on FC.StaffID = S.StaffID
        where
            S.StfFirstName = 'Kathryn'
            and
            S.StfLastname = 'Patterson'
    );
-----------------------------------------------------------------
/*
“Change the orders table by setting the order total to the sum
of quantity ordered times quoted price for all related order
detail rows.”
*/
update
    Orders
set
    OrderToal = (
        select
            sum(OD.QuantityOrdered * OD.QuotedPrice)
        from
            Order_Details OD
        where
            OD.OrderNumber = Orders.OrderNumber
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
