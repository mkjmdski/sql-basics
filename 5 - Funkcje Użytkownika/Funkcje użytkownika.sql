/* Zad. 3 */
CREATE OR ALTER FUNCTION dbo.employeeInfo(@OrderID INT)  
RETURNS TABLE 
AS
RETURN (
	SELECT  E.FirstName, E.LastName, E.Address
	FROM	Orders O JOIN Employees E
	ON		O.EmployeeID = E.EmployeeID
	WHERE	O.OrderID = @OrderID
)
GO

SELECT FirstName, LastName, Address FROM dbo.employeeInfo(10248)
UNION ALL
SELECT FirstName, LastName, Address FROM dbo.employeeInfo(NULL)
UNION ALL
SELECT FirstName, LastName, Address FROM dbo.employeeInfo(0)