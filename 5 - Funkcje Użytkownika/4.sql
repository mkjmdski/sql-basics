CREATE OR ALTER FUNCTION dbo.employeeInfoExt(@OrderID INT)
RETURNS @result TABLE
(
	FirstName NVARCHAR(10),
	LastName NVARCHAR(20),
	Address NVARCHAR(60),
	Comments NVARCHAR(20)
)
AS
BEGIN
DECLARE @flag INT;
SELECT @flag = OrderID FROM Orders WHERE Orders.OrderID = @OrderID
IF @flag IS NULL
	INSERT INTO @result
	SELECT NULL, NULL, NULL, 'There is no such order'
IF @OrderID IS NULL
	INSERT INTO @result
	SELECT NULL, NULL, NULL, 'Really? Null?'
ELSE
	INSERT INTO @result
	SELECT 
		E.FirstName,
		E.LastName,
		E.Address,
		'' AS Comments
	FROM Orders O
	JOIN Employees E ON O.EmployeeID = E.EmployeeID
	WHERE O.OrderID = @OrderID

	RETURN
END
GO

SELECT FirstName, LastName, Address, Comments FROM dbo.employeeInfoExt(10249)
UNION ALL
SELECT FirstName, LastName, Address, Comments FROM dbo.employeeInfoExt(NULL)
UNION ALL
SELECT FirstName, LastName, Address, Comments FROM dbo.employeeInfoExt(0)
