CREATE TABLE Department ( 
DepartmentID INT PRIMARY KEY, 
DepartmentName VARCHAR(100) NOT NULL UNIQUE 
); 

-- Create Designation Table 

CREATE TABLE Designation ( 
DesignationID INT PRIMARY KEY, 
DesignationName VARCHAR(100) NOT NULL UNIQUE 
);
-- Create Person Table 
CREATE TABLE Person ( 
PersonID INT PRIMARY KEY IDENTITY(101,1), 
FirstName VARCHAR(100) NOT NULL, 
LastName VARCHAR(100) NOT NULL, 
Salary DECIMAL(8, 2) NOT NULL, 
JoiningDate DATETIME NOT NULL, 
DepartmentID INT NULL, 
DesignationID INT NULL, 
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID), 
FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID) 
); 

CREATE OR ALTER PROCEDURE PR_Department_Insert
	@DepartmentId int,
	@DepartmentName varchar(100)
AS
BEGIN
	INSERT INTO Department
	(
		DepartmentId,
		DepartmentName
	)
	Values
	(
		@DepartmentId,
		@DepartmentName
	)
	END

exec PR_Department_Insert 1,'admin'
exec PR_Department_Insert 2, 'IT'
exec PR_Department_Insert 3, 'HR'
exec PR_Department_Insert 4, 'Acount'

CREATE OR ALTER PROCEDURE PR_Designation_Insert
	@DesignationID  int,
	@DesignationName  varchar(100)
AS
BEGIN
	INSERT INTO Designation
	(
		DesignationID,
		DesignationName
	)
	Values
	(
		@DesignationID,
		@DesignationName
	)
	END
exec PR_Designation_Insert 11,'Jobber'
exec PR_Designation_Insert 12,'Welder'
exec PR_Designation_Insert 13,'Clerk'
exec PR_Designation_Insert 14,'Manager'
exec PR_Designation_Insert 15,'CEO'


CREATE OR ALTER PROCEDURE PR_Person_Insert
	@FirstName varchar(100),
	@LastName varchar(100),
	@Salary Decimal (8,2), 
	@JoiningDate Datetime,
	@DepartmentID Int,
	@DesignationID Int
AS
BEGIN
	INSERT INTO Person
	(
		FirstName,
		LastName,
		Salary,
		JoiningDate,
		DepartmentID,
		DesignationID
	)
	Values
	(
		@FirstName,
		@LastName,
		@Salary,
		@JoiningDate,
		@DepartmentID,
		@DesignationID
	)
	END

EXEC PR_Person_Insert 'Rahul', 'Anshu', 56000, '1990-01-01', 1, 12;
EXEC PR_Person_Insert 'Hardik', 'Hinsu', 18000, '1990-09-25', 2, 11;
EXEC PR_Person_Insert 'Bhavin', 'Kamani', 25000, '1991-05-14', NULL, 11;
EXEC PR_Person_Insert 'Bhoomi', 'Patel', 39000, '2014-02-20', 1, 13;
EXEC PR_Person_Insert 'Rohit', 'Rajgor', 17000, '1990-07-23', 2, 15;
EXEC PR_Person_Insert 'Priya', 'Mehta', 25000, '1990-10-18', 2, NULL;
EXEC PR_Person_Insert 'Neha', 'Trivedi', 18000, '2014-02-20', 3, 15;
exec PR_Person_Insert 

--Part – A 
--1. Department, Designation & Person Table’s INSERT, UPDATE & DELETE Procedures. 
--Department
	--Insert
		CREATE PROCEDURE PR_InsertDepartment
			@DepartmentName VARCHAR(100)
		AS
		BEGIN
			INSERT INTO Department (DepartmentName)
			VALUES (@DepartmentName);
		END;
	--update
		CREATE PROCEDURE UpdateDepartment
			@DepartmentID INT,
			@DepartmentName VARCHAR(100)
		AS
		BEGIN
			UPDATE Department
			SET DepartmentName = @DepartmentName
			WHERE DepartmentID = @DepartmentID;
		END;

	--delete
		CREATE PROCEDURE DeleteDepartment
			@DepartmentID INT
		AS
		BEGIN
			DELETE FROM Department
			WHERE DepartmentID = @DepartmentID;
		END;

--2.Department, Designation & Person Table’s SELECTBYPRIMARYKEY

CREATE PROCEDURE PR_GetDepartmentByPrimaryKey
    @DepartmentID INT
