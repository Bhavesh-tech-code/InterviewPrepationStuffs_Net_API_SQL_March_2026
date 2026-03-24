--database name----------Use TestDB--------------------------------------------------------------------------------------------------------------------------------------

--SELECT * FROM Employee 
--SELECT * FROM Employee ORDER BY Salary DESC;

--===Find Nth salary=============================================================================================================================
----Select * from Employee

--Select * from Employee order by salary desc

--;with CTE as
--(
-- select salary, DENSE_RANK() over(order by salary desc) as Srank
-- from Employee
--)

--select salary from CTE where Srank = 2

----------------------------------------------Ratna Priya------
----Select * from 
----(
----Select salary, dense_rank() over (order by salary desc) as DRank
----from Employee
----) as A where DRank  = 2
---------------------------------------------------------------------------------------------------------
--How to find the employee with third MAX Salary using a SQL query
--without using Analytic Functions?

--SELECT TOP 1 *
--FROM Employee
--WHERE Salary < (
--    SELECT MAX(Salary)
--    FROM Employee
--    WHERE Salary < (
--        SELECT MAX(Salary)
--        FROM Employee
--    )
--)
--ORDER BY Salary DESC;

----------------------------------
--SELECT TOP 1 Salary
--FROM (
--    SELECT DISTINCT TOP 3 Salary
--    FROM Employee
--    ORDER BY Salary DESC
--) AS Temp
--ORDER BY Salary ASC;


-----------------------------------------------------------------------------------------------------------------------------
--SELECT *
--FROM Employee
--WHERE Salary > (SELECT AVG(Salary) FROM Employee)
--AND Department = 'IT'
--AND Active = 1;
----------------------------------------------------------------------------------------------------------
--Select * from Employee

--select max(salary) 
--from Employee
--where salary < (select max(salary) from Employee)
--=============================================================================================================================================
----Delete dublicate record-------------------------------------------------------------------------------------------------------------------------------------

--Select * from Employee

--;with CTE as
--(
--  select EmpId, EmpName, 
--   ROW_NUMBER() over(partition by EmpName order by EmpId) as RN
--  from Employee
--)

--Delete from Employee where EmpId IN(Select EmpId from CTE where RN > 1)
-----------------------------------------------------------------------------------------------------------------------------------------
--==Find Dublicate Record=============================================================================================================================================
--Select * from Employee

--select EmpName ,count(*) as DubRec
--from Employee
--group by empName
--having count(*) > 1
-------------------------------------------
--select * from 
--(
--Select Email,
--count(*) over(partition by Email order by Email) as DuplicateEmail
--from Employee 
--) as A where DuplicateEmail > 1
--===========================================================================================================================================
-----Find Dublicate Email-------------------------------------------------------------------------------------------------------------------------------------------
--Select * from Employee

--select Email, count(*) dubEmail
--from Employee
--group by Email
--having count(*) > 1
--================================================================================================================================
--Select * from Employee

--select department, max(salary) as maxsalryDepWise
--from Employee
--group by department
--=========================================================================================================================================
----No. of Employee in Each Department.---------------------------------------------------------------------------------------------------------------------------------------
--Select * from Employee

--select department, count(empid) as NoOfEmpEachDeprt
--from Employee
--group by department
--=========================================================================================================================================
-----Everage Salary department wise--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--SELECT Department, AVG(Salary) AS AvgSalary
--FROM Employee
--GROUP BY Department;
-------------------------------------------------------------------------------------------------------------------------------------------------
--=================================================================================================================================================
--Find highest and lowest salary:-----------------------------------------------------------------------------------------------------------------------------------------------
--SELECT MAX(Salary) AS MaxSal, MIN(Salary) AS MinSal
--FROM Employee;
--==================================================================================================================================================
----salary greater than 50000----------------------------------------------------------------
--SELECT * FROM Employee WHERE Salary > 60000;
--==================================================================================================================================================
---Sorting:-----------------------------------------------------------------------------------------------------------------------------------------------
--SELECT * FROM Employees ORDER BY Salary DESC;

--==================================================================================================================================================
---Find total employees:-----------------------------------------------------------------------------------------------------------------------------------------------
--SELECT COUNT(EmpId) FROM Employee;
--SELECT COUNT(*) FROM Employee;
--==================================================================================================================================================
---Employees with their managers (Self Join):-----------------------------------------------------------------------------------------------------------------------------------------------
--select * from Employee

--select E.EmpName as Employee, M.EmpName as Manager 
--from Employee E
--left join Employee M ON E.ManagerId = M.EmpId

--==================================================================================================================================================
----Find employees earning more than Average Salary----------------------------------------------------------------------------------------------------------------------------------------------
--select avg(salary) from Employee

--select EmpName,salary 
--from Employee 
--where salary > (select avg(salary) from Employee) 

