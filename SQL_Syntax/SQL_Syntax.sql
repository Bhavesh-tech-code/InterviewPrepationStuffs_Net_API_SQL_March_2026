--Use TestDB
--select * from Employee
--===========================================================================================================================
--Table creation with primary foreign relationship
--Drop table Employee_mst
-------------------------------------------------------------------------------------------------------------------------------------------
/*

create table department_mst
(
DeptId int primary key identity(1,1),
Description varchar(50)
)

Select * from department_mst

create table Employee_mst
(
EmpId int primary key identity(1,1),
Name varchar(50),
Address Varchar(100),
Mobile varchar(20),
DeptId int
foreign key (DeptId) references department_mst(DeptId)
)

*/
----------------------------------------------------------------------------------------------------------------------------------------------------
--=======================================================================================================================================================
/*

create table course_mst
(
 cid int Primary key identity(1,1),
 description varchar(50)
)

Select * from Department_mst
truncate table Department_mst

Insert into course_mst
(
  description
)
select 'Science'

create table student_mst
(
 sid int primary key identity(1,1),
 name varchar(50) not null,
 age int not null check (age >= 18),
 addmissiondate date default GetDate(),
 email varchar(50) unique,
 cid int not null foreign key references course_mst(cid)
)

drop table student_mst
Select * from course_mst
Select * from student_mst

insert into student_mst
(
   name, age, email,cid
)
Select 'kunal1', 18,'kumar2kunal1@gmail.com',3

*/
--=======================================================================================================================================================
/*
create table Employee2_mst
(
 sid int primary key identity(1,1),
 name varchar(50) not null,
 age int not null check (age >= 18),
 addmissiondate date default GetDate(),
 email varchar(50) unique,
 salary decimal(18,2)  default 5000,
 something char(10)
 cid int not null foreign key references course_mst(cid)
)
*/
----------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
--::Procedure Syntax-Without parameter::::::::----------------------------------------------------------------------------------------------------------

/*

create proc GetEmployee
as
begin
       Select * from Employee
End

Exec getEmployeeByid-----Call Procedure 
*/
--===========================================================================================================================
--===========================================================================================================================
------------------------------------------------------------------------------------------------------------------
--::Procedure With Parameter::::::::------------------------------------------------------------------------------------------------------------------
/*

create proc getEmployeeByid
(
@Empid int = 1
)
as
BEGIN
Select * from Employee where EmpId = @Empid
END

*/
--Exec getEmployeeByid 10
--===========================================================================================================================
--===========================================================================================================================
---------------------------------------------------------------------------------------------------------------------------
--Alter procedure With Parameter------------------------------------------------------------------------------------------------------------------
/*
alter proc getEmployeeByid
(
@Empid int = 1,
@EmpName varchar(50) = 'Amit'
)
as
BEGIN
Select * from Employee where EmpId = @Empid and EmpName =  @EmpName
END

Exec getEmployeeByid 1, 'amit'  -------------Call Procedure with column value in sequnce 
EXEC getEmployeeByid @EmpName = 'amit'; -----Call Procedure random coulumn name.
*/
--===========================================================================================================================
--===========================================================================================================================
--Key Clauses (In Order):-------------------------------------------------------------------------------------------------------------------------

/*

--1. SELECT
--2. FROM
--3. WHERE
--4. GROUP BY
--5. HAVING
--6. ORDER BY

--SELECT Department, COUNT(*) AS TotalEmp
--FROM Employee
--WHERE Salary > 30000
--GROUP BY Department
--HAVING COUNT(*) > 2
--ORDER BY TotalEmp DESC;
*/
--===========================================================================================================================
--===========================================================================================================================
----primary key and forein ley relasionship-----------------------------------------------------------------------------------------------------------------------

--CREATE TABLE Department (
--    DeptId INT PRIMARY KEY,
--    DeptName VARCHAR(50) NOT NULL
--);
----------------------------------------------------------------------

--    CREATE TABLE Employees (
--    EmpId INT PRIMARY KEY,
--    EmpName VARCHAR(50) NOT NULL,
--    Salary DECIMAL(10,2) CHECK (Salary > 10000),
--    DepartmentId INT,
--    FOREIGN KEY (DepartmentId) REFERENCES Department(DeptId)
--);

--select * from Employees
--select * from Department

--===========================================================================================================================
--===========================================================================================================================
---create view------------------------------------------------------------------------------------------------------------------------

--create view VEmployee
--as
--select * from Employee 

