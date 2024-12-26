--Part – A
--1. Write a function to print "hello world".
CREATE OR ALTER FUNCTION fn_helloWorld()
returns varchar(500)
AS  
BEGIN
	Return 'Hello World'
END;
select dbo.fn_helloWorld()

--2. Write a function which returns addition of two numbers.
CREATE OR ALTER FUNCTION fn_addTwoNumber(@num1 int,@num2 int )
returns int
as
begin
return @num1+@num2
end;
select dbo.fn_addTwoNumber(3,5)


--3. Write a function to check whether the given number is ODD or EVEN.
create or alter function fn_oddEven(@n int)
returns varchar(100)
as 
begin
	return case 
	when @n%2=0 then 'Even'
	else 'Odd'
	end
end;
select dbo.fn_oddEven(5)

--4. Write a function which returns a table with details of a person whose first name starts with B.
create or alter function fn_Fname()
returns table
as 
return (select*from Person where FirstName like 'b%')
select *from dbo.fn_Fname()

--5. Write a function which returns a table with unique first names from the person table.
create or alter function fn_UniqueFname()
returns table
as 
return (select FirstName from Person )
select *from dbo.fn_UniqueFname()
--6. Write a function to print number from 1 to N. (Using while loop)
create or alter function fn_1ton(@n int)
returns varchar(100)
as
begin
	declare @msg varchar(100),@count int
	set @msg = ''
	set @count = 1
	while(@count <=@n)
	begin
		set @msg = @msg +''+cast(@count as varchar(100))
		set @count = @count+1
	end
	return @msg
end

select dbo.fn_1ton(5)

--7. Write a function to find the factorial of a given integer
create or alter function fn_factorial(@n int)
returns int
as
begin
	declare @count int,@fact int
	set @fact = 1
	set @count = 1
	while(@count <= @n)
	begin
		set @fact = @fact * @count
		set @count = @count+1
    end
	return @fact
end
select  dbo.fn_factorial(4)

--Part – B
--8. Write a function to compare two integers and return the comparison result. (Using Case statement)
create or alter function fn_compare(@num1 int,@num2 int)
returns varchar(100)
as
begin
return case 
			when @num1 > @num2 then 'num1 is graeter'
			else 'Num2 is greater'
			end
end
select dbo.fn_compare(2,4)



--9. Write a function to print the sum of even numbers between 1 to 20.
create or alter function fn_1to20()
returns varchar(100)
as
begin
	declare @sum int,@temp int
	set @sum=0
	set @temp=1
		while @temp<=20
		begin
			if(@temp%2=0)
			set @sum =@sum+@temp
			set @temp = @temp+1
		end
		return @sum
end
select dbo.fn_1to20()

--10. Write a function that checks if a given string is a palindrome






	