--==================================================================================================================================================
----Find top 3 highest paid employees:----------------------------------------------------------------------------------------------------------------------------------------------
--Select * from Employee order by salary desc

--Select top 3 salary
--from Employee order by salary desc

--==================================================================================================================================================

--SELECT * FROM Employee WHERE Department = 'IT' AND Salary > 50000 ORDER BY JoinDate DESC;
--SELECT TOP 5 * FROM Employee ORDER BY JoinDate DESC; 

--==================================================================================================================================================
---Find nth highest salary (say 2nd highest):-----------------------------------------------------------------------------------------------------------------------------------------------

--SELECT DISTINCT Salary
--FROM Employee e1
--WHERE 2 = (
--    SELECT COUNT(DISTINCT Salary) 
--    FROM Employee e2 
--    WHERE e2.Salary >= e1.Salary
--)

--==================================================================================================================================================
--Salary rank of employees within department:

--SELECT EmpName, Department, Salary,
--RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS RankInDept
--FROM Employee;

--==================================================================================================================================================
--------------------------------------------------------------------------------------------------------------------------------------------------
----Running total of salaries:
--SELECT EmpName, Salary,
--SUM(Salary) OVER (ORDER BY JoinDate) AS RunningTotal
--FROM Employee;

--==================================================================================================================================================
--------------------------------------------------------------------------------------------------------------------------------------------------
----Employees joined in last 1 year:
--Select  DATEADD(YEAR, -1, GETDATE());

--SELECT * 
--FROM Employee 
--WHERE JoinDate >= DATEADD(YEAR, -1, GETDATE());

--==================================================================================================================================================
--------------------------------------------------------------------------------------------------------------------------------------------------
--Employee ka naam aur uska department lana. Agar employee ka department assign hi nahi hai to result me nahi aayega.
--SELECT e.EmpName, d.DepartmentName
--FROM Employees e
--INNER JOIN Departments d ON e.DepartmentId = d.DepartmentId;


--==================================================================================================================================================
--------------------------------------------------------------------------------------------------------------------------------------------------
--Aise employees bhi dikhana jo abhi kisi department me assign nahi hue hain.
--SELECT e.EmpName, d.DepartmentName
--FROM Employees e
--LEFT JOIN Departments d ON e.DepartmentId = d.DepartmentId;

--==================================================================================================================================================
--------------------------------------------------------------------------------------------------------------------------------------------------
--Har department me kitne employees hain aur unki average salary kya hai.
--SELECT DepartmentId, COUNT(*) AS EmployeeCount, AVG(Salary) AS AvgSalary
--FROM Employees
--GROUP BY DepartmentId;

--==================================================================================================================================================
--------------------------------------------------------------------------------------------------------------------------------------------------
--Sirf un departments ko dikhana jinki average salary ₹50,000 se zyada hai.
--SELECT DepartmentId, AVG(Salary) AS AvgSalary
--FROM Employees
--GROUP BY DepartmentId
--HAVING AVG(Salary) > 50000;

--==================================================================================================================================================
--------------------------------------------------------------------------------------------------------------------------------------------------

--Sirf un employees ko dikhana jinki salary overall average salary se zyada hai.
--SELECT EmpName, Salary
--FROM Employees
--WHERE Salary > (SELECT AVG(Salary) FROM Employees);

--==================================================================================================================================================
--------------------------------------------------------------------------------------------------------------------------------------------------
--Sirf un employees ko lana jinke department ki entry Departments table me actually exist karti hai.
--SELECT EmpName
--FROM Employees e
--WHERE EXISTS (
--    SELECT 1 
--    FROM Departments d 
--    WHERE e.DepartmentId = d.DepartmentId
--);
------------------------------------------------------------------------------------------------
--Employee ki salary manager se jyada hai 

--select e.EmpId, e.EmpName as employeeName,e.Salary EmpSalary,
--m.EmpId, m.EmpName as ManagerName ,m.Salary ManSalary
--from employee e
--left join employee m ON e.ManagerId = m.EmpId
--where e.Salary > m.Salary
-----------------------------------------------------------------------
--SELECT *
--FROM Employee
--ORDER BY EmpID
--OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;   ----------Pagination in SQL
----------------------------------------------------------------------------------
--Select avg(salary) from Employee

--Select department, avg(salary) DeptWiseAvgSalary
--from Employee
--group by department        ---------Department wise salary 

--Select department, avg(salary) DeptWiseAvgSalary
--from Employee
--group by department
--having avg(salary) > 60000 ---------jis Department ki avg salary 50k se jyada hai.
------------------------------------------------------------
--Select * from Employee

--Select distinct e.EmpId, e.EmpName as employeename,m.EmpId, m.EmpName as managername 
--from Employee e
--left join Employee m on e.ManagerId = m.EmpId
--where m.EmpId is null      --Employee jinka koi manager nahi hai 
--order by e.EmpId


