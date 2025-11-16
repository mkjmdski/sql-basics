CREATE OR ALTER FUNCTION dbo.orderValue(@OrderID INT)
RETURNS MONEY
AS
BEGIN
	DECLARE @value MONEY;
	SELECT @value = O.Quantity * O.UnitPrice
	FROM
		[Order Details] O
	WHERE
		O.OrderID = @OrderID;
	IF @value IS NULL
		SELECT @value = 0.00;
	RETURN @value
END
GO

SELECT 
	O.OrderID,
	O.CustomerID,
	O.OrderDate,
	dbo.orderValue(O.OrderID) AS OrderAmt
FROM Orders O
