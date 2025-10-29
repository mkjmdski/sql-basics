SELECT 
	C.CategoryName,
	SUM(P.UnitPrice * P.UnitsInStock)
FROM Products P
	JOIN Categories C
		ON P.CategoryID = C.CategoryID
GROUP BY P.CategoryID, C.CategoryName
ORDER BY C.CategoryName ASC