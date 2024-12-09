CREATE TABLE Departments ( 
DepartmentID INT PRIMARY KEY, 
DepartmentName VARCHAR(100) NOT NULL UNIQUE, 
ManagerID INT NOT NULL, 
Location VARCHAR(100) NOT NULL 
); 

CREATE TABLE Employee ( 
EmployeeID INT PRIMARY KEY, 
FirstName VARCHAR(100) NOT NULL, 
LastName VARCHAR(100) NOT NULL, 
DoB DATETIME NOT NULL, 
Gender VARCHAR(50) NOT NULL, 
HireDate DATETIME NOT NULL, 
DepartmentID INT NOT NULL, 
Salary DECIMAL(10, 2) NOT NULL, 
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) ); 

-- Create Projects Table 
CREATE TABLE Projects ( 
ProjectID INT PRIMARY KEY, 
ProjectName VARCHAR(100) NOT NULL, 
StartDate DATETIME NOT NULL, 
EndDate DATETIME NOT NULL, 
DepartmentID INT NOT NULL, 
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) 
); 

INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID, Location) 
VALUES  
(1, 'IT', 101, 'New York'), 
(2, 'HR', 102, 'San Francisco'), 
(3, 'Finance', 103, 'Los Angeles'), 
(4, 'Admin', 104, 'Chicago'), 
(5, 'Marketing', 105, 'Miami'); 
INSERT INTO Employee (EmployeeID, FirstName, LastName, DoB, Gender, HireDate, DepartmentID, 
Salary) 
VALUES  
(101, 'John', 'Doe', '1985-04-12', 'Male', '2010-06-15', 1, 75000.00), 
(102, 'Jane', 'Smith', '1990-08-24', 'Female', '2015-03-10', 2, 60000.00), 
(103, 'Robert', 'Brown', '1982-12-05', 'Male', '2008-09-25', 3, 82000.00), 
(104, 'Emily', 'Davis', '1988-11-11', 'Female', '2012-07-18', 4, 58000.00), 
(105, 'Michael', 'Wilson', '1992-02-02', 'Male', '2018-11-30', 5, 67000.00); 
INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate, DepartmentID) 
VALUES  
(201, 'Project Alpha', '2022-01-01', '2022-12-31', 1), 
(202, 'Project Beta', '2023-03-15', '2024-03-14', 2), 
(203, 'Project Gamma', '2021-06-01', '2022-05-31', 3), 
(204, 'Project Delta', '2020-10-10', '2021-10-09', 4), 
(205, 'Project Epsilon', '2024-04-01', '2025-03-31', 5);

select * from Departments
select *from Employee
select * from Projects

--PART-A
--1.Create Stored Procedure for Employee table As User enters either First Name or Last Name and based 
--on this you must give EmployeeID, DOB, Gender & Hiredate.  

CREATE PROCEDURE PR_GetEmployeeDetails
    @FirstName VARCHAR(100) = NULL,
    @LastName VARCHAR(100) = NULL
AS
BEGIN
    SELECT EmployeeID, DOB, Gender, HireDate
    FROM Employee
    WHERE (@FirstName IS NOT NULL AND FirstName = @FirstName)
       OR (@LastName IS NOT NULL AND LastName = @LastName);
END;

EXEC PR_GetEmployeeDetails 'John', @LastName = NULL;

--2. Create a Procedure that will accept Department Name and based on that gives employees list who 
--belongs to that department.  
CREATE or ALTER PROCEDURE PR_DNAME
	@DepartmentName VARCHAR(100)
AS
BEGIN 
	SELECT
		d.DepartmentName,
		e.FirstName,
		e.LastName
	from Departments d
	join Employee e
	on d.DepartmentID = e.DepartmentID
	where d.DepartmentName = @DepartmentName
END;

EXEC PR_DNAME 'IT'

--3.  Create a Procedure that accepts Project Name & Department Name and based on that you must give 
--all the project related details.  
CREATE or ALTER PROCEDURE PR_PrNameDName
	@DepartmentName VARCHAR(100),
	@ProjectName VARCHAR(100)
AS
BEGIN 
	SELECT p.DepartmentID,
	p.EndDate,
	p.ProjectID,
	p.ProjectName,
	p.StartDate
	from Projects p  
	join Departments d
	on  p.DepartmentID = d.DepartmentID 
	where p.ProjectName = @ProjectName and d.DepartmentName = @DepartmentName
		  
END;
EXEC PR_PrNameDName @DepartmentName = 'Project Alpha', @ProjectName = 'IT'

--4. Create a procedure that will accepts any integer and if salary is between provided integer, then those 
--employee list comes in output.

create proc pr_employee_salar
	@minsalary int,@maxsal int
as
begin
	select firstname,salary from Employee
	where salary between @minsalary and @maxsal
end

exec pr_employee_salar 8000, 150000

--5. create a procedure that will accepts a date and gives all the employees who all
create proc pr_employee_dob
	@dob datetime
as 
begin 
	select firstname,dob from employee
	where dob=@dob	
end

exec pr_employee_dob '1985-04-12'