--select * from  VEmployee 
----------------------------------------------------------------------------
--create view V2Employee as
--select EmpId, EmpName, Department, Salary, ManagerId, JoinDate, Email
--from Employee 

--select * from  V2Employee   -----i have skip password in V2Employee
--===========================================================================================================================
--===========================================================================================================================
--UDF--------User Defined Functions------------------------------------------------------------------------------------------------------------------------
--Return Table from the UDF::: with and without paramenter

--create function fEmployee()
--returns Table
--as 
--return
--(
-- select * from Employee
--)

--Select * from  fEmployee()  ----Table-valued function ko ese call krtey hai.
-------------------------------------------------------------------------------------------------------------------

--create function ffEmployee(@depart varchar(50))
--Returns Table
--as
--return
--(
--Select * from employee where Department = @depart
--)

--Select * from ffEmployee('it')

--------------- -------------------------------------------------------------------------------------------------
--FUNCTION TO RETURN CURRENT DATETIME

--create function FCurrdatetime()
--returns datetime
--as
--begin
--   return  getdate();
--end;

--Select dbo.FCurrdatetime() -------Scalar-valued function ko ese call krtey hai.

---------------------------------------------------------------------------------------------------------------
--UDF returning only the parameters vlues:
--Functions retun only single value of table.
--we want here function to return two values it is not possible
--so we have cast the int to varchar firts then after merging then then we can retun

--Create FUNCTION FNEmployeeRetunParaValuesOnly(@id INT,@name VARCHAR(50))
--RETURNS VARCHAR(100)
--AS
--BEGIN
--    DECLARE @Result VARCHAR(100);
--    SET @Result = CAST(@id AS VARCHAR(10)) + ' -' + @name;    --//Concatenate int + string
--    RETURN @Result;
--END

--SELECT dbo.GetEmployeeFunction(1, 'Rupali') AS EmployeeInfo;

----------------------------------------------------------------------------------------------------------------------
--GetAgeBy Function with dateOf bIrth
--ShortCut but not Recomeded

--create function FNGetAgeByDOBB(@DOBB date)
--returns int
--as 
--Begin
--       Declare @result int
--       select  @result = DATEDIFF(YEAR,@DOBB,GETDATE())
--       return  @result
--ENd

--Select dbo.FNGetAgeByDOBB('1993-07-09')

----------------------------------------------------------------------------------------------------------------
--UDF for the the return age on input of DateOfBirth
--This Function is recomended for Get Age by DOB
--
--CREATE FUNCTION dbo.fn_GetAge(@DateOfBirth DATE)
--RETURNS INT
--AS
--BEGIN
--    DECLARE @Age INT;

--    SET @Age = DATEDIFF(YEAR, @DateOfBirth, GETDATE());

--    -- Check if birthday has occurred this year; if not, subtract 1
--    IF (MONTH(@DateOfBirth) > MONTH(GETDATE())) 
--       OR (MONTH(@DateOfBirth) = MONTH(GETDATE()) AND DAY(@DateOfBirth) > DAY(GETDATE()))
--    BEGIN
--        SET @Age = @Age - 1;
--    END

--    RETURN @Age;
--END;


----SELECT dbo.fn_GetAge('1993-07-09') AS Age;   ---> 32
----SELECT dbo.fn_GetAge('1993-07-09') AS Age;   ---> 32

--===========================================================================================================================
--===========================================================================================================================
---GETDATE()  function------------------------------------------------------------------------------------------------------------------------

--select GETDATE()  as FullDateTime
--Select cast( GETDATE() as date)  as date
--Select cast(GETDATE() as time)   as time -----------*****

--Select Convert(varchar,GetDate(),106)  as  cdate --05/oct/2025
--Select Convert(varchar,GetDate(),103)  as  cdate --dd/mm/yyyy
--Select Convert(varchar,GetDate(),108)  as currtime --24 hours  -----------*****
--Select Convert(varchar(5),GetDate(),108)  as currtime --24 hours  -----------*****
--Select right(Convert(Varchar,GETDATE(),100),7) CurrenTime  --Time With AM -- PM -----------*****
--Select Convert(Varchar,GETDATE(),100) CurrenTime -----------*****
--Select DATEDIFF(YEAR, '1995-10-06', GETDATE()) -----------*****

--select year(GETDATE()) as years
--select month(GETDATE()) as months
--select day(Getdate()) as dayss