--Select distinct e.EmpId, e.EmpName as employeename,m.EmpId, m.EmpName as managername 
--from Employee e
--left join Employee m on e.ManagerId = m.EmpId
--where m.EmpId is not null  --sirf vo Employee jinka koi manager hai.
--order by e.EmpId
------------------------------------------------------------------------------------------------------------------------------------
--Select * from Department    ----6 record
--Select * from Employee      ----36 record

--select * 
--from Employee 
--cross join department      ----216 record
------------------------------------------------------------------------------------------------
----==================================================================================================================
----union and union all

--select * from customers
--select * from suppliers

--select city from customers
--union  
--select city from suppliers

--select city from customers
--union all  
--select city from suppliers
--ORDER BY City; 
--==================================================================================================================


--select top 10 * 
--from employee 

--select * 
--from employee 
--limit 1

--SELECT TOP 50 PERCENT *
--FROM Employee;

--SELECT *
--FROM Employee
--ORDER BY EmpID
--OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;   ----------Pagination in SQL
-----------------------------------------------------------------------------------------------------------------


--select distinct * from 
--(
--select salary,
--DENSE_RANK() over(order by salary desc) as dr
--from employee
--) as t where dr = 3
---------------------------------------------------------------------------
--======================================================================================

----Select * from Employee

--    WITH ActiveEmployee AS (
--        SELECT EmpId, EmpName,Department, Salary
--        FROM Employee
--        WHERE Active = 1
--    )

--    --Select * from ActiveEmployee

--    -- Step 2: Save CTE result to Temp Table
--    SELECT * INTO #ActiveEmployee FROM ActiveEmployee;

--    -- Step 3: Use #TempActiveStudents in next queries
--    SELECT * FROM #ActiveEmployee --WHERE Marks > 80;   -- your next query
--    SELECT COUNT(*) AS TotalActive FROM #ActiveEmployee
---------------------------------------------------------------------------
--======================================================================================
---------------------------------------------------------------------------
--======================================================================================

--Select * from Sales

----1. Total Sales Amount by Each Customer
--SELECT CustomerName,SUM(Quantity * Price) AS TotalSales
--FROM Sales
--GROUP BY CustomerName;

--------------------------------------------------------------------------------------------------------------------
---- 2. Average Product Price by Product Name
--Select * from Sales

--SELECT ProductName,AVG(Price) AS AveragePrice
--FROM Sales
--GROUP BY ProductName;


--------------------------------------------------------------------------------------------------------------------

---- 3. Number of Orders by Region
--Select * from Sales

--SELECT Region,COUNT(SaleID) AS TotalOrders
--FROM Sales
--GROUP BY Region;


--------------------------------------------------------------------------------------------------------------------

---- 4. Minimum and Maximum Price for Each Product
--Select * from Sales

--SELECT ProductName, MIN(Price) AS MinPrice, MAX(Price) AS MaxPrice
--FROM Sales
--GROUP BY ProductName;


--------------------------------------------------------------------------------------------------------------------

---- 5. Total Quantity Sold per Product
--Select * from Sales

--SELECT ProductName, SUM(Quantity) AS TotalQuantitySold
--FROM Sales
--GROUP BY ProductName;


--------------------------------------------------------------------------------------------------------------------

---- 6. Total Sales by Region
--Select * from Sales

--SELECT Region, SUM(Quantity * Price) AS TotalSalesAmount
--FROM Sales
--GROUP BY Region;


--------------------------------------------------------------------------------------------------------------------

---- 7. Average Quantity Sold by Customer
--Select * from Sales

--SELECT CustomerName, AVG(Quantity) AS AvgQty
--FROM Sales
--GROUP BY CustomerName;


--------------------------------------------------------------------------------------------------------------------

---- 8. Group by Multiple Columns (Customer + Region)
--Select * from Sales

--SELECT CustomerName,Region,SUM(Quantity * Price) AS TotalSales
--FROM Sales
--GROUP BY CustomerName, Region;

--------------------------------------------------------------------------------------------------------------------

---- 9. Use HAVING with GROUP BY (Filter groups)
----👉 Example: Only show customers whose total sales > ₹50,000
--Select * from Sales

--SELECT CustomerName, SUM(Quantity * Price) AS TotalSales
--FROM Sales
--GROUP BY CustomerName
--HAVING SUM(Quantity * Price) > 50000;

--------------------------------------------------------------------------------------------------------------------

---- 10. Number of Distinct Products Sold per Region
--Select * from Sales

--SELECT Region,COUNT(DISTINCT ProductName) AS UniqueProducts
--FROM Sales
--GROUP BY Region;




------------------------------------------------------------------------------------------------------------------




































