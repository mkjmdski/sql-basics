SELECT P.ProductName, DATEPART(yyyy, O.OrderDate) AS OrderYear, COUNT(*) AS NumberOfOrders
FROM Products P
	JOIN [Order Details] OD
		ON P.ProductID = OD.ProductID
	JOIN Orders O
		ON O.OrderID = OD.OrderID
GROUP BY  DATEPART(yyyy, O.OrderDate), P.ProductID, P.ProductName
ORDER BY NumberOfOrders DESC