--Select DATEPART(HOUR,GETDATE()) as hourss
--Select DATEPART(MINUTE,GETDATE()) as minutess
--Select DATEPART(SECOND,GETDATE()) as Seconds

--Select DATEADD(day,5,GETDATE()) as addFivedaysCurrentdate
--Select DATEADD(hour,-5,GETDATE()) as addFivedaysCurrentdate
--===========================================================================================================================
--===========================================================================================================================
---Triggers::::------------------------------------------------------------------------------------------------------------------------
--A Trigger is a special kind of stored procedure that,
--automatically executes when a specific event occurs(Insert,update,Delete) 
--on a table or database.

--Types of Triggers in SQL Server
--Trigger Type			     Event						Use case

--1.AFTER Trigger(DML)	     INSERT, UPDATE, DELETE	  --Event ke baad execute hota hai. 
                                                      --Main data changes ke baad kaam karta hai.
                                                    
--2.INSTEAD OF Trigger(DML)	 INSERT, UPDATE, DELETE		Event ke jagah execute hota hai. 
                                                      --Complex logic ke liye use hota hai,
                                                      --jaise view pe insert/update/delete.
                                                      --agar humne table pr instead of trigger
                                                      --laga diya hai delete ke liye to 
                                                      --koi bhi us table se data delete nahi
                                                      --kr payega.
                                                    
--3.DDL Trigger			    CREATE, ALTER, DROP,      --ON DATABASE/ALL SERVER FOR
                                                      --Database level changes monitor karne 
                                                      --ke liye.
                                                      --Agar humne kisi table pr DDL trigger 
                                                      --laga diya hai create ke to koi bhi
                                                      --us perticular database table hi create 
                                                      --nahi kr payega.
                                                      --agar alter ka trigger lagaya to alter 
                                                      --nahi kr payega table ko koi bhi 
                                                      --agar drop ka lagaya to drop nahi
                                                      --kr payega.

--4.Logon Trigger			LOGIN event				  --ON ALL SERVER FOR LOGON	
                                                      --Server login ke waqt execute hota hai.
-----------------------------------------------------------------------------------------------------------------

--CREATE TABLE EmployeeAudit 
--(
--    AuditId INT  PRIMARY KEY identity(1,1),
--    EmpId INT NOT NULL,
--    Action VARCHAR(50) NOT NULL,
--    ActionDate DATETIME NOT NULL,
--    FOREIGN KEY (EmpId) REFERENCES Employee(EmpId)
--);
--Select * from EmployeeAudit  ----like log table

--------------------------------------------------

--CREATE TRIGGER TriggerAfterInsertEmployee
--ON Employee
--AFTER INSERT
--as
--BEGIN
-- insert into EmployeeAudit
-- (
--   Empid, Action, ActionDate
-- ) 
-- select Empid,'Insert',GETDATE()
-- from inserted

--END;


--INSERT INTO Employee (EmpId, EmpName, Department, Salary, ManagerId, JoinDate, Email, Password)
--VALUES (33, 'Priyanka', 'HR', 45000, 6, '2023-03-12', 'priyanka@example.com', 'Priyanka@123');

--Select * from EmployeeAudit
-------------------------------------------------------------------------------------------------------------------
--create trigger TrEmployee
--on Employee
--After insert
--as
--begin
--      insert into EmployeeAudit
--      (
--        empid, Action, ActionDate
--      )

--      Select Empid, 'insert',GETDATE() from inserted
--      Select * from inserted  ---------------------------------Inserted Magic Table.
--End


--INSERT INTO Employee (EmpId, EmpName, Department, Salary, ManagerId, JoinDate, Email, Password)
--VALUES (34, 'Bhavesh', 'IT', 50000, 6, '2021-01-01', 'kumar2bhavesh@gmail.com', 'bhavesh@123');

--Select * from EmployeeAudit
--Select * from Employee

--Magic tables--------------------------------------------------------------

--TriggerType				INSERTED			DELETED
--INSERT					New rows			Empty
--UPDATE					New rows			Old rows
--DELETE					Empty				Deleted rows

----Instead of trigger------------------------------------------------------------------------------------------------------------

--CREATE TRIGGER trg_instead_of_delete
--ON Employee
--INSTEAD OF DELETE
--AS
--BEGIN
--    PRINT 'Delete is not allowed!';
--END;
--GO

--ab koi bhi Employee table mai se kuch delete nahi kr payega
--Select * from Employee
--delete from Employee where EmpId = 33

