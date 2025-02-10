-- Create the Customers table 
CREATE TABLE Customers ( 
Customer_id INT PRIMARY KEY,                 
Customer_Name VARCHAR(250) NOT NULL,         
Email VARCHAR(50) UNIQUE                     
); 
-- Create the Orders table 
CREATE TABLE Orders ( 
Order_id INT PRIMARY KEY,                    
Customer_id INT,                             
Order_date DATE NOT NULL,                    
FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id)  
); 
--Part – A 
--1. Handle Divide by Zero Error and Print message like: Error occurs that is - Divide by zero error. 

begin try
	declare @num1 int,@num2 int, @ans int 
	set @num1 = 4
	set @num2 = 0
	set @ans = @num1/@num2
	print @ans
end try
begin catch
	print('Error occurs that is - Divide by zero error')
end catch

--2. Try to convert string to integer and handle the error using try…catch block. 
begin try 
	declare @str varchar(50)
	declare @i int
	set @str = 'hello'
	set @i = CAST(@str as int)
end try
begin catch
	print error_message()
end catch
--3. Create a procedure that prints the sum of two numbers: take both numbers as integer & handle 
--exception with all error functions if any one enters string value in numbers otherwise print result.
create or alter proc pr_sum
 @num1 varchar(50),
 @num2 varchar(50)
as 
begin
begin try
	declare @sum varchar(50)
	set @sum = CAST(@num1 as int)+CAST(@num2 as int)
	print (@sum)
end try
begin catch
	print error_message()
end catch
end;

exec pr_sum 11,'abc'
	
--4. Handle a Primary Key Violation while inserting data into customers table and print the error details 
--such as the error message, error number, severity, and state. 
create or alter proc pr_pk
	@Customer_id int,
	@Customer_Name varchar(50),
	@Email varchar(50)
as begin
begin try
	insert into Customers values (@Customer_id,@Customer_Name,@Email)
end try
begin catch
	select ERROR_MESSAGE()
end catch
end;

exec pr_pk 101,'vidisha','vidu@123'
select *from Customers


--5. Throw custom exception using stored procedure which accepts Customer_id as input & that throws 
--Error like no Customer_id is available in database. 
CREATE or alter PROC PR_CUS
    @Customer_id INT
AS
BEGIN
	BEGIN TRY
		IF NOT EXISTS (SELECT Customer_id FROM Customers WHERE Customer_id = @Customer_id)
        THROW 3000000, 'No Customer_id is available in the database.', 1;
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;

EXEC PR_CUS 102

--Part – B 
--6. Handle a Foreign Key Violation while inserting data into Orders table and print appropriate error 
--message. 
CREATE OR ALTER PROC PR_FK



--7. Throw custom exception that throws error if the data is invalid.
CREATE or alter PROC PR_ORD
    @Customer_id INT
AS
BEGIN
	BEGIN TRY
		IF NOT EXISTS (SELECT Customer_id FROM Customers WHERE Customer_id = @Customer_id)
        THROW 3000000, 'No Customer_id is available in the database.', 1;
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
--8. Create a Procedure to Update Customer’s Email with Error Handling 

	