AS
BEGIN
    SELECT 
        DepartmentID, 
        DepartmentName
    FROM Department
    WHERE DepartmentID = @DepartmentID;
END;

EXEC PR_GetDepartmentByPrimaryKey 1;

--Designation
CREATE PROCEDURE PR_GetDesignationByPrimaryKey
    @DesignationID INT
AS
BEGIN
    SELECT 
        DesignationID, 
        DesignationName
    FROM Designation
    WHERE DesignationID = @DesignationID;
END;

EXEC PR_GetDesignationByPrimaryKey 11;

--person
CREATE PROCEDURE p_GetPersonByPrimaryKey
  @PersonID int
AS
BEGIN
    SELECT 
     PersonID,FirstName
	 from Person
    WHERE PersonID = @PersonID;
END;

EXEC p_GetPersonByPrimaryKey 101;

--1. Department Table - SELECT with Related Person Details
CREATE PROCEDURE PR_GetDepartmentWithPersons
AS
BEGIN
    SELECT 
        d.DepartmentID,
        d.DepartmentName,
        p.PersonID,
        p.FirstName,
        p.LastName,
        p.Salary,
        p.JoiningDate
    FROM Department d
    LEFT JOIN Person p ON d.DepartmentID = p.DepartmentID
    ORDER BY d.DepartmentID, p.PersonID;
END;

EXEC PR_GetDepartmentWithPersons;

--2. Designation Table - SELECT with Related Person Details

CREATE PROCEDURE PR_GetDesignationWithPersons
AS
BEGIN
    SELECT 
        ds.DesignationID,
        ds.DesignationName,
        p.PersonID,
        p.FirstName,
        p.LastName,
        p.Salary,
        p.JoiningDate
    FROM Designation ds
    LEFT JOIN Person p ON ds.DesignationID = p.DesignationID
    ORDER BY ds.DesignationID, p.PersonID;
END;

EXEC PR_GetDesignationWithPersons;

--3. Person Table - SELECT with Department and Designation Details
CREATE PROCEDURE PR_GetPersonWithDetails
AS
BEGIN
    SELECT 
        p.PersonID,
        p.FirstName,
        p.LastName,
        p.Salary,
        p.JoiningDate,
        d.DepartmentName,
        ds.DesignationName
    FROM Person p
    LEFT JOIN Department d ON p.DepartmentID = d.DepartmentID
    LEFT JOIN Designation ds ON p.DesignationID = ds.DesignationID
    ORDER BY p.PersonID;
END;

EXEC PR_GetPersonWithDetails;

--4.Create a Procedure that shows details of the first 3 persons. 

CREATE PROCEDURE PR_GetFirstThreePersons
AS
BEGIN
    SELECT TOP 3
        p.PersonID,
        p.FirstName,
        p.LastName,
        p.Salary,
        p.JoiningDate,
        d.DepartmentName,
        ds.DesignationName
    FROM Person p
    LEFT JOIN Department d ON p.DepartmentID = d.DepartmentID
    LEFT JOIN Designation ds ON p.DesignationID = ds.DesignationID
    ORDER BY p.PersonID;
END;


EXEC PR_GetFirstThreePersons

--Part – B 

--5. Create a Procedure that takes the department name as input and returns a table with all workers 
--working in that department. 
		CREATE PROCEDURE PR_WORKERS
		@DepartmentName VARCHAR(100)
		AS
		BEGIN
			SELECT d.DepartmentName,
			p.FirstName,
			p.LastName
			from  Person p
			join Department d
			on d.DepartmentID = p.DepartmentID
			where d.DepartmentName = @DepartmentName
		END;

		EXEC PR_WORKERS 'IT'

--6. Create Procedure that takes department name & designation name as input and returns a table with 
--worker’s first name, salary, joining date & department name. 

		CREATE or ALTER PROCEDURE PR_DnameDesiName
		@DepartmentName VARCHAR(100),
		@DesignationName VARCHAR(100)
		AS
		BEGIN
			SELECT d.DepartmentName,
			p.FirstName,
			p.Salary,
			p.JoiningDate
		  FROM Person p
				 JOIN Department d ON p.DepartmentID = d.DepartmentID
				 join Designation ds on p.DesignationID = ds.DesignationID
				where DepartmentName = @DepartmentName and 
					  DesignationName = @DesignationName
		END;

EXEC PR_DnameDesiName 'IT','CEO'


			   		 	  	  	   	