--Ye trigger DELETE ko replace karta hai aur message print karta hai.
--Data actually delete nahi hota unless manually handle karein.

------------------------------------------------------------------------------------------------------------------------
--DDL Trigger Syntax

--CREATE TRIGGER trg_DDL
--ON DATABASE
--FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
--AS
--BEGIN
--    PRINT 'DDL Trigger executed';
--END;
--GO
-----------------
--USE tempDB;
--GO

--CREATE TABLE DDL_Audit (
--    AuditID INT IDENTITY(1,1) PRIMARY KEY,
--    EventType NVARCHAR(100),
--    EventDate DATETIME,
--    EventData XML
--);


--USE tempDB;
--GO

--CREATE TRIGGER trg_CreateTable
--ON DATABASE
--FOR CREATE_TABLE
--AS
--BEGIN
--    PRINT 'CREATE TABLE trigger fired!';

--    INSERT INTO DDL_Audit(EventType, EventDate, EventData)
--    VALUES ('CREATE_TABLE', GETDATE(), EVENTDATA());
--END;
--GO


--CREATE TABLE TestTableTrigger 
--(
--ID INT,
--Name varchar(50)
--);

--Select * from DDL_Audit
--Select * from TestTableTrigger   ----but trigger bann gaya 
--------------------------------------------------------------------------------------------
--But mai chahta hu ki table create na ho Database mai to  uske liye trigger banana hai 

--CREATE TRIGGER trg_BlockCreateTable
--ON DATABASE
--FOR CREATE_TABLE
--AS
--BEGIN
--    PRINT 'Table creation is not allowed in this database!';
--    ROLLBACK;  -- stops the CREATE TABLE operation
--END

--CREATE TABLE TestBlocked (ID INT);  --ab table nahi bana ----********

--Select * from TestBlocked

-----------------------------------------
--DROP TRIGGER trg_BlockCreateTable
--ON DATABASE;
-----------------------------------------
------------------------------------------------------------------------------------------------------------
--Logon Trigger Syntax

--CREATE TRIGGER trg_Logon
--ON ALL SERVER
--FOR LOGON
--AS
--BEGIN
--    PRINT 'User logged in!';
--END;
--GO

----===========================================================================================================================
----===========================================================================================================================
--What is an Index?---------------------------------------------------------------------------------------------------------------------------

--Clustered Index(1) 
--Physically sorts and stores data rows in the table according to the index key.  
--Data is physically stored in the order of the index.
--Sorts and stores the data rows physically in order of the key.  
--Only 1 per table. 
--Usually created automatically when you define a PRIMARY KEY.

--When you define a PRIMARY KEY, 
--a clustered index is automatically created 
--(unless another clustered index exists).

--Syntax::::::

--create clustered index CIEmployee
--ON Employee(Empid)

--SELECT * FROM Employee WHERE EmpId = 20;
--SQL Server finds this record instantly without scanning the full table.

-------------------------------------------------------------------------------------------------------------------

--Non-Clustered Index(2)        
--Creates a separate structure (index table) that stores a copy of key columns 
--and a pointer to the actual data.
--Does not change physical order of data.
--We can create multiple non-clustered indexes on a table.

--Syntax::::::

--Create nonclustered index NCIEmployee
--ON Employee(Department)

--select * from Employee where department = 'IT'
--Improve search by Department

--SQL Server will use the IX_Employee_Department index to quickly locate rows
--instead of scanning all employees.
--===========================================================================================================================
--===========================================================================================================================
--Transactions----------------------------------------------------------------------------------------------------------------------
--
--Ensure data consistency, integrity, and reliability during multiple database operations.
--यह data consistency सुनिश्चित करने के लिए use होता है —
--यानी अगर बीच में error आ जाए तो पूरा transaction rollback हो जाए।

--Syntax (Transaction with TRY...CATCH)::::::::::

--Begin Try

--     Begin Transaction     -- Transaction Start

--     --Insert qeurry
--     --update qeurry
--     --Delete qeurry

--     commit Transaction    --If no error, commit changes

--end Try
--begin catch

--     IF @@TRANCOUNT > 0     --Check karta hai ki koi active transaction hai ya nahi

--     Rollback Transaction   --If error occurs, rollback transaction

--     print 'Error Occured' + Error_message();
--     PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR(10));

---end catch
---------------------------------------------------------------------------------------------------------------------------------
--Example: Error Handling Demo---------------------------------------------------------------------------------------------------------------------
--BEGIN TRY
--    BEGIN TRANSACTION;

