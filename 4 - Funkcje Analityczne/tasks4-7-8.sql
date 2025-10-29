SELECT
	O.OrderDate,
	O.OrderID,
	C.CompanyName,
	ROW_NUMBER() OVER (ORDER BY O.OrderID) as RowNum
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
ORDER BY C.CompanyName ASC, O.OrderDate DESC