--    INSERT INTO Department(DeptId, DeptName)
--    VALUES (7, 'Support2');

--    -- ❌ This will cause error if EmpId = 1 already exists
--    INSERT INTO Employee(EmpId, EmpName, Department, Salary)
--    VALUES (1, 'Amit', 'IT', 50000);

--    COMMIT TRANSACTION;
--END TRY

--BEGIN CATCH
--    --IF @@TRANCOUNT > 0        --Check karta hai ki koi active transaction hai ya nahi
--        ROLLBACK TRANSACTION;   --If error occurs, rollback transaction

--    PRINT 'Transaction Failed: ' + ERROR_MESSAGE();
--END CATCH;
---------------------------------------------------
--Select * from Department
--Select * from Employee

--Transaction Failed: Violation of PRIMARY KEY constraint 'PK__Departme__014881AE93BAE62A'.
--Cannot insert duplicate key in object 'dbo.Department'. The duplicate key value is (1).
----------------------------------------------------------------------------------------------------------------
--===========================================================================================================================
--===========================================================================================================================
--ACID Properties------------------------------------------------------------------------------------------------------------------------
--SQL Server (ya kisi bhi RDBMS) me Transactions ko reliable banane
--ke liye ACID properties ka concept use hota hai.

--1. Atomicity::::::: (All or Nothing)
--Transaction control (COMMIT/ROLLBACK)
--Iska matlab hota hai transaction ya to puri tarah complete hoga, ya bilkul nahi hoga.
--Agar beech me koi error aata hai to rollback ho jata hai (partial update nahi hoti).
---------------------------------
--BEGIN TRANSACTION;
--UPDATE Account SET Balance = Balance - 500 WHERE AccId = 1; -- Debit
--UPDATE Account SET Balance = Balance + 500 WHERE AccId = 2; -- Credit
--IF @@ERROR <> 0
--ROLLBACK TRANSACTION;
--ELSE
--    COMMIT TRANSACTION;
--Agar koi bhi UPDATE fail hota hai, dono rollback ho jayenge.
----------------------------------
--2. Consistency:::::::
--Consistency ka matlab hai ki transaction ke baad database valid state me rahe.
--Matlab constraints, rules, triggers sab maintain rahein.
--Transaction ke baad bhi or pehle bhi same conditon mai ho 
----------------------------------
--3. Isolation
--Multiple transactions parallel chal sakte hain,
--par unke data ek dusre ko affect nahi karne chahiye jab tak transaction commit na ho jaye.
--SQL Server me different isolation levels hote hain:
--Types of Isolation Levels (Read Uncommitted, Read Committed, Repeatable Read, Serializable).
----------------------------------
--4. Durability
--Once transaction commit ho gaya, to system failure (power off, crash) 
--ke baad bhi data lost nahi hota.
--SQL Server me ye transaction log ke through ensure hota hai.

--Example:::::

--CREATE TABLE Accounts (
--    AccId INT PRIMARY KEY,
--    AccName VARCHAR(50),
--    Balance DECIMAL(10,2) CHECK (Balance >= 0) -- Consistency rule
--);

--INSERT INTO Accounts VALUES (101, 'Amit', 1000.00);
--INSERT INTO Accounts VALUES (102, 'Priya', 2000.00);

--BEGIN TRY
--    BEGIN TRANSACTION;  -- Transaction Start (Atomicity)
--    -- 🔹 Step 1: Deduct ₹500 from Amit's Account
--    UPDATE Accounts SET Balance = Balance - 500 WHERE AccId = 101;
--    -- 🔹 Step 2: Credi0t ₹500 to Priya's Account
--    UPDATE Accounts SET Balance = Balance + 500 WHERE AccId = 102;
--    -- 🔹 Step 3: Check Consistency (Balance cannot be negative)
--    IF EXISTS 
--            (
--              SELECT 1 FROM Accounts WHERE Balance < 0
--            )
--    BEGIN
--        THROW 50001, 'Balance cannot be negative', 1;
--    END

--    COMMIT TRANSACTION;  -- ✅ All OK → Save permanently (Durability)
--    PRINT 'Transaction Successful';
--END TRY

--BEGIN CATCH
--    ROLLBACK TRANSACTION;  -- ❌ Error → Undo all (Atomicity)
--    PRINT 'Transaction Failed: ' + ERROR_MESSAGE();
--END CATCH;


--Select * from Accounts

--Interview Tips
--Difference between COMMIT and ROLLBACK.
--Types of Isolation Levels (Read Uncommitted, Read Committed, Repeatable Read, Serializable).
--===========================================================================================================================
--===========================================================================================================================
--===========================================================================================================================
--===========================================================================================================================
--What is Isolation Level?
--Isolation level define karta hai kaise ek transaction doosre transaction 
--ke data changes ko dekh sakta hai.
--Basically: it controls transaction concurrency and consistency.

--SQL Server me 5 main isolation levels hote hain.
/*
Isolation           Level      Description	            DirtyRead   NonRepeatableRead 	PhantomRead
Read Uncommitted	Transactions read uncommitted data.	 Yes	        Yes	            Yes
Read Committed	    Default level. Transactions read     No	            Yes	            Yes
                    only committed data.	
Repeatable Read  	Prevents dirty and non-repeatable    No	            No	            Yes
                    reads by locking read data.	
Serializable	    Highest isolation. Prevents dirty,
                    non-repeatable, and phantom reads.	 No	            No	             No
Snapshot	        Reads data as it existed at the      No	            No	             No
                    start of the transaction 
                    (row versioning).	


Explanation of Read Phenomena
Dirty Read → Transaction reads uncommitted changes of another transaction.
Non-Repeatable Read → Same query returns different results within the same transaction because another transaction modified data.
Phantom Read → New rows are added/deleted by another transaction, changing the result set.

Interview Tip:
Agar tumse pucha jaaye “Which isolation level to use?”
Answer:
“Depends on requirement — for performance use Read Uncommitted,
for data correctness use Serializable or Snapshot.”
Isko or deep mai padhne ki jarurat hai abhi yputube se ya chat GPT se hi 
maine abhi simple names likhe hai sirf.
*/

--===========================================================================================================================
--===========================================================================================================================
--===========================================================================================================================
--===========================================================================================================================
--Performance Optimization-------------------------------------------------------------------------------------------------------------------------
--Enhance the speed and efficiency of database operations.
--Use Execution Plan to analyze query performance.
--Use Indexes appropriately.
--Avoid SELECT * — fetch only required columns.
--Use Proper Joins and Filtering conditions.
--Keep statistics updated.

--Interview Tips
--How to identify slow queries (e.g., Query Store, Profiler).
--How indexing improves

--===========================================================================================================================
--===========================================================================================================================
--Window functions-------------------------------------------------------------------------------------------------------------------------
--1. ROW_NUMBER()::::::
--Assigns a unique sequential number to each row starting from 1 — no duplicates.
--Here, no skipped ranks (1, 2, 3, 4, 5, 6).

--SELECT EmpName,Department,Salary,
--ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNum
--FROM Employee;

--Even if two employees have the same salary, they get different RowNum values.
------------------------------------------------------------
--2. RANK() ::::::::
--Assigns a rank to each row, with gaps in ranking when there are ties (same values).
--skipes the rank values of dublicate and provide the same rank to it.
--Here, skipped ranks (1, 2, 3, 3, 5).

--SELECT EmpName,Department,Salary,
--RANK() OVER (ORDER BY Salary DESC) AS RankNum
--FROM Employee;
    
--Notice the gap after rank 2 — because two employees shared the same salary.
------------------------------------------------------------
--3. DENSE_RANK()
--Similar to RANK(), but no gaps in ranking for ties.
--Here, no skipped ranks (1, 2, 3, 3, 4, 5).

--SELECT EmpName,Department,Salary,
--DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRankNum
--FROM Employee;

--Interview Tip:
--Question: “What’s the difference between RANK() and DENSE_RANK()?”
--Answer: RANK() leaves a gap after duplicate ranks, while DENSE_RANK() doesn’t.
--===========================================================================================================================
--===========================================================================================================================
--Temporary Tables & Table Variables-------------------------------------------------------------------------------------------------------------------------

--1. Local(#) Temporary Tables
--Visible only to the current session, Deleted automatically when session ends
--same session ka mtlb hai same connection matlb same tab se
--Same tab mai select hoga but other table mai select nahi hoga.

--drop table if exists #TempTable
--CREATE TABLE #TempTable (
--    ID INT,
--    Name VARCHAR(50)
--);
--INSERT INTO #TempTable VALUES (1, 'Amit');
--SELECT * FROM #TempTable;
---------------------------------------------------------------------
--2. Global(##) Temporary Table
--Visible to all sessions,	Deleted when all sessions using it are closed
--Same tab mai bhi select hoga and other tab mai bhi select hoga.
--Even agar same svn se connect hai systems to other system pr bhi Run(select)hoga.

--drop table if exists ##TempTable
--CREATE TABLE ##TempTable (
--    ID INT,
--    Name VARCHAR(50)
--);

--INSERT INTO ##TempTable VALUES (1, 'Amit');
--SELECT * FROM ##TempTable;
----------------------------------------------------------------------
--3.able Variables(@Table)
--Table Variables are variables that hold table-type data.
--They are stored in memory (mostly) and are limited to batch/scope 
--(like inside a function or stored procedure). 
--aap separate chalana chahoge table variable ko create krne ke baad to nahi chlta hai.
--Matlb agar aap chaho ki select karu table variable to nahi hoga 
--aapko table ke structure and insert querry then select statement sbb ek sath chalana hoga.
-- and ye automatically turant drop ho jata hai.

--Declare @Employee Table 
--(
--  EmpId INT,
--    EmpName VARCHAR(50),
--    Department VARCHAR(50)
--)

--INSERT INTO @Employee VALUES (1, 'Amit', 'IT'), (2, 'Priya', 'HR')
--Select * from @Employe
---------------------
--DECLARE @Employee TABLE 
--(
--EmpID INT, 
--EmpName VARCHAR(50)
--)

--INSERT INTO @Employee VALUES (1, 'Raj')

----Select * from @Employee

--SELECT name, create_date
--FROM tempdb.sys.objects
--WHERE type = 'U'
--ORDER BY create_date DESC    
-------------------------------------------------------------------------------------------------------------
--Difference Between Temporary Table and Table Variable
--Feature	Temporary Table (#Temp)	Table Variable (@Table)
--Prefix	# or ##	@
--Scope	Session or connection	Batch or function
--Stored in	tempdb	tempdb (but managed differently)
--Transactions	Can be rolled back	Cannot be rolled back fully
--Indexes	Can create indexes	Only Primary Key / Unique constraints
--Statistics	Supported (query optimizer can use them)	Limited or no statistics
--Performance	Better for large datasets	Better for small datasets
--Used in Stored Proc	Can be reused across dynamic SQL	Scope limited strictly to that batch
--⚡ Example: Difference in Use
---- Temporary Table Example
--CREATE TABLE #EmpTemp (Id INT, Name VARCHAR(50));
--INSERT INTO #EmpTemp VALUES (1, 'Amit');
--SELECT * FROM #EmpTemp;

---- Table Variable Example
--DECLARE @Emp TABLE (Id INT, Name VARCHAR(50));
--INSERT INTO @Emp VALUES (1, 'Amit');
--SELECT * FROM @Emp;

--🧠 Interview Tips:

--Q: Can you use a table variable inside a transaction?
--A: Yes, but rollback won’t affect table variable data.

--Q: Where are temporary tables stored?
--A: In the tempdb database.

--Q: Which one is faster — temp table or table variable?
--A: For small data, table variable is faster.
--For large data, temp table is better (because of indexing & stats).
--===========================================================================================================================
--===========================================================================================================================
----------------------------------------------------------------------------------------
--CTE--(Common Table Expression)-------------------------------------------------------------------------------------------------------------------------
/*
Q. Why we use CTE what is the pupose, when we have temp tables by which we can do all.
1. What is a CTE?:::::::
A CTE (Common Table Expression) is a temporary, named result set that you can reference within a single SQL statement.
Syntax example:

WITH CTE_Name AS (
    SELECT EmpId, EmpName, Salary
    FROM Employees
    WHERE Salary > 50000
)
SELECT *
FROM CTE_Name
WHERE EmpName LIKE 'A%';

2. Purpose of CTE:::::::
CTEs are primarily used for:
A. Improved Readability
Instead of writing complex nested queries, you can name intermediate results for easier understanding.
Makes SQL more modular and clean.
Example:

WITH HighSalary AS (
    SELECT EmpId, EmpName, Salary
    FROM Employees
    WHERE Salary > 50000
)
SELECT EmpName
FROM HighSalary
WHERE EmpName LIKE 'A%';

This is much cleaner than embedding the subquery directly inside another query.
----------------------------------------
B. Recursive Queries
CTEs can be recursive, which temp tables cannot do easily.
Useful for hierarchy data, tree structures, organizational charts, etc.
Example:

WITH EmployeeHierarchy AS (
    SELECT EmpId, EmpName, ManagerId
    FROM Employees
    WHERE ManagerId IS NULL

    UNION ALL

    SELECT e.EmpId, e.EmpName, e.ManagerId
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerId = eh.EmpId
)
SELECT * FROM EmployeeHierarchy;


This recursively lists all employees under managers.
-----------------------------------------------------------------------------------------------------------
C. Temporary Scope for Single Query
CTE exists only for the duration of the query.
No need to explicitly drop it (unlike temp tables).
-----------------------------------------------------------------------------------------------------------
D. Avoid Repetition
If the same subquery is needed multiple times, CTE avoids duplication in code and improves readability.
-----------------------------------------------------------------------------------------------------------
E. Simplify Complex Joins
Breaking down complex joins into logical steps makes debugging easier.
3. Why not just use Temporary Tables?:::::::::::
While temp tables (#TempTable) are powerful, they differ from CTEs:

Feature	    CTE	                                Temporary Table
Scope	    Only for single query	            Available for multiple queries
Storage	    In-memory (not physically stored)	Stored in tempdb
Performance	Fast for small datasets         	Better for large datasets or indexes
Recursion	Supported	                        Not directly supported
Creation	No CREATE statement required	    Must explicitly create and drop
Use case	Simplifying queries, recursion  	Complex processing across queries

Example:
If you want hierarchy processing → CTE is the best choice.
If you need to use the result across multiple queries or sessions → Temp Table is better.

Rule of Thumb:
Use CTE for readability, recursion, and single-query logic.
Use Temp Tables when data must be reused across queries, indexed, or manipulated extensively.
*/
--===========================================================================================================================
--===========================================================================================================================
--Pivot & Unpivot-------------------------------------------------------------------------------------------------------------------------
/*
CREATE TABLE SalesData (
    Year INT,
    Product VARCHAR(10),
    Sales INT
);

INSERT INTO SalesData (Year, Product, Sales) VALUES
(2023, 'A', 100),
(2023, 'B', 200),
(2023, 'C', 300),
(2024, 'A', 150),
(2024, 'B', 250),
(2024, 'C', 350);

Select * from SalesData

----------------------------------------------------------------------------------------------------------------
1. PIVOT
Purpose: Transforms rows into columns.
Use case: When you want to convert row data into a summarized columnar format.

--Select * from SalesData

Implement PIVOT
Goal:
We want products (A, B, C) to be columns and years as rows.

SELECT Year, Product, Sales
FROM SalesData;

--Write PIVOT query

SELECT Year, [A], [B], [C]
FROM
(
    SELECT Year, Product, Sales
    FROM SalesData
) AS SourceTable
PIVOT
(
    SUM(Sales)
    FOR Product IN ([A], [B], [C])
) AS PivotTable;


SUM(Sales) → Aggregate function. Pivot requires aggregation.
FOR Product IN (...) → Which values in Product column should become columns.

Key Notes on PIVOT
You must specify columns explicitly ([A], [B], [C]).
Aggregation is mandatory — pivoting requires summarizing.
Useful for reports, dashboards, cross-tab analysis.
--------------------------------------------------------------------------------------------------------------

2. UNPIVOT
Purpose: Transforms columns into rows.
Use case: When you want to normalize a table by converting columns into attribute-value pairs.


Implement UNPIVOT
Goal:
Reverse pivot — take column-based products (A, B, C) back to row format.
a) Create pivoted table
We can store the pivot result into a table for demonstration.

--CREATE TABLE SalesPivot (
--    Year INT,
--    A INT,
--    B INT,
--    C INT
--);

--INSERT INTO SalesPivot (Year, A, B, C) VALUES
--(2023, 100, 200, 300),
--(2024, 150, 250, 350);



SELECT Year, Product, Sales
FROM
(
    SELECT Year, A, B, C
    FROM SalesPivot
) AS Src
UNPIVOT
(
    Sales FOR Product IN (A, B, C)
) AS Unpvt;



Explanation:
Sales FOR Product IN (...) → Sales becomes the value column, Product becomes attribute column.
UNPIVOT flips columns into rows.

Now the pivoted table is unpivoted back to the original form.


Visual Summary:::
Operation       	Result
PIVOT	            Rows → Columns
UNPIVOT	            Columns → Rows

uick Tip:
Use PIVOT when you want to summarize or transpose row data into columns.
Use UNPIVOT when you want to reverse a pivot, making data long and narrow again.
*/

--===========================================================================================================================
--===========================================================================================================================
---------------------------------------------------------------------------------------------------------------------------












